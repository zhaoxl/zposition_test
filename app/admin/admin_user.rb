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
        file = current_admin_user.temp_upload_images.create(params[:file])
        result = {status: "ok", id: file.id, name: file.image_file_file_name, url: file.url(:thumb), desc: file.image_file_file_name}
      end.to_json)
    end
  end
end
