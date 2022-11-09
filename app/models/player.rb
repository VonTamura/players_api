class Player < ApplicationRecord
  validates :name, :level, :goals, :salary, :bonus, :team, presence: true
end
