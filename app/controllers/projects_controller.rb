class ProjectsController < InheritedResources::Base
	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
	    @projects = Project.all
	    @interaction =Interaction.new
  	end

  	def show
    if params[:format] == "img"
      @img_url = ProjectBanner.find(params[:banner_id]).file.path
      if Rails.env == "development"
        send_file @img_url, :type => 'image/jpeg', :disposition => 'attachment'
      else
        send_file Rails.root+"/"+@img_url, :type => 'image/jpeg', :disposition => 'attachment'
      end
    else
      @project_banners = @project.project_banners
      @project_interaction = ProjectInteraction.new
      @add_project_user = ProjectUser.new
      if !params[:q].nil?
        @other_users = User.where("name like ?", "%#{params[:q]}%")
      else
        @other_users = User.find(:all, :conditions=>["id != ?", current_user.id] ) if user_signed_in?
      end
      @project = Project.find(params[:id])
      @speakers = @project.project_users.find_all_by_project_type("Team")
      @partners = @project.project_users.find_all_by_project_type("Partner")
      @attendee = @project.project_users.find_all_by_project_type("Follower")
      @venue = @project.project_users.find_all_by_project_type("Venue")
      @peoject_user = @project.user
      respond_to do |format|
      format.html
      format.json { render :json => @other_users }
    end
    end
  end

   def new
    @project = Project.new
  end

  def edit      
    if params[:format] == "img"
      @img_url = ProjectBanner.find(params[:banner_id]).file.path
      send_file @img_url, :type => 'image/jpeg', :disposition => 'attachment'
    else
      @project = Project.find(params[:id])
      @project_banners = @project.project_banners
      @interaction = Interaction.new
      @speakers = @project.project_users.find_all_by_project_type("Team")
      @partners = @project.project_users.find_all_by_project_type("Partner")
      @attendee = @project.project_users.find_all_by_project_type("Follower")
      @venue = @project.project_users.find_all_by_project_type("Venue")

    end
  end

  def create
    debugger
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        if !params[:banner].blank?
          params[:banner].each do |banner|
            if !banner["file"].nil?
              debugger
              ProjectBanner.create(:project_id=> @project.id, :file=>banner["file"],:featured=> banner["feature"].to_i)
            end
          end
        end
        debugger
        ProjectUser.create(user_id: params[:host_id], project_id: @project.id, project_type: "Host")
        debugger
        ProjectUser.create(user_id: params[:venue_id], project_id: @project.id, project_type: "Venue")
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if !params[:project]["s_date"].nil?
      dd = params[:project]["s_date"].split("/")[0]
      mm = params[:project]["s_date"].split("/")[1]
      yy =  params[:project]["s_date"].split("/")[2]
      params[:project]["s_date"] = mm+ "/" + dd + "/" +  yy
      params[:project]["s_date"] =params[:project]["s_date"].to_date
    end
    if !params[:project]["e_date"].nil?
      dd = params[:project]["e_date"].split("/")[0]
      mm = params[:project]["e_date"].split("/")[1]
      yy =  params[:project]["e_date"].split("/")[2]
      params[:project]["e_date"] = mm+ "/" + dd + "/" +  yy
      params[:project]["e_date"] =params[:project]["e_date"].to_date
    end
      respond_to do |format|
      if @project.update(project_params)

        format.json { head :no_content }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_project
    @project = Project.find(params[:project_id])
    @project.destroy
    flash[:notice] = "Project Succesfully Deleted"
    redirect_to :back
  end

  def search
    @image_user = User.first
    @image_user = current_user if user_signed_in?
    @project=Project.new
    @projects1 = Project.where("title like ? ", "%#{params[:val]}%")
    @projects1 += Project.where("description like ?  ", "%#{params[:val]}%")
    @projects = @projects1 & @projects1
  end

  def project_interaction
    @flag = ProjectInteraction.find_by_user_id_and_project_id_and_action(interaction_params[:user_id],interaction_params[:project_id],interaction_params[:action]).nil?
    if @flag
     ProjectInteraction.create(project_interaction_params)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:user_id, :title, :s_date, :e_date, :project_type, :description, :twitter_hash_tag)
    end

    def project_interaction_params
      params.require(:interaction).permit(:user_id, :project_id, :action, :memo)
    end
end
