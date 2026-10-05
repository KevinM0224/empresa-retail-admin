USE empresa_retail;

DROP PROCEDURE IF EXISTS sp_conversiones_por_tipo;
DROP PROCEDURE IF EXISTS sp_conversiones_por_rango;
DROP PROCEDURE IF EXISTS sp_resumen_conversiones;

DELIMITER $$

CREATE PROCEDURE sp_conversiones_por_tipo (IN p_tipo VARCHAR(20))
  READS SQL DATA
  SQL SECURITY DEFINER
  COMMENT 'Lista las conversiones de un tipo: Compra, Registro o Suscripcion'
BEGIN
  SELECT id_conversion, id_cliente, id_campania, tipo, valor, fecha_conversion
  FROM Conversiones
  WHERE tipo = p_tipo
  ORDER BY fecha_conversion;
END$$

CREATE PROCEDURE sp_conversiones_por_rango (IN p_desde DATE, IN p_hasta DATE)
  READS SQL DATA
  SQL SECURITY DEFINER
  COMMENT 'Lista las conversiones dentro de un rango de fechas (inclusive)'
BEGIN
  SELECT id_conversion, id_cliente, id_campania, tipo, valor, fecha_conversion
  FROM Conversiones
  WHERE DATE(fecha_conversion) BETWEEN p_desde AND p_hasta
  ORDER BY fecha_conversion;
END$$

CREATE PROCEDURE sp_resumen_conversiones ()
  READS SQL DATA
  SQL SECURITY DEFINER
  COMMENT 'Resumen de cantidad y valor total por tipo de conversion'
BEGIN
  SELECT tipo,
         COUNT(*)   AS total_conversiones,
         SUM(valor) AS valor_total
  FROM Conversiones
  GROUP BY tipo
  ORDER BY tipo;
END$$

DELIMITER ;
