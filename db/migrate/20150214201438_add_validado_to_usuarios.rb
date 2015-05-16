class AddValidadoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :roles_mask, :integer
    add_column :usuarios, :validado, :boolean, defaut:false
    add_column :usuarios, :pessoa_id, :integer
  end
end
