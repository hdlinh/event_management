class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :role_name
      t.text :role_description

      t.timestamps
    end
  end
end
