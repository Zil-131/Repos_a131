-- This script is intended for students or Oracle developers.
-- It will allow you to set up the Tiger Scott schema and test data required for study.
CREATE TABLE JOBS
(
  JOB_ID      VARCHAR2(10 BYTE),
  JOB_TITLE   VARCHAR2(35 BYTE) CONSTRAINT JOB_TITLE_NN NOT NULL,
  MIN_SALARY  NUMBER(6),
  MAX_SALARY  NUMBER(6)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
NOMONITORING;

COMMENT ON TABLE JOBS IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

COMMENT ON COLUMN JOBS.JOB_ID IS 'Primary key of jobs table.';

COMMENT ON COLUMN JOBS.JOB_TITLE IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';

COMMENT ON COLUMN JOBS.MIN_SALARY IS 'Minimum salary for a job title.';

COMMENT ON COLUMN JOBS.MAX_SALARY IS 'Maximum salary for a job title';


CREATE TABLE JOB_GRADES
(
  GRADE_LEVEL  VARCHAR2(3 BYTE),
  LOWEST_SAL   NUMBER,
  HIGHEST_SAL  NUMBER
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE TABLE REGIONS
(
  REGION_ID    NUMBER CONSTRAINT REGION_ID_NN   NOT NULL,
  REGION_NAME  VARCHAR2(25 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
NOMONITORING;


CREATE UNIQUE INDEX JOB_ID_PK ON JOBS
(JOB_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX REG_ID_PK ON REGIONS
(REGION_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE TABLE COUNTRIES
(
  COUNTRY_ID    CHAR(2 BYTE) CONSTRAINT COUNTRY_ID_NN NOT NULL,
  COUNTRY_NAME  VARCHAR2(40 BYTE),
  REGION_ID     NUMBER,
  CONSTRAINT COUNTRY_C_ID_PK
 PRIMARY KEY
 (COUNTRY_ID)
)
ORGANIZATION INDEX
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL
NOMONITORING;

COMMENT ON TABLE COUNTRIES IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON COLUMN COUNTRIES.COUNTRY_ID IS 'Primary key of countries table.';

COMMENT ON COLUMN COUNTRIES.COUNTRY_NAME IS 'Country name';

COMMENT ON COLUMN COUNTRIES.REGION_ID IS 'Region ID for the country. Foreign key to region_id column in the departments table.';


CREATE TABLE LOCATIONS
(
  LOCATION_ID     NUMBER(4),
  STREET_ADDRESS  VARCHAR2(40 BYTE),
  POSTAL_CODE     VARCHAR2(12 BYTE),
  CITY            VARCHAR2(30 BYTE) CONSTRAINT LOC_CITY_NN NOT NULL,
  STATE_PROVINCE  VARCHAR2(25 BYTE),
  COUNTRY_ID      CHAR(2 BYTE)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
NOMONITORING;

COMMENT ON TABLE LOCATIONS IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

COMMENT ON COLUMN LOCATIONS.LOCATION_ID IS 'Primary key of locations table';

COMMENT ON COLUMN LOCATIONS.STREET_ADDRESS IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';

COMMENT ON COLUMN LOCATIONS.POSTAL_CODE IS 'Postal code of the location of an office, warehouse, or production site
of a company. ';

COMMENT ON COLUMN LOCATIONS.CITY IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';

COMMENT ON COLUMN LOCATIONS.STATE_PROVINCE IS 'State or Province where an office, warehouse, or production site of a
company is located.';

COMMENT ON COLUMN LOCATIONS.COUNTRY_ID IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';




CREATE UNIQUE INDEX LOC_ID_PK ON LOCATIONS
(LOCATION_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX LOC_CITY_IX ON LOCATIONS
(CITY)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX LOC_STATE_PROVINCE_IX ON LOCATIONS
(STATE_PROVINCE)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX LOC_COUNTRY_IX ON LOCATIONS
(COUNTRY_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE TABLE DEPARTMENTS
(
  DEPARTMENT_ID    NUMBER(4),
  DEPARTMENT_NAME  VARCHAR2(30 BYTE) CONSTRAINT DEPT_NAME_NN NOT NULL,
  MANAGER_ID       NUMBER(6),
  LOCATION_ID      NUMBER(4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
NOMONITORING;

COMMENT ON TABLE DEPARTMENTS IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';

COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_ID IS 'Primary key column of departments table.';

COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_NAME IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';

COMMENT ON COLUMN DEPARTMENTS.MANAGER_ID IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';

COMMENT ON COLUMN DEPARTMENTS.LOCATION_ID IS 'Location id where a department is located. Foreign key to location_id column of locations table.';


/* This object may not be sorted properly in the script due to cirular references */
CREATE TABLE EMPLOYEES
(
  EMPLOYEE_ID     NUMBER(6),
  FIRST_NAME      VARCHAR2(20 BYTE),
  LAST_NAME       VARCHAR2(25 BYTE) CONSTRAINT EMP_LAST_NAME_NN NOT NULL,
  EMAIL           VARCHAR2(25 BYTE) CONSTRAINT EMP_EMAIL_NN NOT NULL,
  PHONE_NUMBER    VARCHAR2(20 BYTE),
  HIRE_DATE       DATE CONSTRAINT EMP_HIRE_DATE_NN NOT NULL,
  JOB_ID          VARCHAR2(10 BYTE) CONSTRAINT EMP_JOB_NN NOT NULL,
  SALARY          NUMBER(8,2),
  COMMISSION_PCT  NUMBER(2,2),
  MANAGER_ID      NUMBER(6),
  DEPARTMENT_ID   NUMBER(4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
NOMONITORING;

COMMENT ON TABLE EMPLOYEES IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN EMPLOYEES.EMPLOYEE_ID IS 'Primary key of employees table.';

COMMENT ON COLUMN EMPLOYEES.FIRST_NAME IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN EMPLOYEES.LAST_NAME IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN EMPLOYEES.EMAIL IS 'Email id of the employee';

COMMENT ON COLUMN EMPLOYEES.PHONE_NUMBER IS 'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN EMPLOYEES.HIRE_DATE IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN EMPLOYEES.JOB_ID IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';

COMMENT ON COLUMN EMPLOYEES.SALARY IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN EMPLOYEES.COMMISSION_PCT IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';

COMMENT ON COLUMN EMPLOYEES.MANAGER_ID IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN EMPLOYEES.DEPARTMENT_ID IS 'Department id where employee works; foreign key to department_id
column of the departments table';


/* This object may not be sorted properly in the script due to cirular references */
CREATE TABLE JOB_HISTORY
(
  EMPLOYEE_ID    NUMBER(6) CONSTRAINT JHIST_EMPLOYEE_NN NOT NULL,
  START_DATE     DATE CONSTRAINT JHIST_START_DATE_NN NOT NULL,
  END_DATE       DATE CONSTRAINT JHIST_END_DATE_NN NOT NULL,
  JOB_ID         VARCHAR2(10 BYTE) CONSTRAINT JHIST_JOB_NN NOT NULL,
  DEPARTMENT_ID  NUMBER(4)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
NOMONITORING;

COMMENT ON TABLE JOB_HISTORY IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

COMMENT ON COLUMN JOB_HISTORY.EMPLOYEE_ID IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';

COMMENT ON COLUMN JOB_HISTORY.START_DATE IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';

COMMENT ON COLUMN JOB_HISTORY.END_DATE IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';

COMMENT ON COLUMN JOB_HISTORY.JOB_ID IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';

COMMENT ON COLUMN JOB_HISTORY.DEPARTMENT_ID IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';


/* This object may not be sorted properly in the script due to cirular references */
CREATE UNIQUE INDEX DEPT_ID_PK ON DEPARTMENTS
(DEPARTMENT_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX DEPT_LOCATION_IX ON DEPARTMENTS
(LOCATION_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE UNIQUE INDEX EMP_EMAIL_UK ON EMPLOYEES
(EMAIL)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE UNIQUE INDEX EMP_EMP_ID_PK ON EMPLOYEES
(EMPLOYEE_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX EMP_DEPARTMENT_IX ON EMPLOYEES
(DEPARTMENT_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX EMP_JOB_IX ON EMPLOYEES
(JOB_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX EMP_MANAGER_IX ON EMPLOYEES
(MANAGER_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX EMP_NAME_IX ON EMPLOYEES
(LAST_NAME, FIRST_NAME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE UNIQUE INDEX JHIST_EMP_ID_ST_DATE_PK ON JOB_HISTORY
(EMPLOYEE_ID, START_DATE)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX JHIST_JOB_IX ON JOB_HISTORY
(JOB_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX JHIST_EMPLOYEE_IX ON JOB_HISTORY
(EMPLOYEE_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


/* This object may not be sorted properly in the script due to cirular references */
CREATE INDEX JHIST_DEPARTMENT_IX ON JOB_HISTORY
(DEPARTMENT_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       2147483645
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


ALTER TABLE JOBS ADD (
  CONSTRAINT JOB_ID_PK
 PRIMARY KEY
 (JOB_ID)
    USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
               ));


ALTER TABLE REGIONS ADD (
  CONSTRAINT REG_ID_PK
 PRIMARY KEY
 (REGION_ID)
    USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
               ));


ALTER TABLE LOCATIONS ADD (
  CONSTRAINT LOC_ID_PK
 PRIMARY KEY
 (LOCATION_ID)
    USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
               ));


ALTER TABLE DEPARTMENTS ADD (
  CONSTRAINT DEPT_ID_PK
 PRIMARY KEY
 (DEPARTMENT_ID)
    USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
               ));


ALTER TABLE EMPLOYEES ADD (
  CONSTRAINT EMP_SALARY_MIN
 CHECK (salary > 0));

ALTER TABLE EMPLOYEES ADD (
  CONSTRAINT EMP_EMP_ID_PK
 PRIMARY KEY
 (EMPLOYEE_ID)
    USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
               ));

ALTER TABLE EMPLOYEES ADD (
  CONSTRAINT EMP_EMAIL_UK
 UNIQUE (EMAIL)
    USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
               ));


ALTER TABLE JOB_HISTORY ADD (
  CONSTRAINT JHIST_DATE_INTERVAL
 CHECK (end_date > start_date));

ALTER TABLE JOB_HISTORY ADD (
  CONSTRAINT JHIST_EMP_ID_ST_DATE_PK
 PRIMARY KEY
 (EMPLOYEE_ID, START_DATE)
    USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       2147483645
                PCTINCREASE      0
               ));


ALTER TABLE COUNTRIES ADD (
  CONSTRAINT COUNTR_REG_FK
 FOREIGN KEY (REGION_ID)
 REFERENCES REGIONS (REGION_ID));


ALTER TABLE LOCATIONS ADD (
  CONSTRAINT LOC_C_ID_FK
 FOREIGN KEY (COUNTRY_ID)
 REFERENCES COUNTRIES (COUNTRY_ID));


ALTER TABLE DEPARTMENTS ADD (
  CONSTRAINT DEPT_LOC_FK
 FOREIGN KEY (LOCATION_ID)
 REFERENCES LOCATIONS (LOCATION_ID));

ALTER TABLE EMPLOYEES ADD (
  CONSTRAINT EMP_DEPT_FK
 FOREIGN KEY (DEPARTMENT_ID)
 REFERENCES DEPARTMENTS (DEPARTMENT_ID));

ALTER TABLE EMPLOYEES ADD (
  CONSTRAINT EMP_JOB_FK
 FOREIGN KEY (JOB_ID)
 REFERENCES JOBS (JOB_ID));

ALTER TABLE EMPLOYEES ADD (
  CONSTRAINT EMP_MANAGER_FK
 FOREIGN KEY (MANAGER_ID)
 REFERENCES EMPLOYEES (EMPLOYEE_ID));


ALTER TABLE JOB_HISTORY ADD (
  CONSTRAINT JHIST_DEPT_FK
 FOREIGN KEY (DEPARTMENT_ID)
 REFERENCES DEPARTMENTS (DEPARTMENT_ID));

ALTER TABLE JOB_HISTORY ADD (
  CONSTRAINT JHIST_EMP_FK
 FOREIGN KEY (EMPLOYEE_ID)
 REFERENCES EMPLOYEES (EMPLOYEE_ID) DISABLE);

ALTER TABLE JOB_HISTORY ADD (
  CONSTRAINT JHIST_JOB_FK
 FOREIGN KEY (JOB_ID)
 REFERENCES JOBS (JOB_ID));


--
-- Note:
-- The following objects may not be sorted properly in the script due to cirular references
--
--  DEPARTMENTS  (Table)
--  EMPLOYEES  (Table)
--  JOB_HISTORY  (Table)
--  DEPT_ID_PK  (Index)
--  DEPT_LOCATION_IX  (Index)
--  EMP_EMAIL_UK  (Index)
--  EMP_EMP_ID_PK  (Index)
--  EMP_DEPARTMENT_IX  (Index)
--  EMP_JOB_IX  (Index)
--  EMP_MANAGER_IX  (Index)
--  EMP_NAME_IX  (Index)
--  JHIST_EMP_ID_ST_DATE_PK  (Index)
--  JHIST_JOB_IX  (Index)
--  JHIST_EMPLOYEE_IX  (Index)
--  JHIST_DEPARTMENT_IX  (Index)

Insert into REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (1, 'Europe');
Insert into REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (2, 'Americas');
Insert into REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (3, 'Asia');
Insert into REGIONS
   (REGION_ID, REGION_NAME)
 Values
   (4, 'Middle East and Africa');
COMMIT;

Insert into COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('CA', 'Canada', 2);
Insert into COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('DE', 'Germany', 1);
Insert into COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('UK', 'United Kingdom', 1);
Insert into COUNTRIES
   (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
 Values
   ('US', 'United States of America', 2);
COMMIT;

Insert into LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE,
    COUNTRY_ID)
 Values
   (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas',
    'US');
Insert into LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE,
    COUNTRY_ID)
 Values
   (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California',
    'US');
Insert into LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE,
    COUNTRY_ID)
 Values
   (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington',
    'US');
Insert into LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE,
    COUNTRY_ID)
 Values
   (1800, '460 Bloor St. W.', 'ON M5S 1X8', 'Toronto', 'Ontario',
    'CA');
Insert into LOCATIONS
   (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE,
    COUNTRY_ID)
 Values
   (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford',
    'UK');
COMMIT;

Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AD_PRES', 'President', 20000, 40000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AD_VP', 'Administration Vice President', 15000, 30000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AD_ASST', 'Administration Assistant', 3000, 6000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AC_MGR', 'Accounting Manager', 8200, 16000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('SA_MAN', 'Sales Manager', 10000, 20000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('SA_REP', 'Sales Representative', 6000, 12000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('ST_MAN', 'Stock Manager', 5500, 8500);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('ST_CLERK', 'Stock Clerk', 2000, 5000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('IT_PROG', 'Programmer', 4000, 10000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('MK_MAN', 'Marketing Manager', 9000, 15000);
Insert into JOBS
   (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
 Values
   ('MK_REP', 'Marketing Representative', 4000, 9000);
COMMIT;


Insert into JOB_GRADES
   (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL)
 Values
   ('A', 1000, 2999);
Insert into JOB_GRADES
   (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL)
 Values
   ('B', 3000, 5999);
Insert into JOB_GRADES
   (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL)
 Values
   ('C', 6000, 9999);
Insert into JOB_GRADES
   (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL)
 Values
   ('D', 10000, 14999);
Insert into JOB_GRADES
   (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL)
 Values
   ('E', 15000, 24999);
Insert into JOB_GRADES
   (GRADE_LEVEL, LOWEST_SAL, HIGHEST_SAL)
 Values
   ('F', 25000, 40000);
COMMIT;

Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (10, 'Administration', 200, 1700);
Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (20, 'Marketing', 201, 1800);
Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (50, 'Shipping', 124, 1500);
Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (60, 'IT', 103, 1400);
Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (80, 'Sales', 149, 2500);
Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (90, 'Executive', 100, 1700);
Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (110, 'Accounting', 205, 1700);
Insert into DEPARTMENTS
   (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
 Values
   (190, 'Contracting', NULL, 1700);
COMMIT;

Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (100, 'Steven', 'King', 'SKING', '515.123.4567',
    TO_DATE('06/17/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_PRES', 24000, NULL, NULL,
    90);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568',
    TO_DATE('09/21/1989 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_VP', 17000, NULL, 100,
    90);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569',
    TO_DATE('01/13/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_VP', 17000, NULL, 100,
    90);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567',
    TO_DATE('01/03/1990 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 9000, NULL, 102,
    60);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568',
    TO_DATE('05/21/1991 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 6000, NULL, 103,
    60);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567',
    TO_DATE('02/07/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 4200, NULL, 103,
    60);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234',
    TO_DATE('11/16/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_MAN', 5800, NULL, 100,
    50);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009',
    TO_DATE('10/17/1995 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3500, NULL, 124,
    50);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994',
    TO_DATE('01/29/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 3100, NULL, 124,
    50);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874',
    TO_DATE('03/15/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2600, NULL, 124,
    50);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004',
    TO_DATE('07/09/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 2500, NULL, 124,
    50);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018',
    TO_DATE('01/29/2000 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 10500, 0.2, 100,
    80);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267',
    TO_DATE('05/11/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 11000, 0.3, 149,
    80);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265',
    TO_DATE('03/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 8600, 0.2, 149,
    80);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263',
    TO_DATE('05/24/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 7000, 0.15, 149,
    NULL);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444',
    TO_DATE('09/17/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_ASST', 4400, NULL, 101,
    10);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555',
    TO_DATE('02/17/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'MK_MAN', 13000, NULL, 100,
    20);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (202, 'Pat', 'Fay', 'PFAY', '603.123.6666',
    TO_DATE('08/17/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'MK_REP', 6000, NULL, 201,
    20);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080',
    TO_DATE('06/07/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_MGR', 12000, NULL, 101,
    110);
Insert into EMPLOYEES
   (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID,
    DEPARTMENT_ID)
 Values
   (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181',
    TO_DATE('06/07/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_ACCOUNT', 8300, NULL, 205,
    110);
COMMIT;

Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (102, TO_DATE('01/13/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('07/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'IT_PROG', 60);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (101, TO_DATE('09/21/1989 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('10/27/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_ACCOUNT', 110);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (101, TO_DATE('10/28/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/15/1997 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_MGR', 110);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (201, TO_DATE('02/17/1996 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/19/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'MK_REP', 20);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (114, TO_DATE('03/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 50);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (122, TO_DATE('01/01/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'ST_CLERK', 50);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (200, TO_DATE('09/17/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('06/17/1993 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AD_ASST', 90);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (176, TO_DATE('03/24/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_REP', 80);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (176, TO_DATE('01/01/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1999 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SA_MAN', 80);
Insert into JOB_HISTORY
   (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
 Values
   (200, TO_DATE('07/01/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('12/31/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'AC_ACCOUNT', 90);
COMMIT;

ALTER TABLE DEPARTMENTS ADD (
  CONSTRAINT DEPT_MGR_FK
 FOREIGN KEY (MANAGER_ID)
 REFERENCES EMPLOYEES (EMPLOYEE_ID));
