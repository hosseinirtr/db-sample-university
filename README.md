
## 1. Introduction

This repository contains a copy of the Oracle Database sample schemas
that are installed with Oracle Database Enterprise Edition.  These
schemas are used in Oracle documentation to show SQL language
concepts and other database features.  The schemas themselves are 
documented in [Oracle Database Sample Schemas](https://www.oracle.com/pls/topic/lookup?ctx=dblatest&id=COMSC).

The schemas are:

- HR: *Human Resources*
- OE: *Order Entry*
- PM: *Product Media*
- IX: *Information Exchange*
- SH: *Sales History*
- BI: *Business Intelligence*

*I welcome any of your pull requests*


## 2. Installing the Samples

*CAUTION*: The first step in installing sample schemas is to drop 
user accounts with the following names: HR, OE, PM, IX, SH and BI. 
Do not proceed with the installation if you have schemas with any 
of these names that you wish to keep.

The installation scripts are designed to run on an Oracle Database.  
Privileged database access is required during installation.

The instructions below work on Linux and similar operating systems.
Adjust them for other platforms.

### 2.1. Clone this repository

Login as the Oracle Database software owner and clone the repository, for example

```shell
cd $HOME
git clone https://github.com/hosseinirtr/university_project.git
```



The schema directory should be owned by the Oracle Database software owner.

### 2.2. Change directory

```shell
cd $HOME/university_project
```

### 2.3. Change all embedded paths to match your working directory

The installation scripts need your current directory embedded in
various locations.  Use a text editor or the following Perl script to
make the changes, replacing occurrences of the token `__SUB__CWD__`
with your current working directory, for example
`/home/oracle/university_project`

```shell
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat 
```

### 2.4. Set the Oracle environment

Skip this step when running on a client machine (one without an Oracle 
Database installed).

```shell
source /usr/local/bin/oraenv
```

*Note*: Oracle's `sqlldr` utility needs to be in `$PATH` for correct
loading of the Product Media (PM) and Sales History (SH) schemas.

### 2.5.  Run the installation script

Review the [README.txt](#README.txt) for information on passwords and
pre-requirements. In particular, verify your default and temporary
tablespace names, and choose a password for each schema.

Start SQL*Plus and run the top level installation script as
discussed in [README.txt](#README.txt):

```shell
sqlplus system/systempw@connect_string
@mksample systempw syspw hrpw oepw pmpw ixpw shpw bipw users temp /your/path/to/log/ connect_string
```

*Note*: Use an absolute path and also append a trailing slash to the log directory name.

Use your current SYSTEM and SYS passwords, and also your actual
default and temporary tablespace names.  The passwords for the new
HR, OE, PM, IX, SH and BI users will be set to the values you
specify.

*Reminder*: currently the CO schema will not be installed as part of this 
process.

Using a connect string permits connections to non-container databases and 
pluggable database using the same syntax.

An example of connect strings for databases with services noncdb and pdb:
```
  localhost:1521/noncdb
  localhost:1521/pdb
```

### 2.6. Review the installation logs

Review output in your log directory for errors.

## 3. Removing the Samples

*CAUTION*: This will drop user accounts named HR, OE, PM, IX, SH and BI.

### 3.1. Set the Oracle environment

Skip this step when running on a client machine (one without an Oracle 
Database installed).

```shell
source /usr/local/bin/oraenv
```

### 3.2. Run the schema removal script

```shell
sqlplus system/systempw@connect_string
@drop_sch.sql
```

When prompted, enter the SYSTEM password, a log file name, and connect string.

### 3.3 Run the CO schema removal script

If you have installed the CO schema, run the following script to remove it. 

```shell
sqlplus system/systempw@connect_string
@co_drop_user.sql 
```