class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :one, null: false
      t.integer :two, null: false
      t.integer :three, null: false
      t.integer :four, null: false
      t.integer :five, null: false
      t.integer :six, null: false
      t.integer :bonus, null: false
      t.integer :choice, null: false
      t.integer :four_dices, null: false
      t.integer :full_house, null: false
      t.integer :small_straight, null: false
      t.integer :big_straight, null: false
      t.integer :yahtzee, null: false

      t.timestamps
    end
  end
end
