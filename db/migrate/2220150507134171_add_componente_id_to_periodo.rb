class AddComponenteIdToPeriodo < ActiveRecord::Migration
  def change
    add_column :periodos, :componente_id, :integer
  end
end
