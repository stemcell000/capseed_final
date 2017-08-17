class AddMelissa < ActiveRecord::Migration
  def change
    User.create! do |u|
            u.email     = 'melissa.desrosiers@inserm.fr'
            u.username = 'mdesrosiers'
            u.firstname = 'Melissa'
            u.lastname = 'Desrosiers'
            u.password    = '2qg4Z2Jf'
            u.role = 'administrator'
        end
  end
end
