class CreatePaginas < ActiveRecord::Migration
  def change
    create_table :paginas do |t|
      #      t.string :nome
      t.string :permalink
      #     t.text :content

      t.timestamps
    end
    add_index :paginas, :permalink
  end
end
