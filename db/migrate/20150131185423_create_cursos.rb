class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :nome
      t.string :codigo
      t.integer :nivel_id

      t.timestamps
    end
  end
end
