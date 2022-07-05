--liquibase formatted sql

--changeset jenkins:1 labels:sample-label context:sample-context
--comment: se crea la tabla persones
create table persones (
    id int primary key not null identity(1, 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE persones;

--changeset jenkins:2 labels:sample-label context:sample-context
--comment: se crea la tabla companias
create table companias (
    id int primary key not null identity(1, 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE companias;

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
