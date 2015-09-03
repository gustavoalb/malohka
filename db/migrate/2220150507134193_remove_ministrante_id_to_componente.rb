class RemoveMinistranteIdToComponente < ActiveRecord::Migration
  def change
    remove_column :componentes, :ministrante_id, :integer
    remove_column :componentes, :qnt_horas, :string
    remove_column :componentes, :publico, :integer
  end
end
