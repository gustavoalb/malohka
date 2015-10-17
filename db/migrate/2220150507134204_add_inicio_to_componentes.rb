class AddInicioToComponentes < ActiveRecord::Migration
  def change
    add_column :componentes, :inicio, :datetime
  end
end
