class AddOrganizacaoToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :organizacao, :text
    add_column :eventos, :parceiros, :text
    add_column :eventos, :apoio, :text
  end
end
