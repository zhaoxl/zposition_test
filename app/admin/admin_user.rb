#Encoding: utf-8
ActiveAdmin.register AdminUser do
  
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  
  controller do
    config.skip_before_filter :ajax_upload_temp_image
    
    #上传图片到用户临时上传文件夹
    def ajax_upload_temp_image
      render(json: ajax_frame do |result|
        Image.transaction do
          img = current_admin_user.temp_upload_images.create(image_file: params[:file])
          result = {status: 1, id: img.id, name: img.image_file_file_name, url: img.image_file(:thumb), desc: ""}
        end
      end.to_json)
    end
    
    #删除用户的临时上传图片
    def ajax_destroy_temp_image
      render(json: ajax_frame do |result|
        current_admin_user.temp_upload_images.destroy(params[:id])
      end.to_json)
    end
  end
end
