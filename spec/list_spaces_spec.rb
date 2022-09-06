require 'list_spaces'

RSpec.describe ListSpaces do
    context '#Add' do
        it 'adds users space to list of all spaces' do
            list_spaces = ListSpaces.new
            list_spaces.add('Space1')
            list_spaces.add('Space2')

            expect(list_spaces.list).to eq ['Space1', 'Space2']
        end
        it 'User does not input a space or invalid space' do
            list_spaces = ListSpaces.new    
            expect{ list_spaces.add(' ') }.to raise_error "Cannot add empty space"
        end
    end
end 