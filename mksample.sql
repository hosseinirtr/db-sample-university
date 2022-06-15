SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 999
SET ECHO OFF
SET CONCAT '.'
SET SHOWMODE OFF

PROMPT 
PROMPT specify password for SYSTEM as parameter 1:
DEFINE password_system     = &1
PROMPT 
PROMPT specify password for SYS as parameter 2:
DEFINE password_sys        = &2
PROMPT 
PROMPT specify password for HR as parameter 3:
DEFINE password_hr         = &3
PROMPT
PROMPT specify password for OE as parameter 4:
DEFINE password_oe         = &4
PROMPT
PROMPT specify password for PM as parameter 5:
DEFINE password_pm         = &5
PROMPT
PROMPT specify password for IX as parameter 6:
DEFINE password_ix         = &6
PROMPT
PROMPT specify password for  SH as parameter 7:
DEFINE password_sh         = &7
PROMPT 
PROMPT specify password for  BI as parameter 8:
DEFINE password_bi         = &8
PROMPT 
PROMPT specify default tablespace as parameter 9:
DEFINE default_ts          = &9
PROMPT
PROMPT specify temporary tablespace as parameter 10:
DEFINE temp_ts             = &10
PROMPT 
PROMPT specify log file directory (including trailing delimiter) as parameter 11:
DEFINE logfile_dir         = &11
PROMPT 
PROMPT specify connect string as parameter 12:
DEFINE connect_string     = &12
PROMPT
PROMPT Sample Schemas are being created ...
PROMPT
DEFINE vrs = v3

host mkdir &&logfile_dir

CONNECT system/&&password_system@&&connect_string

DROP USER hr CASCADE;
DROP USER oe CASCADE;
DROP USER pm CASCADE;
DROP USER ix CASCADE;
DROP USER sh CASCADE;
DROP USER bi CASCADE;

CONNECT system/&&password_system@&&connect_string

SET SHOWMODE OFF

@__SUB__CWD__/human_resources/hr_main.sql &&password_hr &&default_ts &&temp_ts &&password_sys &&logfile_dir &&connect_string

CONNECT system/&&password_system@&&connect_string
SET SHOWMODE OFF

@__SUB__CWD__/order_entry/oe_main.sql &&password_oe &&default_ts &&temp_ts &&password_hr &&password_sys __SUB__CWD__/order_entry/ &&logfile_dir &vrs &&connect_string

CONNECT system/&&password_system@&&connect_string

SET SHOWMODE OFF

@__SUB__CWD__/product_media/pm_main.sql &&password_pm &&default_ts &&temp_ts &&password_oe &&password_sys __SUB__CWD__/product_media/ &&logfile_dir __SUB__CWD__/product_media/ &&connect_string

CONNECT system/&&password_system@&&connect_string
SET SHOWMODE OFF

@__SUB__CWD__/info_exchange/ix_main.sql &&password_ix &&default_ts &&temp_ts &&password_sys &&logfile_dir &vrs &&connect_string

CONNECT system/&&password_system@&&connect_string
SET SHOWMODE OFF

@__SUB__CWD__/sales_history/sh_main &&password_sh &&default_ts &&temp_ts &&password_sys __SUB__CWD__/sales_history/ &&logfile_dir &vrs &&connect_string

CONNECT system/&&password_system@&&connect_string
SET SHOWMODE OFF

@__SUB__CWD__/bus_intelligence/bi_main &&password_bi &&default_ts &&temp_ts &&password_sys &&password_oe &&password_sh &&logfile_dir &vrs &&connect_string

CONNECT system/&&password_system@&&connect_string

SPOOL OFF

DEFINE veri_spool = &&logfile_dir.mkverify_&vrs..log

@__SUB__CWD__/mkverify &&password_system &veri_spool &&connect_string

