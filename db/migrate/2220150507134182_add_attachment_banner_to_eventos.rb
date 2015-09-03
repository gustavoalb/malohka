class AddAttachmentBannerToEventos < ActiveRecord::Migration
  def self.up
    change_table :eventos do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :eventos, :banner
  end
end
