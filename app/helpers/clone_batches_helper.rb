module CloneBatchesHelper

def number_generator
  n = CloneBatch.where.not(:name =>"").last[:number].to_i+1
  return n.to_s
end 

def dismissedOrNot(d)
  #  
  if d == 1
     "danger"
   else
     "default"
   end
  #
end

    #Dynamic menu
  def top_menu
    [
      "On-going clonings" , assays_path,
      "Scheduler", scheduler_assays_path
    ].each_slice(2).map do |name, path| content_tag(:li, link_to(name, path, :class => "navbar-link"), :class =>(cp(path)))
    end.join('').html_safe
  end
  
    
  #Current page helper
  def cp(path)
   if current_page?(path)
    myclass= " nav-item active"
   else
     myclass="nav-item"
    end
    return myclass
 end 
end
