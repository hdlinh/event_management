class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :ro_name
      t.string :ro_type

      t.timestamps
    end
  end
end
