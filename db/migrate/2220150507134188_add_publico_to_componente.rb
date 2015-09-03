class AddPublicoToComponente < ActiveRecord::Migration
  def change
    add_column :componentes, :publico, :integer
  end
end
