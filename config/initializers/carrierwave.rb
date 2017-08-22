CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'HEROKU',
    heroku_access_key_id:     ENV["HEROKU_ACCESS_KEY_ID"],
    heroku_secret_access_key: ENV["HEROKU_SECRET_ACCESS_KEY"],
    region:                'ap-northeast-1',
    path_style:            true,
  }

  config.fog_public     = true
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  case Rails.env
  when 'production'
    config.fog_directory = 'wkbook-production'
    config.asset_host = 'https://git.heroku.com/wkbook.git'
  when 'development'
    config.fog_directory = 'wkbook-development'
    config.asset_host = 'https://git.heroku.com/wkbook.git'
  end
end
