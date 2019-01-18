ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  #Add Button to site
  action_item do
    link_to "View Site", "/"
  end

          
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
   
   
   content title: proc{ I18n.t("active_admin.dashboard") } do
    
    section "Recent records" do
      columns do
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