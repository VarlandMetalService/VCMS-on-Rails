class AddGoogleDriveFolderToCategories < ActiveRecord::Migration

  def change

    change_table :categories do |t|
      t.string :google_drive_folder
    end

  end

end