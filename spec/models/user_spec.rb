require 'rails_helper'

RSpec.describe User, type: :model do
  context 'ensures the present of fields' do
    it 'ensures role is present' do
      user = User.new(role: 0)
      expect(user.valid?).to eq(false)
    end
  end

  context 'validation tests' do
    it 'user`s role should be zero (0) by default' do
      user = User.new(role: 0)
      expect(user.role).to eq('user')
    end

    it 'admin`s role should be 1' do
      user = User.new(role: 1)
      expect(user.role).to eq('admin')
    end

    it 'super admin`s role should be 2' do
      user = User.new(role: 2)
      expect(user.role).to eq('super_admin')
    end

    it 'should be three types of roles (user, admin and super_admin) + default (user)' do
      expect(User.roles.values.count).to eq(4)
    end
  end

  context 'relation (relationships with other tables)' do
    it 'user should have many ratings' do
      should have_many :ratings
    end
  end
end
