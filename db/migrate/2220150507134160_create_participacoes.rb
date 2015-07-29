class CreateParticipacoes < ActiveRecord::Migration
  def change
    create_table :participacoes do |t|
      t.references :periodo, :pessoa
      t.boolean :frequencia

      t.timestamps
    end
  end
end
