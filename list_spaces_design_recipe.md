## List Space Design Recipe for MakersBnB


## 1. Describe the Problem

As a user
When listing a place I want to be able to see a list of my spaces


## 2. Design the Class Interface
Include the initializer and public methods with all parameters and return values.

class ListSpaces
  def add(space) # Be able to add space to a list
  end

  def list # stores a list of all the spaces as an array
  end
end


## 3. Create Examples as Tests
Make a list of examples of how the class will behave in different situations.

# 1 Adds users space to list of all spaces
list_spaces = ListSpaces.new
list_spaces.add('Spaces1')
list_spaces.list => ['Spaces1']

# 2 Adds users space to list of all spaces 
list_spaces = ListSpaces.new
list_spaces.add('Spaces2')
list_spaces.list => ['Spaces2']


# 3 If user does not input a space or invalid space
list_spaces = ListSpaces.new    
expect(list_spaces.add(' ').to raise_error 'Cannot add empty space'



## 4. Implement the Behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.  