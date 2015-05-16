class AddPessoaidToAlunos < ActiveRecord::Migration
  def change
    add_column :alunos, :pessoa_id, :integer
  end
end
