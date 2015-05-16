class CreateOcasioes < ActiveRecord::Migration
  def change
    create_table :ocasioes do |t|
      t.integer :evento_id
      t.datetime :inicio
      t.datetime :termino

      t.timestamps
    end
  end
end
