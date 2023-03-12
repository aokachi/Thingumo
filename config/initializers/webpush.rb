Webpush.configure do |config|
  config.vapid_public_key = ENV['VAPID_PUBLIC_KEY']
  config.vapid_private_key = ENV['VAPID_PRIVATE_KEY']
  config.vapid_subject = 'mailto:strohynis@gmail.com'
end