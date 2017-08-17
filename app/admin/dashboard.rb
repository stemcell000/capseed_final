ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

          
   page_action :stats_data, :method => :get do
    @stats = Statistic.all
    respond_to do |format|
      format.html
      format.json {render :json => @stats, :root => false}
    end
   end
   
   page_action :export_stats, :method => :post do
    status_list = Assay.get_status_label
    status_list.each do |label|
      q = Assay.count_by_status(label)
      Stat.import_data(label,q)
    end
  end
   
   
    action_item do
    link_to "View Site", "/"
    end
   
   

   content title: proc{ I18n.t("active_admin.dashboard") } do
     section "Statistics" do
      columns do
       panel 'Clonings groups'
       render :partial => 'assay_charts'
      end
    end
    
    section "Recent records" do
      columns do
        column do
        panel 'Assays' do
          table_for Assay.order("created_at desc").limit(5) do |t|
          t.column :name
          t.column :status
          t.column :created_at
          t.column :duration
          end
          strong {link_to "View All Assays" , admin_assays_path}
        end
        end
        column do
        panel 'Clones' do
          table_for Clone.order("created_at desc").limit(5) do |t|
          t.column :name
          t.column :nb
          t.column :created_at
          end
         strong {link_to "View All Clones" , admin_clones_path}
        end 
        end
      end
    end
  end

end