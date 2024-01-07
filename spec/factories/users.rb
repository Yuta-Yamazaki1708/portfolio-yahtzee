FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    username { "test-user" }
    password { "password" }
    password_confirmation { "password" }
  end
end
