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
PROMPT specify password for SYS as parameter 1:
DEFINE password_sys        = &1
PROMPT 
PROMPT specify OUTPUT export file name, excluding path, as parameter 2:
DEFINE exp_file            = &2
PROMPT
PROMPT specify OUTPUT tablespace backup file name, excluding path, as parameter 3:
DEFINE backup_file         = &3
PROMPT 
PROMPT specify LOG directory, open for write, as parameter 4:
DEFINE log_path            = &4
PROMPT 
PROMPT specify DUMP directory as parameter 5:
DEFINE dump_path            = &5
PROMPT 
DEFINE vrs = v3

SPOOL &log_path.mkunplug_&vrs._@.log 

CONNECT sys/&&password_sys AS SYSDBA;

--
-- Check for violations of TTS prerequisites
--

EXECUTE dbms_tts.transport_set_check('EXAMPLE',TRUE);

SELECT * FROM TRANSPORT_SET_VIOLATIONS;

-- create the 'SS_IMPEXP_DIR' directory object for the dump files
create or replace directory SS_IMPEXP_DIR as '&dump_path';
grant read,write on directory SS_IMPEXP_DIR to public;
create or replace directory SS_LOGPATH_DIR as '&log_path';
grant read,write on directory SS_LOGPATH_DIR to public;

--
-- Begin unplugging
--

ALTER TABLESPACE example READ ONLY;

-- export the meta data for the tablespace
host expdp "'sys/&&password_sys AS SYSDBA'" dumpfile=&exp_file logfile=SS_LOGPATH_DIR:tts_example_exp.log transport_tablespaces=EXAMPLE directory=SS_IMPEXP_DIR silent=banner

SET PAGESIZE 0

SELECT 'Backing up tablespace file '||file_name
 FROM  dba_data_files
 WHERE tablespace_name='EXAMPLE';

set serveroutput on;

SELECT TO_CHAR(systimestamp, 'YYYYMMDD HH:MI:SS')  FROM dual;

-- back up the data in the tablespace
variable devicename varchar2(255);
variable set_stamp number;
variable devicename varchar2(255);
variable set_stamp number;
variable set_count number;
variable data_file_id number;

declare
    done boolean;
    concur boolean;
    pieceno binary_integer;
    handle varchar2(255);
    comment varchar2(255);
    media varchar2(255);
    params varchar2(255);
    archlog_failover boolean;
    recid number;
    stamp number;
    tag varchar2(32);
    
    
begin
    dbms_output.put_line(' ');
    dbms_output.put_line(' BACKUP: Allocating device... ');
      :devicename := dbms_backup_restore.deviceAllocate;
    dbms_output.put_line(' BACKUP: Specifing datafiles... ');
    dbms_backup_restore.backupSetDataFile(:set_stamp, :set_count);
    SELECT file_id INTO :data_file_id FROM dba_data_files WHERE tablespace_name='EXAMPLE';
    dbms_backup_restore.backupDataFile(:data_file_id);
    dbms_output.put_line(' BACKUP: Create piece ');
    dbms_backup_restore.backupPieceCreate('&dump_path'||'&backup_file',pieceno,done,handle,comment,media,concur,params,reuse=>true,archlog_failover=>archlog_failover,deffmt=>0,recid=>recid,stamp=>stamp,tag=>tag,docompress=>true);
    IF done then
        dbms_output.put_line(' BACKUP: Unplugged example tablespace backed up.');
    else
        dbms_output.put_line(' BACKUP: Backup of example tablespace failed');
    end if;
  end;
/

SELECT TO_CHAR(systimestamp, 'YYYYMMDD HH:MI:SS')  FROM dual;

-- clean up the directory object now that we're done with it.
drop directory SS_IMPEXP_DIR;
drop directory SS_LOGPATH_DIR;

PROMPT
PROMPT Ready to transport export file &exp_file
PROMPT Ready to transport tablespace backup file &backup_file
PROMPT
PROMPT Please copy both, the tablespace backup and export file, to the target database location 

EXIT

