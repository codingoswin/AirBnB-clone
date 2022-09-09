require 'user_repository'

RSpec.describe UserRepository do 
    it 'adds a new user' do 
        new_user = User.new 
        user_repo = UserRepository.new
        new_user.username = 'Adrian'
        new_user.email = 'adrian@makersbnb.com'
        new_user.password = 'noyb123'
        user_repo.create(new_user)
        expect(user_repo.all.size).to eq 4
        expect(user_repo.all.last.username).to eq "Adrian"
        expect(user_repo.all.last.email).to eq "adrian@makersbnb.com"
        expect(user_repo.all.last.password).to eq "noyb123"
    end 
end 