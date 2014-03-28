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


  form do |f|
    f.inputs "Details" do

      #f.input :user_id, :label => 'Member', :as => :select, :collection => User.all.map{|u| ["#{u.last_name}, #{u.first_name}", u.id]}
      
      f.input :city_id, :as => :select,:collection => City.all.map {|a| ["#{a.name}",a.id]}
      f.input :email
      f.input :password
      f.input :name
      f.input :company
      f.input :address
      f.input :user_type
      f.input :description
      f.input :twitter
      f.input :facebook
      f.input :linkedin
      f.input :avatar

#City.find(User.find(@event.user_id).city_id).name
      
    end
    f.actions

  end

  index do
    column "Name", :name
    column "Type", :user_type
    column "Company", :company
    column "City" ,:city
    #  column "City"  do |user|
    # city_name= City.find(user.city_id).name
    #  end

    actions :defaults => false do |user|
     link_to "View", admin_user_path(user)

    end
    actions :defaults => false do |user|
     link_to "Edit", edit_admin_user_path(user)

    end
    actions :defaults => false do |user|
       link_to 'Delete',admin_user_path(user), :confirm => 'Are you sure?', :method => :delete 
    end
  end
  
  permit_params :city_id, :email, :password, :company, :address, :user_type, :description, :twitter, :facebook, :linkedin, :avatar, :name
end
