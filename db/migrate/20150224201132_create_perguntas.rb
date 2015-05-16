class CreatePerguntas < ActiveRecord::Migration
  def change
    create_table :perguntas do |t|
      t.integer :pesquisa_id
      t.text :conteudo

      t.timestamps
    end
  end
end
