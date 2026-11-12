DROP TABLE IF EXISTS "kr_agents";
DROP TABLE IF EXISTS "kr_clients";
DROP TABLE IF EXISTS "kr_real_estate";
DROP TABLE IF EXISTS "kr_planned_detours";
DROP TABLE IF EXISTS "kr_sold_properties";
DROP TYPE IF EXISTS "real_estate_type";
DROP TYPE IF EXISTS "estate_status";
DROP TYPE IF EXISTS "client_type";

CREATE TYPE real_estate_type AS ENUM (
    'Будівля',
    'Квартира',
    'Комерційне'
);
CREATE TABLE kr_agents (
    initials VARCHAR(100) PRIMARY KEY,
    specialty real_estate_type NOT NULL
);

CREATE TYPE client_type AS ENUM(
    'Продавець',
    'Покупець'
);
CREATE TABLE kr_clients (
    initials VARCHAR(100) PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    type client_type NOT NULL
);

CREATE TYPE estate_status AS ENUM (
    'Продається',
    'Продано'
);
CREATE TABLE kr_real_estate (
    address VARCHAR(1000) PRIMARY KEY,
    type real_estate_type NOT NULL,
    owner VARCHAR(100) REFERENCES kr_clients(initials),
    price_uah INT NOT NULL,
    room_count INT NOT NULL,
    status estate_status NOT NULL
);

CREATE TABLE kr_planned_detours (
    location VARCHAR(1000) REFERENCES kr_real_estate(address),
    date DATE NOT NULL,
    client VARCHAR(100) REFERENCES kr_clients(initials),
    PRIMARY KEY(location, date, client)
);

CREATE TABLE kr_sold_properties (
    location VARCHAR(1000) REFERENCES kr_real_estate(address),
    bought_for_uah INT NOT NULL,
    date DATE NOT NULL
);
# OLTP
INSERT INTO kr_clients(email, initials, type) 
VALUES
('rr_bohatenkyi@gov.ua', 'А.А. Богатенький', 'Продавець'),
('ba_bohatenkyi@gov.ua', 'Б.А. Богатенький', 'Продавець'),
('bvchmelnickyi@gmail.com', 'В.В. Хмельницький', 'Покупець');

INSERT INTO kr_real_estate(address, type, owner, price_uah, room_count, status) 
VALUES
('вул. Шевченка (Жуляни), буд. 1, кв. 12, м. Київ, Київська область, 03193',
    'Квартира', 'А.А. Богатенький', 100000000, 1, 'Продається'),
('вул. Хрещатик, буд. 3, кв. 34, м. Київ, 01001',
    'Квартира', 'Б.А. Богатенький', 50000000, 1, 'Продається');

UPDATE kr_clients
SET email = 'aa_bohatenkyi@gmail.com'
WHERE initials = 'А.A. Богатенький';
UPDATE kr_real_estate
SET price_uah = 150000000
WHERE address = 'вул. Шевченка (Жуляни), буд. 1, кв. 12, м. Київ, Київська область, 03193';

DELETE FROM kr_clients
WHERE initials = 'А.A. Богатенький';
DELETE FROM kr_real_estate
WHERE initials = 'А.A. Богатенький';

# 1 - skip
SELECT (*)
FROM kr_planned_detours
WHERE address = 'вул. Хрещатик, буд. 3, кв. 34, м. Київ, 01001';

# OLAP
SELECT AVG(price_uah)
FROM kr_real_estate
GROUP BY "type";
# 2-4 - skip