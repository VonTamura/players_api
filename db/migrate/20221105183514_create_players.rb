class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :level
      t.integer :goals
      t.decimal :salary
      t.decimal :bonus
      t.decimal :total_salary
      t.string :team

      t.timestamps
    end
  end
end
