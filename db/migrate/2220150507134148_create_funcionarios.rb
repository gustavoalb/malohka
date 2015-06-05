class CreateFuncionarios < ActiveRecord::Migration
  def change
    create_table :funcionarios do |t|
      t.string :matricula
      t.string :cargo
      t.integer :cargo_id
      t.date :data_posse
      t.integer :pessoa_id

      t.timestamps
    end
  end
end
