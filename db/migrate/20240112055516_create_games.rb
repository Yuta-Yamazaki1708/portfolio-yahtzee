class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :one
      t.integer :two
      t.integer :three
      t.integer :four
      t.integer :five
      t.integer :six
      t.integer :bonus
      t.integer :choice
      t.integer :four_dices
      t.integer :full_house
      t.integer :small_straight
      t.integer :big_straight
      t.integer :yahtzee
      t.integer :sum

      t.timestamps
    end
  end
end
