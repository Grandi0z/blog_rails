require 'rails_helper'
require 'tools/test_data'

RSpec.describe 'User index', type: :feature do
  include TestData
  describe 'index page' do
    before(:each) do
      call_test_data
    end
    before do
      @user = User.create(name: 'Martin', photo: 'https://example.jpg', bio: 'Eng')
    end
    it "Redirected user's show page When I click on a user" do
      visit users_path
      first('a', text: @user.name).click
      expect(page).to have_current_path(user_path(@user))
    end
    it 'shows the username of all users' do
      visit users_path
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end
    it 'Shows the profile picture of all users' do
      visit users_path
      expect(page).to have_css("img.profile_picture[src*='https://example.jpg3']")
      expect(page).to have_css("img.profile_picture[src*='https://example.jpg2']")
    end

    it 'Shows the number of user has writen' do
      visit users_path
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 0')
    end
  end
end
