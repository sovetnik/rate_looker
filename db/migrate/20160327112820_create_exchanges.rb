class CreateExchanges < ActiveRecord::Migration[5.0]
  def change
    create_table :exchanges do |t|
      t.string :iso_from
      t.string :iso_to
      t.float :fresh_rate
      t.float :custom_rate
      t.datetime :expires_at

      t.timestamps
    end
  end
end
