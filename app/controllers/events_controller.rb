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
    @banners = @event.event_banners
    @interaction = Interaction.new
    @speakers = @event.event_users.find_all_by_event_type("Speaker")
    @partners = @event.event_users.find_all_by_event_type("Partner")
    @attendee = @event.event_users.find_all_by_event_type("Attendee")
    @event_user = User.find(@event.event_users.find_by_event_type("Host").user_id) if !@event.event_users.find_by_event_type("Host").nil?
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
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        if !params[:banner].blank?
          params[:banner].each do |banner|
            EventBanner.create(:event_id=> @event.id, :file=>banner["file"],:featured=> banner["feature"].to_i)
          end
        end
        EventUser.create(user_id: current_user.id, event_id: @event.id, event_type: "Host")
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
    respond_to do |format|
      if @event.update(event_params)
        format.json { head :no_content }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  
  def delete    
    @events = Event.find(params[:id])
    @events.destroy
    flash[:notice] = "Activity Succesfully Deleted"
    redirect_to :back
  end

  def event_search
    if params[:id] == "all"
      @events=Event.all
    else 
      if !params[:checked].blank?
        @user = User.find_by_city_id(params["id"])
        if @user.nil?
          @events = []
        else
          @events = @user.events
        end
      elsif params[:all_checked]=="checked"     
        @events=Event.all  
      elsif !params[:unchecked].blank?

        @events = User.find_by_city_id(params["id"]).events
      else  params[:unchecked]=="all"
          @events=Event.all 
      end
    end
  end

  def event_interaction
    Interaction.create(interaction_params)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :title, :s_date, :e_date, :s_time, :e_time, :description, :twitter_hash_tag)
    end

    def interaction_params
      params.require(:interaction).permit(:user_id, :event_id, :action, :memo)
    end
end
