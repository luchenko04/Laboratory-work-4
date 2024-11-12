-- Создание таблицы пользователей
CREATE TABLE Users (
    User_id SERIAL PRIMARY KEY,
    User_name VARCHAR(100) NOT NULL CHECK (
        regexp_like(User_name, '^[A-ZА-Я][a-zа-яA-ZА-Я\s]{1,99}$')
    ),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL
);

-- Создание таблицы художников
CREATE TABLE Artists (
    Artist_id SERIAL PRIMARY KEY,
    Artist_name VARCHAR(100) NOT NULL CHECK (
        regexp_like(Artist_name, '^[A-ZА-Я][a-zа-яA-ZА-Я\s]{1,99}$')
    ),
    Biography VARCHAR(1000),
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES Users (User_id)
);

-- Создание таблицы клиентов
CREATE TABLE Clients (
    Client_id SERIAL PRIMARY KEY,
    Client_name VARCHAR(100) NOT NULL CHECK (
        regexp_like(Client_name, '^[A-ZА-Я][a-zа-яA-ZА-Я\s]{1,99}$')
    ),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES Users (User_id)
);

-- Создание таблицы картин
CREATE TABLE Paintings (
    Painting_id SERIAL PRIMARY KEY,
    Painting_title VARCHAR(200) NOT NULL,
    Artist_id INT,
    Price FLOAT NOT NULL CHECK (Price > 0),
    Description VARCHAR(1000),
    FOREIGN KEY (Artist_id) REFERENCES Artists (Artist_id)
);

-- Создание таблицы каталога
CREATE TABLE Catalogs (
    Catalog_id SERIAL PRIMARY KEY,
    Painting_id INT,
    Stock_num INT NOT NULL CHECK (Stock_num >= 0),
    FOREIGN KEY (Painting_id) REFERENCES Paintings (Painting_id)
);

-- Создание таблицы заказов
CREATE TABLE Orders (
    Order_id SERIAL PRIMARY KEY,
    Client_id INT,
    Order_date TIMESTAMP NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (
        Status IN ('Pending', 'Shipped', 'Completed', 'Cancelled')
    ),
    Total_amount FLOAT NOT NULL CHECK (Total_amount > 0),
    FOREIGN KEY (Client_id) REFERENCES Clients (Client_id)
);

-- Создание таблицы оплат
CREATE TABLE Payments (
    Payment_id SERIAL PRIMARY KEY,
    Order_id INT,
    Payment_date TIMESTAMP NOT NULL,
    Amount FLOAT NOT NULL CHECK (Amount > 0),
    Payment_method VARCHAR(50) CHECK (
        Payment_method IN ('Credit Card', 'PayPal', 'Bank Transfer')
    ),
    FOREIGN KEY (Order_id) REFERENCES Orders (Order_id)
);

-- Создание таблицы корзины
CREATE TABLE Carts (
    Cart_id SERIAL PRIMARY KEY,
    Client_id INT,
    Painting_id INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (Client_id) REFERENCES Clients (Client_id),
    FOREIGN KEY (Painting_id) REFERENCES Paintings (Painting_id)
);
