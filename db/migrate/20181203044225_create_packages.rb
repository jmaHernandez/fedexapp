class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :shipper
      t.string :recipient
      t.integer :total_weight
      t.decimal :total_charge
      t.integer :overweight
      
      t.string :numero_rastreo
      t.integer :peso_kilogramos
      t.integer :peso_volumetrico
      t.integer :peso_total
      t.integer :fedex_peso_kilogramos
      t.integer :fedex_peso_volumetrico
      t.integer :fedex_peso_total
      t.integer :sobrepeso

      t.timestamps
    end
  end
end
