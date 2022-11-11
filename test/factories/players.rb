FactoryBot.define do
  factory :player do
    name { Faker::Name.name }
    level { ['A', 'B', 'C', 'Cuauh'].sample }
    goals { rand(1..30) }
    salary { rand(50000.00..100000.00).round(2) }
    bonus { rand(10000.00..50000.00).round(2) }
    total_salary { nil }
    team { r = rand(0..1)
           if r == 0
             'blue'
           else
             'rojo'
           end
    }
  end
end
