class AddComponenteToPeriodo < ActiveRecord::Migration
  def change
    add_column :periodos, :componente, :string
  end
end
