class CreateComponentesPessoas < ActiveRecord::Migration
  def change
    create_table :componentes_pessoas do |t|
      t.integer :componente_id
      t.integer :pessoa_id
    end
  end
end
