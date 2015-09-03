class AddAttachmentFotoToMinistrantes < ActiveRecord::Migration
  def self.up
    change_table :ministrantes do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :ministrantes, :foto
  end
end
