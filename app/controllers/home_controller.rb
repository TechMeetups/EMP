class HomeController < ApplicationController
  def index
  	@events = Event.all
    @user = current_user if user_signed_in?
  end

  def notifications
    @events_ids = current_user.events.collect(&:id)
    @interactions =[]
    @events_ids.each do |event_id|
    	if Interaction.all.collect(&:event_id).include? event_id
    		@interactions += Interaction.find_all_by_event_id(event_id)
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

  	@interaction.destroy

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

  def banner_destroy
  	@event_banner = EventBanner.find(params["banner_id"])
  	@event = Event.find(@event_banner.event_id)
  	@event_banner.destroy
  	@banners = @event.event_banners
  end

  def add_more
    if EventUser.find_by_user_id_and_event_id_and_event_type(event_user_param["user_id"], event_user_param["event_id"], event_user_param['event_type']).nil?
      @event_user = EventUser.create(event_user_param)
      if event_user_param['event_type'] == "Attendee"
        @attendee = Event.find(@event_user.event_id).event_users.find(:all, :conditions=>["event_type = ?", "Attendee"])
      elsif event_user_param['event_type'] == "Speaker"
        @speakers = Event.find(@event_user.event_id).event_users.find(:all, :conditions=>["event_type = ?", "Speaker"])
      elsif event_user_param['event_type'] == "Partner"
        @partners = Event.find(@event_user.event_id).event_users.find(:all, :conditions=>["event_type = ?", "Partner"])
      end
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
    @speakers = EventUser.find(:all, :conditions=>["user_id = ? && event_type = ?", @user.id, "Speaker"] )
    @partners = EventUser.find(:all, :conditions=>["user_id = ? && event_type = ?", @user.id, "Partner"] )
    @attendee = EventUser.find(:all, :conditions=>["user_id = ? && event_type = ?", @user.id, "Attendee"] )
  end

  private

    def event_user_param
      params.require(:event_user).permit(:user_id, :event_id, :event_type)
    end

end
