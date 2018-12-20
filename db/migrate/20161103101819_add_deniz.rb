class AddDeniz < ActiveRecord::Migration
  def change
         User.create! do |u|
            u.email     = 'deniz.dalkara@inserm.fr'
            u.username = 'ddalkara'
            u.firstname = 'Deniz'
            u.lastname = 'Dalkara'
            u.encrypted_password   = '76W3prAj'
            u.password = '76W3prAj'
            u.password_confirmation =  '76W3prAj'
            u.role = 'administrator'
        end
  end
end
