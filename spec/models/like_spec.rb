# spec/models/like_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    subject { create(:like) }

    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'callbacks' do
    let(:like) { create(:like) }

    it 'should increment the post\'s likes_counter by 1' do
      expect { like.save }.to change { like.post.reload.likes_counter }.by(1)
    end
  end
end
