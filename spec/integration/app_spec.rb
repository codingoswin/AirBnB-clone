require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do

    include Rack::Test::Methods

    let(:app) { Application.new }

    context 'GET bookings/new' do
        it 'has a form to request a booking' do
            response = get('/bookings/new')
            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>Make a new booking request</h1>')
            expect(response.body).to include('User ID: <input type="text" name="user_id">')
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

    

end

# it 'should create a new album' do
#     response = post(
#       'albums',
#       title: 'Voyage',
#       release_year: '2022',
#       artist_id: '2'
#     )
#     expect(response.status).to eq(200)
#     expect(response.body).to include ('<p>Your album has been added!</p>')
    
#     response = get("/albums")
#     expect(response.body).to include ("Voyage")
#   end