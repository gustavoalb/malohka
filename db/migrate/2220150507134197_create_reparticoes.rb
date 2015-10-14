class CreateReparticoes < ActiveRecord::Migration
  def change
    create_table :reparticoes do |t|
      t.string :nome
      t.string :sigla
      t.integer :orgao_id
      t.text :descricao
      t.date :data_criacao

      t.timestamps null: false
    end
  end
end
