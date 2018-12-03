class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :shipper
      t.string :recipient
      t.integer :total_weight
      t.decimal :total_charge
      t.integer :overweight

      t.timestamps
    end
  end
end
