-- SQL Server
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
    ATTENDANCE_ID   INTEGER      NOT NULL,
    ATTENDANCE_DES  VARCHAR(100) NOT NULL,
    CONSTRAINT PK_ATTENDANCES PRIMARY KEY (ATTENDANCE_ID)
);

-- ============================================================
--  2. DEPARTMENTS TABLE
-- ============================================================
CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID   INTEGER      NOT NULL,
    DEPARTMENT_DES  VARCHAR(100) NOT NULL,
    CONSTRAINT PK_DEPARTMENTS PRIMARY KEY (DEPARTMENT_ID)
);

-- ============================================================
--  3. FIRMS TABLE
-- ============================================================
CREATE TABLE FIRMS (
    FIRM_ID   INTEGER      NOT NULL,
    FIRM_DES  VARCHAR(150) NOT NULL,
    CONSTRAINT PK_FIRMS PRIMARY KEY (FIRM_ID)
);


-- ============================================================
--  4. EMPLOYEES TABLE
-- ============================================================
CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID           INTEGER      NOT NULL,
    EMPLOYEE_SURNAME      VARCHAR(80)  NOT NULL,
    EMPLOYEE_NAME         VARCHAR(80)  NOT NULL,
    EMPLOYEE_DAY_OF_BIRTH DATE         NOT NULL,
    EMPLOYEE_DEPARTMENT   INTEGER      NOT NULL,
    EMPLOYEE_FIRM         INTEGER      NOT NULL,
    CONSTRAINT PK_EMPLOYEES         PRIMARY KEY (EMPLOYEE_ID),
    CONSTRAINT FK_EMP_DEPARTMENTS   FOREIGN KEY (EMPLOYEE_DEPARTMENT) REFERENCES DEPARTMENTS(DEPARTMENT_ID),
    CONSTRAINT FK_EMP_FIRMS         FOREIGN KEY (EMPLOYEE_FIRM) REFERENCES FIRMS(FIRM_ID)
);

-- ============================================================
--  5. DURATIONS TABLE
-- ============================================================
CREATE TABLE DURATIONS (
    [DATE]         DATE        NOT NULL,
    EMPLOYEE_ID    INTEGER     NOT NULL,
    ATTENDANCE_ID  INTEGER     NOT NULL,
    DURATION       TIME        NOT NULL,   -- format HH:MM:SS
    CONSTRAINT PK_DURATIONS       PRIMARY KEY ([DATE], EMPLOYEE_ID, ATTENDANCE_ID),
    CONSTRAINT FK_DUR_EMPLOYEES   FOREIGN KEY (EMPLOYEE_ID)   REFERENCES EMPLOYEES(EMPLOYEE_ID),
    CONSTRAINT FK_DUR_ATTENDANCES FOREIGN KEY (ATTENDANCE_ID) REFERENCES ATTENDANCES(ATTENDANCE_ID)
);

-- ============================================================
--  6. BADGE_SWIPES TABLE
-- ============================================================
CREATE TABLE BADGE_SWIPES (
    DATETIME_BADGE_SWIPE    TIMESTAMP  NOT NULL,   -- aaaa-mm-dd hh:mm:ss
    BADGE_SWIPE_TYPE        CHAR(1)    NOT NULL,   -- 'I' = in, 'O' = out
    SEQUENCE_NUMBER         INTEGER    NOT NULL,
    EMPLOYEE_ID             INTEGER    NOT NULL,
    CONSTRAINT PK_BADGE_SWIPES    PRIMARY KEY (EMPLOYEE_ID, DATETIME_BADGE_SWIPE),
    CONSTRAINT FK_BS_EMPLOYEES    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
    CONSTRAINT CK_TYPE            CHECK (BADGE_SWIPE_TYPE IN ('I','O'))
);