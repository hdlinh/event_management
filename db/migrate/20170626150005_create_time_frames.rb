class CreateTimeFrames < ActiveRecord::Migration[5.0]
  def change
    create_table :time_frames do |t|
      t.string :tf_title
      t.datetime :tf_start
      t.datetime :tf_end
      t.integer :speaker_id
      t.integer :event_id
      t.integer :ro_id

      t.timestamps
    end
  end
end
