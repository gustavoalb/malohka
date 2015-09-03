class RemovePublicoToComponente < ActiveRecord::Migration
  def change
    remove_column :componentes, :publico, :integer
  end
end
