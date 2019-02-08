 #Mandatory Seeds
  #Add units
  Unit.create( name:"ng/uL")
  Unit.create( name:"ug/uL")
   #Add Volume units
  VolUnit.create( name:"µL")
  VolUnit.create( name:"mL")
  
  #Add Types
  Type.create( name:"Helper")
  Type.create( name:"Transgene")
  Type.create(name:"Capsid")
  Type.create(name:"Library")
  Type.create(name:"Lenti")
  Type.create(name:"Other | Unknown")
  
  #Add Strands
  Strand.create( name:"sc")
  Strand.create( name:"ss")
  Strand.create( name:"nc")
  Strand.create( name:"Irrelevant")
  Strand.create( name:"Unknown")

  
   #Add boxes
  Box.create(name: "Unknown")
  Box.create(name: "Garbage")
  
  #Add cloning methods
  Cmeth.create(name: "InFusion")
  Cmeth.create(name: "Directed mutagenesis")
  Cmeth.create(name: "Classic")
  Cmeth.create(name: "Gibson")
  Cmeth.create(name: "other")
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
  
  #Target
  Target.create(name: "Unknown")
  Target.create(name: "Ubiquitous")
  Target.create(name: "RGC")
  Target.create(name: "Cones")
  Target.create(name: "neuronal")
  Target.create(name: "Bipolar cells on")
  Target.create(name: "Red cones")
  Target.create(name: "Blue cones")
  Target.create( name: "Neuronal")
  Target.create( name: "RGC")
  
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  
  #Add Projects to Assay
  Project.create( name:"Global project")
 

  #Add Users
     User.create! do |u|
        u.email     = 'melissa.desrosiers@inserm.fr'
        u.username = 'mdesrosiers'
        u.firstname = 'Mélissa'
        u.lastname = 'Desrosiers'
        u.password  = '123456789'
        u.role = 'administrator'
    end

     User.create! do |u|
        u.email     = 'deniz.dalkara@inserm.fr'
        u.username = 'ddalkara'
        u.firstname = 'Deniz'
        u.lastname = 'Dalkara'
        u.password  = '123456789'
        u.role = 'administrator'
    end 
   
   
  User.create! do |u|
        u.email     = 'camille.robert@inserm.fr'
        u.username = 'crobert'
        u.firstname = 'Camille'
        u.lastname = 'Robert'
        u.password  = 'YM26r9mt'
        u.role = 'user'
    end 
    
    User.create! do |u|
        u.email     = 'fiona.routet@inserm.fr'
        u.username = 'froutet'
        u.firstname = 'Fiona'
        u.lastname = 'Routet'
        u.password  = 'YM26r9mt'
        u.role = 'user'
    end  
    
      User.create! do |u|
        u.email     = 'julien.murat@inserm.fr'
        u.username = 'jmurat'
        u.firstname = 'Julien'
        u.lastname = 'Murat'
        u.password    = 'gVx29g2G'
        u.role = 'guest'
    end 
    
     User.create! do |u|
        u.email     = 'muge.tenkisoy@inserm.fr'
        u.username = 'mtenkisoy'
        u.firstname = 'Müge'
        u.lastname = 'Tenkisoy'
        u.password    = 'gVx29g2G'
        u.role = 'user'
    end 
    
    User.create! do |u|
        u.email     = 'catherine.botto@inserm.fr'
        u.username = 'cbotto'
        u.firstname = 'Catherine'
        u.lastname = 'Botto'
        u.password    = 'gVx29g2G'
        u.role = 'user'
    end 
    
      User.create! do |u|
        u.email     = 'cardillia.simon@inserm.fr'
        u.username = 'csimon'
        u.firstname = 'Cardillia'
        u.lastname = 'Simon'
        u.password    = 'gVx29g2G'
        u.role = 'user'
    end
    
      User.create! do |u|
        u.email     = 'emilie.mace@inserm.fr'
        u.username = 'emace'
        u.firstname = 'Emilie'
        u.lastname = 'Macé'
        u.password    = 'C84r2mXs'
        u.role = 'user'
    end 
    
    User.create! do |u|
        u.email     = 'eleonore.duvelle@inserm.fr'
        u.username = 'eduvelle'
        u.firstname = 'Eléonore'
        u.lastname = 'Duvelle'
        u.password    = 'rr7A5Ke7'
        u.role = 'guest'
    end 
    
    User.create! do |u|
        u.email     = 'celine.winkler@inserm.fr'
        u.username = 'cwinkler'
        u.firstname = 'Céline'
        u.lastname = 'Winkler'
        u.password    = 'E2tah3Y7'
        u.role = 'guest'
    end 
    
    User.create! do |u|
        u.email     = 'arthur.planul@inserm.fr'
        u.username = 'aplanul'
        u.firstname = 'Arthur'
        u.lastname = 'Planul'
        u.password    = 'E2tah3Y7'
        u.role = 'guest'
    end 
    
    User.create! do |u|
        u.email     = 'hanen.khabou@inserm.fr'
        u.username = 'hkhaboul'
        u.firstname = 'Hanen'
        u.lastname = 'Khabou'
        u.password    = 'E2tah3Y7'
        u.role = 'guest'
    end

    User.create! do |u|
        u.email     = 'laure.pacot@inserm.fr'
        u.username = 'lpacot'
        u.firstname = 'Laure'
        u.lastname = 'Pacot'
        u.password    = 'E2tah3Y7'
        u.role = 'guest'
    end
