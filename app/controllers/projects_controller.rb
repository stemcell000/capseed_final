class ProjectsController < ApplicationController
before_action :project_params, only:[:create, :update]
  before_action :find_project, only: [:edit, :destroy, :update]
  
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 def new
   @project = Project.new
 end
 
 
 def edit
 end
 
  def create
    @project = Project.create(project_params)
    if @project.save
      flash.keep[:success] = "A new project has been successfully created!"
    else
      render :action => 'new'
    end
  end
  
  def update
     @project.update_attributes(project_params)
  end
 
 def index
    @projects = smart_listing_create(:projects, Project.all, partial: "projects/list", default_sort: {name: "asc"},  page_sizes: [20, 40,100])   
 end
 
 def destroy
   @project.destroy
 end
  
  private
   
   def find_project
      @project = Project.find(params[:id])
   end
 
   def project_params
      params.require(:project).permit(:id, :name)
   end
  

end
