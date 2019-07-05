class OptionsController < InheritedResources::Base

before_action :set_option, :except => [:create, :new, :index]

def display_all_virus_switch
  @option.toggle!(:display_all_virus)
  respond_to do |format|
    format.js
  end
end 

def display_hidden_virus_switch
  @option.toggle!(:display_hidden_virus)
  respond_to do |format|
    format.js
  end
end  

def display_hidden_clone_batch_switch
  @option.toggle!(:display_hidden_clone_batch)
  respond_to do |format|
    format.js
  end
end 

private

  def option_params
    params.require(:option).permit(:id, :display_all_virus, :display_hidden_virus, :display_hidden_clone_batch)
  end
    
  def set_option
    @option = Option.find(params[:id])
  end
end

