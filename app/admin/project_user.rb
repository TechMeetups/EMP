ActiveAdmin.register ProjectUser do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  index do
    column "Project_Type", :project_type
    column "User", :user_id
    actions :defaults => false do |project_user|
      link_to image_tag( "../assets/view.png", :style=>"width:15px;"),admin_project_user_path(project_user)      
    end

    actions :defaults => false do |project_user|
      link_to image_tag( "../assets/edit1.png", :style=>"width:15px;"),edit_admin_project_user_path(project_user)      
    end

    actions :defaults => false do |project_user|
      link_to image_tag( "../assets/trash.png", :style=>"width:15px;"),admin_project_user_path(project_user) , :confirm => 'Are you sure?', :method => :delete      
    end
  end
     permit_params :user_id, :project_id, :project_type

  
end
