ActiveAdmin.register City do

  
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

    actions :defaults => false do |city|
      link_to image_tag( "../assets/view.png", :style=>"width:15px;"),admin_city_path(city)      
    end

    actions :defaults => false do |city|
      link_to image_tag( "../assets/edit1.png", :style=>"width:15px;"),edit_admin_city_path(city)      
    end

    actions :defaults => false do |city|
      link_to image_tag( "../assets/trash.png", :style=>"width:15px;"),admin_city_path(city) , :confirm => 'Are you sure?', :method => :delete      
    end
  end
  permit_params :name
end
