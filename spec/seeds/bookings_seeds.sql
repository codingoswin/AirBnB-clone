TRUNCATE TABLE users, spaces, bookings RESTART IDENTITY;

INSERT INTO users (username, email, password) VALUES ('Sam', 'sam@makersbnb.com', 'password!123');
INSERT INTO users (username, email, password) VALUES ('Pat', 'pat@makersbnb.com', 'password!456');
INSERT INTO users (username, email, password) VALUES ('John', 'john@makersbnb.com', 'password!789');
INSERT INTO spaces (name, availability, description, price_per_night, owner_id) VALUES ('Beach house', false, 'You can see the beach', '55', 1);
INSERT INTO spaces (name, availability, description, price_per_night, owner_id) VALUES ('City Apartment', false, 'You can see the city', '400', '2');
INSERT INTO spaces (name, availability, description, price_per_night, owner_id) VALUES ('Country home', true, 'You can see the countryside', '330', '3');
INSERT INTO spaces (name, availability, description, price_per_night, owner_id) VALUES ('Mountain view', true, 'You can see the mountain', '120', '1');
INSERT INTO spaces (name, availability, description, price_per_night, owner_id) VALUES ('By the lake', true, 'You can see the lake', '100', '2');
INSERT INTO bookings (space_id, start_date, end_date, user_id, status) VALUES ('1', '2022-01-01', '2022-01-30', '1', 'unconfirmed');
INSERT INTO bookings (space_id, start_date, end_date, user_id, status) VALUES ('2', '2022-03-01', '2022-03-30', '2', 'unconfirmed');
INSERT INTO bookings (space_id, start_date, end_date, user_id, status) VALUES ('3', '2022-04-01', '2022-04-30', '3', 'unconfirmed');
