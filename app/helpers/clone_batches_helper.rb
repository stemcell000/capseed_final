module CloneBatchesHelper

def number_generator
  n = CloneBatch.where.not(:name =>"").last[:number].to_i+1
  return n.to_s
end 

def dismissedOrNot(d)
  if d == 1
     "alert alert-danger"
   end
end
end
