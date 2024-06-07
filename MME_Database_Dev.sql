DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS store CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS cust_trans CASCADE;
DROP TABLE IF EXISTS delivery_schedule CASCADE;
DROP TABLE IF EXISTS warehouse_item CASCADE;
DROP TABLE IF EXISTS customer_order CASCADE;
DROP TABLE IF EXISTS purchase_history CASCADE;


CREATE TABLE customer (
    customer_id SMALLINT NOT NULL PRIMARY KEY,
    customer_first_name VARCHAR(25) NOT NULL,
    customer_last_name VARCHAR(30) NOT NULL,
    house_no VARCHAR(10),
    street_name VARCHAR(30),
    city VARCHAR(30),
    post_code VARCHAR(8),
    customer_telno VARCHAR(12),
    date_of_birth DATE NOT NULL,
    bank_name VARCHAR(30),
    bank_address VARCHAR(100),
    sort_code VARCHAR(6),
    account_number VARCHAR(11)
);

CREATE TABLE store (
    store_id SMALLINT NOT NULL PRIMARY KEY,
    store_location VARCHAR(50)
);

CREATE TABLE product (
    prod_id SMALLINT NOT NULL PRIMARY KEY,
    prod_type VARCHAR(50) NOT NULL,
    prod_name VARCHAR(50) NOT NULL,
    prod_description TEXT,
    prod_cost NUMERIC(10, 2) NOT NULL
);

CREATE TABLE cust_trans (
    transaction_id SMALLINT NOT NULL PRIMARY KEY,
    customer_id SMALLINT NOT NULL REFERENCES customer(customer_id),
    store_id SMALLINT NOT NULL REFERENCES store(store_id),
    transaction_date DATE NOT NULL
);

CREATE TABLE delivery_schedule (
    delivery_id SMALLINT PRIMARY KEY,
    transaction_id SMALLINT NOT NULL REFERENCES cust_trans(transaction_id),
    customer_id SMALLINT NOT NULL REFERENCES customer(customer_id),
    delivery_date DATE NOT NULL,
    delivery_time TIME NOT NULL 
);


CREATE TABLE warehouse_item (
    warehouse_item_id SMALLINT NOT NULL PRIMARY KEY,
    prod_id SMALLINT NOT NULL REFERENCES product(prod_id),
    store_id SMALLINT NOT NULL REFERENCES store(store_id),
    item_location VARCHAR(10) NOT NULL,
    stock_level SMALLINT NOT NULL CHECK (stock_level >=0)
);


CREATE TABLE customer_order (
    order_id SMALLINT NOT NULL PRIMARY KEY,
    customer_id SMALLINT NOT NULL REFERENCES customer(customer_id),
    order_date DATE NOT NULL,
    prod_id SMALLINT NOT NULL REFERENCES product(prod_id),
    order_quantity SMALLINT NOT NULL CHECK (order_quantity > 0),
    delivery_id SMALLINT REFERENCES delivery_schedule(delivery_id)
);


CREATE TABLE purchase_history (
    purchase_id SMALLINT NOT NULL PRIMARY KEY,
    prod_id SMALLINT NOT NULL REFERENCES product(prod_id),
    store_id SMALLINT NOT NULL REFERENCES store(store_id),
    customer_id SMALLINT NOT NULL REFERENCES customer(customer_id),
    purchase_date DATE NOT NULL,
    quantity_purchased SMALLINT NOT NULL CHECK (quantity_purchased >= 0)
);



INSERT INTO customer (customer_id, customer_first_name, customer_last_name, house_no, street_name, city, post_code, customer_telno, date_of_birth, bank_name, bank_address, sort_code, account_number)
VALUES
    (1,'John', 'David', '123', 'Main Street', 'Cityville', 'CV1 2AB', '011234567890', to_date ('15-01-1990', 'DD-MM-YYYY'), 'Bank of York', '123 Bank Rd, Cityville', '123456', '12344567890'),
    (2, 'Jane', 'Smith', '456', 'Broadway', 'Townsville', 'TS2 3CD', '098761543210', to_date('02-05-1985', 'DD-MM-YYYY'), 'The First Bank', '789 Money St, Townsville', '789012', '98756543210'),
    (3, 'Mat', 'Moses', '56', 'South Street', 'Kent', 'KE1 5NT', '009878612214', to_date('21-11-2000', 'DD-MM-YYYY'), 'Union Bank', '89 Money Lane, Kent', '097823', '01901276384'),
    (4, 'Will', 'Smith', '6', 'Westwood Street', 'Barnet', 'BA5 9ET', '078623141784', to_date('13-10-2002', 'DD-MM-YYYY'), 'Bank of York', '1 Money Lane, Kent', '097823', '01892536122'),
    (5, 'Sarah', 'Word', '10', 'Riverside Avenue', 'Townsville', 'TS2 4AD', '019942540975', to_date('01-01-2006', 'DD-MM-YYYY'), 'The First Bank', '789 Money St, Townsville', '789012', '98112087744');

