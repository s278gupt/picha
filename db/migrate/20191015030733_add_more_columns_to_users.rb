class AddMoreColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :album_id, :integer
  end
end
