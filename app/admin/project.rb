ActiveAdmin.register Project do

  
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
   filter :title
  filter :s_date
  filter :e_date
  form do |f|
    f.inputs "Details" do
      f.input :user_id ,:as => :select, :collection => User.all.map {|a| ["#{a.name}",a.id]}
      f.input :title
      f.input :s_date
      f.input :e_date
      f.input :project_type ,:as => :select, :collection => ProjectType.all.map {|a| ["#{a.name}",a.id]}
      f.input :description 
      f.input :twitter_hash_tag  
      #f.input :event_user ,:as => :select, :collection => EventUser.all.map {|a| ["#{a.name}",a.id]}
    end
    f.actions
  end

    index do
    column "Title", :title
    column "Starting_Date", :s_date
    column "Ending_Date", :e_date
    column "Description", :description
    
    actions :defaults => false do |project|
     link_to image_tag( "../assets/view.png", :style=>"width:15px;"), admin_project_path(project)

    end
    actions :defaults => false do |project|
     link_to image_tag( "../assets/edit1.png", :style=>"width:15px;"), edit_admin_project_path(project)

    end
    actions :defaults => false do |project|
       link_to image_tag( "../assets/trash.png", :style=>"width:15px;"),admin_project_path(project), :confirm => 'Are you sure?', :method => :delete 
    end

    

  end
  controller do
      def create
      super
      debugger
      @project.project_users.create(user_id: @project.user_id,project_type: "Host")
      @project.project_users.create(user_id: @project.user_id,project_type: "Venue")
    end 
    end 
  permit_params  :user_id, :title, :s_date, :e_date, :description, :twitter_hash_tag, :project_type
end

