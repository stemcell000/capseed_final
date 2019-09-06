class VirusProductionsController < InheritedResources::Base
 
   before_action :set_virus_production, only:[:edit, :destroy, :edit_from_inventory, :hide_from_inventory, :add_vb_from_inventory, :spawn_dosage, :update, :update_from_inventory, :create_dosage]
   before_action :set_option, only:[:index, :hide_from_inventory]
  #Smart_listing
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
 def index
   #"between search": recherche dans un range de dates
      
      #Formattage des dates
      start_time = params[:created_at_gteq].to_date rescue Date.current
      start_time = start_time.beginning_of_day # sets to 00:00:00
      end_time = params[:created_at_lteq].to_date rescue Date.current
      end_time = end_time.end_of_day # sets to 23:59:59
      
      start_prod_time = params[:date_of_production_gteq].todate rescue Date.current
      start_prod_time = start_prod_time.beginning_of_day # sets to 00:00:00
      end_prod_time = params[:date_of_production_lteq].to_date rescue Date.current
      end_prod_time = end_prod_time.end_of_day # sets to 23:59:59
      
    #Champ select pour "step" (champ de Production) et "projects" 
    
      @users_all = User.all.order(lastname: "asc").uniq
      @users_all = @users_all.map{ |obj| [(obj['firstname']+" "+obj['lastname']), obj['id']] }

      @plasmid_batches_all = PlasmidBatch.all.order(:id)
      @plasmid_batches_all = @plasmid_batches_all.map{|obj| [obj['name']] }
      
    #Champs genes
      @genes_all = Gene.all.order(name: "asc").uniq
      @genes_all = @genes_all.map{ |obj| [obj['name'], obj['id']] }
    #Champs promoters
      @promoters_all = Promoter.all.order(name: "asc").uniq
      @promoters_all = @promoters_all.map{ |obj| [obj['name'], obj['id']] }
      #Champs projects
      @projects_all = Project.all.order(name: "asc").uniq
      @projects_all = @projects_all.map{ |obj| [obj['name'], obj['id']] }  
      #Champ Plasmid
      @clone_batches_all = CloneBatch.all.order(name: "asc").uniq
      @clone_batches_all = @clone_batches_all.map{ |obj| [obj['name'], obj['id']] }  
      @option = current_user.options.first
      #virus cachés
      unless @option.display_all_virus
        hidden_virus_ids = @option.virus_productions.pluck(:id)
      else
        hidden_virus_ids = []
      end
        
      @q = VirusProduction.ransack(params[:q])
      
      @vps = @q.result.includes([:production, :plasmid_batches, :clone_batches, :sterilitytests, :genes, :user ]).where.not(:id => hidden_virus_ids)
      
      @vps  = @vps.limit(100) if current_user.options.first.display_limited_virus
        
      
      #Config de l'affichage des résultats.
      @vps = smart_listing_create(:virus_productions, @vps, partial: "virus_productions/smart_listing/list", default_sort: {nb: "desc"}, page_sizes: [ 20, 30, 50, 100])  

 end
 
def display_all_virus_switch
  @option = current_user.options.first
  @option.toggle!(:display_all_virus)
  redirect_to :index
