class AddCapaToNoticias < ActiveRecord::Migration
  def change
    add_column :noticias, :capa_id, :string
  end
end
