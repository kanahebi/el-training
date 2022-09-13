FactoryBot.define do
  factory :user do
    name { 'User' }
    email { 'user@example.com' }
    password { 'password' }

    trait :other do
      name { 'Other User' }
      email { 'other_user@example.com' }
    end
  end
end
