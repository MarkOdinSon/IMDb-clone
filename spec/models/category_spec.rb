require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'ensures the present of fields' do
    it 'ensures field name is present' do
      category = Category.new(name: 'Some name')
      expect(category.valid?).to eq(true)
    end
  end

  context 'validation tests' do
    it 'categories should be in alphabetical order' do
      list_of_categories_keys = Category.get_list_categories
      expect(list_of_categories_keys == list_of_categories_keys.sort).to eq(true)
    end

    it 'categories should be 26' do
      expect(Category.get_list_categories.count).to eq(26)
    end
  end

  context 'relation (relationships with other tables)' do
    it 'category should have many movie categories' do
      should have_many :movie_categories
    end
  end
end
