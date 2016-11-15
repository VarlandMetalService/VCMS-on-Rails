class AddExcludeFromNewest < ActiveRecord::Migration

  def change

    change_table :documents do |t|
      t.boolean :exclude_from_newest, default: false
    end

  end

end