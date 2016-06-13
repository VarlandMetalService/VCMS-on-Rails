class AddFileToAttachments < ActiveRecord::Migration

  def change

    change_table :attachments do |t|
      t.string :file
    end

  end

end