class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string  :name
      #zposition
      t.integer :position, default: 0
      #awesome_nested_set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth # this is optional.
    end
  end
end
