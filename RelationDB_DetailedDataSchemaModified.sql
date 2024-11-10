-- Створення таблиці Художник
CREATE TABLE Artist (
    artist_id INTEGER,
    name VARCHAR(50) NOT NULL,
    bio VARCHAR(255),
    birth_date DATE,
    PRIMARY KEY (artist_id)
);

-- Створення таблиці Картина
CREATE TABLE Painting (
    painting_id INTEGER,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price NUMERIC(10,2),
    artist_id INTEGER,
    PRIMARY KEY (painting_id),
    FOREIGN KEY (artist_id) REFERENCES Artist (artist_id)
);

-- Створення таблиці Користувач
CREATE TABLE User (
    user_id INTEGER,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    user_type VARCHAR(20) CHECK (user_type IN ('Покупець', 'Агент')),
    PRIMARY KEY (user_id),
    CONSTRAINT user_email_unique UNIQUE (email)
);

-- Створення таблиці Покупець
CREATE TABLE Buyer (
    buyer_id INTEGER,
    user_id INTEGER,
    address VARCHAR(255),
    PRIMARY KEY (buyer_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id)
);

-- Створення таблиці Агент з продажу
CREATE TABLE SalesAgent (
    agent_id INTEGER,
    user_id INTEGER,
    commission_rate NUMERIC(5,2),
    PRIMARY KEY (agent_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id)
);

-- Створення таблиці Каталог
CREATE TABLE Catalog (
    catalog_id INTEGER,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (catalog_id)
);

-- Створення таблиці Картина-Каталог
CREATE TABLE PaintingCatalog (
    painting_id INTEGER,
    catalog_id INTEGER,
    PRIMARY KEY (painting_id, catalog_id),
    FOREIGN KEY (painting_id) REFERENCES Painting (painting_id),
    FOREIGN KEY (catalog_id) REFERENCES Catalog (catalog_id)
);

-- Створення таблиці Замовлення
CREATE TABLE Order (
    order_id INTEGER,
    buyer_id INTEGER,
    order_date DATE,
    total_amount NUMERIC(10,2),
    PRIMARY KEY (order_id),
    FOREIGN KEY (buyer_id) REFERENCES Buyer (buyer_id)
);

-- Створення таблиці Оплата
CREATE TABLE Payment (
    payment_id INTEGER,
    order_id INTEGER,
    payment_date DATE,
    amount NUMERIC(10,2),
    payment_method VARCHAR(20) CHECK (payment_method IN ('Кредитна карта', 'Наличные', 'Онлайн оплата')),
    PRIMARY KEY (payment_id),
    FOREIGN KEY (order_id) REFERENCES Order (order_id)
);

-- Конец файла (пустая строка)

