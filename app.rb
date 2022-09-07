require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/booking_repository'
require_relative 'lib/list_spaces_repository'
require_relative 'lib/booking'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/booking_repository'
    also_reload 'lib/list_spaces_repository'
  end

  get '/bookings/new' do
    return erb(:new_booking)
  end

  post '/bookings/available' do
    @spaces = SpaceRepository.new
    return erb(:available_bookings)
  end 

  post '/bookings' do 
    return erb(:confirmation_booking)
  end 

end
