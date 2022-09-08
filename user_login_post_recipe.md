# GET /login
# POST /login



## 1. Design the Route Signature

# Requests:
GET /login
POST /login

# With body parameters:
GET request: no parameters
POST /login: username, password

# Expected response (200 OK)
GET request: /login
HTML form returned
<!-- file: views/login.erb -->

<h1>Welcome to Papaya BnB.</h1>

<form action="/login" method="GET">

  Username: <input type="text" name="username">
  Password: <input type="password" name="password">
  <input type="submit" value="Submit the form">

</form>

POST request:
HTML page including "You have logged in successfully!"
<!-- file: views/login_success.erb -->

<html>
  <head></head>
  <body>
    <p>You have logged in successfully!</p>
    <a href='/available_bookings'>Book a space.</a>
  </body>
</html>



## 2. Design the Response

GET
/login

Returns a HTML page including a form to log in a user.

POST
/login

Returns a HTML page confirming submission and link to book a space.



## 3. Write Examples

# Request:

GET /login

# Expected response:

Response for 200 OK:
<!-- file: views/login.erb -->

<h1>Welcome to Papaya BnB.</h1>

<form action="/login" method="GET">

  Username: <input type="text" name="username">
  Password: <input type="password" name="password">
  <input type="submit" value="Submit the form">

</form>

POST /login

# Expected response:

Response for 200 OK:
<!-- file: views/login_success.erb -->

<html>
  <head></head>
  <body>
    <p>You have logged in successfully!</p>
    <a href='/available_bookings'>Book a space.</a>
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

    context "GET /login" do
        it 'returns the login page' do
        response = get('/login')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Welcome to Papaya BnB</h1>')
        end
    end

    context "POST /artists" do
        it 'returns a successful login page' do
        response = post(
            '/login',
            username: 'sam@makersbnb.com',
            password: 'password!123',
        )
        expect(response.status).to eq(200)
        expect(response.body).to include('<p>You have logged in successfully!</p>')
        end
  
        # it 'responds with 400 status if parameters are invalid' do
        # response = post(
        #     '/artist',
        #     wrong_name: 'Johnny Money',
        #     wrong_genre: 'Easter',
        # )
        # expect(response.status).to eq(400)
        # expect(response.body).to eq('<p>No good - try again</p>')
        # end
  end
end
```



## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
