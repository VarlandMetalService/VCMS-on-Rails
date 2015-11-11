class CreatePermissions < ActiveRecord::Migration
  
  def change
    
    create_table :permissions do |t|
      t.string :permission
      t.string :description
    end
    
    add_index :permissions, :permission, unique: true
    
  end
  
end