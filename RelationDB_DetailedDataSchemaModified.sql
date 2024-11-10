-- Створення таблиці Художник
CREATE TABLE Artist (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    bio VARCHAR(255),
    birth_date DATE
);

-- Створення таблиці Картина
CREATE TABLE Painting (
    painting_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price NUMERIC(10, 2),
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artist (artist_id)
);

-- Створення таблиці Користувач
CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    user_type VARCHAR(20) CHECK (user_type IN ('Покупець', 'Агент'))
);

-- Створення таблиці Покупець
CREATE TABLE Buyer (
    buyer_id SERIAL PRIMARY KEY,
    user_id INT,
    address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES "User" (user_id)
);

-- Створення таблиці Агент з продажу
CREATE TABLE SalesAgent (
    agent_id SERIAL PRIMARY KEY,
    user_id INT,
    commission_rate NUMERIC(5,2),
    FOREIGN KEY (user_id) REFERENCES "User" (user_id)
);

-- Створення таблиці Каталог
CREATE TABLE Catalog (
    catalog_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- Створення таблиці Картина-Каталог
CREATE TABLE PaintingCatalog (
    painting_id INT,
    catalog_id INT,
    PRIMARY KEY (painting_id, catalog_id),
    FOREIGN KEY (painting_id) REFERENCES Painting (painting_id),
    FOREIGN KEY (catalog_id) REFERENCES Catalog (catalog_id)
);

-- Створення таблиці Замовлення
CREATE TABLE "Order" (
    order_id SERIAL PRIMARY KEY,
    buyer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2),
    FOREIGN KEY (buyer_id) REFERENCES Buyer (buyer_id)
);

-- Створення таблиці Оплата
CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount NUMERIC(10,2),
    payment_method VARCHAR(20) CHECK (payment_method IN ('Кредитна карта', 'Наличные', 'Онлайн оплата')),
    FOREIGN KEY (order_id) REFERENCES "Order" (order_id)
);

