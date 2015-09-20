CarrierWave.configure do |config|
  credentials = Rails.application.secrets.aws
  if credentials.values.all?(&:present?)
    config.storage :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: credentials[:access_key_id],
      aws_secret_access_key: credentials[:secret_access_key],
    }
    config.fog_directory = credentials[:s3_bucket]
  else
    config.storage :file
  end
end
