class AddDeleteFlagToThicknessRecords < ActiveRecord::Migration

  def change

    change_table :thickness_blocks do |t|
      t.boolean :is_deleted,    :default => false
    end

    change_table :thickness_checks do |t|
      t.boolean :is_deleted,    :default => false
    end

  end

end