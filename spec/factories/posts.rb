# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence (:title) { |n| "Example post title #{n}" }
    body "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    trait :published do
      # Randomized published_at date so we can test ordering
      from = Time.local(2009, 1, 1)
      sequence (:published_at) { Time.at(from + Kernel.rand * (Time.zone.now.to_f - from.to_f)) }
      state '1'
    end

    trait :invalid do
      body ""
    end

    factory :invalid_post, :traits => [:invalid]
    factory :published_post, :traits => [:published]
  end
end
