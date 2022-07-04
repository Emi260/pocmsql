--liquibase formatted sql

--changeset case:1
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

--rollback DROP TABLE Persons;

--changeset case:2
CREATE TABLE Personas (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

--rollback DROP TABLE Personas;

--changeset case:3
CREATE TABLE Tipos (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

--rollback DROP TABLE Tipos;

--changeset case:4 
CREATE TABLE Pedro (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

--rollback DROP TABLE Pedro;
