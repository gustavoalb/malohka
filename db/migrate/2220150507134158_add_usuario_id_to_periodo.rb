class AddUsuarioIdToPeriodo < ActiveRecord::Migration
  def change
    add_column :periodos, :nome, :string
    remove_column :periodos, :usuario_id: :integer
  end
end
