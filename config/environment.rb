# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
IosApi::Application.initialize!

API_SERVER = ENV['API_SERVER']