ActiveAdmin.register User do

permit_params :id, :email, :password, :password_confirmation, :role, :username, :firstname, :lastname
 
    index do
        column :username
        column :firstname
        column :lastname
        column :email
        column :role
        column :current_sign_in_at
        column :last_sign_in_at
        column :sign_in_count
        actions       
    end
 
    filter :email
 
    form do |f|
        f.inputs "User Details" do
            f.input :username
            f.input :firstname
            f.input :lastname
            f.input :email
            f.input :password
            f.input :password_confirmation
            f.input :role, as: :radio, collection: {User: "user", Guest: "guest", Administrator: "administrator"}
        end
        f.actions
    end
    
    #Add Button to site
       action_item do
    link_to "View Site", "/"
    end
    
   show do |user|
    attributes_table do
      row :firstname
      row :lastname
      row :email
      row :role
      row :created_at
      row :last_sign_in_at
     end    
  end


end
