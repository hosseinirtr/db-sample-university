

DROP TABLE        customers             CASCADE CONSTRAINTS;
DROP TABLE        inventories           CASCADE CONSTRAINTS;
DROP TABLE        order_items           CASCADE CONSTRAINTS;
DROP TABLE        orders                CASCADE CONSTRAINTS;
DROP TABLE        product_descriptions  CASCADE CONSTRAINTS;
DROP TABLE        product_information   CASCADE CONSTRAINTS;
DROP TABLE        warehouses            CASCADE CONSTRAINTS;

DROP TYPE         cust_address_typ;
DROP TYPE         phone_list_typ;

DROP SEQUENCE     orders_seq;

DROP SYNONYM      countries;
DROP SYNONYM      departments;
DROP SYNONYM      employees;
DROP SYNONYM      job_history;
DROP SYNONYM      jobs;
DROP SYNONYM      locations;

DROP VIEW         bombay_inventory;
DROP VIEW         product_prices;
DROP VIEW         products;
DROP VIEW         sydney_inventory;
DROP VIEW         toronto_inventory;

COMMIT;


