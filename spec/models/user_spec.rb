require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Tomy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  # before {subject.save}

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  describe '#post_counter' do
    it 'posts_counter should be integer' do
      subject.posts_counter = 'v'
      expect(subject).to_not be_valid
    end
    it 'should not be less than zero' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
    # after {subject.save}
    describe '#self.three_recent_posts' do
      it 'should returns the three most recent posts by an author' do
        subject = create(:user)
        create(:post, author: subject)
        post2 = create(:post, author: subject)
        post3 = create(:post, author: subject)
        post4 = create(:post, author: subject)
        expect(User.three_recent_posts(subject.id)).to eq([post4, post3, post2])
      end
    end
  end
end
