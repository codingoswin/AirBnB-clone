check_in_date = variable
check_out_date = variable

holiday_dates = [check_in_date..check_out_date]

repo = BookingRepository.new
all_bookings = repo.all

all_bookings.map do |booking|
    @space.all.each |space|
        
        if all_bookings[start_date..end_date].include?(holiday_dates)
            booking.delete
        else 
            @space.name
        end


in bookings we have user and check_in check_out dates

if user.name != new_user

automatically have each availability as true
iterate through each booking checking the dates (do they clash or not)
if they clash, change the availability to false

# Method for cecking date range
start_date = Date.parse (start_date of booking)
end_date = Date.parse (end_date of booking)
date_range = ((start_date .. end_date).each{|date| puts date}).to_a
date_range.any?(booking_dates)