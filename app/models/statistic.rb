class Statistic < ActiveRecord::Base
    
  def self.import_data(l, q)
    case l
      when 0
      s = "Creation"
    when 1
      s = "Clone design"
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
    
    @stat = self.find_or_initialize_by(:label=>s.to_s)
    @stat.value = q
    @stat.save
 end
    
  
 def stepToString(step_id)
    case step_id
    when 0
      s = "Creation"
    when 1
      s = "Clone design"
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
