class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nome
      t.text :descricao
      t.string :status
      t.integer :responsavel_id
      t.integer :pessoa_id

      t.timestamps
    end
  end
end
