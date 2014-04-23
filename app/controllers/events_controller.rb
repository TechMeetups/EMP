class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    if params[:format] == "img"
      @img_url = EventBanner.find(params[:banner_id]).file.path
      if Rails.env == "development"
        send_file @img_url, :type => 'image/jpeg', :disposition => 'attachment'
      else
        send_file Rails.root+"/"+@img_url, :type => 'image/jpeg', :disposition => 'attachment'
      end
    else
      @banners = @event.event_banners
      @interaction = Interaction.new
      @add_event_user = EventUser.new
      if !params[:q].nil?
        @other_users = User.where("name like ?", "%#{params[:q]}%")
      else
        @other_users = User.find(:all, :conditions=>["id != ?", current_user.id] ) if user_signed_in?
      end
      @event = Event.find(params[:id])
      @speakers = @event.event_users.find_all_by_event_type("Speaker")
      @partners = @event.event_users.find_all_by_event_type("Partner")
      @attendee = @event.event_users.find_all_by_event_type("Attendee")
      @venue = @event.event_users.find_all_by_event_type("Venue")
      @event_user = @event.user
      respond_to do |format|
      format.html
      format.json { render :json => @other_users }
    end
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit      
    if params[:format] == "img"
      @img_url = EventBanner.find(params[:banner_id]).file.path
      send_file @img_url, :type => 'image/jpeg', :disposition => 'attachment'
    else
      @event = Event.find(params[:id])
      @banners = @event.event_banners
      @interaction = Interaction.new
      @speakers = @event.event_users.find_all_by_event_type("Speaker")
      @partners = @event.event_users.find_all_by_event_type("Partner")
      @attendee = @event.event_users.find_all_by_event_type("Attendee")
      @venue = @event.event_users.find_all_by_event_type("Venue")

    end
  end

  # POST /events
  # POST /events.json
  def create
    debugger
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        if !params[:banner].blank?
          params[:banner].each do |banner|
            if !banner["file"].nil?
              debugger
              EventBanner.create(:event_id=> @event.id, :file=>banner["file"],:featured=> banner["feature"].to_i)
            end
          end
        end
        debugger
        EventUser.create(user_id: params[:host_id], event_id: @event.id, event_type: "Host")
        debugger
        EventUser.create(user_id: params[:venue_id], event_id: @event.id, event_type: "Venue")
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if !params[:event]["s_date"].nil?
      dd = params[:event]["s_date"].split("/")[0]
      mm = params[:event]["s_date"].split("/")[1]
      yy =  params[:event]["s_date"].split("/")[2]
      params[:event]["s_date"] = mm+ "/" + dd + "/" +  yy
      params[:event]["s_date"] =params[:event]["s_date"].to_date
    end
    if !params[:event]["e_date"].nil?
      dd = params[:event]["e_date"].split("/")[0]
      mm = params[:event]["e_date"].split("/")[1]
      yy =  params[:event]["e_date"].split("/")[2]
      params[:event]["e_date"] = mm+ "/" + dd + "/" +  yy
      params[:event]["e_date"] =params[:event]["e_date"].to_date
    end
      respond_to do |format|
      if @event.update(event_params)

        format.json { head :no_content }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_event
    @event = Event.find(params[:event_id])
    @event.destroy
    flash[:notice] = "Event Succesfully Deleted"
    redirect_to :back
  end

  def search
    @image_user = User.first
    @image_user = current_user if user_signed_in?
    @event=Event.new
    @events1 = Event.where("title like ? ", "%#{params[:val]}%")
    @events1 += Event.where("description like ?  ", "%#{params[:val]}%")
    @events = @events1 & @events1
  end

  def event_search
    @events =[]
    if !params[:checked].blank?
      params[:checked].each do |id|
      @events += User.find_by_city_id(id).events if !User.find_by_city_id(id).nil?
    end
    else
      @events = Event.all
    end
  end

  def event_search_type

    @events =[]
    if !params[:checked].blank?
      @events = Event.where(event_type: params[:checked]) 
    else
      @events = Event.all
    end
    #debugger
  end
  def event_interaction
    @flag = Interaction.find_by_user_id_and_event_id_and_action(interaction_params[:user_id],interaction_params[:event_id],interaction_params[:action]).nil?
    if @flag
     Interaction.create(interaction_params)
    end
  end

#   @flag = Interaction.find_by_user_id_and_job_id_and_action(interaction_params[:user_id],interaction_params[:job_id],interaction_params[:action]).nil?
# if @flag
# Interaction.create(interaction_params)
# end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :title, :s_date, :e_date, :s_time, :e_time, :event_type, :description, :twitter_hash_tag)
    end

    def interaction_params
      params.require(:interaction).permit(:user_id, :event_id, :action, :memo)
    end
end