# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'Find relation' do
    it 'it true' do
      m1 = Member.create(name: 'Taylor', website: 'https://gist.github.com/tadast/5642683')
      m2 = Member.create(name: 'Bart', website: 'https://ahrefs.com/blog/h1-tag')
      m3 = Member.create(name: 'Claudia', website: 'https://github.com/jamis/bulk_insert')
      m1.friends << m2
      m2.friends << m3

      expect(m1.show_relation(m3)).to eq('Taylor -> Bart -> Claudia')
    end
  end
end
