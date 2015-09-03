class AddVagasToComponentes < ActiveRecord::Migration
  def change
    add_column :componentes, :vagas, :integer
    add_column :componentes, :publico, :integer
    add_column :componentes, :tipo_componente, :integer
    add_column :componentes, :local, :integer
  end
end
