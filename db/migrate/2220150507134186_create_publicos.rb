class CreatePublicos < ActiveRecord::Migration
  def change
    create_table :publicos do |t|
      t.string :nome
      t.string :descricao

      t.timestamps null: false
    end
  end
end
