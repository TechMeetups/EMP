class RegistrationsController < Devise::RegistrationsController
	def new
		super
	end
  def create 
    
  	@user = User.new(user_params)
    @user.set_tag_list_on(:offer_tags,params[:offer])
    @user.set_tag_list_on(:looking_for_tags,params[:looking_for])
  	if @user.save
  		flash[:notice] = "User Succesfully created"
      sign_in @user
      
    else
      flash[:notice] = "Please enter valid information in fields."
  	end
redirect_to new_user_session_path  end

  private

  def user_params
    params.require(:user).permit(:email,:name,:password,:password_confirmation,:company,:city,:address,:user_type,:description,:offer, :looking_for,:twitter,:facebook,:linkedin,:avatar)
  end
end
