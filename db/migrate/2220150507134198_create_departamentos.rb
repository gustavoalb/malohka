class CreateDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.string :nome
      t.string :sigla
      t.integer :reparticao_id
      t.date :data_criacao
      t.string :portaria_criacao

      t.timestamps null: false
    end
  end
end
