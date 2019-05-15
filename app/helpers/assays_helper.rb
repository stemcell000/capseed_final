module AssaysHelper
  #Dynamic menu
  def top_menu
    [
      "On-going clonings" , assays_path,
      "Scheduler", scheduler_assays_path
    ].each_slice(2).map do |name, path| content_tag(:li, link_to(name, path, :class => "navbar-link"), :class =>(cp(path)))
    end.join('').html_safe
   end
end

# Alternative message when an assay is not yet started 
 def date_missing_msg(d)
   date_str = d.to_s
   if d.blank?
     msg = "not started yet"
   else
     msg = d
   end
   return msg
 end
 
 def pending?
   return(self == "Design")? true : false
 end
 
 def qc?
   return(self == "Quality Control")? true : false
 end
 
def formatStep(st, id)
   @hash ={}
  case st
  when 1
    s = "Clone design"
    p = clone_design_assay_path(id)
  when 2
    s = "Clone batch"
    p = clone_batch_assay_path(id)
  when 3
    s = "Clone batch QC"
    p = clone_batch_qc_assay_path(id)
  when 4
    s = "Plasmid design"
    p = plasmid_design_assay_path(id)
  when 5
    s = "Plasmid batch"
    p = plasmid_batch_assay_path(id)
   when 6
    s = "Plasmid batch QC"
    p = p = plasmid_batch_qc_assay_path(id)
  when 7
    s = "Closing"
    p = close_assay_path(id)
  when 8
    s = "Completed"
    p = complete_assay_path(id)
   end 
@hash = {:step_name => s, :step_path => p}
   return @hash
end

def stepToString(step_id)
    case step_id
      when 1
        s = "Design"
      when 2
        s = "Clone batch"
      when 3
        s = "Clone batch QC"
      when 4
        s = "Plasmid design"
      when 5
        s = "Plasmid batch"
       when 6
        s = "Plasmid batch QC"
      when 7
        s = "Closing"
      when 8
        s = "Completed"
       end 
      return s
  end
  
   def stringToStep(label)
    case label
      when "Design"
        i = 1
      when "Clone batch"
        i = 2
      when "Clone batch QC"
        i = 3
      when "Plasmid design"
        i = 4
      when "Plasmid batch"
        i = 5
      when "Plasmid batch QC"
        i = 6
      when "Closing"
        i = 7
      when "Completed"
        i = 8
       end 
     return i.to_i
  end

#abandonné
def formatLinkTitle(step)
  return step.downcase.tr(" ", "_")
end
 
def setLinktoActive(ctrlr, title, str, path)
  if current_page?(:controller => ctrlr, :action => str )
    c = "active"
 end
  item = content_tag(:li, class: c ) do
    link_to(title, path)
  end
  return item
end

def setCloneBatchName(str,nb)
  clone_name = str+"-"+nb.to_s
  return clone_name
end

def setBatchCollectionName(i)
  @batch_collection.send(i)
end

def setQcColor(conclusion)
  if conclusion == true
     myClass = "validated"
  else
    myClass = "unvalidated"
  end
  return myClass
end

def setQcPanelClass(conclusion)
  if conclusion == true
     myClass = "panel panel-success"
  else
    myClass = "panel panel-warning"
  end
  return myClass
end

def setSearchableDate(st)
  date = DateTime.strptime(st, "%m/%d/%Y")
  #date = DateTime.parse(date).strftime('%Y-%m-%d %H:%M:%S')
  return date
end

def formatDateEN(date)
  date = date.strftime("%B %e, %Y")
  return date
end

def detectDuplicates(a)
  pbs.select(:id).group(:id).having("count(*) > 1")
end