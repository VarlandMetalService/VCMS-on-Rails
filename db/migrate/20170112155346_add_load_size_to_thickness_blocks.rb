class AddLoadSizeToThicknessBlocks < ActiveRecord::Migration

  def change

    change_table :thickness_blocks do |t|
      t.decimal     :pounds,              precision: 6,     scale: 2
      t.decimal     :piece_weight,        precision: 10,    scale: 6
      t.decimal     :part_area,           precision: 10,    scale: 6
      t.decimal     :pounds_per_cubic,    precision: 7,     scale: 2
    end

  end

end