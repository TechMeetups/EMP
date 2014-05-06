ActiveAdmin.register ProjectInteraction do

  
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
    column "Action", :action
    column "Memo", :memo
    column "Status", :status
    actions :defaults => false do |project_interaction|
      link_to image_tag( "../assets/view.png", :style=>"width:15px;"),admin_project_interaction_path(project_interaction)      
    end

    actions :defaults => false do |project_interaction|
      link_to image_tag( "../assets/edit1.png", :style=>"width:15px;"),edit_admin_project_interaction_path(project_interaction)      
    end

    actions :defaults => false do |project_interaction|
      link_to image_tag( "../assets/trash.png", :style=>"width:15px;"),admin_project_interaction_path(project_interaction) , :confirm => 'Are you sure?', :method => :delete      
    end
  end
   permit_params :user_id, :project_id, :action, :memo, :status
  
end
