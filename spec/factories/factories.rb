FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@huanlv.com" }
    password { "123456" }

    transient do
      movie { build(:movie) }
    end
  end

  factory :movie do
    sequence(:title) { |n| "test-#{n.to_s.rjust(3, "0")}" }
    description  { "abc abcsbc sbc acb" }
    youtube_id { 'xRKhIq6HNBY' }

    author { association :user }
  end
end
