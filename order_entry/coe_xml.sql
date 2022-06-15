

PROMPT 
PROMPT specify password for OE as parameter 1:
DEFINE pass_oe  = &1
PROMPT
PROMPT PROMPT password for SYS as parameter 2:
DEFINE pass_sys = &2
PROMPT
PROMPT specify connect string as parameter 3:
DEFINE connect_string     = &3
PROMPT


--
-- CONNECT as SYS. Add roles AND privileges to OE.
--
CONNECT sys/&pass_sys@&connect_string AS SYSDBA;

GRANT xdbadmin TO oe;
GRANT create any directory TO oe; 
GRANT drop any directory TO oe;
GRANT alter session TO oe;

-- Create stored objects
   @__SUB__CWD__/order_entry/xdbSupport


-- Create directory object, instantiated by createUser.sql.sbs
 @__SUB__CWD__/order_entry/createUser &pass_oe &pass_sys &connect_string



CONNECT oe/&pass_oe@&connect_string;

--
-- set . and , as decimal point and thousand separator for the session
-- as the unit prices are hard coded, which might cause NLS issues
--
ALTER SESSION SET NLS_NUMERIC_CHARACTERS='.,';

-- Create folders and load
 @__SUB__CWD__/order_entry/xdb03usg


--
-- CONNECT as SYS. Revoke "ANY" privs
--

CONNECT sys/&pass_sys@&connect_string AS SYSDBA;  

REVOKE create any directory FROM oe;
REVOKE drop any directory FROM oe;
REVOKE alter session FROM oe;
   
DROP PACKAGE xdb.coe_configuration;
DROP PACKAGE xdb.coe_namespaces;
DROP PACKAGE xdb.coe_dom_helper;
DROP PACKAGE xdb.coe_utilities;
DROP PACKAGE xdb.coe_tools;
DROP TRIGGER xdb.no_dml_operations_allowed;
DROP VIEW    xdb.database_summary;


CONNECT oe/&&pass_oe@&connect_string;

