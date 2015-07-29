class AddQntHorasIdToPeriodo < ActiveRecord::Migration
  def change
    add_column :periodos, :qnt_horas, :string
  end
end
