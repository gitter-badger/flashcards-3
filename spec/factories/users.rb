FactoryGirl.define do
  factory :user do
    email "someone@somewhere.in.ru"
    password "secret"
    password_confirmation { password }
  end
end
