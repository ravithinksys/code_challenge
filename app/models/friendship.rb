# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: 'Member'
end
