class CreateShiftNotes < ActiveRecord::Migration

  def change

    create_table :shift_notes do |t|
      t.integer     :entered_by
      t.date        :note_on
      t.integer     :shift
      t.string      :ip_address
      t.integer     :department,    default: nil
      t.string      :note_type,     default: nil
      t.text        :notes
      t.timestamps  null: false
    end

    add_foreign_key :shift_notes,  :users, column: :entered_by

  end

end