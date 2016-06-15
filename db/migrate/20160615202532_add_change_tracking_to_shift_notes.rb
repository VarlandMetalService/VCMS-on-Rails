class AddChangeTrackingToShiftNotes < ActiveRecord::Migration

  def change

    change_table :shift_notes do |t|
      t.boolean :author_email_needed
    end

  end

end