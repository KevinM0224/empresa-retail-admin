USE empresa_retail;

INSERT INTO Clientes (nombre, apellido, email, telefono, ciudad) VALUES
 ('Laura',  'Gómez',    'laura.gomez@correo.com',  '3001112233', 'Popayán'),
 ('Carlos', 'Ramírez',  'carlos.ramirez@correo.com','3012223344', 'Cali'),
 ('Sofía',  'Martínez', 'sofia.martinez@correo.com','3023334455', 'Bogotá'),
 ('Andrés', 'Pérez',    'andres.perez@correo.com', '3034445566', 'Medellín'),
 ('Valeria','Torres',   'valeria.torres@correo.com','3045556677', 'Popayán');

INSERT INTO Canales (nombre, descripcion) VALUES
 ('WhatsApp',        'Atención y ventas por mensajería'),
 ('Correo',          'Email marketing y soporte'),
 ('Redes sociales',  'Instagram y Facebook'),
 ('Tienda física',   'Atención presencial en punto de venta');

INSERT INTO Campanias (nombre, id_canal, fecha_inicio, fecha_fin, presupuesto, estado) VALUES
 ('Lanzamiento primavera', 3, '2026-03-01', '2026-03-31',  2500000.00, 'Finalizada'),
 ('Descuento por suscripción', 2, '2026-06-01', NULL,       1200000.00, 'Activa'),
 ('Fidelización WhatsApp', 1, '2026-09-15', NULL,            800000.00, 'Activa');

INSERT INTO Interacciones (id_cliente, id_canal, tipo, descripcion) VALUES
 (1, 1, 'Consulta',    'Pregunta por disponibilidad de producto'),
 (2, 2, 'Reclamo',     'Retraso en la entrega'),
 (3, 4, 'Venta',       'Compra en tienda'),
 (4, 3, 'Seguimiento', 'Seguimiento a cotización');

INSERT INTO Conversiones (id_cliente, id_campania, tipo, valor, fecha_conversion) VALUES
 (1, 1, 'Registro',     0.00,      '2026-03-05 10:15:00'),
 (1, 1, 'Compra',       185000.00, '2026-03-12 16:40:00'),
 (2, 2, 'Suscripcion',  25000.00,  '2026-06-10 09:00:00'),
 (3, 3, 'Compra',       92000.00,  '2026-09-20 14:25:00'),
 (4, 2, 'Registro',     0.00,      '2026-07-02 11:05:00'),
 (5, 3, 'Suscripcion',  25000.00,  '2026-09-25 18:30:00');
