# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cargo do
    title "MyString"
    port_id 1
    date "2017-04-10"
    volume 1
  end
end
