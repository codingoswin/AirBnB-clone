require_relative 'space'

class SpaceRepository

    def all

        spaces = []
        sql = 'SELECT id, name, availability, description, price_per_night, owner_id FROM spaces;'
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
        sql = 'INSERT INTO spaces (name, availability, description, price_per_night, owner_id) VALUES ($1, $2, $3, $4, $5);'
        result_set = DatabaseConnection.exec_params(sql, [space.name, space.availability, space.description, space.price_per_night, space.owner_id])
        return space
    end

    def check_availability(id)
        sql = 'UPDATE availability
                    SET true
                    FROM spaces
                    INNER JOIN bookings 
                        ON bookings.space_id = space.id
                        WHERE id = $1;'
        if requested_dates.include?(@start_date..@end_date)
            DatabaseConnection.exec_params(sql, [space.name, space.availability, space.owner_id])
        else 
        end 
    end 

end