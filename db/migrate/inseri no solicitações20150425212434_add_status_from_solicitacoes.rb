class AddStatusFromSolicitacoes < ActiveRecord::Migration
  def change
    add_column :solicitacoes, :status, :string
  end
end
