require 'rails_helper'

RSpec.describe 'User', type: :request do
  describe 'GET /index' do
    it 'returns correct response status' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders correct templete' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'include the correct placeholder' do
      get users_path
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET /show' do
    def valid_attributes
      { name: 'Joseph K', bio: 'My bio', posts_counter: 0 }
    end

    let(:user) { User.create! valid_attributes }

    it 'returns correct response status' do
      get user_url(user)
      expect(response).to be_successful
    end

    it 'renders correct templete' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'include the correct placeholder' do
      get user_path(user)
      expect(response.body).to include('Show a user')
    end
  end
end
