class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string      :title
      t.string      :content
      t.integer     :position,  default: 0
      t.timestamps
    end
  end
end
