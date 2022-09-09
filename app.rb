require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/booking_repository'
require_relative 'lib/space_repository'
require_relative 'lib/booking'
require 'date'
require_relative 'lib/user_repository'
require_relative 'lib/user'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/booking_repository'
    also_reload 'lib/space_repository'
  end

  get '/login' do
    return erb(:login)
  end

  get '/bookings/new' do
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

  get '/' do
    return erb(:homepage)
  end
  
  post '/' do
    user_repo = UserRepository.new
    new_user = User.new
    new_user.username = params['username']
    new_user.email = params['email']
    new_user.password = params['password']
    user_repo.create(new_user)
    return erb(:signup_success)
  end

  get '/spaces/new' do 
    return erb(:new_space)
  end 

  post '/spaces/new' do
    space_repo = SpaceRepository.new
    new_space = Space.new 
    new_space.name = params['name']
    new_space.availability = true
    new_space.description = params['description']
    new_space.price_per_night = params['price_per_night']
    new_space.owner_id = params['owner_id']
    space_repo.add(new_space)
    return erb(:space_added)
  end 

  get '/check_bookings' do 
    return erb(:check_bookings)
  end

end
