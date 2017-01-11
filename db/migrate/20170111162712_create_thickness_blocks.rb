class CreateThicknessBlocks < ActiveRecord::Migration

  def change

    create_table :thickness_blocks do |t|
      t.integer     :user_id,           default: nil
      t.datetime    :block_at
      t.integer     :shop_order
      t.integer     :load
      t.integer     :block
      t.string      :directory
      t.string      :product
      t.string      :application
      t.string      :customer,          default: nil
      t.string      :process,           default: nil
      t.string      :part,              default: nil
      t.string      :sub,               default: nil
      t.timestamps  null: false
    end

    add_foreign_key :thickness_blocks,  :users, column: :user_id

  end

end