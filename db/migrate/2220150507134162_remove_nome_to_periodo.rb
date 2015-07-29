class RemoveNomeToPeriodo < ActiveRecord::Migration
  def change
    remove_column :periodos, :nome, :string
  end
end
