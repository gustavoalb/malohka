class AddStatusToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :status, :string
  end
end
