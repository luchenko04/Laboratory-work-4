-- Удаление существующих таблиц, если они есть
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS painting_catalogs;
DROP TABLE IF EXISTS catalogs;
DROP TABLE IF EXISTS sales_agents;
DROP TABLE IF EXISTS buyers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS paintings;
DROP TABLE IF EXISTS artists;

-- Создание таблицы художников
CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    bio VARCHAR(255),
    birth_date DATE
);

-- Создание таблицы картин
CREATE TABLE paintings (
    painting_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price NUMERIC(10, 2),
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES artists (artist_id)
);

-- Создание таблицы пользователей
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    user_type VARCHAR(20),
    CHECK (user_type IN ('Покупець', 'Агент'))
);

-- Создание таблицы покупателей
CREATE TABLE buyers (
    buyer_id SERIAL PRIMARY KEY,
    user_id INT,
    address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

-- Создание таблицы агентов по продажам
CREATE TABLE sales_agents (
    agent_id SERIAL PRIMARY KEY,
    user_id INT,
    commission_rate NUMERIC(5, 2),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

-- Создание таблицы каталогов
CREATE TABLE catalogs (
    catalog_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- Создание таблицы для связи картины и каталога
CREATE TABLE painting_catalogs (
    painting_id INT,
    catalog_id INT,
    PRIMARY KEY (painting_id, catalog_id),
    FOREIGN KEY (painting_id) REFERENCES paintings (painting_id),
    FOREIGN KEY (catalog_id) REFERENCES catalogs (catalog_id)
);

-- Создание таблицы заказов
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    buyer_id INT,
    order_date DATE,
    total_amount NUMERIC(10, 2),
    FOREIGN KEY (buyer_id) REFERENCES buyers (buyer_id)
);

-- Создание таблицы оплат
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount NUMERIC(10, 2),
    payment_method VARCHAR(20),
    CHECK (payment_method IN ('Кредитна карта', 'Наличные', 'Онлайн оплата')),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);








