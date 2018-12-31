class BcCrypt < ActiveRecord::Migration
  def change
    Clearance.configure do |config|
      config.password_strategy = Clearance::PasswordStrategies::BCryptMigrationFromSHA1
    end
  end
end
