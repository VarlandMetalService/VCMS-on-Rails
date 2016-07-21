class CreateDocuments < ActiveRecord::Migration

  def change

    create_table :documents do |t|
      t.integer     :added_by
      t.string      :name
      t.datetime    :document_updated_at
      t.boolean     :is_valid
      t.string      :content_type
      t.string      :file
      t.string      :google_url,          default: nil
      t.string      :google_id,           default: nil
      t.text        :google_contents,     default: nil
      t.datetime    :google_updated_at,   default: nil
      t.timestamps  null: false
    end

    create_table :categories do |t|
      t.string      :name
      t.integer     :parent_id,         :null => true,    :index => true
      t.integer     :lft,               :null => false,   :index => true
      t.integer     :rgt,               :null => false,   :index => true
      t.integer     :depth,             :null => false,   :default => 0
      t.integer     :children_count,    :null => false,   :default => 0
      t.timestamps  null: false
    end

    create_table :categories_documents, id: false do |t|
      t.belongs_to :document,   index: true
      t.belongs_to :category,   index: true
    end

  end

end