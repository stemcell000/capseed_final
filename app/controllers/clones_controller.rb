class ClonesController < ApplicationController

autocomplete :clone, :name, :extra_data => [:id]

include SmartListing::Helper::ControllerExtensions
helper  SmartListing::Helper

before_action :load_assay, only:[:edit, :new, :edit_record, :edit_batch, :edit_batch_select, :update, :create, :autocm, :destroy, :replicate, :update_record, :update_record_batch, :update_record_batch_select, :update_record_batch_qc, :clone_info]
before_action :set_param, only: [:update, :edit, :edit_record, :edit_batch, :edit_batch_select, :update_record, :update_record_batch, :update_record_batch_select, :update_record_batch_qc]
before_action :clone_params, only: [:update, :update_clone, :create, :edit, :update_record_batch]
skip_before_filter :verify_authenticity_token, :only => :update_record_batch

@@old_id =0

def index
end

def new
  #Genere un nouveau clone pour la methode create
  #Si le formulaire contient un champ :id non vide, alors on charge le même formulaire en 'edit'.
  if params[:id]
    @clone = Clone.find(params[:id])
    @@old_id = params[:id]
    @clone.inserts.build
    @clone_enzymes = @clone.enzymes.build
    @clone_inserts = @clone.inserts.build
    @clone_batches = @clone.clone_batches.build
    render 'edit'
  else
    @clone = @assay.clones.new
    @clone_enzymes = @clone.enzymes.build
    @clone_inserts = @clone.inserts.build
    @clone.clone_batches.build
  end
  #initialisation de la liste des enzymes (Backbone)
    @enzymes_all = Enzyme.where(:category => 'backbone').all
  #initialisation de la liste des inserts
    @inserts_all = Insert.all
end

def create
    #Le paramètre à prendre en compte ici est l':id. si on prend le nom ("name"), pas de validation.
        @clone = Clone.where(:name => params[:clone][:id]).first_or_create(clone_params)
        @clones = @assay.clones.all
      if @clone.valid?
        @assay.clones << @clone
        flash.keep[:success] = "Task completed!"
      else
        render :action => 'new'
      end
end

def show
 
end

def edit
  @clones = @assay.clones.build
  @assays = @clone.assays.build
  @assays_count = @clone.assays.count
  #initialisation de la liste des enzymes backbones.
  @enzymes_all = Enzyme.where(:category => 'backbone').all
  #initialisation de la liste des inserts.
  @inserts_all = Insert.all
  #
  @clone_enzymes = @clone.enzymes.build
  @clone_inserts = @clone.inserts.build
  @clone_batches = @clone.clone_batches.build
  @@old_id = params[:id]
end
  
def update
  @clones = @assay.clones.all
  #
  if !@assay.clones.where(:id => @@old_id).present?
        if @assay.clones << @clone
          flash.keep[:success] = "Task completed!"
          redirect_to assay_path(@assay)
         else
           render :action => 'edit'
         end
       else
          flash.keep[:notice] = "This clone is already associated to this assay!"
          redirect_to @assay
   end
end

def edit_record
  @clones = @assay.clones.build
  #initialisation de la liste des enzymes
  @enzymes_all = Enzyme.where(:category => 'backbone').all
  #initialisation de la liste des inserts.
  @inserts_all = Insert.all
  #
  @clone_enzymes = @clone.enzymes.build  
  @clone_insert = @clone.inserts.build
end

def update_record
  @clones = @assay.clones
  if @clone.update_attributes(clone_params)
      flash.keep[:success] = "Task completed!"
      #redirect_to @assay
    else
      render :action => 'edit'
    end
end

def replicate
  @clone = Clone.find(@@old_id)
  @clone = @clone.amoeba_dup
  render :new  
end

def destroy
  @clones = @assay.clones.all
  @clone = Clone.find(params[:id])
  @clone.destroy
end

def edit_batch
  @clones = @assay.clones.build
  @clones = @assay.clones.order(:id)
  @assay.clones.build
  @clone.clone_attachments.build
end

