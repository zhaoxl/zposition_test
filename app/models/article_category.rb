class ArticleCategory < ActiveRecord::Base
  attr_accessible :name
  acts_as_nested_set
  z_position debug: true, acts_as_nested_set: true
  
end
