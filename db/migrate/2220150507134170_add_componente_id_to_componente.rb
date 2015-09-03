class AddComponenteIdToComponente < ActiveRecord::Migration
  def change
    add_column :componentes, :componente_id, :integer
  end
end
