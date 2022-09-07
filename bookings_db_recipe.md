1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a user,
When booking a place I want to be able to send a booking request

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	    Properties
bookings    space_id, start date, end date, user_id (booker), status
users       name, email
spaces      name, status (available/unavailable), user_id (owner) 

# Name of the first table (always plural): users

Column names: email, name

# Name of the second table (always plural): bookings

Column names: space, start date, end date, user_id, status

# Name of the third table (always plural): spaces

Column names: id, name, owner_id, status


3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: users
id: SERIAL
name: text
email: text

Table: bookings
id: SERIAL
space: text
start_date: date
end_date: date
user_id: int
status: text

Table: spaces
id: SERIAL
name: text
status: boolean
owner_id: int

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one booking have many users? No
Can one booking have many spaces? No
Can one space have many users? No
Can one space have many bookings? Yes
Can one user have many sapces? Yes
Can one user have many bookings? Yes

You'll then be able to say that:

[A] has many [B]
And on the other side, [B] belongs to [A]
In that case, the foreign key is in the table [B]
Replace the relevant bits in this example with your own:

# EXAMPLE

1. Can one booking have many users? No
2. Can one user have many bookings? Yes

-> Therefore,
-> A user HAS MANY bookings
-> An booking BELONGS TO an user

-> Therefore, the foreign key is on the bookings table.
If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).

4. Write the SQL.
-- EXAMPLE
-- file: bookings_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name text,
    email text
);

-- Then the table with the foreign key.
CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  availability boolean,
-- The foreign key name is always {other_table_singular}_id
  owner_id int,
  constraint fk_owner foreign key(owner_id)
    references users(id)
    on delete cascade
);

-- Then the table with the foreign key.
CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  start_date date,
  end_date date,
  status text,
-- The foreign key name is always {other_table_singular}_id
  space_id int,
  constraint fk_space foreign key(space_id)
    references spaces(id)
    on delete cascade,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql