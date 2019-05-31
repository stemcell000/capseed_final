module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Capseed"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  # Replace 
  def char_replace(str="")
    if str.present?
      str.gsub(" ", "_")
   end
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

  def title(page_title, show_title = true)
    @show_title = show_title
    @content_for_title = page_title.to_s
  end

  def show_title?
    @show_title
  end
  
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end
  
  #Sortable columns
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
#Format name of step from number (assay only)
def stepToString(step_id)
 @hash ={}
  case step_id
  when 0
    s = "Clone design"
  when 1
    s = "Clone batch"
  when 2
    s = "Plasmid design"
  when 3
    s = "Plasmid batch"
   when 4
    s = "Plasmid batch QC"
  when 5
    s = "Closing"
  when 7
    s = "Completed"
   end 
   return s
end

#Format name of step from number (production only)
def stepToStringProd(step_id)
 @hash ={}
  case step_id
  when 0
    s = "Creation"
  when 1
    s = "Production design"
  when 2
    s = "Virus Production"
  when 3
    s = "Closed"
   end 
   return s
end

def formatDate(d)
   if d
    d.strftime("%h %e, %Y ")
   end
end

 def formatDateToGantt(d)
    if d
    d.strftime("%Y, %-m, %-d")
    end
 end
 
 def round_up(n)
   (n.to_f).ceil
 end
 
 def cb_display(collection)
  r = ""
  
  unless collection.empty?
    r = collection.map {|c| c.number+c.name+"- "+c.type.name[0..3]}
  else
    r = "No data yet"
  end

  return r

end

def clone_display(collection)
   r = ""
    if !collection.empty?
      r = collection.order(:id).map {|c| c.name+" | "+c.id.to_s}.to_sentence
    else
      r="Add a construction!"
    end
  return r
end

def display_collection(collection)
   r = ""
  if !collection.empty?
    r = collection.order(:id).map {|c| c.name }.to_sentence
  else
    r="-"
  end
  return r
end

def cb_flag(i)
 flag = ""
 
 case i
 when i=1
  flag = "(Help.)"
 when i=2
  flag = "(Trans.)"
 when i=3
  flag = "(Caps.)"
 when i=4
  flag = "(Libr.)"
 else
  flag=""   
 end
 
end

def colorize(vol)
  str=""
  if vol.nil? || vol == 0
    str="red"
  else
    str="#009933"
  end
  return str
end

def pluralize_without_count(count, noun, text = nil)
  if count != 0
    count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
  end
end

end
