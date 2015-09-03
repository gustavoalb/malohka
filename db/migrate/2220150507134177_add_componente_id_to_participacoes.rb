class AddComponenteIdToParticipacoes < ActiveRecord::Migration
  def change
    add_column :participacoes, :componente_id, :integer
  end
end
