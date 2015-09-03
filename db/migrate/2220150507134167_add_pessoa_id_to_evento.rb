class AddPessoaIdToEvento < ActiveRecord::Migration
  def change
    add_column :eventos, :pessoa_id, :integer
  end
end
