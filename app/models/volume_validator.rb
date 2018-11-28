class VolumeValidator < ActiveModel::Validator
  def validate(record)
      unless record.volume > 0
        record.errors[:volume] << 'not enough material!'
     end
  end
end