class CreateAlunos < ActiveRecord::Migration
  def change
    create_table :alunos do |t|
      #t.string :nome
      #t.date :nascimento
      #t.string :rg
      t.string :matricula
      t.integer :ano_ingresso
      t.integer :turma_id
      t.integer :curso_id
      t.string :semestre_atual
      t.string :curso
      t.integer :pessoa_id

      t.timestamps
    end
  end
end
