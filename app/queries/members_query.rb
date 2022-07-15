# frozen_string_literal: true

module MembersQuery
  extend self

  def friends(member_id:, scope: false)
    query = relation.joins(sql(scope: scope)).where.not(id: member_id)

    query.where(friendships: { member_id: member_id })
         .or(query.where(friendships: { friend_id: member_id }))
  end

  private

  def relation
    @relation ||= Member.all
  end

  def sql(scope: false)
    if scope
      <<~SQL
        OR members.id = friendships.member_id
      SQL
    else
      <<~SQL
        INNER JOIN friendships
          ON members.id = friendships.friend_id
          OR members.id = friendships.member_id
      SQL
    end
  end
end
