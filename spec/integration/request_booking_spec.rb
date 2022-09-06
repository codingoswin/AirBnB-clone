require 'booking'

RSpec.describe Booking do 
    context "a user makes a new booking" do 
        it "confirms the request was received" do 
            booking = Booking.new 
            booking.space = booking["space"]
        end 
    end 
end 