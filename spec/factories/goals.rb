FactoryGirl.define do
  factory :goal do
    user_id 1
    title { Faker::Hacker.say_something_smart }
    description { Faker::Hacker.say_something_smart }
    private false
  end
end
