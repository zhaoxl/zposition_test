ActiveAdmin.register Article do
  index do
    column :id
    column :title
    column :position
    default_actions
  end
  
  form :partial => "content"
  
  member_action :update, :method => :put do
    article = Article.find(params[:id])
    article.update_attributes(params[:article])
    redirect_to admin_articles_path
  end
end
