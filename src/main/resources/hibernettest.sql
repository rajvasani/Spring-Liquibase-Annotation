--liquibase formatted sql

--changeset rajesh:1
--comment: creating Department table
CREATE TABLE IF NOT EXISTS Department (
  deptId int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID OF Department',
  deptName varchar(255) DEFAULT NULL COMMENT 'deptName OF Employee',
  location varchar(255) DEFAULT NULL COMMENT 'location OF Employee',
  PRIMARY KEY (deptId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
--rollback drop table Department;


--changeset rajesh:2
--comment: creating employee table
CREATE TABLE IF NOT EXISTS employee (
  empId int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID OF Employee',
  fName varchar(255) DEFAULT NULL COMMENT 'fName OF Employee',
  lName varchar(255) DEFAULT NULL COMMENT 'lName OF Employee',
  PRIMARY KEY (empId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
--rollback drop table employee;

--changeset rajesh:3
--comment: creating employee_Department table
CREATE TABLE IF NOT EXISTS employee_Department (
  Employee_empId int(11) NOT NULL,
  listOfDepts_deptId int(11) NOT NULL,
  UNIQUE KEY listOfDepts_deptId (listOfDepts_deptId),
  KEY FKF2E35A3F6DFE875 (Employee_empId),
  KEY FKF2E35A3453CBCED (listOfDepts_deptId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--rollback drop table employee_Department;

--changeset rajesh:4
--comment: alter table
ALTER TABLE employee_Department
  ADD CONSTRAINT FKF2E35A3453CBCED FOREIGN KEY (listOfDepts_deptId) REFERENCES Department (deptId),
  ADD CONSTRAINT FKF2E35A3F6DFE875 FOREIGN KEY (Employee_empId) REFERENCES employee (empId);
