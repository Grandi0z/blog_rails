FactoryBot.define do
  factory :comment do
    text { 'Comment Text' }
    author { association :user }
    post { association :post }
  end
end
