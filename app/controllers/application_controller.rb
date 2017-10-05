class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  
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
    
  #Methods for statistics
    #Statistics for assays:
     #step :
     #Get the step collection
   def getallstats
      Statististic.all
    end
     #Get the values of the label attribute the Stat model    
   def getstatlabel
     Statistic.all.label
   end 
     #Get the values of the value attribute of the Stat model
   def getstatval
     Statstistic.all.val
   end
   
    def get_stats
      @stats = Statistic.all
        respond_to do |format|
          format.html
          format.json {render :json => @stats, :root => false}
        end
    end
    
    def export_stats
      step_list = Assay.get_step_label
        step_list.each do |label|
          q = Assay.count_by_step(label)
          Statistic.import_data(label,q)
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
  
    
    protected
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :password, :password_confirmation, :current_password, subteam_ids: [] ) }
    end
    
      protected

    def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
    
      
end
