# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :set_member, only: %i[show search]

  def show
    # @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  def create
    member = Member.create(member_params)
    redirect_to member_path(member)
  end

  def search
    @headings = Heading.includes(:member).where('data LIKE ?', "%#{params[:key]}%")
  end

  private

  def member_params
    params.require(:member).permit(:name, :website, { friend_ids: [] })
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
