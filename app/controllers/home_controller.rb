
class HomeController < ApplicationController
  def index
    @events = Event.all
    @user = current_user if user_signed_in?   
  end

  def notifications
    @interaction =Interaction.new
    @events_ids = current_user.events.collect(&:id)
    @interactions =[]
    @events_ids.each do |event_id|
      if Interaction.all.collect(&:event_id).include? event_id
        @interactions += Interaction.find_all_by_event_id(event_id)
      end
    end
  end

  def project_notifications
    @project_interaction =ProjectInteraction.new
    @projects_ids = current_user.projects.collect(&:id)
    @project_interactions =[]
    @projects_ids.each do |project_id|
      if ProjectInteraction.all.collect(&:project_id).include? project_id
        @project_interactions += ProjectInteraction.find_all_by_project_id(project_id)
      end
    end
  end

  def accept_proposal    
    @interaction = Interaction.find(params["interaction_id"])
    @event_user = EventUser.new(event_id: @interaction.event_id, user_id: @interaction.user_id)
    @event_user.event_type = "Speaker" if @interaction.action == "Become Speaker"
    @event_user.event_type = "Partner" if @interaction.action == "Become Partner"
    @event_user.event_type = "Attendee" if @interaction.action == "Attend event"
    @event_user.save
    @interaction.update(status: true) 
    redirect_to notifications_path
  end

  def project_accept_proposal    
    @project_interaction = ProjectInteraction.find(params["project_interaction_id"])
    @project_user = ProjectUser.new(project_id: @project_interaction.project_id, user_id: @project_interaction.user_id)
    @project_user.event_type = "Speaker" if @project_interaction.action == "Become Speaker"
    @project_user.event_type = "Partner" if @project_interaction.action == "Become Partner"
    @project_user.event_type = "Attendee" if @project_interaction.action == "Attend event"
    @project_user.save
    @project_interaction.update(status: true) 
    redirect_to notifications_path
  end

  def add_banners    
    @event = Event.find(params["event_id"])
    if !params["file-0"].nil?
      @banner = @event.event_banners.build(file: params["file-0"], featured: params[:featured])
      @banner.save
    end
    @banners = @event.event_banners
  end

  def add_project_banners    
    @project = Project.find(params["project_id"])
    if !params["file-0"].nil?
      @project_banner = @project.project_banners.build(file: params["file-0"], featured: params[:featured])
      @project_banner.save
    end
    @project_banners = @project.project_banners
  end

  def banner_destroy
    @event_banner = EventBanner.find(params["banner_id"])
    @event_banner.destroy
    @event = Event.find(@event_banner.event_id)
    @banners = @event.event_banners
    redirect_to :back
  end

  def project_banner_destroy
    @project_banner = ProjectBanner.find(params["banner_id"])
    @project_banner.destroy
    @project = Project.find(@project_banner.project_id)
    @project_banners = @project.project_banner
    redirect_to :back
  end

  def add_more
    @event = Event.find(params[:event_user][:event_id])
    if event_user_param["user_id"].split(",").count >= 2
      event_user_param["user_id"].split(",").each do |user_id|
        if EventUser.find_by_user_id_and_event_id_and_event_type(user_id, event_user_param["event_id"], event_user_param['event_type']).nil?
          @event_user = EventUser.create(:user_id=>user_id, :event_id=>event_user_param["event_id"], :event_type=> event_user_param['event_type'])
        end
      end
    else
      if EventUser.find_by_user_id_and_event_id_and_event_type(event_user_param["user_id"], event_user_param["event_id"], event_user_param['event_type']).nil?
        @event_user = EventUser.create(event_user_param)
      end
    end
    if !@event_user.nil?
      add_participants
    end
  end

  def add_more_project
    @project = Project.find(params[:project_user][:project_id])
    if project_user_param["user_id"].split(",").count >= 2
      project_user_param["user_id"].split(",").each do |user_id|
        if ProjectUser.find_by_user_id_and_project_id_and_project_type(user_id, project_user_param["project_id"], project_user_param['project_type']).nil?
          @project_user = ProjectUser.create(:user_id=>user_id, :project_id=>project_user_param["project_id"], :project_type=> project_user_param['project_type'])
        end
      end
    else
      if ProjectUser.find_by_user_id_and_project_id_and_project_type(project_user_param["user_id"], project_user_param["project_id"], project_user_param['project_type']).nil?
        @project_user = ProjectUser.create(project_user_param)
      end
    end
    if !@project_user.nil?
      add_project_participants
    end
  end


  def host_change
    @event=Event.find(params[:event_user][:event_id])
    @event_user=@event.event_users.where(event_type: "Host").first   
     @add_event_user = EventUser.new
     if @event_user.nil?
      @event.event_users.create(user_id: event_user_param[:user_id],event_type: "Host")
    else 
      @event_user.update(user_id: event_user_param[:user_id])
    end
  end

  def project_host_change
    @project=Project.find(params[:project_user][:project_id])
    @project_user=@project.project_users.where(project_type: "Host").first   
     @add_project_user = ProjectUser.new
     if @project_user.nil?
      @project.project_users.create(user_id: project_user_param[:user_id],project_type: "Host")
    else 
      @project_user.update(user_id: project_user_param[:user_id])
    end
  end

  def change_user
   @image_user = User.find(params[:user_id])
   @venue_user = params[:user]
  end

  def venue_change
    @event=Event.find(params[:event_user][:event_id])
    @event_user=@event.event_users.where(event_type: "Venue").first
     @add_event_user = EventUser.new
     if @event_user.nil?
      @event.event_users.create(user_id: event_user_param[:user_id],event_type: "Venue")
    else 
      @event_user.update(user_id: event_user_param[:user_id])
    end
  end

   def project_venue_change
    @project=Project.find(params[:project_user][:project_id])
    @project_user=@project.project_users.where(project_type: "Venue").first
     @add_project_user = ProjectUser.new
     if @project_user.nil?
      @project.project_users.create(user_id: project_user_param[:user_id],project_type: "Venue")
    else 
      @project_user.update(user_id: project_user_param[:user_id])
    end
  end

  def looking_for
     @user = current_user
     if params[:looking_for]!="undefined" 
      if !params[:looking_for].blank? && params[:view]=="true" 
        @user.set_tag_list_on(:looking_for_tags,params[:looking_for])
        @user.save
      end
    end
  end
  def offer
     @user = current_user
    if params[:offer]!="undefined" 
      if !params[:offer].blank? && params[:view]=="true" 
        @user.set_tag_list_on(:offer_tags,params[:offer])
        @user.save
      end
    end
  end

  def update_avatar
    if !params["file-0"].nil?
      current_user.avatar = params["file-0"]
      current_user.save
    end
  end

  def profile
    @user = User.find(params[:id])
    @speakers = @partners = @attendee = []
    @speakers = EventUser.find(:all, :conditions=>["user_id = ? AND event_type = ?", @user.id, "Speaker"] )
    @partners = EventUser.find(:all, :conditions=>["user_id = ? AND event_type = ?", @user.id, "Partner"] )
    @attendee = EventUser.find(:all, :conditions=>["user_id = ? AND event_type = ?", @user.id, "Attendee"] )
  end

  def destroy_event_user
    @event_user = EventUser.find(params[:format])
    @event_user.destroy
    if @event_user.event_type == "Speaker"
      flash[:notice] = "Speaker Succesfully Deleted"
    elsif @event_user.event_type == "Attendee"
      flash[:notice] = "Attendee Succesfully Deleted"      
    else
       flash[:notice] = "Partner Succesfully Deleted"
    end
    redirect_to :back
  end

  def destroy_project_user
    @project_user = ProjectUser.find(params[:format])
    @project_user.destroy
    if @project_user.project_type == "Team"
      flash[:notice] = "Team Succesfully Deleted"
    elsif @project_user.project_type == "Follower"
      flash[:notice] = "Followers Succesfully Deleted"      
    else
       flash[:notice] = "Partner Succesfully Deleted"
    end
    redirect_to :back
  end

  def import_event 
    @results_events=[]
    @results_attendees=[]
    @count = (params[:page].blank? ? 1 : (params[:page].to_i))
    results = JSON.parse(open("https://www.eventbriteapi.com/v3/users/me/owned_events/?token=CKUU5YHXMHKRLS7ZVIBG&page=#{@count}").read)
    @total_count=5
    results_events = results["events"].sort_by{|k,v| k["start"]["utc"]}.collect{|p| p if (string_to_datetime(p["start"]["utc"].split("T")[0].split("-")[1]+"/"+p["start"]["utc"].split("T")[0].split("-")[2]+"/"+p["start"]["utc"].split("T")[0].split("-")[0]) <= string_to_datetime(params[:e_date])) && (string_to_datetime(p["start"]["utc"].split("T")[0].split("-")[1]+"/"+p["start"]["utc"].split("T")[0].split("-")[2]+"/"+p["start"]["utc"].split("T")[0].split("-")[0]) >= string_to_datetime(params[:s_date])) }.reject(&:blank?)      
    results_events.each_with_index do |event,index|       
      @event= Event.find_by_title(event["name"]["text"])
      if @event.blank? 
        debugger               
        @event = Event.new(:title=>event["name"]["text"],:eventbrite_url=>event["url"],:eventbrite_id=>event["id"],:description=>event["description"]["text"],:s_date=>event["start"]["utc"],:e_date=>event["end"]["utc"],:s_time=>event["start"]["local"].split("T")[1],:e_time=>event["end"]["local"].split("T")[1])
        if @event.save  
          debugger         
          @EB_user= User.find_by_name(event["venue"]["name"])
          if @EB_user.blank? 
            @EB_user = User.create(:email=>"#{"EB"}#{event["id"]}@techmeetups.com",:password=>event["venue"]["id"],:name=>event["venue"]["name"],:address=>"#{event["venue"]["address"]["address_1"]}#{event["venue"]["address"]["region"]}",:city_id=>"#{event["venue"]["address"]["city"]=="London" ? 5 : (event["venue"]["address"]["city"]=="Berlin" ? 6 : 7) }")
          else
            @EB_user.update(:email=>"#{"EB"}#{event["id"]}@techmeetups.com",:password=>event["venue"]["id"],:name=>event["venue"]["name"],:address=>"#{event["venue"]["address"]["address_1"]}#{event["venue"]["address"]["region"]}",:city_id=>"#{event["venue"]["address"]["city"]=="London" ? 5 : (event["venue"]["address"]["city"]=="Berlin" ? 6 : 7) }")
          end
          debugger             
          EventUser.create(user_id: 5408, event_id: @event.id, event_type: "Host")            
          debugger 
          EventUser.create(user_id: @EB_user.id, event_id: @event.id, event_type: "Venue")
          @results_events[index] = @event
          @id=@event.eventbrite_id
        end 
        @count_attendee = (params[:attendee].blank? ? 1 : (params[:attendee].to_i))             
        attendee_results = JSON.parse(open("https://www.eventbriteapi.com/v3/events/#{@id}/attendees?token=CKUU5YHXMHKRLS7ZVIBG&page=#{@attendee}").read)          
        @total_count=7
        atts=attendee_results["attendees"]
        atts.each_with_index do |attendee,index|            
          @attendee= User.find_by_name(attendee["profile"]["first_name"])
          if @attendee.blank?    
          debugger      
            @attendee = User.create(:name=>attendee["profile"]["first_name"],:password=>attendee["id"],:email=>attendee["profile"]["email"],:eventbrite_id=>attendee["id"],:source=>"E")             
            @event_attendee = EventUser.create(:event_type=>"Attendee",:event_id=>@event.id,:user_id=>@attendee.id)             
            
            @results_attendees[index] = @attendee
          else      
            @attendee.update(:name=>attendee["profile"]["first_name"],:password=>attendee["id"],:email=>attendee["profile"]["email"],:eventbrite_id=>attendee["id"],:source=>"E")
            @event_attendee= EventUser.create(:event_type=>"Attendee",:event_id=>@event.id,:user_id=>@attendee.id)             
            
            @results_attendees[index] = @attendee
          end
        end 
      else 
        debugger
        @id=@event.eventbrite_id
        @event.update(:title=>event["name"]["text"],:eventbrite_url=>event["url"],:eventbrite_id=>event["id"],:description=>event["description"]["text"],:s_date=>event["start"]["utc"],:e_date=>event["end"]["utc"],:s_time=>event["start"]["local"].split("T")[1],:e_time=>event["end"]["local"].split("T")[1])
        @results_events[index] = @event
        attendee_results = JSON.parse(open("https://www.eventbriteapi.com/v3/events/#{@id}/attendees?token=CKUU5YHXMHKRLS7ZVIBG").read)          
        atts=attendee_results["attendees"]
        atts.each_with_index do |attendee,index|            
          @attendee= User.find_by_name(attendee["profile"]["first_name"])
          if @attendee.blank?   
          debugger       
            @attendee = User.create(:name=>attendee["profile"]["first_name"],:password=>attendee["id"],:email=>attendee["profile"]["email"],:eventbrite_id=>attendee["id"],:source=>"E")             
            @event_attendee = EventUser.create(:event_type=>"Attendee",:event_id=>@event.id,:user_id=>@attendee.id)             
            
            @results_attendees[index] = @attendee
          else 
          debugger     
            @attendee.update(:name=>attendee["profile"]["first_name"],:password=>attendee["id"],:email=>attendee["profile"]["email"],:eventbrite_id=>attendee["id"],:source=>"E")
            @event_attendee= EventUser.create(:event_type=>"Attendee",:event_id=>@event.id,:user_id=>@attendee.id)             
            
            @results_attendees[index] = @attendee
          end
        end
      end
    end
  end

  def import_member
    @user_exist=[]
    if params[:city_id]=='http://www.meetup.com/new-york-silicon-alley'  
      @count = (params[:offset_value].blank? ? 0 : (params[:offset_value].to_i))
      results = JSON.parse(open("http://api.meetup.com/2/members?order=name&group_urlname=new-york-silicon-alley&offset=#{@count}&format=json&page=10&sig_id=144713682&sig=428f1436dcb9918eb2e799158a69795c5bac60ce").read)
      @total_count=190
      results["results"].each_with_index do |result,index|
        @user= User.find_by_name(result["name"]) 
        sec = (result["joined"].to_f / 1000).to_s
        @date = Date.strptime(sec, '%s')   
        if @user.blank?
          @user = User.create(:name=>result["name"],:password=>result["id"],:email=>"#{result["id"]}@gmail.com",:meetup_member_url=>result["link"],:meetup_id=>result["id"],:address=>result["city"],:description=>result["bio"],:meetup_photo_url=>"#{(result["photo"]["photo_link"] if !result["photo"].blank?) }",:member_since=>@date,:source=>"M")       
          @user_exist << @user
        else         
          @user.update(:name=>result["name"],:password=>result["id"],:email=>"#{result["id"]}@gmail.com",:meetup_member_url=>result["link"],:meetup_id=>result["id"],:description=>result["bio"],:meetup_photo_url=>"#{(result["photo"]["photo_link"] if !result["photo"].blank?) }",:member_since=>@date,:source=>"M")
          @user_exist << @user
        end
      end
    end     
    if params[:city_id]=='http://www.meetup.com/london-silicon-roundabout/'
      @count = (params[:offset_value].blank? ? 0 : (params[:offset_value].to_i))
      results = JSON.parse(open("http://api.meetup.com/2/members?order=name&group_urlname=london-silicon-roundabout&offset=#{@count}&format=json&page=10&sig_id=144713682&sig=570cafef19bdd22283245c01d7a06badb3f11c61").read)
      @total_count=500
      results["results"].each_with_index do |result,index|
        @user= User.find_by_id(result["id"])
        sec = (result["joined"].to_f / 1000).to_s
          @date = Date.strptime(sec, '%s')    
        if @user.blank?
          @user = User.create(:name=>result["name"],:password=>result["id"],:email=>"#{result["id"]}@gmail.com",:meetup_member_url=>result["link"],:meetup_id=>result["id"],:address=>result["city"],:description=>result["bio"],:meetup_photo_url=>"#{(result["photo"]["photo_link"] if !result["photo"].blank?) }",:member_since=>@date,:source=>"M")       
          @user_exist << @user
        else
          @user.update(:name=>result["name"],:password=>result["id"],:email=>"#{result["id"]}@gmail.com",:meetup_member_url=>result["link"],:meetup_id=>result["id"],:description=>result["bio"],:meetup_photo_url=>"#{(result["photo"]["photo_link"] if !result["photo"].blank?) }",:member_since=>@date,:source=>"M")
          @user_exist << @user
        end          
      end
    end

    if params[:city_id]=='http://www.meetup.com/TechMeetups-Berlin'
      @count = (params[:offset_value].blank? ? 0 : (params[:offset_value].to_i))
      results = JSON.parse(open("http://api.meetup.com/2/members?order=name&group_urlname=TechMeetups-Berlin&offset=#{@count}&format=json&page=10&sig_id=144713682&sig=7c9f37d8ae8ac7e702f6b9aa053bbe9469ecf47c").read)       
      @total_count=90
      results["results"].each_with_index do |result,index|
        @user= User.find_by_name(result["name"]) 
        sec = (result["joined"].to_f / 1000).to_s
        date = Date.strptime(sec, '%s')   
        if @user.blank?
          @user = User.create(:name=>result["name"],:password=>result["id"],:email=>"#{result["id"]}@gmail.com",:meetup_member_url=>result["link"],:meetup_id=>result["id"],:address=>result["city"],:description=>result["bio"],:meetup_photo_url=>"#{(result["photo"]["photo_link"] if !result["photo"].blank?) }",:member_since=>@date,:source=>"M")            
          @user_exist << @user
        else            
          @user.update(:name=>result["name"],:password=>result["id"],:email=>"#{result["id"]}@gmail.com",:meetup_member_url=>result["link"],:meetup_id=>result["id"],:description=>result["bio"],:meetup_photo_url=>"#{(result["photo"]["photo_link"] if !result["photo"].blank?) }",:member_since=>date,:source=>"M")            
          @user_exist << @user
        end 
      end
    end
  end
  private

    def event_params
      params.require(:event).permit(:user_id, :title, :s_date, :e_date, :s_time, :e_time, :event_type, :description, :twitter_hash_tag)
    end

    def event_user_param
      params.require(:event_user).permit(:user_id, :event_id, :event_type)
    end

    def project_user_param
      params.require(:project_user).permit(:user_id, :project_id, :project_type)
    end

    def add_participants
      if event_user_param['event_type'] == "Attendee"
        @attendee = Event.find(@event_user.event_id).event_users.find(:all, :conditions=>["event_type = ?", "Attendee"])
      elsif event_user_param['event_type'] == "Speaker"
        @speakers = Event.find(@event_user.event_id).event_users.find(:all, :conditions=>["event_type = ?", "Speaker"])
      elsif event_user_param['event_type'] == "Partner"
        @partners = Event.find(@event_user.event_id).event_users.find(:all, :conditions=>["event_type = ?", "Partner"])
      end
    end

    def add_project_participants
      if project_user_param['project_type'] == "Follower"
        @attendee = Project.find(@project_user.project_id).project_users.find(:all, :conditions=>["project_type = ?", "follower"])
      elsif project_user_param['project_type'] == "Team"
        @speakers = Project.find(@project_user.project_id).project_users.find(:all, :conditions=>["project_type = ?", "Team"])
      elsif project_user_param['project_type'] == "Partner"
        @partners = Project.find(@project_user.project_id).project_users.find(:all, :conditions=>["project_type = ?", "Partner"])
      end
    end

    def string_to_datetime(string)
      if !string.blank?
        format="%m-%d-%Y"
        real_date = DateTime.strptime(string.gsub("/","-"), format).to_time
      end
    end

    def user_params
    params.require(:user).permit(:email,:name,:password,:password_confirmation,:company,:city_id,:address,:user_type,:description,:offer, :looking_for,:twitter,:facebook,:linkedin,:avatar)
    end
end