class AddDescricaoToPeriodo < ActiveRecord::Migration
  def change
    add_column :periodos, :descricao, :text
  end
end
