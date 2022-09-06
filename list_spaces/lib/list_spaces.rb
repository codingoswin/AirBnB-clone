class ListSpaces
    def initialize 
        @list = []
    end

    def add(space)
        fail "Cannot add empty space" if space.empty?
        @list << space
    
    end

    def list
       return @list
    end
end