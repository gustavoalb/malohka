class AddTipoToPaginas < ActiveRecord::Migration
  def change
    add_column :paginas, :tipo, :string
    add_column :paginas, :conteudo, :text
    add_column :paginas, :tipo_id, :integer
  end
end
