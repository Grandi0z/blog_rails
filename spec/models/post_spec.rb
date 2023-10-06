require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject { create(:post) }
    it 'should have title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 's title should not exeed 250 caracters' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'comment_counter should be integer' do
      subject.comments_counter = 'v'
      expect(subject).to_not be_valid
    end
    it 'comment_counter should not be less than zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#methods' do
    let(:post) { create(:post) }
    describe '#uddate_counter_post' do
      it 'should udpate the counter of post' do
        expect { post.save }.to change { post.author.reload.posts_counter }.by(1)
      end
    end
    describe '#five_recents_comments' do
      it 'should return the five most recent comments for a given post id' do
        expect(Post.five_recents_comments(post.id)).to eq(post.comments.order(created_at: :desc).limit(5))
      end
    end
  end
end
