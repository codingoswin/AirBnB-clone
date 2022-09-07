require_relative 'booking'
require_relative 'database_connection'

class BookingRepository 
    def all
        bookings = []
        sql = 'SELECT id, space_id, start_date, end_date, user_id, status FROM bookings;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            booking = Booking.new
            booking.id = record['id'].to_i
            booking.space_id = record['space_id'].to_i
            booking.start_date = record['start_date']
            booking.end_date = record['end_date']
            booking.status = record['status']
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

    def create(booking)
        sql = 'INSERT INTO bookings (start_date, end_date, space_id, user_id, status) VALUES ($1, $2, $3, $4, $5);'
        result_set = DatabaseConnection.exec_params(sql, [booking.start_date, booking.end_date, booking.space_id, booking.user_id, booking.status])
        return booking
    end 

    def confirm(id)
        sql = "UPDATE bookings SET status = 'confirmed' WHERE id = $1;"
        sql_params = [id]
        DatabaseConnection.exec_params(sql, sql_params)
    end 
end 

