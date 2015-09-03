class AddPresencaToParticipacoes < ActiveRecord::Migration
  def change
    add_column :participacoes, :frequencia, :boolean, :default=>false
  end
end
