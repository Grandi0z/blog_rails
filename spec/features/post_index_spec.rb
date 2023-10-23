require 'rails_helper'
require 'tools/test_data'

RSpec.describe 'User post index page', type: :feature do
  include TestData
  before(:each) do
    call_test_data
    visit user_posts_path(@user1)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css("img.profile_picture[src*='https://example.jpg']")
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content('Number of posts: 10') # Assuming 10 posts were created in the before block
  end

  scenario 'I can see a post\'s title' do
    expect(page).to have_content(@posts.first.title)
  end

  scenario 'I can see some of the post\'s body' do
    expect(page).to have_content(@posts.first.text.truncate(100))
  end

  scenario 'I can see the first comments on a post' do
    expect(page).to have_content('comment yet')
    expect(page).to have_content('Comment 1')
    expect(page).to have_content('Comment 2')
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_content('Comment: 2')
  end

  scenario 'I can see how many likes a post has' do
    expect(page).to have_content('Like: 3')
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_css('button#pagination')
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    first('a', text: @post_with_comments.title).click # click on the first 'Post you'll meet
    expect(page).to have_current_path(user_post_path(@user1, @posts[0]))
  end
end
