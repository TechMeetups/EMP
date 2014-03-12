class HomeController < ApplicationController
  def index
  	@events = Event.all
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
	
  end

  def banner_destroy
  	@event_banner = EventBanner.find(params["banner_id"])
	@event = Event.find(@event_banner.event_id)
	@event_banner.destroy
	@banners = @event.event_banners
  end
end
