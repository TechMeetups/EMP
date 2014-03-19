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
  # index do
  #   column :city, :type => :select,:collection => City.all.collect {|a| [a.id, a.name]}
  #   column :email
  #   column :password
  #   column :name
  #   column :company
  #   column :address
  #   column :user_type
  #   column :description
  #   column :offer
  #   column :looking_for
  #   column :twitter
  #   column :facebook
  #   column :linkedin
  #   column :avatar
  # end


  form do |f|
    f.inputs "Details" do
      #f.input :memberships, :label => 'Membership Type', :as => :select, :collection => Membership.all
      f.input :city, :type => :select,:collection => City.all.collect {|a| [a.name, a.id]}
      f.input :email
      f.input :password
      f.input :name
      f.input :company
      f.input :address
      f.input :user_type
      f.input :description
      f.input :offer
      f.input :looking_for
      f.input :twitter
      f.input :facebook
      f.input :linkedin
      f.input :avatar
      
    end
    f.actions
  end
  permit_params :city, :email, :password, :company, :address, :user_type, :description, :offer, :looking_for, :twitter, :facebook, :linkedin, :avatar, :name
end
