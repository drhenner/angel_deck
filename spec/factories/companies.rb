# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
      name "MyString"
      brief_description "MyText"
      description "MyText"
      description_markup "MyText"
      city_id 1
    end
end