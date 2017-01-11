class CreateThicknessChecks < ActiveRecord::Migration

  def change

    create_table :thickness_checks do |t|
      t.integer     :thickness_block_id
      t.datetime    :check_at
      t.integer     :check
      t.decimal     :thickness,         precision: 8,   scale: 5
      t.decimal     :alloy_percentage,  precision: 8,   scale: 5,  default: nil
      t.decimal     :x,                 precision: 8,   scale: 5
      t.decimal     :y,                 precision: 8,   scale: 5
      t.decimal     :z,                 precision: 8,   scale: 5
      t.timestamps  null: false
    end

    add_foreign_key :thickness_checks,  :thickness_blocks, column: :thickness_block_id

  end

end