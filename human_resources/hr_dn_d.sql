SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO ON

ALTER TABLE departments
 DROP COLUMN dn ;

ALTER TABLE employees
 DROP COLUMN dn ; 
