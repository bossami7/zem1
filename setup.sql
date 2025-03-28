DROP DATABASE IF EXISTS land_analysis;
CREATE DATABASE land_analysis;
\c land_analysis

-- Создание таблицы для земельных участков
CREATE TABLE IF NOT EXISTS lands (
    id SERIAL PRIMARY KEY,
    region VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    area FLOAT NOT NULL,
    coordinates TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Вставка тестовых данных
INSERT INTO lands (region, type, area, coordinates) VALUES
    ('Московская область', 'ИЖС', 10.5, '[55.751244, 37.618423]'),
    ('Ленинградская область', 'ИЖС', 15.2, '[59.931058, 30.360909]'),
    ('Новосибирская область', 'СНТ', 6.8, '[55.008352, 82.935733]'),
    ('Московская область', 'ИЖС', 4.5, '[55.755819, 37.617644]'),
    ('Калужская область', 'ИЖС', 12.0, '[54.513845, 36.261224]'); 