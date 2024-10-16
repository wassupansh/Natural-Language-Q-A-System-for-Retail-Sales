CREATE DATABASE IF NOT EXISTS atliq_tshirts;
USE atliq_tshirts;

-- Create the t_shirts table
CREATE TABLE t_shirts (
    t_shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    brand ENUM('Van Huesen', 'Levi', 'Nike', 'Adidas') NOT NULL,
    color ENUM('Red', 'Blue', 'Black', 'White') NOT NULL,
    size ENUM('XS', 'S', 'M', 'L', 'XL') NOT NULL,
    price INT CHECK (price BETWEEN 10 AND 50),
    stock_quantity INT NOT NULL,
    UNIQUE KEY brand_color_size (brand, color, size)
);

-- Create the discounts table
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    t_shirt_id INT NOT NULL,
    pct_discount DECIMAL(5,2) CHECK (pct_discount BETWEEN 0 AND 100),
    FOREIGN KEY (t_shirt_id) REFERENCES t_shirts(t_shirt_id)
);

INSERT INTO t_shirts (brand, color, size, price, stock_quantity)
VALUES
('Adidas', 'Red', 'M', 20, 50),
('Nike', 'Blue', 'L', 25, 40),
('Van Huesen', 'Black', 'S', 30, 60),
('Levi', 'White', 'XL', 15, 70),
('Adidas', 'Red', 'S', 20, 30),
('Nike', 'Blue', 'M', 25, 45),
('Van Huesen', 'Black', 'L', 30, 55),
('Levi', 'White', 'M', 15, 65),
('Adidas', 'Red', 'XL', 20, 35),
('Nike', 'Blue', 'S', 25, 50);

INSERT INTO discounts (t_shirt_id, pct_discount)
VALUES
(1, 10.00),
(2, 15.00),
(3, 20.00),
(4, 5.00),
(5, 25.00),
(6, 10.00),
(7, 30.00),
(8, 35.00),
(9, 40.00),
(10, 45.00);

SELECT * FROM t_shirts;
SELECT * FROM discounts;

-- Insert 40 random records into t_shirts
DELIMITER $$

CREATE PROCEDURE PopulateMoreTShirts()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE max_records INT DEFAULT 40;
    DECLARE brand VARCHAR(20);
    DECLARE color VARCHAR(20);
    DECLARE size VARCHAR(5);
    DECLARE price INT;
    DECLARE stock INT;

    -- Seed the random number generator
    SET SESSION rand_seed1 = UNIX_TIMESTAMP();

    WHILE counter < max_records DO
        -- Generate random values
        SET brand = ELT(FLOOR(1 + RAND() * 4), 'Van Huesen', 'Levi', 'Nike', 'Adidas');
        SET color = ELT(FLOOR(1 + RAND() * 4), 'Red', 'Blue', 'Black', 'White');
        SET size = ELT(FLOOR(1 + RAND() * 5), 'XS', 'S', 'M', 'L', 'XL');
        SET price = FLOOR(10 + RAND() * 41);
        SET stock = FLOOR(10 + RAND() * 91);

        -- Attempt to insert a new record
        -- Duplicate brand, color, size combinations will be ignored due to the unique constraint
        BEGIN
            DECLARE CONTINUE HANDLER FOR 1062 BEGIN END;  -- Handle duplicate key error
            INSERT INTO t_shirts (brand, color, size, price, stock_quantity)
            VALUES (brand, color, size, price, stock);
            SET counter = counter + 1;
        END;
    END WHILE;
END$$

DELIMITER ;

-- Call the stored procedure to populate more records in the t_shirts table
CALL PopulateMoreTShirts();

Select * from t_shirts;
Select * from discounts;
Select Count(*) from t_shirts
where brand = "nike";

Select sum(price*stock_quantity)
from t_shirts
where size ="S";



SELECT SUM(price * (1 - pct_discount)) 
FROM t_shirts JOIN discounts ON t_shirts.t_shirt_id = discounts.t_shirt_id 
WHERE brand = 'Levi' AND CURDATE() BETWEEN discounts.start_date AND discounts.end_date;

Select Count(*)
 from t_shirts
where color= "Red";

	Select *
	from t_shirts
	where brand = "Adidas";
    
Select t_shirt_id
from t_shirts
where color = "White" and brand = "Nike";
Select * from t_shirts;
SELECT SUM(price*stock_quantity) FROM t_shirts WHERE brand = 'Adidas';

SELECT sum(stock_quantity) FROM t_shirts WHERE brand = 'Nike' AND size = 'XS' AND color = 'White';

SELECT sum(a.total_amount * ((100-COALESCE(discounts.pct_discount,0))/100)) as total_revenue from
(select sum(price*stock_quantity) as total_amount, t_shirt_id from t_shirts where brand = 'Levi'
group by t_shirt_id) a left join discounts on a.t_shirt_id = discounts.t_shirt_id;

SELECT SUM(price * stock_quantity) FROM t_shirts WHERE brand = 'Levi';

SELECT sum(stock_quantity) FROM t_shirts WHERE brand = 'Levi' AND color = 'White';

SELECT sum(a.total_amount * ((100-COALESCE(discounts.pct_discount,0))/100)) as total_revenue from
(select sum(price*stock_quantity) as total_amount, t_shirt_id from t_shirts where brand = 'Nike' and size="L"
group by t_shirt_id) a left join discounts on a.t_shirt_id = discounts.t_shirt_id