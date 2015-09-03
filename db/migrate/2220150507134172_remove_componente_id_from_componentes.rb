class RemoveComponenteIdFromComponentes < ActiveRecord::Migration
  def change
    remove_column :componentes, :componente_id, :integer
  end
end
