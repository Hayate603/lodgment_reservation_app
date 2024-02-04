class AddPrefectureToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :prefecture, :string
  end
end
