class CreateGuts < ActiveRecord::Migration
  def change
    create_table :guts do |t|
      t.integer :iteracao_id
      t.integer :gravidade
      t.integer :urgencia
      t.integer :tendencia

      t.timestamps
    end
  end
end
