/* crear esquema de base de datos */
CREATE SCHEMA `nalula_diseño_grafico` DEFAULT CHARACTER SET utf8 ;

/* seleccionar la base de datos a trabajar */
USE `nalula_diseño_grafico`;

/* crear tablas*/ 
CREATE TABLE `usuarios` (
	`id_usuario` INT NOT NULL AUTO_INCREMENT,
	`nombre` VARCHAR(45) NOT NULL,
	`apellido` VARCHAR(45) NOT NULL,
	`email` VARCHAR(45) NOT NULL,
	`username` VARCHAR(45) NOT NULL,
	`contraseña` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`id_usuario`),
	UNIQUE INDEX `id_usuario_UNIQUE` (`id_usuario` ASC) VISIBLE);
  
CREATE TABLE `datos_usuarios` (
	`usuario_id` INT NOT NULL,
	`fecha_nacimiento` DATE NOT NULL,
	`fecha_registro` DATETIME NOT NULL,
	`genero` ENUM('Femenino', 'Masculino', 'Otro') NOT NULL,
	`telefono` BIGINT NOT NULL,
	`pais` VARCHAR(45) NOT NULL,
	`provincia` VARCHAR(45) NOT NULL,
	`localidad` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`usuario_id`),
	UNIQUE INDEX `usuario_id_UNIQUE` (`usuario_id` ASC) VISIBLE,
	CONSTRAINT `fk_usuario_datos`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    ALTER TABLE `datos_usuarios` 
CHANGE COLUMN `fecha_registro` `fecha_registro` DATETIME NOT NULL DEFAULT NOW() ;

CREATE TABLE `categorias` (
    id_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50)
);

ALTER TABLE `nalula_diseño_grafico`.`categorias` 
CHANGE COLUMN `nombre_categoria` `nombre_categoria` VARCHAR(50) NOT NULL ,
ADD UNIQUE INDEX `id_categoria_UNIQUE` (`id_categoria` ASC) VISIBLE;

CREATE TABLE `productos` (
	`id_producto` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nombre` VARCHAR(45) NOT NULL,
    `detalle` VARCHAR(150) NOT NULL,
    `precio` FLOAT NOT NULL,
    `stock` INT NOT NULL,
    `categoria_id` INT NOT NULL,
    CONSTRAINT `fk_producto_categoria`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `categorias` (`id_categoria`)
);
ALTER TABLE `nalula_diseño_grafico`.`productos` 
CHANGE COLUMN `stock` `stock` INT NULL ;


CREATE TABLE `carrito_compras` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `nombre` VARCHAR(150) NOT NULL,
  `precio` FLOAT NOT NULL,
  `stock` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_carrito_usuario_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_carrito_producto_idx` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_carrito_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `nalula_diseño_grafico`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrito_producto`
    FOREIGN KEY (`producto_id`)
    REFERENCES `productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/* insertar datos*/ 
INSERT INTO categorias (nombre_categoria) VALUES 
	("Fiestas"),
    ("Regalos Personalizados"),
    ("Imprimibles"),
    ("Papelería comercial"),
    ("Packaging"),
    ("Gráfica Publicitaria"),
    ("Editorial"),
    ("Diseño digital");

INSERT INTO productos (nombre, detalle, precio, stock, categoria_id) VALUES 
	("Tarjetas personales", "Tarjetas personales x100u, 8x5cm, impresión simple faz, full color, papel ilustración 300g, diseño incluído", "1260", NULL, 4),
    ("Agenda semana a la vista", "Agenda tamaño A5, semana a la vista", "3860", "5", 7),
    ("Diseño de Identidad Visual", "Dale a tu marca la identidad que merece. Trabajemos juntos y creemos una identidad sólida y memorable.", "15000", NULL, 8),
    ("Etiquetas", "Etiquetas x100u, 8x5cm, impresión simple faz, full color, papel ilustración 300g, con una perforación y diseño incluído", "1520", NULL, 6);
    
INSERT INTO usuarios (nombre, apellido, email, username, contraseña) VALUES 
	("Matías", "López", "mlopez@gmail.com", "mlopez", "bshcjk"),
    ("Narela", "Lavia", "nlavia@gmail.com", "nlavia", "nmdosbcjskl"),
    ("Sofía", "Álvarez", "salvarez@gmail.com", "salvarez", "51jbnjehfoeklf");
    
INSERT INTO datos_usuarios (usuario_id, fecha_nacimiento, genero, telefono, pais, provincia, localidad) VALUES 
	(1, "1998-05-24", "Masculino", "013644851", "Argentina", "Córdoba", "Córdoba"),
    (3, "2002-09-17", "Femenino", "154681548", "Argentina", "Santa Fe", "Rosario"),
    (2, "1991-12-04", "Femenino", "1552364521", "Argentina", "Neuquén", "Neuquén");
    
/* mostrar tablas */
select * from categorias;

/* mostrar tabla productos con nombre de categoría */
select * from productos
	JOIN categorias ON productos.categoria_id = categorias.id_categoria;
    
select * from usuarios;
select * from datos_usuarios;


