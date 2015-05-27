class AddLoteToIestudantis < ActiveRecord::Migration
  def change
    add_column :iestudantis, :data_lote, :datetime
    add_column :iestudantis, :data_impressao, :datetime
    add_column :iestudantis, :data_entrega, :datetime
    add_column :iestudantis, :data_finalizacao, :datetime
  end
end
