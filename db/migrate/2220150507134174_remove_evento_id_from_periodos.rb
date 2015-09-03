class RemoveEventoIdFromPeriodos < ActiveRecord::Migration
  def change
    remove_column :periodos, :evento_id, :integer
    remove_column :periodos, :qnt_horas, :string
    remove_column :periodos, :componente, :string
    remove_column :periodos, :descricao, :text
  end
end
