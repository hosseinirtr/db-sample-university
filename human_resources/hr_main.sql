SET ECHO OFF
SET VERIFY OFF

PROMPT 
PROMPT specify password for HR as parameter 1:
DEFINE pass     = &1
PROMPT 
PROMPT specify default tablespeace for HR as parameter 2:
DEFINE tbs      = &2
PROMPT 
PROMPT specify temporary tablespace for HR as parameter 3:
DEFINE ttbs     = &3
PROMPT 
PROMPT specify password for SYS as parameter 4:
DEFINE pass_sys = &4
PROMPT 
PROMPT specify log path as parameter 5:
DEFINE log_path = &5
PROMPT
PROMPT specify connect string as parameter 6:
DEFINE connect_string     = &6
PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

DEFINE spool_file = &log_path.hr_main.log
SPOOL &spool_file

REM =======================================================
REM cleanup section
REM =======================================================

DROP USER hr CASCADE;

REM =======================================================
REM create user
REM three separate commands, so the create user command 
REM will succeed regardless of the existence of the 
REM DEMO and TEMP tablespaces 
REM =======================================================

CREATE USER hr IDENTIFIED BY &pass;

ALTER USER hr DEFAULT TABLESPACE &tbs
              QUOTA UNLIMITED ON &tbs;

ALTER USER hr TEMPORARY TABLESPACE &ttbs;

GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO hr;
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE , UNLIMITED TABLESPACE TO hr;

REM =======================================================
REM grants from sys schema
REM =======================================================

CONNECT sys/&pass_sys@&connect_string AS SYSDBA;
GRANT execute ON sys.dbms_stats TO hr;

REM =======================================================
REM create hr schema objects
REM =======================================================

CONNECT hr/&pass@&connect_string
ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;

--
-- create tables, sequences and constraint
--

@__SUB__CWD__/human_resources/hr_cre

-- 
-- populate tables
--

@__SUB__CWD__/human_resources/hr_popul

--
-- create indexes
--

@__SUB__CWD__/human_resources/hr_idx

--
-- create procedural objects
--

@__SUB__CWD__/human_resources/hr_code

--
-- add comments to tables and columns
--

@__SUB__CWD__/human_resources/hr_comnt

--
-- gather schema statistics
--

@__SUB__CWD__/human_resources/hr_analz

spool off
