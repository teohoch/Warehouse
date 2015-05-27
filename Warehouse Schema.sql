

-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'Existencias'
-- Listado de las existencias reales en el Laboratorio
-- ---

DROP TABLE IF EXISTS `Existencias`;
		
CREATE TABLE `Existencias` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_articulo` INTEGER NULL DEFAULT NULL,
  `cantidad` INTEGER NULL DEFAULT NULL,
  `id_bodega` INTEGER NULL DEFAULT NULL,
  `id_folio` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMM
ENT 'Listado de las existencias reales en el Laboratorio';

-- ---
-- Table 'Articulos'
-- Lista de todos los artículos en lista
-- ---

DROP TABLE IF EXISTS `Articulos`;
		
CREATE TABLE `Articulos` (
  `id` INTEGER NOT NULL AUTO_INCREMENT DEFAULT NULL,
  `nombre` VARCHAR(50) NOT NULL DEFAULT 'NULL',
  `Descripcion` MEDIUMTEXT NULL DEFAULT NULL,
  `id_proveedor` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Lista de todos los artículos en lista';

-- ---
-- Table 'Proveedores'
-- Lista de todos los proveedores 
-- ---

DROP TABLE IF EXISTS `Proveedores`;
		
CREATE TABLE `Proveedores` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `nombre` VARCHAR(50) NOT NULL DEFAULT 'NULL',
  `Direccion` VARCHAR(100) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Lista de todos los proveedores ';

-- ---
-- Table 'Bodega'
-- Listado de las bodegas existentes
-- ---

DROP TABLE IF EXISTS `Bodega`;
		
CREATE TABLE `Bodega` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `nombre` VARCHAR(50) NOT NULL DEFAULT 'NULL',
  `ubicacion` VARCHAR(100) NOT NULL DEFAULT 'NULL',
  `descripcion` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Listado de las bodegas existentes';

-- ---
-- Table 'Folio'
-- Folio o calibración del reactivo o elemento
-- ---

DROP TABLE IF EXISTS `Folio`;
		
CREATE TABLE `Folio` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `descripcion` MEDIUMTEXT NULL DEFAULT NULL,
  `fecha_vencimiento` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Folio o calibración del reactivo o elemento';

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `Existencias` ADD FOREIGN KEY (id_articulo) REFERENCES `Articulos` (`id`);
ALTER TABLE `Existencias` ADD FOREIGN KEY (id_bodega) REFERENCES `Bodega` (`id`);
ALTER TABLE `Existencias` ADD FOREIGN KEY (id_folio) REFERENCES `Folio` (`id`);
ALTER TABLE `Articulos` ADD FOREIGN KEY (id_proveedor) REFERENCES `Proveedores` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Existencias` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Articulos` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Proveedores` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Bodega` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Folio` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `Existencias` (`id`,`id_articulo`,`cantidad`,`id_bodega`,`id_folio`) VALUES
-- ('','','','','');
-- INSERT INTO `Articulos` (`id`,`nombre`,`Descripcion`,`id_proveedor`) VALUES
-- ('','','','');
-- INSERT INTO `Proveedores` (`id`,`nombre`,`Direccion`,`telefono`) VALUES
-- ('','','','');
-- INSERT INTO `Bodega` (`id`,`nombre`,`ubicacion`,`descripcion`) VALUES
-- ('','','','');
-- INSERT INTO `Folio` (`id`,`descripcion`,`fecha_vencimiento`) VALUES
-- ('','','');

