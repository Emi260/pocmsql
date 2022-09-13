--liquibase formatted sql

--changeset bbva:1 
create table empleados (
    id int primary key not null identity(1, 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE empleados;
