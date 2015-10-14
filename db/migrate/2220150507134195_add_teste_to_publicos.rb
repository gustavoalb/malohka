class AddTesteToPublicos < ActiveRecord::Migration
  def change
    add_column :publicos, :teste, :decimal, :precision => 3, :scale => 2
    add_column :publicos, :teste1, :float, :precision => 3, :scale => 2
  end
end
