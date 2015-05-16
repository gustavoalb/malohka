class AddStatusFromIestudantis < ActiveRecord::Migration
  def change
    add_column :iestudantis, :status, :string
  end
end
