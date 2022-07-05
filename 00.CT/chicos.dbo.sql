--liquibase formatted sql

--changeset chicos:1
--comment: se crea la tabla chicos
CREATE TABLE chicos (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
