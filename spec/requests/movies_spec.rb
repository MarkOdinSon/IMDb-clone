require 'rails_helper'

RSpec.describe "Movies", type: :request do
  context "GET #index" do

    # let(:movies) { create_list :movie, 5}

    it 'return all movies records from database' do
      # is_expected.to render_template :index
      # expect(assigns(:movies)).to match_array(movies)
    end
  end
end
