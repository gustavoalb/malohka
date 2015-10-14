class CreateOrgoes < ActiveRecord::Migration
  def change
    create_table :orgoes do |t|
      t.string :nome
      t.string :sigla

      t.timestamps null: false
    end
  end
end
