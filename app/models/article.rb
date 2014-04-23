#Encoding: utf-8
class Article < ActiveRecord::Base
  attr_accessible :title, :content, :position
  has_many :images, as: :item, dependent: :destroy
  
  z_position debug: true
end
