class AddColumnToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :point, :integer
  end
end
