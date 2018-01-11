module StatisticsHelper
  
def stepToString(step_id)
    case step_id
      when 0
        s = "Creation"
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

  
end
