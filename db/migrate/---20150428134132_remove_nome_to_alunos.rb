class RemoveNomeToAlunos < ActiveRecord::Migration
  def change
    remove_column :alunos, :nome, :string
    remove_column :alunos, :nascimento, :date
    remove_column :alunos, :rg, :string
    remove_column :alunos, :cpf, :string
    remove_column :alunos, :telefone, :string
    remove_column :alunos, :endereco, :string
  end
end
