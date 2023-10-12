require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /index' do
    it 'returns correct response status' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders correct templete' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template(:index)
    end

    it 'include the correct placeholder' do
      get user_posts_path(user_id: user.id)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    let(:post) { FactoryBot.create(:post, author: user) }

    it 'returns correct response status' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders correct templete' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template(:show)
    end

    it 'include the correct placeholder' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response.body).to include('Show a posta of a given user')
    end
  end
end
