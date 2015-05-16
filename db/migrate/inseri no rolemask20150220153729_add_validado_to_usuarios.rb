class AddValidadoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :validado, :boolean, defaut:false
  end
end
