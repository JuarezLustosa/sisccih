FactoryGirl.define do
  factory :user do
    username          'juarez'
    sequence(:email)  {|n| "test#{n}@example.com"}
    password          'f4k3p455w0rd'
  end
end
