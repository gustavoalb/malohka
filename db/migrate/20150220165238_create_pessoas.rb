class CreatePessoas < ActiveRecord::Migration
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.string :cpf
      t.string :rg
      t.date :nascimento
      t.string :email
      t.attachment :foto

      t.timestamps
    end
  end
end
