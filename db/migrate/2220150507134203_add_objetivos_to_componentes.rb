class AddObjetivosToComponentes < ActiveRecord::Migration
  def change
    add_column :componentes, :objetivos, :string
  end
end
