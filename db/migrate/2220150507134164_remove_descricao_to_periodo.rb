class RemoveDescricaoToPeriodo < ActiveRecord::Migration
  def change
    remove_column :periodos, :descricao, :string
    remove_column :periodos, :usuario_id, :integer
  end
end
