class AddDescricaoToEvento < ActiveRecord::Migration
  def change
    add_column :eventos, :descricao, :text
    add_column :eventos, :status, :string
    add_column :eventos, :responsavel_id, :integer
  end
end
