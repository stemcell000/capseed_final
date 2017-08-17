class AddAdministrator < ActiveRecord::Migration
  def change    
            User.create! do |u|
            u.email     = 'marc.lechuga@inserm.fr'
            u.username = 'mlechuga'
            u.firstname = 'Marc'
            u.lastname = 'Lechuga'
            u.password    = 'stemcell'
            u.role = 'administrator'
        end
  end
end
