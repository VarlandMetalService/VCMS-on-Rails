class AddSupervisorInfoToShiftNotes < ActiveRecord::Migration

  def change

    change_table :shift_notes do |t|
      t.datetime :supervisor_notes_at
      t.integer :supervisor_id
    end

  end

end