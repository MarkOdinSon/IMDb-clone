require 'rails_helper'

RSpec.describe User, type: :model do
  context 'relation (relationships with other tables)' do
    it 'user should have many ratings' do
      should have_many :ratings
    end
  end
end
