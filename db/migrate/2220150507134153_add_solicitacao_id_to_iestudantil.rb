class AddSolicitacaoIdToIestudantil < ActiveRecord::Migration
  def change
    add_column    :iestudantis, :solicitacao_id, :integer
    remove_column :iestudantis, :impresso, :boolean
    remove_column :iestudantis, :entregue, :boolean
  end
end
