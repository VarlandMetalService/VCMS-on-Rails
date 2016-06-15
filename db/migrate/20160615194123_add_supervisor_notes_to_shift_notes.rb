class AddSupervisorNotesToShiftNotes < ActiveRecord::Migration

  def change

    change_table :shift_notes do |t|
      t.text :supervisor_notes,     default: nil
    end

  end

end