-- SQL Server
DROP DATABASE IF EXISTS TAM;
CREATE DATABASE TAM;
GO
USE TAM; -- Time and Attendance Management 
GO

-- ============================================================
--  DROP EXISTING TABLES
-- ============================================================
DROP TABLE IF EXISTS BADGE_SWIPES;
DROP TABLE IF EXISTS DURATIONS;
DROP TABLE IF EXISTS EMPLOYEES;   -- MasterData
DROP TABLE IF EXISTS ATTENDANCES; -- MasterData
DROP TABLE IF EXISTS DEPARTMENTS; -- MasterData
DROP TABLE IF EXISTS FIRMS;       -- MasterData

-- ============================================================
--  1. ATTENDANCES TABLE
-- ============================================================
CREATE TABLE ATTENDANCES (
    ATTENDANCES_ID   INTEGER      NOT NULL,
    ATTENDANCES_DES  VARCHAR(100) NOT NULL,
    CONSTRAINT PK_ATTENDANCES PRIMARY KEY (ATTENDANCES_ID)
);

-- ============================================================
--  2. DEPARTMENTS TABLE
-- ============================================================
CREATE TABLE DEPARTMENTS (
    DEPARTMENTS_ID   INTEGER      NOT NULL,
    DEPARTMENTS_DES  VARCHAR(100) NOT NULL,
    CONSTRAINT PK_DEPARTMENTS PRIMARY KEY (DEPARTMENTS_ID)
);

-- ============================================================
--  3. FIRMS TABLE
-- ============================================================
CREATE TABLE FIRMS (
    FIRMS_ID   INTEGER      NOT NULL,
    FIRMS_DES  VARCHAR(150) NOT NULL,
    CONSTRAINT PK_FIRMS PRIMARY KEY (FIRMS_ID)
);

-- ============================================================
--  4. EMPLOYEES TABLE
-- ============================================================
CREATE TABLE EMPLOYEES (
    EMPLOYEES_ID              INTEGER      NOT NULL,
    EMPLOYEES_SURNAME         VARCHAR(80)  NOT NULL,
    EMPLOYEES_NAME            VARCHAR(80)  NOT NULL,
	EMPLOYEES_GENDER          CHAR(1)      NOT NULL,
    EMPLOYEES_DAY_OF_BIRTH    DATE         NOT NULL,
    EMPLOYEES_DEPARTMENT_ID   INTEGER      NOT NULL,
    EMPLOYEES_FIRM_ID         INTEGER      NOT NULL,
    CONSTRAINT PK_EMPLOYEES         PRIMARY KEY (EMPLOYEES_ID),
    CONSTRAINT FK_EMP_DEPARTMENTS   FOREIGN KEY (EMPLOYEES_DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENTS_ID),
    CONSTRAINT FK_EMP_FIRMS         FOREIGN KEY (EMPLOYEES_FIRM_ID) REFERENCES FIRMS(FIRMS_ID),
	CONSTRAINT CK_GENDER            CHECK (EMPLOYEES_GENDER IN ('M','F', 'X'))
);

-- ============================================================
--  5. DURATIONS TABLE
-- ============================================================
CREATE TABLE DURATIONS (
    DURATIONS_DATE           DATE        NOT NULL,
    DURATIONS_EMPLOYEE_ID    INTEGER     NOT NULL,
    DURATIONS_ATTENDANCE_ID  INTEGER     NOT NULL,
    DURATION                 TIME        NOT NULL,   -- format HH:MM:SS
    CONSTRAINT PK_DURATIONS       PRIMARY KEY (DURATIONS_DATE, DURATIONS_EMPLOYEE_ID, DURATIONS_ATTENDANCE_ID),
    CONSTRAINT FK_DUR_EMPLOYEES   FOREIGN KEY (DURATIONS_EMPLOYEE_ID)   REFERENCES EMPLOYEES(EMPLOYEES_ID),
    CONSTRAINT FK_DUR_ATTENDANCES FOREIGN KEY (DURATIONS_ATTENDANCE_ID) REFERENCES ATTENDANCES(ATTENDANCES_ID)
);

-- ============================================================
--  6. BADGE_SWIPES TABLE
-- ============================================================
CREATE TABLE BADGE_SWIPES (
    BADGE_SWIPES_DATETIME    DATETIME  NOT NULL,   -- format AAAA-MM-DD HH:MM:SS
    BADGE_SWIPES_TYPE        CHAR(1)    NOT NULL,   -- 'I' = in, 'O' = out
    BADGE_SWIPES_SN          INTEGER    NOT NULL,   -- Sequence Number
    BADGE_SWIPES_EMPLOYEE_ID INTEGER    NOT NULL,
    CONSTRAINT PK_BADGE_SWIPES    PRIMARY KEY (BADGE_SWIPES_EMPLOYEE_ID, BADGE_SWIPES_DATETIME),
    CONSTRAINT FK_BS_EMPLOYEES    FOREIGN KEY (BADGE_SWIPES_EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEES_ID),
    CONSTRAINT CK_TYPE            CHECK (BADGE_SWIPES_TYPE IN ('I','O'))
);