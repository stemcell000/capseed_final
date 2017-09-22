#Mandatory Seeds
  #Add units
  Unit.create( name:"ng/uL")
  Unit.create( name:"ug/uL")
   #Add Volume units
  VolUnit.create( name:"mL")
  VolUnit.create( name:"uL")
  
  #Add Types
  Type.create( name:"Helper")
  Type.create( name:"Transgene")
  Type.create(name:"capsid")
  Type.create(name:"library")
  Type.create(name:"none")
  
  #Add Strands
  Strand.create( name:"sc")
  Strand.create( name:"ss")
  Strand.create( name:"nc")
  Strand.create( name:"irrelevant")
  Strand.create( name:"unknown")

  
   #Add boxes
  Box.create(name: "box1")
  Box.create(name: "box2")
  Box.create(name: "box3")
  Box.create(name: "Garbage")
  
  #Add cloning methods
  Cmeth.create(name: "method1")
  Cmeth.create(name: "method2")
  Cmeth.create(name: "method3")
  Cmeth.create(name: "method4")
  Cmeth.create(name: "unknown") 
 
  #Add columns
  Column.create( name:"1")
  Column.create( name:"2")
  Column.create( name:"3")
  Column.create( name:"4")
  Column.create( name:"5")
  Column.create( name:"6")
  Column.create( name:"7")
  Column.create( name:"8")
  Column.create( name:"9")
  Column.create(name: "None")
  
  
  #Add rows
  Row.create( name:"A")
  Row.create( name:"B")
  Row.create( name:"C")
  Row.create( name:"D")
  Row.create( name:"E")
  Row.create( name:"F")
  Row.create( name:"G")
  Row.create( name:"H")
  Row.create( name:"I")
  Row.create(name: "None")
  
  #Add Enzymes 
  Enzyme.create(name: "Eco RI")
  Enzyme.create(name: "BamHI")
  Enzyme.create(name: "HindIII")
  Enzyme.create(name: "MstII")
  Enzyme.create(name: "TaqI")
  Enzyme.create(name: "NotI")
  Enzyme.create(name: "HinfI")
  Enzyme.create(name: "Alul")
  Enzyme.create(name: "BgIIII")
  Enzyme.create(name: "HaelII")
  Enzyme.create(name: "Hhal")
  Enzyme.create(name: "PsrI")
  
  #Formats
  Format.create(name: "mini")
  Format.create(name: "midi")
  Format.create(name: "maxi")
  Format.create(name: "giga")
  
  #PCR Colony
  PcrColony.create(name: "ok")
  PcrColony.create(name: "failed")
  PcrColony.create(name: "not done")
  PcrColony.create(name: "passed")
  
  #Sequencing
  Sequencing.create(name: "ok")
  Sequencing.create(name: "failed")
  Sequencing.create(name: "not done")
  Sequencing.create(name: "passed")
  
  #Sma1
  Sma1.create(name: "yes")
  Sma1.create(name: "no")
  Sma1.create(name: "not applicable")
  
  #First project
  Project.create( name:"Global project")
  
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  
 