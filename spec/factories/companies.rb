# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
      name "MyString"
      brief_description "MyText"
      city { |c| c.association(:city) }
    end
end