end 
 
 def edit
 end
 
 def update
   @production = @virus_production.production
   @vps = @production.virus_productions
   #
   @virus_production.update_attributes(virus_production_params)
    if @virus_production.valid?
      flash.keep[:success] = "Task completed!"
      generate_recap
    else
      render :action => 'edit'
    end
  end
  
  
  def edit_from_inventory
      @users = User.all
  end
  
  def update_from_inventory
      @virus_production.update_attributes(virus_production_params)
      generate_recap
  end 
  
  def destroy
     @vps = VirusProduction.all
     @virus_production.destroy
  end
  
  def new
    @virus_production = VirusProduction.new
  end
  
  def create
        @virus_production = VirusProduction.create(virus_production_params)
      if  @virus_production.valid?
          flash.keep[:success] = "Task completed!"
          generate_recap
      else
          render :action => :new
      end
  end
  
  def spawn_dosage
    @virus_production = VirusProduction.find(params[:id])
    @users = User.all
  end
  
  def create_dosage
    production = @virus_production.production
    @vps = production.virus_productions
     @virus_production.update_attributes(virus_production_params)
     if @virus_production.valid?
      flash.keep[:success] = "Task completed!"
      generate_recap
     else
      render :action => 'spawn_dosage'
    end
  end
  
  def add_vb_from_inventory
    @users = User.all
    @virus_production.virus_batches.build
    @virus_batches = @virus_production.virus_batches
          n = VirusProduction.last.nb
          @nb = (n +1).to_s
  end
  
  def hide_from_inventory
    unless @option.virus_productions.where(:id => @virus_production.id).exists?
      @option.virus_productions << @virus_production
    else
      @option.virus_productions.destroy(@virus_production)
    end
  end
  
  def generate_recap
      block1 = "<strong>Associated plasmids: </strong>"
      block2=""
      block3=""
      block4=""
      block5=""
      block6=""
      block7=""
      block8=""
      block9=""
      block10=""
      block11=""
                
    if @virus_production.clone_batches.empty?
      block2="No plasmid<br />"
      block3=""
      block4=""
    else
      block2="<table>"
          
     @virus_production.clone_batches.each do |cb| 
      
      block3="<tr><td> #{ cb.number } </td><td> #{ cb.name } </td><tr>"
     end
     
      block4="</table>"
    end
    date_of_prod = @virus_production.date_of_production.nil? ? "none" : @virus_production.date_of_production.strftime("%b %e, %Y")
    projects = @virus_production.production.nil? ? "none" : @virus_production.production.projects.pluck(:name).to_sentence
    user =  @virus_production.user.nil? ? "none" : @virus_production.user.full_name
    volume =  @virus_production.vol.nil? ? "none" : "#{@virus_production.vol} #{@virus_production.vol_unit.name}"
    
      unless @virus_production.sterilitytests.nil?
        last_st = @virus_production.sterilitytests.last 
                  if last_st
                    last_st_date = last_st.date.nil? ? "none" : last_st.date.strftime("%b %e, %Y")
                    sterility_result = last_st.sterility.nil? ? ">on-going" : int_to_string(last_st.sterility)
                    block5 = "#{last_st_date} <br /><strong>Last result for sterility: </strong> #{ sterility_result} <br />"
                  end
       else
                    block5=""
       end
           
      block6="<strong>Date of prod.: </strong> #{date_of_prod} <br />
             <strong>Project: </strong> #{projects} <br />
             <strong>Contact: </strong> #{user} <br />
             <strong>Volume: </strong> #{volume} <br />"
                 
       gel_prot = @virus_production.gel_prot.nil? ? "none" : @virus_production.gel_prot
  
       block7= "<strong>Gel (Prot.): #{gel_prot} </strong> <br />"
       
       hek_result = @virus_production.hek_result 
       comment = @virus_production.comment
          unless @virus_production.hek_result.blank?
       block8 = "<strong>HEK results: </strong> #{hek_result} <br />"
       else
         block8=""
          end
          unless @virus_production.comment.blank?
           block9 = "<strong>Comment: </strong> #{comment}<br />"
        else
          block9=""
          end
           last_dosage = @virus_production.dosages.last
           inactivation_count = pluralize_without_count(@virus_production.dosages.count, 'Inactivation' , ' :')
           inactivation_dates = @virus_production.dosages.map {|dosage| dosage.inactivation.nil? ? "Unknown" : dosage.inactivation.strftime("%b %e, %Y")}.to_sentence
           
           if last_dosage
           last_inactivation_dates = last_dosage.date.nil? ? "none" : last_dosage.date.strftime("%b %e, %Y")
           last_dosage_titer =  last_dosage.titer.nil? ? "none" : "%.2e" %last_dosage.titer+"vg/ml"
           last_dosage_atcc = last_dosage.titer_atcc.nil? ? "none" : "%.2e" %last_dosage.titer_atcc+"vg/ml"
           last_dosage_to_atcc = last_dosage.titer_to_atcc.nil? ? "none" : "%.2e" %last_dosage.titer_to_atcc+"vg/ml"
           last_inactivation_dates = last_dosage.date.nil? ? "none" : last_dosage.date.strftime("%b %e, %Y")
           block10 ="<strong> #{inactivation_count} </strong> #{inactivation_dates} #{inactivation_dates} <br />
                        <strong> Date of the last titration: </strong> #{last_inactivation_dates} <br />
                        <ul>  
                          <li><strong> Titer: </strong> #{last_dosage_titer} </li>
                          <li><strong> Titer ATCC: </strong> #{last_dosage_atcc} </li>
                          <li><strong> Titer to ATCC: </strong> #{last_dosage_to_atcc} </li>
                        </ul>"
           else

               block10 = "<strong>Titer :</strong>None<br />"                
           end

      block11 = "<div>"
      
      block = block1+block2+block3+block4+block5+block6+block7+block8+block9+block10+block11
      @virus_production.update_columns(:recap => block)
                  
    end
  end
  
  private
 
  def virus_production_params
    params.require(:virus_production).permit(:id, :number, :nb, :plate_name, :vol, :sterility, :titer_atcc, :titer, :titer_to_atcc, :comment, :date_of_production, :user_id,
    :gel_prot, :invoice,  :l2, :hek_result, :created_at, :updated_at, :vol_unit_id, :production_id, :_destroy, :plasmid_tag, :plasmid_batch_tag, :rev_plasmid_tag, :rev_plasmid_batch_tag,
    :dosages_attributes => [:id, :virus_production_id, :titer, :titer_atcc, :titer_to_atcc, :date, :plate_name, :_destroy, :remove_dosage,
    :inactivation, :inactivation_atcc, :inactivation_standard, :accepted, :user_id],
    :sterilitytests_attributes => [:id, :virus_production_id, :sterility, :date, :_destroy, :remove_sterilitytest],
    :virus_batches_attributes => [:id, :name, :box_id, :volume, :vol_unit_id, :row_id, :column_id, :date_of_thawing ],
    :users_attributes =>[:id, :firstname, :lastname], user_ids: [])
  end
  
 def set_virus_production
   @virus_production = VirusProduction.find(params[:id])
 end
 
 def set_option
   @option = current_user.options.first
 end
 
end

