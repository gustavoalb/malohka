class CreateNiveis < ActiveRecord::Migration
  def change
    create_table :niveis do |t|
      t.string :nome
      t.string :codigo

      t.timestamps
    end
  end
end
