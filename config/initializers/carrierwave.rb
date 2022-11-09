unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA4ELI4CX2J73TCRM3',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'thingumo'
    config.cache_storage = :fog
  end
end