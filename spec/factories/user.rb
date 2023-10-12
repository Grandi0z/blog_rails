FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Joseph K #{n}" }
    bio { 'My bio' }
    posts_counter { 0 }
  end
end
