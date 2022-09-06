
TRUNCATE TABLE spaces RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO spaces (id, name, availability, owner_id) VALUES ('1', 'Country house', false, '1');
INSERT INTO spaces (id, name, availability, owner_id) VALUES ('2', 'City aprtment', false, '2');
INSERT INTO spaces (id, name, availability, owner_id) VALUES ('3', 'Beach drive', false, '3');
