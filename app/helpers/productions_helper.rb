module ProductionsHelper
  
def top_menu_prod
    [
      "On-going productions" , productions_path,
      #"Search" , display_all_productions_path,
      "Scheduler", scheduler_productions_path,
    ].each_slice(2).map do |name, path| content_tag(:li, link_to(name, path), :class =>(cp(path)))
    end.join('').html_safe
 end 
 
 def formatProdStep(st, id)
   @hash ={}
  case st
  when 0
    s = "creation"
    if id
      p = edit_production_path(id)
    else
      p = new_production_path
    end
  when 1
    s = "production design"
    p = add_plasmid_production_path(id)
  when 2
    s = "virus production"
    p = virus_production_production_path(id)
  when 3
    s = "closed"
    p = productions_path(id)
  end
@hash = {:step_name => s, :step_path => p}
   return @hash
end

 def formatProdStatus(st)
   @hash ={}
  case st
  when 0
    s = "creation"
  when 1
    s = "production design"
  when 2
    s = "virus production"
  else
    s = "closed"
  end
@hash = {:step_name => s}
   return @hash
end

def setProdLinktoActive(ctrlr, title, str, path)
  if current_page?(:controller => ctrlr, :action => str )
    c = "current"
 end
  item = content_tag(:li, class: c ) do
    link_to(title, path)
  end
  return item
end

def field_formater(field)
  if field
    str = field
  else
    str = "wait_for data."   
  end
  return str
end

def formatQC(qc_validation)
  if qc_validation
    str = content_tag(:i, " ", :class => "glyphicon glyphicon-thumbs-up font-green")
  else
    str = content_tag(:i, " ", :class => "glyphicon glyphicon-thumbs-down font-red")
  end
end

def formatDateToGantt(d)
    if d
    d.strftime("%Y, %-m, %-d")
    end
end
 
def volume_checker(u,v)
  str =""
  if u.nil?
    w = v
    str = w.to_s
  elsif v < u
    w = v
    str = "Not enough material."
  else
    w = v-u
    str= w.to_s
  end
  return str
end

#Format name of step from number (production only)

def stepToStringProd(step_id)

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
  
end