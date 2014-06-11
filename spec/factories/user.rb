FactoryGirl.define do
  factory :user do
    name "Dougie Fresh"
    email "dougie@gunit.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end
