class RemoveResumoFromNoticias < ActiveRecord::Migration
  def change
    remove_column :noticias, :resumo, :string
    remove_column :noticias, :capa_file_name, :string
    remove_column :noticias, :capa_content_type, :string
    remove_column :noticias, :capa_file_size, :integer
    remove_column :noticias, :capa_updated_at, :datetime
  end
end
