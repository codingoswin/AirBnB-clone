require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_tables
    seed_sql = File.read('spec/seeds/bookings_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end

describe Application do

    include Rack::Test::Methods

    let(:app) { Application.new }

    before(:each) do 
        reset_tables 
    end
    
    context "GET /login" do
        it 'returns the login page' do
        response = get('/login')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Welcome to Papaya BnB</h1>')
        end
    end

    # context "POST /login" do
    #     it 'returns a successful login page' do
    #     response = post(
    #         '/login',
    #         name: 'Sam',
    #         email: 'sam@makersbnb.com',
    #         password: 'password!123'
    #     )
    #     expect(response.status).to eq(200)
    #     expect(response.body).to include('<p>You have logged in successfully!</p>')
    #     end
    # end

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

    context 'POST /spaces/available' do
        it 'returns dates once search sent' do
            response = post('/spaces/available',
                start_date: '2022-09-04', 
                end_date: '2022-09-10')
            
            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>Available Spaces</h1>')
            expect(response.body).to include('<td>Beach house</td>')
            expect(response.body).to include('<td>Mountain view</td>')
            expect(response.body).to include('<input type="submit" value="Book now!">')
 
        end

        it 'returns only spaces that are not booked on those dates' do
            response = post('/spaces/available',
                user_id: 1,
                start_date: '2022-04-04', 
                end_date: '2022-04-10')
            
            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>Available Spaces</h1>')
            expect(response.body).to include('<td>Beach house</td>')
            expect(response.body).not_to include('<td>Country home</td>')
            expect(response.body).to include('<input type="submit" value="Book now!">')
        end

        it 'returns only spaces that are available for a date overlapping 2 months' do 
            response = post('/spaces/available',
                user_id: 1,
                start_date: '2022-03-25',
                end_date: '2022-04-05'
            )

            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>Available Spaces</h1>')
            expect(response.body).not_to include('City Apartment')
            expect(response.body).not_to include('Country home')
        end
    end

    context ' POST /bookings' do 
        it'returns a confirmation HTML page' do
            response = post('bookings')

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

    context "GET /spaces/new" do
        it 'returns the new space form page' do
        response = get('/spaces/new')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>List a space</h1>')
        end
    end
    context "POST /spaces/new" do
        it 'returns a successful space added page' do
        response = post(
            '/spaces/new',
            name: 'My New Space',
            availability: 'false',
            description: 'Western',
            price_per_night: '65',
            owner_id: '2'
        )
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Your space has been added!</h1>')
        end
    end
end
