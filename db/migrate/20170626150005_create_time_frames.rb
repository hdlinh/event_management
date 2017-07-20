class CreateTimeFrames < ActiveRecord::Migration[5.0]
  def change
    create_table :time_frames do |t|
      t.string :tf_title
      t.datetime :tf_start
      t.datetime :tf_end
<<<<<<< c6d9b688134958d63ccb458b5ddfd790a4a63628
      t.integer :sp_id
      t.integer :ev_id
=======
      t.integer :speaker_id
      t.integer :event_id
>>>>>>> next task
      t.integer :ro_id

      t.timestamps
    end
  end
end
