require 'booking'

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

        end 
    end 
end 