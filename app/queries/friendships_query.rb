# frozen_string_literal: true

module FriendshipsQuery
  extend self

  def both_ways(member_id:)
    relation.unscope(where: :member_id)
            .where(member_id: member_id)
            .or(relation.where(friend_id: member_id))
  end

  private

  def relation
    @relation ||= Friendship.all
  end
end
