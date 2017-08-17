module StatisticsHelper
  
def stepToString(step_id)
  @hash ={}
  case step_id
  when 0
    s = "Creation"
  when 1
    s = "Clone design"
  when 2
    s = "Clone batch"
  when 3
    s = "Clone batch selection"
  when 4
    s = "Clone batch QC"
  when 5
    s = "Plasmid design"
  when 6
    s = "Plasmid batch"
    c= "plasmidbatch"
   when 7
    s = "Plasmid batch QC"
  when 8
    s = "Closing"
  when 9
    s = "Completed"
   end 
   return s
end

  
end