INSERT INTO store (store_id, store_location)
VALUES
    (1, 'Cityville Store'),
    (2, 'Townsville Store'),
    (3, 'Money Lane Store'),
    (4, 'Kent Store')
;

INSERT INTO product (prod_id, prod_type, prod_name, prod_description, prod_cost)
VALUES
    (1, 'Musical Instrument', 'Guitar', 'Acoustic guitar with a rosewood finish', 599.99),
    (2, 'Printed Music', 'Songbook', 'Collection of classic rock songs', 29.99),
    (3, 'Musical Instrument', 'Piano', 'Grand piano with a polished ebony finish', 2499.99),
    (4, 'Printed Music', 'Sheet Music', 'Collection of classical sheet music for piano', 19.99),
    (5, 'Musical Instrument', 'Violin', 'Professional-grade violin with a spruce top', 799.99),
    (6, 'Printed Music', 'Guitar Chords Book', 'Comprehensive guide to guitar chords and progressions', 12.99),
    (7, 'Musical Instrument', 'Drums Set', 'Complete drum kit with cymbals and hardware', 999.99),
    (8, 'CD', 'Classical Music Collection', '3-disc set of classical symphonies and concertos', 24.99),
    (9, 'DVD', 'Live Concert', 'Live musical concert with various musical acts', 14.99),
    (10, 'CD', 'Jazz Favorites', 'Compilation of smooth jazz tracks by various artists', 19.99)
;


    INSERT INTO cust_trans (transaction_id, customer_id, store_id, transaction_date)
VALUES
   (1, 1, 1, to_date('02-08-2023', 'DD-MM-YYYY')),
    (2, 2, 1, to_date('11-08-2023', 'DD-MM-YYYY')),
    (3, 3, 4, to_date('05-09-2023', 'DD-MM-YYYY')),
    (4, 2, 3, to_date('15-09-2023', 'DD-MM-YYYY')),
    (5, 5, 2, to_date('23-10-2023', 'DD-MM-YYYY')),
    (6, 5, 1, to_date('25-10-2023', 'DD-MM-YYYY'))
;

INSERT INTO delivery_schedule (delivery_ID, transaction_id, customer_id, delivery_date, delivery_time)
VALUES
    (1, 1, 1, to_date('09-08-2023', 'DD-MM-YYYY'), '14:30'),
    (2, 2, 2, to_date('18-08-2023', 'DD-MM-YYYY'), '12:00'),
    (3, 3, 3, to_date('12-09-2023', 'DD-MM-YYYY'), '15:00'),
    (4, 4, 2, to_date('22-09-2023', 'DD-MM-YYYY'), '12:00'),
    (5, 5, 5, to_date('24-10-2023', 'DD-MM-YYYY'), '15:30'),
    (6, 6, 5, to_date('28-10-2023', 'DD-MM-YYYY'), '13:30')

;

INSERT INTO warehouse_item (warehouse_item_id, prod_id, store_id, item_location, stock_level)
VALUES
    (1, 1, 1, 'Area 1', 15),
    (2, 2, 3, 'Area 2', 7),
    (3, 1, 2, 'Area 3', 8),
    (4, 2, 3, 'Area 4', 10),
    (5, 10, 4, 'Area 5', 4),
    (6, 9, 3, 'Area 6', 2),
    (7, 5, 2, 'Area 2', 3),
    (8, 3, 4, 'Area 4', 12)
;


INSERT INTO customer_order (order_id, customer_id, order_date, prod_id, order_quantity, delivery_id)
VALUES
  	(1, 1, to_date('02-08-2023', 'DD-MM-YYYY'), 1, 2, 1),
    (2, 2, to_date('11-08-2023', 'DD-MM-YYYY'), 2, 3, 2),
    (3, 3, to_date('05-09-2023', 'DD-MM-YYYY'), 1, 2, 3),
    (4, 2, to_date('15-09-2023', 'DD-MM-YYYY'), 5, 1, 4),
    (5, 5, to_date('23-10-2023', 'DD-MM-YYYY'), 6, 2, 5),
    (6, 5, to_date('25-10-2023', 'DD-MM-YYYY'), 2, 1, 6)
;



INSERT INTO purchase_history (purchase_id, prod_id, store_id, customer_id, purchase_date, quantity_purchased)
VALUES
    (1, 1, 1, 1, to_date('02-10-2023', 'DD-MM-YYYY'), 3),
    (2, 3, 2, 2, to_date('05-10-2023', 'DD-MM-YYYY'), 2),
    (3, 5, 1, 1, to_date('08-10-2023', 'DD-MM-YYYY'), 5),
    (4, 2, 3, 4, to_date('12-10-2023', 'DD-MM-YYYY'), 4),
    (5, 1, 4, 5, to_date('15-10-2023', 'DD-MM-YYYY'), 1)
