/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/

-- drop tables
DROP TABLE IF EXISTS auth.permisions;
DROP TABLE IF EXISTS auth.granted_permissions;
DROP TABLE IF EXISTS auth.user_roles;
DROP TABLE IF EXISTS sales.order_items;
DROP TABLE IF EXISTS sales.orders;
DROP TABLE IF EXISTS production.stocks;
DROP TABLE IF EXISTS production.products;
DROP TABLE IF EXISTS production.categories;
DROP TABLE IF EXISTS production.brands;
DROP TABLE IF EXISTS sales.customers;
DROP TABLE IF EXISTS sales.staffs;
DROP TABLE IF EXISTS sales.stores;
DROP TABLE IF EXISTS auth.hashing_algorithms;
DROP TABLE IF EXISTS auth.email_validation_status;
DROP TABLE IF EXISTS auth.user_login_data;





-- drop the schemas

DROP SCHEMA IF EXISTS sales;
DROP SCHEMA IF EXISTS production;
DROP SCHEMA IF EXISTS auth;

