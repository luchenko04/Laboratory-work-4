-- Создание таблицы пользователей
CREATE TABLE Users (
    User_id NUMBER PRIMARY KEY,
    User_name VARCHAR(100) NOT NULL CHECK (
        User_name ~ '^[A-ZА-Я][a-za-я\s]{1,99}$'
    ),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL
);

-- Создание таблицы художников
CREATE TABLE Artists (
    Artist_id NUMBER PRIMARY KEY,
    Artist_name VARCHAR(100) NOT NULL CHECK (
        Artist_name ~ '^[A-ZА-Я][a-za-я\s]{1,99}$'
    ),
    Biography VARCHAR(1000),
    User_id NUMBER,
    FOREIGN KEY (User_id) REFERENCES Users (User_id)
);

-- Создание таблицы клиентов
CREATE TABLE Clients (
    Client_id NUMBER PRIMARY KEY,
    Client_name VARCHAR(100) NOT NULL CHECK (
        Client_name ~ '^[A-ZА-Я][a-za-я\s]{1,99}$'
    ),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    User_id NUMBER,
    FOREIGN KEY (User_id) REFERENCES Users (User_id)
);

-- Создание таблицы картин
CREATE TABLE Paintings (
    Painting_id NUMBER PRIMARY KEY,
    Painting_title VARCHAR(200) NOT NULL,
    Artist_id NUMBER,
    Price FLOAT NOT NULL CHECK (Price > 0),
    Description VARCHAR(1000),
    FOREIGN KEY (Artist_id) REFERENCES Artists (Artist_id)
);

-- Создание таблицы каталога
CREATE TABLE Catalogs (
    Catalog_id NUMBER PRIMARY KEY,
    Painting_id NUMBER,
    Stock_num NUMBER NOT NULL CHECK (Stock_num >= 0),
    FOREIGN KEY (Painting_id) REFERENCES Paintings (Painting_id)
);

-- Создание таблицы заказов
CREATE TABLE Orders (
    Order_id NUMBER PRIMARY KEY,
    Client_id NUMBER,
    Order_date TIMESTAMP NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (
        Status IN ('Pending', 'Shipped', 'Completed', 'Cancelled')
    ),
    Total_amount FLOAT NOT NULL CHECK (Total_amount > 0),
    FOREIGN KEY (Client_id) REFERENCES Clients (Client_id)
);

-- Создание таблицы оплат
CREATE TABLE Payments (
    Payment_id NUMBER PRIMARY KEY,
    Order_id NUMBER,
    Payment_date TIMESTAMP NOT NULL,
    Amount FLOAT NOT NULL CHECK (Amount > 0),
    Payment_method VARCHAR(50) CHECK (
        Payment_method IN ('Credit Card', 'PayPal', 'Bank Transfer')
    ),
    FOREIGN KEY (Order_id) REFERENCES Orders (Order_id)
);

-- Создание таблицы корзины
CREATE TABLE Carts (
    Cart_id NUMBER PRIMARY KEY,
    Client_id NUMBER,
    Painting_id NUMBER,
    Quantity NUMBER NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (Client_id) REFERENCES Clients (Client_id),
    FOREIGN KEY (Painting_id) REFERENCES Paintings (Painting_id)
);






















