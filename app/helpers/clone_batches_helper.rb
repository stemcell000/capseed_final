module CloneBatchesHelper

def number_generator
  n = CloneBatch.where.not(:name =>"").last[:number].to_i+1
  return n.to_s
end  
  
end
