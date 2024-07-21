class AddPointToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :point, :integer
    add_reference :posts, :game, foreign_key: true
  end
end
