class Article < ActiveRecord::Base
  attr_accessible :title, :content, :position
  
  
  z_position debug: true
end
