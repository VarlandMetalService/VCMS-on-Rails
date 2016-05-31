class CreateAttachments < ActiveRecord::Migration

  def change

    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.string :name,                   default: nil
      t.string :filename
      t.string :content_type
      t.binary :file_contents,          limit: 16.megabyte
      t.timestamps null: false
    end

  end

end