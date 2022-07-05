--liquibase formatted sql

--changeset case:1
--comment: se crea la tabla Persons
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

--rollback DROP TABLE Persons;
