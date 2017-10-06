module CloneBatchesHelper

def number_generator
  n = CloneBatch.last[:number].to_i+1
  return n.to_s
end  
  
end
