class OptionsController < InheritedResources::Base

def display_all_virus_switch
  @option = current_user.options.first
  @option.toggle!(:display_all_virus)
  respond_to do |format|
    format.js
  end
end 

def display_all_clone_batch_switch
  @option = current_user.options.first
  @option.toggle!(:display_all_clone_batch)
  respond_to do |format|
    format.js
  end
end

def display_limited_virus_switch
  @option = current_user.options.first
  @option.toggle!(:display_limited_virus)
  respond_to do |format|
    format.js
  end
end

private

  def option_params
    params.require(:option).permit(:id, :display_all_virus, :display_all_clone_batch)
  end
    
  def set_option
    @option = current_user.options.first
  end
end

