# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
      state { State.first }
      name "MyString"
      latitude "9.99"
      longitude "9.99"
    end
end