/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/
-- create schemas
CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go


CREATE SCHEMA auth;
go

-- create tables

CREATE TABLE auth.user_roles (
	role_id INT IDENTITY (1, 1) PRIMARY KEY,
	role_description VARCHAR (50) NOT NULL
);

CREATE TABLE auth.permisions (
	permission_id INT IDENTITY (1, 1) PRIMARY KEY,
	permission_description VARCHAR (50) NOT NULL
);

CREATE TABLE auth.granted_permissions (
	role_id INT NOT NULL,
	permission_id INT NOT NULL,
	FOREIGN KEY (role_id) REFERENCES auth.user_roles (role_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (permission_id) REFERENCES auth.permisions (permission_id) ON DELETE CASCADE ON UPDATE CASCADE

);
CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	role_id INT NOT NULL,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (role_id) REFERENCES auth.user_roles (role_id) ON  DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE auth.hashing_algorithms (
	hash_algorithm_id INT IDENTITY (1, 1) PRIMARY KEY,
	algorithm_name VARCHAR (20) NOT NULL
);

CREATE TABLE auth.email_validation_status (
	email_validation_status_id INT IDENTITY (1, 1) PRIMARY KEY,
	status_description VARCHAR (20) NOT NULL
);

CREATE TABLE auth.user_login_data(
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	login_name VARCHAR (30) NOT NULL,
	password_hash VARCHAR (250) NOT NULL,
	password_salt VARCHAR (100) NOT NULL,
	hash_algorithm_id INT NOT NULL,
	confirmation_token VARCHAR(100),
	token_generation_time datetime,
	email_validation_status_id INT NOT NULL,
	password_recovery_token VARCHAR(100),
	recovery_token_time datetime,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id),
	FOREIGN KEY (hash_algorithm_id) REFERENCES auth.hashing_algorithms (hash_algorithm_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (email_validation_status_id) REFERENCES auth.email_validation_status (email_validation_status_id) ON  DELETE CASCADE ON UPDATE CASCADE
);