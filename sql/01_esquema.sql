DROP DATABASE IF EXISTS empresa_retail;
CREATE DATABASE empresa_retail
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE empresa_retail;

CREATE TABLE Clientes (
  id_cliente     INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  nombre         VARCHAR(60)   NOT NULL,
  apellido       VARCHAR(60)   NOT NULL,
  email          VARCHAR(120)  NOT NULL,
  telefono       VARCHAR(20)   NULL,
  ciudad         VARCHAR(60)   NULL,
  estado         ENUM('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  fecha_registro DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_cliente),
  UNIQUE KEY uq_clientes_email (email)
) ENGINE=InnoDB;

CREATE TABLE Canales (
  id_canal    INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre      VARCHAR(60)  NOT NULL,
  descripcion VARCHAR(200) NULL,
  PRIMARY KEY (id_canal),
  UNIQUE KEY uq_canales_nombre (nombre)
) ENGINE=InnoDB;

-- se llama Campanias para no usar la ñ en el nombre de la tabla
CREATE TABLE Campanias (
  id_campania  INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  nombre       VARCHAR(100)  NOT NULL,
  id_canal     INT UNSIGNED  NOT NULL,
  fecha_inicio DATE          NOT NULL,
  fecha_fin    DATE          NULL,
  presupuesto  DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  estado       ENUM('Planificada','Activa','Finalizada') NOT NULL DEFAULT 'Planificada',
  PRIMARY KEY (id_campania),
  CONSTRAINT fk_campanias_canal FOREIGN KEY (id_canal) REFERENCES Canales (id_canal)
) ENGINE=InnoDB;

CREATE TABLE Interacciones (
  id_interaccion    INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_cliente        INT UNSIGNED NOT NULL,
  id_canal          INT UNSIGNED NOT NULL,
  tipo              ENUM('Consulta','Reclamo','Seguimiento','Venta') NOT NULL,
  descripcion       VARCHAR(255) NULL,
  fecha_interaccion DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_interaccion),
  CONSTRAINT fk_inter_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente),
  CONSTRAINT fk_inter_canal   FOREIGN KEY (id_canal)   REFERENCES Canales (id_canal)
) ENGINE=InnoDB;

CREATE TABLE Conversiones (
  id_conversion    INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  id_cliente       INT UNSIGNED  NOT NULL,
  id_campania      INT UNSIGNED  NULL,
  tipo             ENUM('Compra','Registro','Suscripcion') NOT NULL,
  valor            DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  fecha_conversion DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_conversion),
  CONSTRAINT fk_conv_cliente  FOREIGN KEY (id_cliente)  REFERENCES Clientes (id_cliente),
  CONSTRAINT fk_conv_campania FOREIGN KEY (id_campania) REFERENCES Campanias (id_campania)
) ENGINE=InnoDB;
