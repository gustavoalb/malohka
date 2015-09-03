class CreatePublicosComponentes < ActiveRecord::Migration
  def change
    create_table :publicos_componentes do |t|
      t.integer :publico_id
      t.integer :componente_id
    end
  end
end
