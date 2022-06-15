

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

PROMPT
PROMPT specify password for SH as parameter 1:
DEFINE sh_pass             = &1
PROMPT
PROMPT specify connect string as parameter 2:
DEFINE connect_string     = &2
PROMPT

CONNECT sh/&sh_pass@&connect_string;

GRANT SELECT ON channels		TO bi;
GRANT SELECT ON countries		TO bi;
GRANT SELECT ON times			TO bi;
GRANT SELECT ON costs			TO bi;
GRANT SELECT ON customers		TO bi;
GRANT SELECT ON products		TO bi;
GRANT SELECT ON promotions		TO bi;
GRANT SELECT ON sales			TO bi;
GRANT SELECT ON times			TO bi;
GRANT SELECT ON cal_month_sales_mv	TO bi;
GRANT SELECT ON sh.fweek_pscat_sales_mv	TO bi;

COMMIT;
