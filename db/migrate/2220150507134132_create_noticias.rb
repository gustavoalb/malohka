class CreateNoticias < ActiveRecord::Migration
  def change
    create_table :noticias do |t|
      t.string :titulo
      t.text :conteudo
      t.datetime :publicado_em
      t.boolean :publicado
      t.boolean :destaque
      t.boolean :pauta

      t.timestamps
    end
  end
end
