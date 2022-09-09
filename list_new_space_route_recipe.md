# GET /spaces/new
# POST /spaces/new

As a user, 
When listing a place 
I want to be able to list a new space to rent



## 1. Design the Route Signature

# Request:
GET /spaces/new

# With body parameters:
GET request: no parameters

# Expected responses for GET /spaces/new (200 OK)
GET /spaces/new
HTML form returned (200 OK)
<!-- file: views/new_space.erb -->


<h1>List a space</h1>

<form action="/spaces/new" method="GET">

  Owner ID: <input type="text" name="owner_id">
  Name: <input type="text" name="name">
  Give a short description of your place: <textarea type="text" name="description">Enter text here...</textarea>
  Price Per night: <input type="number" name="price_per_night">
  <input type="submit" value="Search">

</form>



# Request:
POST /spaces/new

# With body parameters:
POST request: name, availability, description, price_per_night, owner_id
HTML confirmation page returned.

# Expected responses for POST /spaces/new (200 OK)
HTML page returned (200 OK)
<!-- file: views/space_added.erb -->

<h1>Your space has been added!</h1>

<a href='/bookings/new'>See the list of available spaces</a>
<a href='/spaces/new'>Add another space</a>




## 2. Design the Response

GET
/bookings/new

Returns a HTML page including a form to request a new booking.

POST
/bookings

Returns a HTML page confirming request submission



## 3. Write Examples

# Request:

GET /spaces/new

# Expected response:

Response for 200 OK:
<!-- file: views/new_space.erb -->


<h1>List a space</h1>

<form action="/spaces/new" method="GET">

  Owner ID: <input type="text" name="owner_id">
  Name: <input type="text" name="name">
  Give a short description of your place: <textarea type="text" name="description">Enter text here...</textarea>
  Price Per night: <input type="number" name="price_per_night">
  <input type="submit" value="Search">

</form>

# Request:

POST /spaces/new

# Expected response:

Response for 200 OK:
<!-- file: views/space_added.erb -->

<h1>Your space has been added!</h1>

<a href='/bookings/new'>See the list of available spaces</a>
<a href='/spaces/new'>Add another space</a>



## 4. Encode as Tests Examples

```ruby
EXAMPLE
file: spec/integration/application_spec.rb

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
