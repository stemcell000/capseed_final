class UserVirusProduction < ActiveRecord::Base
  self.table_name = "users_virus_productions"
  belongs_to :user
  belongs_to :virus_production
end
