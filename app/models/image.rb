#Encoding: utf-8
require 'paperclip_processors/watermark'
class Image < ActiveRecord::Base
  attr_accessible :item_id, :item_type, :image_file
  has_attached_file :image_file, :processors => [:watermark], :styles => { :medium => "300x300>", 
                                              :thumb => "100x100>",
                                              :original => {:geometry => '550x400>',  
                                                            :watermark_path => "#{Rails.root}/public/watermark.png",#水印图片所在位置  
                                                            :position => 'SouthEast'
                                                          }
                                              }, 
                                              :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image_file, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :item , polymorphic: true
end
