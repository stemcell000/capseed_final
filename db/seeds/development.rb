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
  
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  
  #Not Mandatory
  Assay.new( name:"Cloning1", display: "true", step:0, created_at: "2016-10-10 11:41:03" ).save(:validate => false)
  Assay.new( name:"Cloning2", display: "true", step:1, created_at: "2016-10-13 11:41:03").save(:validate => false)
  Assay.new( name:"Cloning3", display: "true", step:2, created_at: "2016-10-15 11:41:03").save(:validate => false)
  Assay.new( name:"Cloning4", display: "true", step:3, created_at: "2016-10-17 11:41:03").save(:validate => false)
  Assay.new( name:"Cloning5", display: "true", step:5, created_at: "2016-10-20 11:41:03").save(:validate => false)
  Assay.new( name:"Cloning6", display: "true", step:4, created_at: "2016-10-21 11:41:03").save(:validate => false)
 
  Production.new( name:"Prod1", display: "true", step:0, last_step:0, created_at: "2016-10-20 09:41:03").save(:validate => false)
  Production.new( name:"Prod2", display: "true", step:1, last_step:1, created_at: "2016-10-24 12:41:03").save(:validate => false)
  Production.new( name:"Prod3", display: "true", step:2, last_step:2, created_at: "2016-10-28 09:12:03").save(:validate => false)
  Production.new( name:"Prod4", display: "true", step:3, last_step:3, created_at: "2016-10-28 14:56:03").save(:validate => false)
  Production.new( name:"Prod5", display: "true", step:0, last_step:0, created_at: "2016-10-30 17:00:30").save(:validate => false)
  Production.new( name:"Prod6", display: "true", step:0, last_step:0, created_at: "2016-10-31 11:41:03").save(:validate => false)
 
  #Add Projects to Assay
  Project.create( name:"Global project")
  Project.create( name:"Hoffmann-La Roche")
  Project.create( name:"Sanofi")
  Project.create( name:"Novartis")
  Project.create( name:"Bayer")
  Project.create( name:"Lilly")
  

  #Seed Clone
  Clone.new( name: "Alpha", bbnb: 144, primerinsfor: "VR1", primerinsrev: "VR2", comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.").save(:validate => false)
  Clone.new( name: "Beta", bbnb: 319, primerinsfor: "WR1", primerinsrev: "WR2", comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.").save(:validate => false)
  Clone.new( name: "Gamma", bbnb: 102, primerinsfor: "VR1", primerinsrev: "VR2", comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.").save(:validate => false)
  
  #Seed Insert
  Insert.new( name:"insert1", clone_batch_id: 400, number: 650).save(:validate => false)
  Insert.new( name:"insert2", clone_batch_id: 577, number: 651).save(:validate => false)
  Insert.new( name:"insert3", clone_batch_id: 687, number: 652).save(:validate => false)
  Insert.new( name:"insert4", clone_batch_id: 724, number: 653).save(:validate => false)
  
  
  Assay.find(1).projects << Project.find(1)
  Assay.find(1).projects << Project.find(2)
  Assay.find(2).projects << Project.find(1)
  Assay.find(2).projects << Project.find(3)
  Assay.find(3).projects << Project.find(1)
  Assay.find(3).projects << Project.find(4)
  Assay.find(4).projects << Project.find(1)
  Assay.find(4).projects << Project.find(5)
  Assay.find(5).projects << Project.find(1)
  Assay.find(5).projects << Project.find(6)
  
  #
  Clone.find(1).enzymes << Enzyme.find(4)
  Clone.find(1).enzymes << Enzyme.find(2)
  Clone.find(2).enzymes << Enzyme.find(5)
  Clone.find(2).enzymes << Enzyme.find(3)
  Clone.find(2).enzymes << Enzyme.find(7)
  Clone.find(3).enzymes << Enzyme.find(7)
  Clone.find(3).enzymes << Enzyme.find(6)
  Clone.find(3).enzymes << Enzyme.find(1)
  
  #
  Clone.find(1).inserts << Insert.find(1)
  Clone.find(1).inserts << Insert.find(2)
  Clone.find(2).inserts << Insert.find(3)
  Clone.find(2).inserts << Insert.find(4)