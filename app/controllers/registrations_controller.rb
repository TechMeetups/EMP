class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token, :only => :create

	def new
		super
	end

  def create
    debugger
  	@user = User.new(user_params)
    @user.set_tag_list_on(:offer_tags,params[:offer])
    @user.set_tag_list_on(:looking_for_tags,params[:looking_for])
  	if @user.save
  		flash[:notice] = "User Succesfully created"
      sign_in @user
      redirect_to new_user_session_path
    else
      flash[:notice] = "Please enter valid information in fields."
      redirect_to :back
    end
 end

 def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
 end

  private

  def user_params
    params.require(:user).permit(:email,:name,:password,:password_confirmation,:company,:city_id,:address,:user_type,:description,:offer, :looking_for,:twitter,:facebook,:linkedin,:avatar)
  end
end
