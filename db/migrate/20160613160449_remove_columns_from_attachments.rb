class RemoveColumnsFromAttachments < ActiveRecord::Migration

  def change

    change_table :attachments do |t|
      t.remove :name, :filename, :file_contents
    end

  end

end