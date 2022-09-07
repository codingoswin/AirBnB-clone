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

end

# context "GET /albums/new" do
#     it 'returns the new artist form page' do
#       response = get('/artists/new')
#       expect(response.status).to eq(200)
#       expect(response.body).to include('<h1>Add an artist</h1>')
#     end
# end