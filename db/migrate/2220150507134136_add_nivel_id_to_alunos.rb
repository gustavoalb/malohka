class AddNivelIdToAlunos < ActiveRecord::Migration
  def change
    add_column :alunos, :nivel_id, :integer
    add_column :alunos, :status, :string
    add_column :alunos, :ativo, :boolean
  end
end
