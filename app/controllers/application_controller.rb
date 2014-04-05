class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  protect_from_forgery with: :null_session 

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

	 def configure_permitted_parameters
	   devise_parameter_sanitizer.for(:sign_up) << :name << :company << :user_type <<:city << :address << :description << :offer << :looking_for << :twitter << :facebook << :linkedin << :avatar
	   devise_parameter_sanitizer.for(:account_update) << :name << :company << :user_type <<:city << :address << :description << :offer << :looking_for << :twitter << :facebook << :linkedin << :avatar
	 end
 
end
