class ListSpaces
    def initialize 
        @list = []
    end

    def add(space)
        fail "Cannot add empty space" unless space.nil?
        @list << space

    end

    def list
       return @list
    end
end