def update_record_batch
  @clones = @assay.clones.order(:id)
  @clone.update_attributes(clone_params)
   if @clone.valid?
      flash.keep[:success] = "Task completed!"
      respond_to do |format|
        format.js
      end
      #Nommage (temp_name) et création du nombre de batch indiqués +  ajout à la collection.
      i = 1
      @clone.batch_nb.times do
        temp =@assay.name+'_'+@clone.name+'_'+i.to_s
        cb = CloneBatch.create(:temp_name => temp)
        @clone.clone_batches << cb
        i += 1
      end
    else
      render :action => 'edit_batch'
    end
end


def edit_batch_select
  @clones = @assay.clones.build
  @clones = @assay.clones.order(:id)
  @assay.clones.build
  #Génère le nombre de champs nécessaires dans le formulaire, sans le dépasser.
  if @clone.clone_batches.size < @clone.batch_nb
    (@clone.batch_nb-@clone.clone_batches.size).times do
      @clone.clone_batches.build
    end
  end
end

def update_record_batch_select
  @clones = @assay.clones.order(:id)
  @clone.update_attributes(clone_params)
  @clone_batches_counter = @clone.clone_batches.all.size
   if @clone.valid?
      flash.keep[:success] = "Task completed!"
      respond_to :js
    else
      render :action => 'edit_batch_select'
    end
end

def edit_batch_qc
  @clones = @assay.clones.build
  @assays = @clone.assays.build
  @clones = @assay.clones.order(:id)
  @assay.clones.build
  @clone.clone_batches.build
end

def update_record_batch_qc
  @clones = @assay.clones.order(:id)
  @clone.update_attributes(clone_params)
   if @clone.valid?
      flash.keep[:success] = "Task completed!"
      respond_to :js
    else
      render :action => 'edit_batch_qc'
    end
end

def switch_qc_table
  @clones = @assay.clones.order(:id)
end

def clone_info
   id = params[:clone_id]
  @clone = Clone.find(id)
  @clones = @assay.clones.order(:id)
  #@page_tab = "clone"
  respond_to do |format|
    format.js
  end
end

def plasmid_info
  clone_id = params[:clone_id]
  assay_id = params[:assay_id]
  @clone = Clone.find(clone_id)
  @assay = Assay.find(assay_id)
  respond_to do |format|
    format.js
  end
end

def plasmid_info_close
  #rappel: les plasmid sont en fait les clone_batches.
  clone_id = params[:clone_id]
  assay_id = params[:assay_id]
  @clone = Clone.find(clone_id)
  @assay = Assay.find(assay_id)
  @clone.clone_batches.build
  respond_to do |format|
    format.js
  end
end

def plasmid_batch_info
  clone_id = params[:clone_id]
  assay_id = params[:assay_id]
  @clone = Clone.find(clone_id)
  @assay = Assay.find(assay_id)
  respond_to do |format|
    format.js
  end
end


def plasmid_batch_qc_info
    clone_id = params[:clone_id]
  assay_id = params[:assay_id]
  @clone = Clone.find(clone_id)
  @assay = Assay.find(assay_id)
  respond_to do |format|
    format.js
  end
end

private

def set_param
  @clone = Clone.find(params[:id])
  
end

def load_assay 
  @assay = Assay.find(params[:assay_id])
end

def clone_params
  params.require(:clone).permit( :id, :assay_id, :name, :bbnb, :primerinsfor, :primerinsrev, :comment, :comment_batch, :batch_nb, :strict_validation,
  enzyme_ids: [],
  insert_ids: [],
  :enzymes_attributes =>[:id, :clone_id, :name, :category],
  :inserts_attributes =>[:id, :name, :clone_batch_id, :clone_id],
  :assay_attributes => [:id, :name, :step],
  :clone_batches_attributes => [:id, :clone_id, :unit_id, :name, :temp_name, :comment, :_destroy,
  :clone_batch_qcs_attributes => [:id, :primer_nb, :primer_name, :date_send, :date_rec, :rec_name, :result, :op, :_destroy],
  :plasmid_batch_attributes => [:id, :clone_batch_id, :name, :format, :concentration, :_destroy],
  :unit_attributes =>[:id, :clone_batch_id, :name]],
  :clone_attachments_attributes =>[:id,:clone_id, :attachment, :remove_attachment, :_destroy])
end


end
