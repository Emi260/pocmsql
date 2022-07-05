--liquibase formatted sql

--changeset drop:1
--comment: se borra la tabla Persons
DROP TABLE Persons;
