-- ana (cajas)
GRANT SELECT, INSERT, UPDATE ON empresa_retail.Clientes      TO 'rol_ana';
GRANT SELECT, INSERT, UPDATE ON empresa_retail.Interacciones TO 'rol_ana';

-- pedro (inventario)
GRANT SELECT, INSERT, UPDATE ON empresa_retail.Canales    TO 'rol_pedro';
GRANT SELECT, INSERT, UPDATE ON empresa_retail.Campanias  TO 'rol_pedro';
GRANT SELECT                 ON empresa_retail.Clientes   TO 'rol_pedro';

-- marta (gerencia)
GRANT SELECT  ON empresa_retail.Conversiones                      TO 'rol_marta';
GRANT EXECUTE ON PROCEDURE empresa_retail.sp_conversiones_por_tipo  TO 'rol_marta';
GRANT EXECUTE ON PROCEDURE empresa_retail.sp_conversiones_por_rango TO 'rol_marta';
GRANT EXECUTE ON PROCEDURE empresa_retail.sp_resumen_conversiones   TO 'rol_marta';

-- roles a usuarios
GRANT 'rol_ana'   TO 'ana_crm'@'localhost';
GRANT 'rol_pedro' TO 'pedro_mkt'@'localhost';
GRANT 'rol_marta' TO 'marta_auditoria'@'localhost';

SET DEFAULT ROLE 'rol_ana'   TO 'ana_crm'@'localhost';
SET DEFAULT ROLE 'rol_pedro' TO 'pedro_mkt'@'localhost';
SET DEFAULT ROLE 'rol_marta' TO 'marta_auditoria'@'localhost';

FLUSH PRIVILEGES;
