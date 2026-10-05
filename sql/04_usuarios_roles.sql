DROP USER IF EXISTS 'ana_crm'@'localhost';
DROP USER IF EXISTS 'pedro_mkt'@'localhost';
DROP USER IF EXISTS 'marta_auditoria'@'localhost';
DROP ROLE IF EXISTS 'rol_ana', 'rol_pedro', 'rol_marta';

CREATE ROLE 'rol_ana', 'rol_pedro', 'rol_marta';

CREATE USER 'ana_crm'@'localhost'         IDENTIFIED BY 'Retail2026!Caja';
CREATE USER 'pedro_mkt'@'localhost'       IDENTIFIED BY 'Retail2026!Stock';
CREATE USER 'marta_auditoria'@'localhost' IDENTIFIED BY 'Retail2026!Admin';
