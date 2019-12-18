module VirusProductionsHelper
  def scientific_notation(i)
    sci = "%e" %i
    return sci
  end
  
  def int_to_string(a)
    b=""
    case a
    when 0
      b = "not done"
    when 1
      b = "sterile"
    when 3
      b = "not sterile" 
    end
    return b
  end
  
  def dismissedOrNot(obj)
  if d == 1
     "alert alert-danger"
   end
  end
  
  def isavailable(obj)
    if obj.virus_batches.pluck(:trash) == [true]
      "info"
    end
  end
  
  def invcolor(obj)
    if obj.dismissed == 1
      "danger"
    elsif obj.virus_batches.empty?
      "warning"
    elsif obj.virus_batches.pluck(:trash) == [true]
      "warning"
    end
  end
end
