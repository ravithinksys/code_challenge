# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :member

  has_many :friendships,
           ->(member) { FriendshipsQuery.both_ways(member_id: member.id) },
           inverse_of: :member,
           dependent: :destroy

  has_many :friends,
           ->(member) { MembersQuery.friends(member_id: member.id, scope: true) },
           through: :friendships

  has_many :headings

  before_create :create_short_url
  after_create :fecch_data

  def show_relation(friend)
    rel = find_relation(friend)
    if rel.present?
      rel.collect(&:name).join(' -> ')
    else
      'No relation found'
    end
  end

  def find_relation(friend)
    rel(self, friend, [])
  end

  def rel(f_p, e_p, check_l)
    check_l << f_p.id
    f_list = [f_p]
    if f_p.friends.include?(e_p)
      f_list << e_p
    else
      f_p.friends.where.not(id: check_l).each do |friend|
        f_list << rel(friend, e_p, check_l)
        break if f_list.flatten.include?(e_p)
      end
      f_list = [] unless f_list.flatten.include? e_p
    end
    f_list.flatten
  end

  def create_short_url
    self.short_url = Shortener::ShortenedUrl.generate(smart_add_url_protocol(website)).unique_key
  end

  def fecch_data
    doc = Nokogiri::HTML(open(smart_add_url_protocol(website)))
    doc.search('h1').each do |data|
      headings.create(tag_type: 'h1', data: data.text)
    end
    doc.search('h3').each do |data|
      headings.create(tag_type: 'h3', data: data.text)
    end
  end

  def smart_add_url_protocol(url)
    url = "http://#{url}" unless url[%r{\Ahttp://}] || url[%r{\Ahttps://}]
    url
  end
end
