class CreateSolicitacoes < ActiveRecord::Migration
  def change
    create_table :solicitacoes do |t|
      t.integer :solicitante_id
      t.integer :solicitavel_id
      t.string :solicitavel_type
      t.boolean :finalizado, default: false
      t.string :status

      t.timestamps
    end
  end
end
