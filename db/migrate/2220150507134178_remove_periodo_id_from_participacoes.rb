class RemovePeriodoIdFromParticipacoes < ActiveRecord::Migration
  def change
    remove_column :participacoes, :periodo_id, :integer
    remove_column :participacoes, :frequencia, :boolean
  end
end
