class CreateIteracoes < ActiveRecord::Migration
  def change
    create_table :iteracoes do |t|
      t.string :nome
      t.string :status

      t.timestamps
    end
  end
end
