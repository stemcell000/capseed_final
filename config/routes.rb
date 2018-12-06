Rails.application.routes.draw do
  resources :virus_batches
  resources :origins
  resources :sterilitytests
  get 'errors/not_found'

  get 'errors/internal_server_error'
  
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :virus_productions
  resources :inserts
  resources :clone_batch_as_plasmid_attachments
  resources :types
  resources :formats
  get 'users/inform_cloning'
  get 'users/inform_production'
  resources :plasmid_batches_productions

  resources :vol_units
  resources :rows
  resources :columns
  resources :boxes
  resources :qc_attachments
  resources :plasmid_batch_qcs do
    patch :validation_switch, :on => :collection
  end
  resources :plasmid_batch_attachments
  resources :add_attachment_to_plasmids
  resources :plasmid_batches
  resources :units
  resources :clone_batch_attachments
  resources :plasmids
  resources :qc_attachments
  resources :clone_attachments
  resources :clone_batches

  resources :search_suggestions

  get 'enzymes/index'

  get 'statistics/index'
  
  get 'inserts/index'

  devise_for :users
  ActiveAdmin.routes(self)

  resources :assays do
    collection do
        get :autocomplete_assay_name
        post :update_row_order
        get :display_all
        get :scheduler
        get :reset_cloning_table
        post :scheduler
        get :stats_data
        get :assay_generator
        resources :search, :only => [:index]
    end
    member do
      get :watch
      get :get_line
      get :get_id
      post :mask_line
      get :clone_design
      get :clone_batch
      get :clone_batch_qc
      patch :clone_batch_nb_update
      get :plasmid_design
      get :plasmid_batch
      get :plasmid_batch_qc
      get :close
      get :complete
      patch :lock_process
    end

     resources :projects
     resources :clones do
      get :replicate, :on => :collection
      get :edit_record, :on => :member
      get :edit_batch, :on => :member
      get :edit_batch_select, :on => :member
      patch :update_record, :on => :member
      patch :update_record_batch, :on => :member
      patch :update_record_batch_select, :on => :member
      patch :update_record_batch_qc, :on => :member
      get :clone_info
      get :plasmid_info
      get :plasmid_batch_info
      get :plasmid_batch_qc_info
      resources :sequencings do
           get :new_sequencing_protocol, :on => :new
           post :create_sequencing_protocol_collection, :on => :collection
      end
      resources :pcr_colonies do
           get :new_pcr_colony_protocol, :on => :new
           post :create_pcr_colony_protocol_collection, :on => :collection
      end
      resources :clone_batches do
           get :show_exist, :on => :member
           get :display, :on => :member
           patch :update_as_plasmid, :on => :member
           get :remove_from_clone_collection, :on => :member
           
           #Clone Batch QC
           resources :sequencings do
             get :set_sequencing_validation, :on => :member
             get :set_sequencing_unvalidation, :on => :member
           end 
           resources :pcr_colonies do
             get :set_pcr_colony_validation, :on => :member
             get :set_pcr_colony_unvalidation, :on => :member
           end 
           
           #Plasmid Batch QC
           resources :plasmid_batch_qcs do
              get :new_qc_protocol, :on => :new
              post :create_qc_protocol_collection, :on => :collection
              get :set_qc_validation, :on => :member
               get :set_qc_unvalidation, :on => :member
            end
            resources :plasmid_batches do
            get :edit_and_sort, :on => :member
              #Plasmid Batch QC indiv
              resources :plasmid_batch_qcs
          end
        end
        resources :clone_attachments
          get :plasmid_info, :on => :member
          get :plasmid_info_close, :on => :member
        end
  end  
  
  resources :productions do
    post :update_row_order, :on => :collection
    get :add_plasmid, :on => :member
    get :virus_production, :on => :member
    get :display_all, :on => :collection
    get :scheduler, :on => :collection
    post :scheduler, :on => :collection
    get :select_pbs, :on => :member
    get :spawn_vp, :on => :new 
    patch :create_vp, :on => :member
    patch :add_pbs, :on => :member
    get :remove_vp_from_prod, :on => :member
    patch :pool
    get :close, :on => :member
    get :inform_closed_production, :on => :member
    get :set_pb_volume, :on => :member
    patch :update_pb_volume, :on => :member
    get :reset_volume, :on => :member
      resources :plasmid_batches do
            get :edit_pb_volume, :on => :member
            patch :update_from_inventory, :on => :member 
      end
    
    resources :projects
    
    resources :virus_productions do
      resources :dosages, :on => :member
      get :spawn_dosage, :on => :member
    end
    
    resources :clone_batches do
      get :edit_from_prod, :on => :member
    end
   end
   
   
   resources :virus_productions do
     get :edit_from_inventory, :on => :member
     get :add_vb_from_inventory, :on => :member
     patch :update_from_inventory, :on => :member
     resources :dosages, :on => :member
     get :spawn_dosage, :on => :member
     patch :create_dosage, :on => :member
     resources :virus_batches do
       get :new_from_inventory, :on => :new
       post :create_from_inventory, :on => :collection
       get :destroy_from_inventory, :on => :member
       get :edit_from_inventory, :on => :member
       patch :update_from_inventory, :on => :member
     end
   end
  
  resources :stats do
    collection do
      get :get_stats
    end
  end
  
  resources :clones do
   get :autocomplete_clone_name, :on => :collection
   get :replicate, :on => :collection
   get :edit_record, :on => :member
   put :update_record, :on => :member
   patch :update_record_batch, :on => :member
   
  resources :enzymes 
  resources :inserts
  
  resources :clone_batches do
    get :autocomplete_clone_batch_name, :on => :collection
    patch :update_qc, :on => :member
    get :select_to_add, :on => :member
  end
    resources :clone_attachments
    resources :clone_batches do
       get :show_exist, :on => :member
       post :select, :on => :member
    end
  end
  
  resources :clone_batches do
    resources :sequencings
    resources :pcr_colonies 
    resources :plasmid_batches do
      get :new_from_inventory, :on => :new
      post :create_from_inventory, :on => :collection
      get :destroy_from_inventory, :on => :member
      get :edit_from_inventory, :on => :member
      patch :update_from_inventory, :on => :member
     get :destroy_from_list, :on => :member
    end
    get :edit_as_plasmid, :on => :member
    get :edit_from_inventory, :on => :member
    get :new_from_inventory, :on => :new
    post :create_from_inventory, :on => :collection
    delete :destroy_from_inventory, :on => :member
    patch :update_from_inventory, :on => :member
    patch :update_as_plasmid, :on => :member
    get :remove_plasmid_data, :on => :member
    get :add_pb_from_inventory, :on => :member
  end
  
  resources :plasmid_batches do
    get :edit_and_sort
    get :edit_from_inventory, :on => :member
    get :edit_pb_volume, :on => :member
    patch :update_from_inventory, :on => :member 
    get :inventory, :on => :collection
    get :autocomplete_plasmid_batch_number, :on => :collection
    get :new_from_inventory, :on => :new
    post :create_from_inventory, :on => :collection
    get :destroy_confirm, :on => :member
    delete :destroy_from_inventory, :on => :member
    patch :update_and_sort, :on => :member
    delete :remove_box_row_column, :on => :member
    get :pipe, :on => :member
    patch :send_to_production, :on => :member
      resources :plasmid_batch_qcs
      resources :assets
  end
  resources :enzymes
  resources :genes
  resources :promoters
  resources :origins
  
  #Home
  root 'clone_batches#index'
end
