# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ports_list, class: Hash do
    initialize_with {{
      ireland: {
        "title" => "Dingle Harbour",
        "latitude" => 52.13333333,
        "longitude" => -10.26666667
      },
      japan: {
        "title" => "Hirao",
        "latitude" => 33.9,
        "longitude" => 132.05
      },
      australia: {
        "title" => "Humbug Point Wharf",
        "latitude" => -12.66666667,
        "longitude" => 141.8666667
      }
    }}
  end

  factory :port do
    title "String"
    latitude 1.5
    longitude 1.5
  end
end
