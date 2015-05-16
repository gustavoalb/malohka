class CreateRespostas < ActiveRecord::Migration
  def change
    create_table :respostas do |t|
      t.integer :pergunta_id
      t.string :conteudo

      t.timestamps
    end
  end
end
