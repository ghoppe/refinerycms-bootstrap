
FactoryGirl.define do
  factory :bootstrap, :class => Refinery::Bootstrap::Bootstrap do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

