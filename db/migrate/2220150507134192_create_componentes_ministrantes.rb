class CreateComponentesMinistrantes < ActiveRecord::Migration
  def change
    create_table :componentes_ministrantes do |t|
      t.integer :ministrante_id
      t.integer :componente_id
    end
  end
end
