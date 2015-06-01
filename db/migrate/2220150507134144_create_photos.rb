class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
