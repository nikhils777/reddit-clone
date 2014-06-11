FactoryGirl.define do
  factory :user do
    name "Dougie Fresh"
    sequence(:email) { |n| "person#{n}@example.com"}
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end
