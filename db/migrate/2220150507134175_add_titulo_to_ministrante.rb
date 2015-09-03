class AddTituloToMinistrante < ActiveRecord::Migration
  def change
    add_column :ministrantes, :titulo, :string
  end
end
