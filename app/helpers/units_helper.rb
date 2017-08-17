module UnitsHelper
def unitFinder(myId)
  Unit.find(myId).name
end

end
