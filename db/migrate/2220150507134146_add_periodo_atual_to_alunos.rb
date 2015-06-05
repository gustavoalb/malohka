class AddPeriodoAtualToAlunos < ActiveRecord::Migration
  def change
    add_column :alunos, :periodo_atual, :integer
  end
end
