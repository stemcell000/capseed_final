class Addoptionstousers < ActiveRecord::Migration
  def change
    User.all.each do |u|
      u.options.create(display_hidden_virus: false, display_hidden_clone_batch: false, display_all_virus: false, display_all_clone_batch: false)
    end
  end
end
