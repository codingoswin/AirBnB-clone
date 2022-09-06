# GET /bookings/new
# POST /bookings

As a user, When booking a place I want to be able to send a booking request



## 1. Design the Route Signature

# Requests:
GET /bookings/new
POST /bookings

# With body parameters:
GET request: no parameters
POST request: user_id, space, start_date, end_date

# Expected response (200 OK)
GET request:
HTML form returned
<!-- file: views/new_booking.erb -->

<h1>Make a booking</h1>

<form action="/bookings" method="POST">

  User ID: <input type="text" name="user_id">
  Space: <input type="text" name="space">
  Check-in date: <input type="date" name="start_date">
  Check-out date: <input type="date" name="end_date">
  <input type="submit" value="Submit the form">

</form>

POST request:
HTML page including "Your booking request was sent!"
<!-- file: views/booking_request_sent.erb -->

<html>
  <head></head>
  <body>
    <p>Your booking request was sent!</p>
  </body>
</html>



## 2. Design the Response

GET
/bookings/new

Returns a HTML page including a form to request a new booking.

POST
/bookings

Returns a HTML page confirming request submission



## 3. Write Examples

# Request:

GET /bookings/new

# Expected response:

Response for 200 OK:
<!-- file: views/new_booking.erb -->

<h1>Make a booking</h1>

<form action="/bookings" method="POST">

  User ID: <input type="text" name="user_id">
  Space: <input type="text" name="space">
  Check-in date: <input type="date" name="start_date">
  Check-out date: <input type="date" name="end_date">
  <input type="submit" value="Submit the form">

</form>

# Request:

POST /bookings

# Expected response:

Response for 200 OK:
<!-- file: views/booking_request_sent.erb -->

<html>
  <head></head>
  <body>
    <p>Your booking request was sent!</p>
  </body>
</html>



## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
    include Rack::Test::Methods

    let(:app) { Application.new }

    context "GET /albums/new" do
        it 'returns the new artist form page' do
        response = get('/artists/new')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Add an artist</h1>')
        end
    end

    context "POST /artists" do
        it 'returns a success page' do
        # We're now sending a POST request,
        # simulating the behaviour that the HTML form would have.
        response = post(
            '/artists',
            name: 'Johnny Cash',
            genre: 'Western',
        )
        expect(response.status).to eq(200)
        expect(response.body).to include('<p>Your artist has been added!</p>')
        end
  
        it 'responds with 400 status if parameters are invalid' do
        response = post(
            '/artist',
            wrong_name: 'Johnny Money',
            wrong_genre: 'Easter',
        )
        expect(response.status).to eq(400)
        expect(response.body).to eq('<p>No good - try again</p>')
        end
  end
end
```



## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
