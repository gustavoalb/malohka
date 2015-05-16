class AddPublicadoEmToNoticias < ActiveRecord::Migration
  def change
    add_column :noticias, :publicado_em, :datetime
  end
end
