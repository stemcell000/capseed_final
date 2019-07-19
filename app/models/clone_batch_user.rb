class CloneBatchUser < ActiveRecord::Base
  self.table_name = "clone_batches_users"
  belongs_to :user
  belongs_to :clone_batch
end
