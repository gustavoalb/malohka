class AddAttachmentFotoToPessoas < ActiveRecord::Migration
  def self.up
    change_table :pessoas do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :pessoas, :foto
  end
end
