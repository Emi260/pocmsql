--liquibase formatted sql

--changeset bbva:2
ALTER TABLE empleados
ADD COLUM Email varchar(255);

--rollback ALTER TABLE empleados DROP COLUMN Email;
