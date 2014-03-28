ActiveAdmin.register Event do

  
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
      f.input :user_id
      f.input :s_date
      f.input :s_time
      f.input :e_time
      f.input :title
      #f.input :city, :type => :select,:collection => City.all.collect {|a| [a.name, a.id]}
      
    end
    f.actions
  end
  permit_params  :user_id, :title, :s_date, :s_time, :e_time

    index do
   
    
    column "Title", :title
    column "Date", :s_date
    column "Starting Time", :s_time
    column "End Time", :e_time
    
    actions :defaults => false do |event|
     link_to "View", admin_event_path(event)

    end
    actions :defaults => false do |event|
     link_to "Edit", edit_admin_event_path(event)

    end
    actions :defaults => false do |event|
       link_to 'Delete',admin_event_path(event), :confirm => 'Are you sure?', :method => :delete 
    end
  end
end