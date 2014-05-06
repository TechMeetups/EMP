module ProjectsHelper
	module HomeHelper
	def participants_detail(participant)
    @project = Project.where(:id => participant.project_id)
    if !@project.blank?
   		@project = @project.first
	    if !@project.blank? 
	      content = "#{link_to(image_tag(@project.project_banners.first.try(:file).try(:url), :style=>"width: 100px;height: 80px;"), @project)}<br/>"
	      content +="<b>#{link_to @project.title, @project}</b>"
	      return content.try(:html_safe)
	    end
	  end
	end
end

end
