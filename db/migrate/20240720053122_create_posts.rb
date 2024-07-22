class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :comment

      t.timestamps
    end
    add_reference :posts, :user, foreign_key: true
    add_reference :posts, :game, foreign_key: true
  end
end
