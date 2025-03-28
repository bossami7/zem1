DROP DATABASE IF EXISTS land_analysis;
CREATE DATABASE land_analysis;
\c land_analysis;

CREATE TABLE lands (
    id SERIAL PRIMARY KEY,
    region VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    area FLOAT NOT NULL,
    coordinates TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO lands (region, type, area, coordinates) VALUES
    ('Moskovskaya oblast', 'IZhS', 10.5, '[55.751244, 37.618423]'),
    ('Leningradskaya oblast', 'IZhS', 15.2, '[59.931058, 30.360909]'),
    ('Novosibirskaya oblast', 'SNT', 6.8, '[55.008352, 82.935733]'),
    ('Moskovskaya oblast', 'IZhS', 4.5, '[55.755819, 37.617644]'),
    ('Kaluzhskaya oblast', 'IZhS', 12.0, '[54.513845, 36.261224]'); 