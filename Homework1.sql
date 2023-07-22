USE lesson_1;
DROP TABLE IF EXISTS Mobile_Phones;
CREATE TABLE IF NOT EXISTS Mobile_Phones
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(20),
    Manufacturer VARCHAR(45),
    ProductCount INT,
    Price DECIMAL
);

INSERT Mobile_Phones (ProductName,Manufacturer,ProductCount, Price)
VALUES
	("iPhone X", "Apple", "3", "76000"),
    ("iPhone 8", "Apple", "2", "51000"),
    ("Galaxy S9", "Samsung", "2", "56000"),
    ("Galaxy S8", "Samsung", "1", "41000"),
    ("P20 Pro", "Huawei", "5", "36000");
    
SELECT * FROM Mobile_Phones;

SELECT ProductName, Manufacturer, Price
FROM Mobile_Phones
WHERE ProductCount > 2;

SELECT *
FROM Mobile_Phones
WHERE Manufacturer = "Samsung";

SELECT *, ProductCount*Price AS Sum
FROM Mobile_Phones
WHERE ProductCount*Price > 100000 AND ProductCount*Price < 145000;

SELECT *
FROM MObile_Phones
WHERE ProductName LIKE "%Iphone%";

SELECT *
FROM Mobile_Phones
WHERE ProductName LIKE "%Galaxy%";

SELECT *
FROM Mobile_Phones
WHERE ProductName REGEXP '[0-9]';

SELECT *
FROM Mobile_Phones
WHERE ProductName REGEXP '8';


