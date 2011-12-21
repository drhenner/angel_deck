# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
      company {|c| c.association(:company) }
      user  {|c| c.association(:user) }
      title "MyString"
      status "MyString"
    end
end