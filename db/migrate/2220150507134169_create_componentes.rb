class CreateComponentes < ActiveRecord::Migration
  def change
    create_table :componentes do |t|
      t.integer :evento_id
      t.string :nome
      t.string :qnt_horas
      t.text :descricao
      t.string :status
      t.integer :ministrante_id

      t.timestamps
    end
  end
end
