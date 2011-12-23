# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
      pageable { |c| c.association(:company) }
      pageable_type "MyString"
      page_type 'homepage'
      description "MyText"
      description_markup "MyText"
    end
end