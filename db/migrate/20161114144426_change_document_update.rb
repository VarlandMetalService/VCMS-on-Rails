class ChangeDocumentUpdate < ActiveRecord::Migration

  def change

    change_table :documents do |t|
      t.remove :document_updated_at
      t.date :document_updated_on
    end

  end

end