class AddStatusToPessoas < ActiveRecord::Migration
  def change
    add_column :pessoas, :status, :string
  end
end
