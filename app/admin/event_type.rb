ActiveAdmin.register EventType do

  
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
    column "Name", :name

    actions :defaults => false do |event_type|
      link_to image_tag( "../assets/view.png", :style=>"width:15px;"),admin_event_type_path(event_type)      
    end

    actions :defaults => false do |event_type|
      link_to image_tag( "../assets/edit1.png", :style=>"width:15px;"),edit_admin_event_type_path(event_type)      
    end

    actions :defaults => false do |event_type|
      link_to image_tag( "../assets/trash.png", :style=>"width:15px;"),admin_event_type_path(event_type) , :confirm => 'Are you sure?', :method => :delete      
    end
  end
  
end
