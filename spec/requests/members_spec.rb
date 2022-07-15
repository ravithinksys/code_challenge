# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Members', type: :request do
  describe 'GET /show' do
    m = Member.create(name: 'Taylor', website: 'https://gist.github.com/tadast/5642683')
    it 'returns http success' do
      get "/members/#{m.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/members/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /search' do
    m = Member.create(name: 'Taylor', website: 'https://gist.github.com/tadast/5642683')
    it 'returns http success' do
      get "/members/#{m.id}/search"
      expect(response).to have_http_status(:success)
    end
  end
end
