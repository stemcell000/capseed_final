class User < ActiveRecord::Base
  
  after_create :create_option
  
  has_many :virus_productions
  has_many :assays
  has_many :plasmid_batches
  has_many :sequencings
  has_many :pcr_colonies
  has_many :dosages
  has_many :options

  accepts_nested_attributes_for :virus_productions
  accepts_nested_attributes_for :assays
  accepts_nested_attributes_for :plasmid_batches, :allow_destroy => true
  accepts_nested_attributes_for :sequencings
  accepts_nested_attributes_for :dosages
  accepts_nested_attributes_for :options
  
  has_many :plasmid_batch_qcs
  accepts_nested_attributes_for :virus_productions
  
  validates :username, :firstname, :lastname,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:rememberable, :trackable, :confirmable, 
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
    unless role.nil?
     role.include? r.to_s
    end
   end
   
   def full_name
     "#{firstname} #{lastname}"
   end
  
   def switch_toggle
     self.toggle!(:toggle_switch)
  end
  
    def password_match?
     self.errors[:password] << I18n.t('errors.messages.blank') if password.blank?
     self.errors[:password_confirmation] << I18n.t('errors.messages.blank') if password_confirmation.blank?
     self.errors[:password_confirmation] << I18n.translate("errors.messages.confirmation", attribute: "password") if password != password_confirmation
     password == password_confirmation && !password.blank?
  end

  # new function to set the password without knowing the current 
  # password used in our confirmation controller. 
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore. 
  # Instead you should use `pending_any_confirmation`.  
  def only_if_unconfirmed
   pending_any_confirmation {yield}
   #unless_confirmed {yield}
  end
  
  def password_required?
  # Password is required if it is being set, but not for new records
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
   
   def dependencies
     self.virus_productions.empty? || self.assays.empty? ||self.plasmid_batches.empty? || self.sequencings.empty? || self.pcr_colonies.empty || self.dosages.empty?
   end
   
   private
   
     def create_option
      self.options.create(:display_all_virus => false, :display_all_clone_batch => false, :display_hidden_virus => false, :display_hidden_clone_batch => false)
    end
   
end
