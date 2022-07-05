--liquibase formatted sql changeLogId:140aa641-911b-4a2e-af0b-e8f3d809cc74

--changeset jenkins:1 labels:sample-label context:sample-context
--comment: se crea la tabla personas
create table personas (
    id int primary key not null identity(1, 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE person;

--changeset jenkins:2 labels:sample-label context:sample-context
--comment: se crea la tabla companias
create table companias (
    id int primary key not null identity(1, 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE company;

--changeset jenkins:3 labels:sample-label context:sample-context
--comment: se crea la tabla datos
create table datos (
    id int primary key not null identity(1, 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE datos;

--changeset jenkins:4 labels:sample-label context:sample-context
--comment: se crea la tabla direcion
create table direccion (
    id int primary key not null identity(1, 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE direccion;