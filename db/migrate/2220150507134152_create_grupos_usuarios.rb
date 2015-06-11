class CreateGruposUsuarios < ActiveRecord::Migration
  def change
    create_table :grupos_usuarios do |t|
      t.integer :usuario_id
      t.integer :grupo_id
    end
  end
end
