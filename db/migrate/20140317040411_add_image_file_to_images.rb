class AddImageFileToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :image_file
  end

  def self.down
    remove_attachment :images, :image_file
  end
end
