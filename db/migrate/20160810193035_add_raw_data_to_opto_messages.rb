class AddRawDataToOptoMessages < ActiveRecord::Migration

  def change

    change_table :opto_messages do |t|
      t.text :raw_data
    end

  end

end