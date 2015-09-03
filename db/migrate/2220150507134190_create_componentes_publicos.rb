class CreateComponentesPublicos < ActiveRecord::Migration
  def change
    create_table :componentes_publicos do |t|
      t.integer :publico_id
      t.integer :componente_id
    end
  end
end
