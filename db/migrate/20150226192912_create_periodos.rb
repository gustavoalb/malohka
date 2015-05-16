class CreatePeriodos < ActiveRecord::Migration
  def change
    create_table :periodos do |t|
      t.integer :evento_id
      t.datetime :inicio
      t.datetime :termino

      t.timestamps
    end
  end
end
