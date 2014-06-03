module HomeHelper
	def participants_detail(participant)
    @event = Event.where(:id => participant.event_id)
    if !@event.blank?
   		@event = @event.first
	    if !@event.blank? 
	      content = "#{link_to(image_tag(@event.event_banners.first.try(:file).try(:url), :style=>"width: 100px;height: 80px;"), @event)}<br/>"
	      content +="<b>#{link_to @event.title, @event}</b>"
	      return content.try(:html_safe)
	      if @event.event_banners.first.blank?
	      	 content = "#{link_to(image_tag("../assets/missing.png", :style=>"width: 100px;height: 80px;"), @event)}<br/>"
	      	 content +="<b>#{link_to @event.title, @event}</b>"
	     
	      end
	    end
	  end
	end
end
