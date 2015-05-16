class CreateIestudantis < ActiveRecord::Migration
  def change
    create_table :iestudantis do |t|
      t.boolean :impresso, default: false
      t.boolean :entregue, default: false
      t.integer :aluno_id
      t.string :status

      t.timestamps
    end
  end
end
