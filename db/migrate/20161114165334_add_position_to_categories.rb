class AddPositionToCategories < ActiveRecord::Migration

  def change

    change_table :categories do |t|
      t.integer :position
    end

  end

end