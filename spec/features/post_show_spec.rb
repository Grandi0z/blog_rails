require 'rails_helper'
require 'tools/test_data'

RSpec.describe 'Post show page', type: :feature do
  include TestData
  before(:all) do
    call_test_data
  end

  it 'I can see the post title' do
    visit user_post_path(@user1, @post_with_comments)
    expect(page).to have_content(@post_with_comments.text)
  end

  it 'I can see who wrote the post' do
    visit user_post_path(@user1, @post_with_comments)
    expect(page).to have_content(@user1.name)
  end

  it 'I can see how many comments it has' do
    visit user_post_path(@user1, @post_with_comments)
    expect(page).to have_content('Comment: 2') # Assuming 2 comments were created
  end

  it 'I can see how many likes it has' do
    visit user_post_path(@user1, @post_with_comments)
    expect(page).to have_content('Like: 3')
  end

  it 'I can see the post text' do
    visit user_post_path(@user1, @post_with_comments)
    expect(page).to have_content(@post_with_comments.text)
  end

  it 'I can see the username of each commentor' do
    visit user_post_path(@user1, @post_with_comments)
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
  end

  it 'I can see the comment each commentor left' do
    visit user_post_path(@user1, @post_with_comments)
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end
end
