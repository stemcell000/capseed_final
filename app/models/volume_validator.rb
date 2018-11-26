class VolumeValidator < ActiveModel::Validator
  def validate(record)
      unless record.volume - record.plasmid_batch.volume > 0
        record.errors[:volume] << 'not enough material!'
     end
  end
end