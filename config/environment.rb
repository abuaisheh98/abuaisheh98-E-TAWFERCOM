# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_job = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.smtp_settings = {
  address: 'smtp@gmail.com',
  port: 465,
  domain: 'gmail.com',
  user_name: ENV['laithabuaisheh9@gmail.com'],
  password: ENV['000000000'],
  authentication: 'plain',
  :ssl => true ,
  :tsl => true ,
  enable_starttls_auto: true
}