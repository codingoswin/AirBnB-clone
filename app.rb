require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/booking_repository'
require_relative 'lib/list_spaces_repository'
require_relative 'lib/booking'
require 'date'

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
    #@spaces = SpaceRepository.new 
    #@space = Space.new 
    #@booking_repo = BookingRepository.new
    #@booking = Booking.new
    #@booking.start_date = params[:start_date]
    #@booking.end_date = params[:end_date]
    #@booking.space_id = params[:space_id]
    #@booking.user_id = params[:user_id]
    #@booking_repo.create(@booking)
    #@space.name = params[:name]
    #@space.availability = params[:availability]
    #@space.owner_id = params[:owner_id]
    return erb(:new_booking)
  end

  post '/spaces/available' do
    @spaces = SpaceRepository.new
    @booking_repo = BookingRepository.new
    @new_booking = Booking.new

    @new_booking.user_id = params[:user_id]
    @new_booking.start_date = params[:start_date]
    @new_booking.end_date = params[:end_date]

    checkin_date = Date.parse(@new_booking.start_date)
    checkout_date = Date.parse(@new_booking.end_date)

    user_dates = ((checkin_date .. checkout_date).each{|date| date}).to_a
    
    @booking_clashes = @booking_repo.available_spaces(user_dates)
                      
    return erb(:available_spaces)
  end 

  post '/bookings' do 
    return erb(:confirmation_booking)
  end 

end

