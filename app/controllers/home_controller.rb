# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @members = Member.includes(:headings)
  end
end
