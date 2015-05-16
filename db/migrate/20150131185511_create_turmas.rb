class CreateTurmas < ActiveRecord::Migration
  def change
    create_table :turmas do |t|
      t.string :nome
      t.string :codigo
      t.integer :turno
      t.integer :curso_id

      t.timestamps
    end
  end
end
