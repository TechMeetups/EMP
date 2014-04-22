ActiveAdmin.register User do


  
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
  filter :name
  filter :city
  filter :company
  filter :user_type
  form do |f|
    f.inputs "Details" do
      
      f.input :city_id, :as => :select,:collection => City.all.map {|a| ["#{a.name}",a.id]}
      f.input :email
      f.input :password
      f.input :name
      f.input :company
      f.input :address
      f.input :user_type, :as => :radio, :collection =>[ 'Startup', 'Mentor', 'Investor', 'developer']
      f.input :description,:required => false
      f.input :twitter
      f.input :facebook
      f.input :linkedin
      f.input :avatar ,:as => :file      
    end
    f.actions
  end

  index do
    column "Name", :name
    column "Type", :user_type
    column "Company", :company
    column "City" ,:city

    actions :defaults => false do |user|
     link_to image_tag( "../assets/view.png", :style=>"width:15px;"),admin_user_path(user)      
    end
    actions :defaults => false do |user|
     link_to image_tag( "../assets/edit1.png", :style=>"width:15px;"), edit_admin_user_path(user)
    end
    actions :defaults => false do |user|
      link_to image_tag( "../assets/trash.png", :style=>"width:15px;"),admin_user_path(user), :confirm => 'Are you sure?', :method => :delete 
    end
  end
  
  permit_params :city_id, :email, :password, :company, :address, :user_type, :description, :twitter, :facebook, :linkedin, :avatar, :name
end
