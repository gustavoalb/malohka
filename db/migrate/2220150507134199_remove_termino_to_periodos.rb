class RemoveTerminoToPeriodos < ActiveRecord::Migration
  def change
    remove_column :periodos, :termino, :datetime
  end
end
