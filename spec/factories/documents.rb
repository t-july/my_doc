FactoryGirl.define do
  factory :document do
    user

    sequence(:name) {|n| "Doc#{n}" }
    description 'desc'
    schema_file '<xml></xml>'
  end
end
