require_relative 'booking'
require_relative 'database_connection'
require 'date'

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

    def available_spaces(user_dates)
        booking_clashes = []
        sql = 'SELECT start_date, end_date, space_id FROM bookings;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            booking = Booking.new

            booking.id = record['id'].to_i
            booking.space_id = record['space_id'].to_i
 
            booking.start_date = Date.parse(record['start_date'])
            booking.end_date = Date.parse(record['end_date'])

            date_range = ((booking.start_date .. booking.end_date).each{|date| date}).to_a

            user_dates.each do |date|
                if date_range.any?(date)
                    booking_clashes << booking.space_id
                    break
                end
            end
        end 
        return booking_clashes
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

    def find(id)
        sql = 'SELECT start_date, end_date, space_id, status FROM bookings WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])
        @spaces = []
        result_set.each do |record|
            booking = Booking.new 
            booking.start_date = result_set[0]['start_date']
            booking.end_date = result_set[0]['end_date']
            booking.space_id = result_set[0]['space_id']
            booking.status = result_set[0]['status']
            @spaces << booking
        end 
        return @spaces
    end 
end 

