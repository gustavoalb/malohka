class CreatePaginas < ActiveRecord::Migration
  def change
    create_table :paginas do |t|
      t.string :nome
      t.string :tipo
      t.string :tipo_id
      t.string :permalink
      t.text :conteudo

      t.timestamps
    end
    add_index :paginas, :permalink
  end
end
