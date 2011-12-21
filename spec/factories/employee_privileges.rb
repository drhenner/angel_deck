# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee_privilege do
      employee {|c| c.association(:employee) }
      privilege { Privilege.first }
    end
end