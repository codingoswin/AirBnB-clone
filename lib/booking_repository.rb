require 'booking'

class BookingRepository 
    def all
        bookings = []
        sql = 'SELECT id, space_id, start_date, end_date, user_id FROM bookings;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            booking = Booking.new
            booking.id = record['id'].to_i
            booking.space_id = record['space_id']
            booking.start_date = record['start_date']
            booking.end_date = record['end_date']
            booking.user_id = record['user_id'].to_i
            bookings << booking
        end 
        return bookings
    end 

    def make_available(id)
        sql = 'UPDATE spaces SET availability = true WHERE id = $1;'
    end 

    def make_unavailable
        sql = 'UPDATE spaces SET availability = false WHERE id = $1;'
    end 
end 