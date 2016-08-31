class CreateOptoMessages < ActiveRecord::Migration

  def change

    create_table :opto_messages do |t|
      t.string :message_name
      t.datetime :message_at
      t.integer :department
      t.integer :lane,          default: nil
      t.integer :station,       default: nil
      t.integer :shop_order,    default: nil
      t.integer :load,          default: nil
      t.integer :barrel,        default: nil
      t.string :customer,       default: nil
      t.text :message
      t.string :hashed_data
      t.timestamps null: false
    end

    add_index :opto_messages, :hashed_data, unique: true

  end

end