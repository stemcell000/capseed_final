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
  
  # Change class from page title
  def jumboclass(page_title ='')
    color_class = ''
    case page_title
    when "Production"
     color_class = "prod-bg-color"
    else
      color_class= "cloning-color"
   end
   return color_class
  end
  
  # Replace 
  def char_replace(str="")
    if str.present?
      str.gsub(" ", "_")
   end
  end
  
  #Current page helper
  def cp(path)
  "current" if current_page?(path)
  end
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
  
  #Format name of step from number
  def stepToString(step_id)
  @hash ={}
  case step_id
  when 0
    s = "Creation"
  when 1
    s = "Clone design"
  when 2
    s = "Clone batch"
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
  if collection
    r = collection.order(:type_id).map {|c| c.name+" | "+c.number+" "+cb_flag(c.type_id)}
  else
    r=""
  end
  return r.to_sentence
end

