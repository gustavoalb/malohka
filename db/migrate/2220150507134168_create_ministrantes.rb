class CreateMinistrantes < ActiveRecord::Migration
  def change
    create_table :ministrantes do |t|
      t.integer :pessoa_id
      t.string :nome
      t.string :organizacao
      t.string :biografia

      t.timestamps null: false
    end
  end
end
