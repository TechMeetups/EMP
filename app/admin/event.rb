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
      f.input :user_id ,:as => :select, :collection => User.all.map {|a| ["#{a.name}",a.id]}
      f.input :title
      f.input :s_date
      f.input :e_date
      f.input :s_time
      f.input :e_time
      f.input :description 
      f.input :twitter_hash_tag  
    end
    f.actions
  end

    index do
    column "Title", :title
    column "Starting_Date", :s_date
    column "Ending_Date", :e_date
    column "Starting Time", :s_time
    column "End Time", :e_time
    
    actions :defaults => false do |event|
     link_to image_tag( "../assets/view.png", :style=>"width:15px;"), admin_event_path(event)

    end
    actions :defaults => false do |event|
     link_to image_tag( "../assets/edit1.png", :style=>"width:15px;"), edit_admin_event_path(event)

    end
    actions :defaults => false do |event|
       link_to image_tag( "../assets/trash.png", :style=>"width:15px;"),admin_event_path(event), :confirm => 'Are you sure?', :method => :delete 
    end
  end
  permit_params  :user_id, :title, :s_date, :e_date, :s_time, :e_time, :description, :twitter_hash_tag
end
