class AddTipoToComponentes < ActiveRecord::Migration
  def change
    add_column :componentes, :tipo, :integer
  end
end
