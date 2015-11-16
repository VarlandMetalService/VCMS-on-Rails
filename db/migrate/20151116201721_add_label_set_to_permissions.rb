class AddLabelSetToPermissions < ActiveRecord::Migration
  
  def change
    
    change_table :permissions do |t|
      t.integer :label_set, default: nil
    end
    
  end
  
end