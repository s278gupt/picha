class AddMoreColumnsToPictures < ActiveRecord::Migration[6.0]
  def change
    add_column :pictures, :album_id, :integer
  end
end
