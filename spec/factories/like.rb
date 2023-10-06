FactoryBot.define do
  factory :like do
    author { association :user }
    post { association :post }
  end
end
