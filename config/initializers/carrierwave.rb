#Config précédente (upload local seulement)
#CarrierWave.configure do |config|
 # config.storage = :file
 # config.asset_host = ActionController::Base.asset_host
 CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY"],        # required
    aws_secret_access_key: ENV["AWS_SECRET_KEY"],        # required
    region: 'eu-west-3',
    #host: 's3-eu-west-3.amazonaws.com'
  }
  config.fog_directory  = ENV["AWS_BUCKET"]              # required

end
  
