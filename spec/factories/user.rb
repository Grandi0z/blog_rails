FactoryBot.define do
  factory :user do
    name { 'Joseph K' }
    bio { '<y bio' }
    posts_counter { 0 }
  end
end
