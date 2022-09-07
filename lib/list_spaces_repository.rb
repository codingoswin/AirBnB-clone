require 'spaces'

class SpaceRepository

    def all

        spaces = []
        sql = 'SELECT id, name, availability, owner_id FROM spaces;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            space = Space.new

            space.id = record['id'].to_i
            space.name = record['name']
            space.availability = record['availability']
            space.owner_id = record['owner_id'].to_i
            spaces << space
        end 
        return spaces
    end

    def add(space)
        fail "Cannot add empty space" if space == nil
        sql = 'INSERT INTO spaces (name, availability, owner_id) VALUES ($1, $2, $3);'
        result_set = DatabaseConnection.exec_params(sql, [space.name, space.availability, space.owner_id])
        return space
    end


    # def list
    #    return @list
    # end
end