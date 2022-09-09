require 'space_repository'

def reset_tables
    seed_sql = File.read('spec/seeds/bookings_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end

RSpec.describe SpaceRepository do


    before(:each) do 
        reset_tables 
    end

    context '#Add' do
        it 'adds users space to list of all spaces' do
            repo = SpaceRepository.new
            new_space = Space.new 
            new_space.name = "Our new house"
            new_space.availability = true 
            new_space.owner_id = 1
            repo.add(new_space)
            all_spaces = repo.all
            expect(all_spaces.length).to eq 6   
        end
        # it 'User does not input a space or invalid space' do
        #     list_spaces = SpaceRepository.new    
        #     expect{ list_spaces.add('')}.to raise_error "Cannot add empty space"
        # end
    end
end 

