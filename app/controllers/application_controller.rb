class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
    def authenticate_active_admin_user!
        authenticate_user!
        unless current_user.role?(:administrator)
            flash[:alert] = "You are not authorized to access this resource!"
            redirect_to root_path
        end
    end
    
   def update_last_step(model, value)
    unless model.last_step.nil?
      if model.last_step < value
         model.update_columns(:last_step => value)
      end
    else
        model.update_columns(:last_step => 0)
     end
  end
  
def search_params
  params[:q]
end
 
  def clear_search_index
    if params[:search_cancel]
      params.delete(:search_cancel)
      if(!search_params.nil?)
        search_params.each do |key, param|
          search_params[key] = nil
        end
      end
    end
  end
  
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
  
    
    protected
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :role ) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, :firstname, :lastname, :role) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :password, :password_confirmation, :encrypted_password, :cloning_notify, :production_notify, :firstname,
        :lastname, :role, :actual_member) }
    end
    
end
