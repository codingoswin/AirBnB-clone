TRUNCATE TABLE users, spaces, bookings RESTART IDENTITY;

INSERT INTO users (name, email) VALUES ('Sam', 'sam@makersbnb.com');
INSERT INTO users (name, email) VALUES ('Pat', 'pat@makersbnb.com');
INSERT INTO users (name, email) VALUES ('John', 'john@makersbnb.com');
INSERT INTO spaces (name, availability, owner_id) VALUES ('Beach house', false, '1');
INSERT INTO spaces (name, availability, owner_id) VALUES ('City Apartment', false, '2');
INSERT INTO spaces (name, availability, owner_id) VALUES ('Country home', false, '3');
INSERT INTO spaces (name, availability, owner_id) VALUES ('Mountain view', false, '1');
INSERT INTO spaces (name, availability, owner_id) VALUES ('By the lake', false, '2');
INSERT INTO bookings (space_id, start_date, end_date, user_id) VALUES ('1', '2022-01-01', '2022-01-30', '1');
INSERT INTO bookings (space_id, start_date, end_date, user_id) VALUES ('2', '2022-03-01', '2022-03-30', '2');
INSERT INTO bookings (space_id, start_date, end_date, user_id) VALUES ('3', '2022-04-01', '2022-04-30', '3');
