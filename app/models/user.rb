class User < ActiveRecord::Base
  has_many :virus_productions
  has_many :assays
  has_many :plasmid_batches
  has_many :virus_productions
  has_many :sequencings
  has_many :pcr_colonies
  has_many :dosages

  accepts_nested_attributes_for :virus_productions
  accepts_nested_attributes_for :assays
  accepts_nested_attributes_for :plasmid_batches, :allow_destroy => true
  accepts_nested_attributes_for :sequencings
  accepts_nested_attributes_for :dosages

  has_many :plasmid_batch_qcs
  accepts_nested_attributes_for :virus_productions
  
  validates :username, :firstname, :lastname,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:rememberable, :trackable, 
         :validatable, :authentication_keys => [:login]
  
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
    def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
  end
    
   def role?(r)
     role.include? r.to_s
   end
   
   def full_name
     "#{firstname} #{lastname}"
   end
   
end
