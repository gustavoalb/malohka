require 'tempfile'
class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def set_picture(data)
    temp_file = Tempfile.new(['temp', '.jpg'], :encoding => 'ascii-8bit')

    begin
      temp_file.write(data)
      self.image = temp_file # assumes has_attached_file :picture
    ensure
      temp_file.close
      temp_file.unlink
    end
  end
end
