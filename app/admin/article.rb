#Encoding: utf-8
ActiveAdmin.register Article do
  config.sort_order = "position_asc"
  config.batch_actions = false
  
  index do
    column :id
    column "标题", :title
    column "创建时间", :created_at
    column "显示顺序", :position
    column "" do |article|
      render :partial => "zposition", locals: {resource: article, resource_type: :article}
    end
    default_actions
  end
  
  form :partial => "content"
  
  member_action :update, :method => :put do
    article = Article.find(params[:id])
    article.update_attributes(params[:article])
    redirect_to admin_articles_path
  end
  
  member_action :move_to, method: :get do
    article = Article.find(params[:id])
    article.send("move_to_#{params[:act]}")
    redirect_to admin_articles_path
  end
end
