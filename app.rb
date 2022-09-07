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
    @spaces = SpaceRepository.new 
    @space = Space.new 
    @booking_repo = BookingRepository.new
    @booking = Booking.new
    @booking.start_date = params[:start_date]
    @booking.end_date = params[:end_date]
    @booking.space_id = params[:space_id]
    @booking.user_id = params[:user_id]
    @booking_repo.create(@booking)
    @space.name = params[:name]
    @space.availability = params[:availability]
    @space.owner_id = params[:owner_id]
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

