class AddStatusToNoticias < ActiveRecord::Migration
  def change
    add_column :noticias, :status, :string
  end
end
