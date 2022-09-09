require 'booking'
require 'booking_repository'

def reset_tables
    seed_sql = File.read('spec/seeds/bookings_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end

RSpec.describe Booking do 
    
    before(:each) do 
        reset_tables 
    end

    context 'several bookings have been added' do
        it 'returns all bookings' do
            repo = BookingRepository.new
            all_bookings = repo.all

            expect(all_bookings.length).to eq(3)
        end
    end

    context 'a user has made a booking request' do 
        it 'makes a booking' do 
            booking = Booking.new
            expect(booking.class).to eq(Booking)
        end 
        it 'checks a booking appears in the booking table' do
            repo = BookingRepository.new
            new_booking = Booking.new

            new_booking.space_id = 4
            new_booking.start_date = '2022-09-01'
            new_booking.end_date = '2022-09-08'
            new_booking.user_id = 2

            repo.create(new_booking)

            all_bookings = repo.all
            expect(all_bookings.last.space_id).to eq 4
            expect(all_bookings.last.start_date).to eq '2022-09-01'
            expect(all_bookings.last.end_date).to eq '2022-09-08'
            expect(all_bookings.last.user_id).to eq 2
            expect(all_bookings.last.id).to eq 4
        
        end 
    end
    
    context 'a booking request has been made' do
        it 'checks the status of a booking' do
            booking_repo = BookingRepository.new
            booking = Booking.new
            booking.id = 5
            booking.space_id = 1
            booking.start_date = '2022-02-05'
            booking.end_date = '2022-02-10'
            booking.user_id = 3
            booking.status = 'unconfirmed'
            booking_repo.create(booking)
            expect(booking_repo.all.last.status).to eq 'unconfirmed'
        end
        it 'changes the status of a booking from unconfirmed to confirmed' do
            booking_repo = BookingRepository.new
            booking = Booking.new
            booking.id = 4
            booking.space_id = 3
            booking.start_date = '2022-02-05'
            booking.end_date = '2022-02-10'
            booking.user_id = 3
            booking.status = 'unconfirmed'
            booking_repo.create(booking)
            booking_repo.confirm(4)
            expect(booking_repo.all.last.status).to eq 'confirmed'
        end
    end
    context 'users have been added' do 
        it 'will return a booking with a given id' do 
            booking_repo = BookingRepository.new
            result = booking_repo.find(1)
            expect(result[0].start_date).to eq '2022-01-01'
            expect(result[0].end_date).to eq '2022-01-30'
            expect(result[0].status).to eq 'unconfirmed'
        end
    end 
end 

