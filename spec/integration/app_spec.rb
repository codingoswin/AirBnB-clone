require "spec_helper"
require "rack/test"
require_relative '../../app'

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

    context "POST /login" do
        it 'returns a successful login page' do
        response = post(
            '/login',
            name: 'Sam',
            email: 'sam@makersbnb.com',
            password: 'password!123'
        )
        expect(response.status).to eq(200)
        expect(response.body).to include('<p>You have logged in successfully!</p>')
        end
    end

    context 'GET bookings/new' do
        it 'has a form to request a booking' do
            response = get('/bookings/new')
            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>Make a new booking request</h1>')
            expect(response.body).to include('User ID: <input type="text" name="user_id">')
            expect(response.body).to include('Check-in date: <input type="date" name="start_date"')
            expect(response.body).to include('Check-out date: <input type="date" name="end_date"')
            expect(response.body).to include('<input type="submit" value="Search">')
        end
    end

    context 'POST /bookings/available' do
        it 'returns dates once search sent' do
            response = post('/bookings/available',
                start_date: '2022-09-04', 
                end_date: '2022-09-10')
            
            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>Available Spaces</h1>')
            expect(response.body).to include('<td>Beach house</td>')
            expect(response.body).to include('<td>Mountain view</td>')
            expect(response.body).to include('<input type="submit" value="Book now!">')
        end
    end

    context ' POST /bookings' do 
        it'returns a confirmation HTML page' do
            response = post('bookings', 
                start_date: '2022-09-04', 
                end_date: '2022-09-10', 
                space: '5', 
                user_id: '1')

            expect(response.status).to eq(200)
            expect(response.body).to include('<p>Your booking request was sent!</p>')
        end
    
    end

    context 'GET /' do
        it 'homepage with form for new users to sign up' do
            response = get('/')

            expect(response.status).to eq(200)
            expect(response.body).to include ('<h1>Papaya BnB</h1>')
        end
    end
end
