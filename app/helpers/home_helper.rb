module HomeHelper
	def participants_detail(participant)
    @event = Event.where(:id => participant.event_id)
    if !@event.blank?
   		@event = @event.first
	    if !@event.blank? 
	      content = "#{link_to(image_tag(@event.event_banners.first.try(:file).try(:url), :style=>"width: 100px;height: 80px;"), @event)}<br/>"
	      content +="<b>#{link_to @event.title, @event}</b>"
	      return content.try(:html_safe)
	    end
	  end
	end
end