;


--STORED PROCEDURE FOR REGISTER NEW CUSTOMER
CREATE OR REPLACE PROCEDURE register_customer(
    first_name VARCHAR(25),
    last_name VARCHAR(30),
    house_no VARCHAR(10),
    street_name VARCHAR(30),
    city VARCHAR(30),
    post_code VARCHAR(8),
    customer_telno VARCHAR(12),
    dob DATE,
    bank_name VARCHAR(30),
    bank_address VARCHAR(100),
    sort_code VARCHAR(6),
    account_number VARCHAR(11)
) 
LANGUAGE 'plpgsql' AS 
$BODY$

 
DECLARE new_customer_id SMALLINT;


BEGIN

SELECT COALESCE(MAX(customer_id), 0) + 1 INTO new_customer_id FROM customer;

    -- Check if the date_of_birth is valid (not in the future)
    IF dob > CURRENT_DATE THEN
        RAISE EXCEPTION 'Invalid date_of_birth: Date cannot be in the future';
    END IF;

    -- Check if a customer with the same first name, last name, and date of birth already exists.
    IF EXISTS (
        SELECT 1
        FROM customer
        WHERE customer_first_name = first_name
        AND customer_last_name = last_name
        AND date_of_birth = dob
    ) THEN
        RAISE EXCEPTION 'Customer with the same first name, last name, and date of birth already exists.';
    END IF;

   
    -- Insert the new customer record into the customer table.
    INSERT INTO customer (customer_id, customer_first_name, customer_last_name, house_no, street_name, city, post_code, customer_telno, date_of_birth, bank_name, bank_address, sort_code, account_number)
    VALUES (new_customer_id, first_name, last_name, house_no, street_name, city, post_code, customer_telno, dob, bank_name, bank_address, sort_code, account_number);
END;
$BODY$ 

--Call to register new customer
CALL register_customer('Joe', 'Mann', '78', 'Maple Street', 'Cityville', 'CV8 3AB', '011234567890', to_date('15-01-1990', 'DD-MM-YYYY'), 'Bank of York', '123 Bank Rd, Cityville', '536201', '67128963401');




--STORED PROCEDURE TO PURCHASE PRODUCT 
CREATE OR REPLACE PROCEDURE purchase_product(
    IN customer_id SMALLINT,
    IN prod_name VARCHAR(50),
    IN delivery_date DATE,
    IN delivery_time TIME
) 
LANGUAGE 'plpgsql' AS 
$BODY$
DECLARE
    product_id SMALLINT;
    stock_level SMALLINT;
BEGIN
    -- Find the product_id based on prod_name
    SELECT prod_id INTO product_id
    FROM product
    WHERE prod_name = prod_name;

    -- Check if the customer exists
    IF NOT EXISTS (SELECT 1 FROM customer WHERE customer_id = customer_id) THEN
        RAISE EXCEPTION 'Customer with ID % does not exist', customer_id;
        RETURN;
    END IF;

    -- Check if the product exists
    IF product_id IS NULL THEN
        RAISE EXCEPTION 'Product with name % does not exist', prod_name;
        RETURN;
    END IF;

    -- Check product availability in the warehouse
    SELECT stock_level INTO stock_level
    FROM warehouse_item
    WHERE prod_id = product_id;

    IF stock_level <= 0 THEN
        RAISE EXCEPTION 'Product is out of stock';
        RETURN;
    END IF;

    -- Check if the delivery slot is available
    IF EXISTS (
        SELECT 1
        FROM delivery_schedule
        WHERE delivery_date = delivery_date
        AND delivery_time = delivery_time
    ) THEN
        RAISE EXCEPTION 'Delivery slot on % at % is already booked', delivery_date, delivery_time;
        RETURN;
    END IF;

    -- Insert purchase record into customer_order
    INSERT INTO customer_order (customer_id, prod_id, order_date, order_quantity, delivery_id)
    VALUES (customer_id, product_id, current_date, 1, NULL);

    -- Update stock level in warehouse item 
    UPDATE warehouse_item
    SET stock_level = stock_level - 1
    WHERE prod_id = product_id;

    -- Insert delivery record into delivery_schedule
    INSERT INTO delivery_schedule (transaction_id, customer_id, delivery_date, delivery_time)
    VALUES (NULL, customer_id, delivery_date, delivery_time);

    -- Commit transaction
    COMMIT;
    
    -- Return success message
    RAISE NOTICE 'Purchase successful';
    
EXCEPTION
    WHEN OTHERS THEN
        -- Rollback transaction
        ROLLBACK;
        -- Raise error message
        RAISE EXCEPTION 'Purchase failed';
END;
$BODY$;

--Call to purchase product procedure
CALL purchase_product(1, 'Guitar', to_date('2023-11-15', 'DD-MM-YYYY'), to_time('12:00:00', 'HH:MI:SS'));

