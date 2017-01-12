class AddDeletedByToThicknessRecords < ActiveRecord::Migration

  def change

    change_table :thickness_blocks do |t|
      t.integer :deleted_by
    end

    add_foreign_key :thickness_blocks,  :users, column: :deleted_by

    change_table :thickness_checks do |t|
      t.integer :deleted_by
    end

    add_foreign_key :thickness_checks,  :users, column: :deleted_by

  end

end