# Liquibase Spring Annotation Example

Liquibase is an open source database change management tool built on Java. Rather than writing SQL directly against the database to create, update or drop database objects, developers define their desired database changes in XML files.

### Add this maven dependency to your pom.xml file :

```
<!-- https://mvnrepository.com/artifact/org.liquibase/liquibase-core -->
		<dependency>
			<groupId>org.liquibase</groupId>
			<artifactId>liquibase-core</artifactId>
			<version>3.5.1</version>
		</dependency>
```

### Add this bean defination to your spring configuration file :

```
@Bean
public SpringLiquibase liquibase() {
    log.debug("Configuring Liquibase");
    SpringLiquibase liquibase = new SpringLiquibase();
    liquibase.setDataSource(dataSource());
    liquibase.setChangeLog("classpath:hibernettest.sql);
    liquibase.setContexts("development, production");
    return liquibase;
}
```

### Create liquibase formated .sql file for your schema change (or new schema import) in your resource directory :

```
--liquibase formatted sql

--changeset rajesh:1
--comment: creating Department table
CREATE TABLE IF NOT EXISTS Department (
  deptId int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID OF Department',
  deptName varchar(255) DEFAULT NULL COMMENT 'deptName OF Employee',
  location varchar(255) DEFAULT NULL COMMENT 'location OF Employee',
  PRIMARY KEY (deptId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


--changeset rajesh:2
--comment: creating employee table
CREATE TABLE IF NOT EXISTS employee (
  empId int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID OF Employee',
  fName varchar(255) DEFAULT NULL COMMENT 'fName OF Employee',
  lName varchar(255) DEFAULT NULL COMMENT 'lName OF Employee',
  PRIMARY KEY (empId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--changeset rajesh:3
--comment: creating employee_Department table
CREATE TABLE IF NOT EXISTS employee_Department (
  Employee_empId int(11) NOT NULL,
  listOfDepts_deptId int(11) NOT NULL,
  UNIQUE KEY listOfDepts_deptId (listOfDepts_deptId),
  KEY FKF2E35A3F6DFE875 (Employee_empId),
  KEY FKF2E35A3453CBCED (listOfDepts_deptId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--changeset rajesh:4
--comment: alter table
ALTER TABLE employee_Department
  ADD CONSTRAINT FKF2E35A3453CBCED FOREIGN KEY (listOfDepts_deptId) REFERENCES Department (deptId),
  ADD CONSTRAINT FKF2E35A3F6DFE875 FOREIGN KEY (Employee_empId) REFERENCES employee (empId);
```

### Run your spring project and get your schema change updated in your specified database.

```
INFO 10/8/16 12:39 PM: liquibase: Successfully acquired change log lock
INFO 10/8/16 12:39 PM: liquibase: Creating database history table with name: hibernettest.DATABASECHANGELOG
INFO 10/8/16 12:39 PM: liquibase: Reading from hibernettest.DATABASECHANGELOG
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::1::rajesh: Custom SQL executed
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::1::rajesh: ChangeSet classpath:hibernettest.sql::1::rajesh ran successfully in 105ms
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::2::rajesh: Custom SQL executed
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::2::rajesh: ChangeSet classpath:hibernettest.sql::2::rajesh ran successfully in 75ms
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::3::rajesh: Custom SQL executed
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::3::rajesh: ChangeSet classpath:hibernettest.sql::3::rajesh ran successfully in 75ms
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::4::rajesh: Custom SQL executed
INFO 10/8/16 12:39 PM: liquibase: classpath:hibernettest.sql: classpath:hibernettest.sql::4::rajesh: ChangeSet classpath:hibernettest.sql::4::rajesh ran successfully in 243ms
INFO 10/8/16 12:39 PM: liquibase: Successfully released change log lock
```
