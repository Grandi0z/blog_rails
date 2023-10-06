require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    subject { build(:comment) }
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'callbacks' do
    let(:comment) { create(:comment) }
    it 'should increment the post\'s comments_counter by 1' do
      expect { comment.save }.to change { comment.post.reload.comments_counter }.by(1)
    end
  end
end
