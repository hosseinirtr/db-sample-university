SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

PROMPT
PROMPT specify password for BI as parameter 1:
DEFINE bi_pass             = &1
PROMPT
PROMPT specify connect string as parameter 2:
DEFINE connect_string     = &2
PROMPT

CONNECT bi/&bi_pass@&connect_string;

CREATE SYNONYM channels		FOR sh.channels;
CREATE SYNONYM countries	FOR sh.countries;
CREATE SYNONYM times		FOR sh.times;
CREATE SYNONYM costs		FOR sh.costs;
CREATE SYNONYM customers	FOR sh.customers;
CREATE SYNONYM products		FOR sh.products;
CREATE SYNONYM promotions	FOR sh.promotions;
CREATE SYNONYM sales		FOR sh.sales;

COMMIT;
