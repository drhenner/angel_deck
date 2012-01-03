
Factory.sequence :company_unique_identifier do |n|
  "unique_identifier#{n}"
end

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
      name "MyString"
      brief_description "MyText"
      city { |c| c.association(:city) }
      unique_identifier { Factory.next(:company_unique_identifier) }
      company_type 'companytype'
      maintainer { |c| c.association(:user) }
      account { Account.first }
    end
end