-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.28 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para prueba-tecnica
CREATE DATABASE IF NOT EXISTS `prueba-tecnica` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `prueba-tecnica`;

-- Volcando estructura para procedimiento prueba-tecnica.agregarAsignatura
DELIMITER //
CREATE PROCEDURE `agregarAsignatura`(IN _nombre VARCHAR(30), IN _profe_id int)
BEGIN
   INSERT INTO asignaturas (asig_nombre, profesores_profe_id)
   VALUES (UCASE(_nombre), _profe_id);
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.agregarBloque
DELIMITER //
CREATE PROCEDURE `agregarBloque`(IN _bloque_nombre  VARCHAR(45))
BEGIN
   INSERT INTO bloques (Bloque_Nombre)
   VALUES (UCASE(_bloque_nombre));
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.agregarClase
DELIMITER //
CREATE PROCEDURE `agregarClase`(IN _estudiante_id int, IN _id_asignatura int)
BEGIN
   INSERT INTO clases (Estudiantes_Estud_ID, Asignaturas_Asig_ID)
   VALUES (_estudiante_id, _id_asignatura);
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.agregarDocente
DELIMITER //
CREATE PROCEDURE `agregarDocente`(IN _nombres varchar(45), IN _apellidos varchar(45),
                                                      IN _identificacion varchar(45), IN _corrreo varchar(50))
BEGIN
   INSERT INTO profesores (Profe_Nombres, Profe_Apellidos, Profe_Identificacion, Profe_correo)
   VALUES (UPPER(_nombres), UPPER(_apellidos),  UPPER(_identificacion), UPPER(_corrreo));
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.agregarEstudiante
DELIMITER //
CREATE PROCEDURE `agregarEstudiante`(IN _nombre VARCHAR(30), IN _apellido VARCHAR(30), IN _identificacion VARCHAR(25), IN _correo VARCHAR(50))
BEGIN
   INSERT INTO estudiantes (Estud_Nombres, Estud_Apellidos, Estud_Identificacion, Estud_correo)
   VALUES (UCASE(_nombre), UCASE(_apellido), UCASE(_identificacion),UCASE(_correo));
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.agregarHorario
DELIMITER //
CREATE PROCEDURE `agregarHorario`(IN _dia VARCHAR(10), IN _hor_inicio VARCHAR(15), IN _hor_fin VARCHAR(15))
BEGIN
   INSERT INTO `prueba-tecnica`.horarios (Horario_Dia, Horario_Hora_Inicio, Horario_Hora_Fin)
   VALUES (UCASE(_dia), UCASE(_hor_inicio), UCASE(_hor_fin));
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.agregarProgramaAcademico
DELIMITER //
CREATE PROCEDURE `agregarProgramaAcademico`(IN _nombre VARCHAR(45))
BEGIN
   INSERT INTO programas_academicos (ProgAcad_Nombre)
   VALUES (UPPER(_nombre));
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.agregarSalon
DELIMITER //
CREATE PROCEDURE `agregarSalon`(IN _bloque_id int, IN _nombre_salon VARCHAR(45))
BEGIN
   INSERT INTO salones (Bloques_Bloque_ID, Salon_Nombre)
   VALUES (_bloque_id, UCASE(_nombre_salon));
END//
DELIMITER ;

-- Volcando estructura para tabla prueba-tecnica.asignar_asig_y_salones
CREATE TABLE IF NOT EXISTS `asignar_asig_y_salones` (
  `Asignaturas_Asig_ID` int NOT NULL,
  `Salones_Salon_ID` int NOT NULL,
  PRIMARY KEY (`Asignaturas_Asig_ID`,`Salones_Salon_ID`),
  KEY `fk_Asignaturas_has_Salones_Asignaturas1_idx` (`Asignaturas_Asig_ID`),
  KEY `fk_Asignaturas_has_Salones_Salones1_idx` (`Salones_Salon_ID`),
  CONSTRAINT `fk_Asignaturas_has_Salones_Asignaturas1` FOREIGN KEY (`Asignaturas_Asig_ID`) REFERENCES `asignaturas` (`Asig_ID`),
  CONSTRAINT `fk_Asignaturas_has_Salones_Salones1` FOREIGN KEY (`Salones_Salon_ID`) REFERENCES `salones` (`Salon_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.asignar_asig_y_salones: ~5 rows (aproximadamente)
INSERT IGNORE INTO `asignar_asig_y_salones` (`Asignaturas_Asig_ID`, `Salones_Salon_ID`) VALUES
	(1, 1),
	(2, 2),
	(5, 5),
	(5, 6),
	(6, 2);

-- Volcando estructura para tabla prueba-tecnica.asignar_docente_programa
CREATE TABLE IF NOT EXISTS `asignar_docente_programa` (
  `Programas_academicos_ProgAcad_ID` int NOT NULL,
  `Profesores_Profe_ID` int NOT NULL,
  PRIMARY KEY (`Programas_academicos_ProgAcad_ID`,`Profesores_Profe_ID`),
  KEY `fk_Programas_academicos_has_Profesores_Profesores1_idx` (`Profesores_Profe_ID`),
  KEY `fk_Programas_academicos_has_Profesores_Programas_academicos_idx` (`Programas_academicos_ProgAcad_ID`),
  CONSTRAINT `fk_Programas_academicos_has_Profesores_Profesores1` FOREIGN KEY (`Profesores_Profe_ID`) REFERENCES `profesores` (`Profe_ID`),
  CONSTRAINT `fk_Programas_academicos_has_Profesores_Programas_academicos1` FOREIGN KEY (`Programas_academicos_ProgAcad_ID`) REFERENCES `programas_academicos` (`ProgAcad_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.asignar_docente_programa: ~9 rows (aproximadamente)
INSERT IGNORE INTO `asignar_docente_programa` (`Programas_academicos_ProgAcad_ID`, `Profesores_Profe_ID`) VALUES
	(3, 1),
	(12, 1),
	(13, 2),
	(1, 4),
	(2, 4),
	(1, 5),
	(2, 5),
	(8, 5),
	(13, 5);

-- Volcando estructura para tabla prueba-tecnica.asignar_horario
CREATE TABLE IF NOT EXISTS `asignar_horario` (
  `Horarios_Horario_ID` int NOT NULL,
  `Asignaturas_Asig_ID` int NOT NULL,
  PRIMARY KEY (`Horarios_Horario_ID`,`Asignaturas_Asig_ID`),
  KEY `fk_Asignar_Horario_Asignaturas1_idx` (`Asignaturas_Asig_ID`),
  CONSTRAINT `fk_Asignar_Horario_Asignaturas1` FOREIGN KEY (`Asignaturas_Asig_ID`) REFERENCES `asignaturas` (`Asig_ID`),
  CONSTRAINT `fk_Asignar_Horario_Horarios1` FOREIGN KEY (`Horarios_Horario_ID`) REFERENCES `horarios` (`Horario_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.asignar_horario: ~8 rows (aproximadamente)
INSERT IGNORE INTO `asignar_horario` (`Horarios_Horario_ID`, `Asignaturas_Asig_ID`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 5),
	(6, 6),
	(7, 6);

-- Volcando estructura para tabla prueba-tecnica.asignaturas
CREATE TABLE IF NOT EXISTS `asignaturas` (
  `Asig_ID` int NOT NULL AUTO_INCREMENT,
  `Asig_nombre` varchar(45) DEFAULT NULL,
  `Profesores_Profe_ID` int NOT NULL,
  PRIMARY KEY (`Asig_ID`,`Profesores_Profe_ID`),
  KEY `fk_Asignaturas_Profesores1_idx` (`Profesores_Profe_ID`),
  CONSTRAINT `fk_Asignaturas_Profesores1` FOREIGN KEY (`Profesores_Profe_ID`) REFERENCES `profesores` (`Profe_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.asignaturas: ~11 rows (aproximadamente)
INSERT IGNORE INTO `asignaturas` (`Asig_ID`, `Asig_nombre`, `Profesores_Profe_ID`) VALUES
	(1, 'MATEMATICAS BASICAS', 1),
	(2, 'MATEMATICAS BASICAS', 1),
	(3, 'ALGORITMOS Y PROGRAMACION', 3),
	(4, 'ALGORITMOS 1', 5),
	(5, 'ALGORITMOS 2', 2),
	(6, 'BASES DE DATOS', 2),
	(7, 'REDES 1', 3),
	(8, 'REDES 2', 2),
	(9, 'INFORMATICA BASICA', 4),
	(10, 'EXCEL AVANZADO', 2),
	(11, 'PROGRAMACION NUMERICA', 5);

-- Volcando estructura para tabla prueba-tecnica.asign_prog_estud
CREATE TABLE IF NOT EXISTS `asign_prog_estud` (
  `ProgrAcade_ID` int NOT NULL AUTO_INCREMENT,
  `Estud_Estud_ID` int NOT NULL,
  PRIMARY KEY (`ProgrAcade_ID`,`Estud_Estud_ID`),
  KEY `fk_Programas_academicos_has_Estudiantes_Estudiantes1_idx` (`Estud_Estud_ID`),
  KEY `fk_Programas_academicos_has_Estudiantes_Programas_academico_idx` (`ProgrAcade_ID`),
  CONSTRAINT `fk_Programas_academicos_has_Estudiantes_Estudiantes1` FOREIGN KEY (`Estud_Estud_ID`) REFERENCES `estudiantes` (`Estud_ID`),
  CONSTRAINT `fk_Programas_academicos_has_Estudiantes_Programas_academicos` FOREIGN KEY (`ProgrAcade_ID`) REFERENCES `programas_academicos` (`ProgAcad_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.asign_prog_estud: ~20 rows (aproximadamente)
INSERT IGNORE INTO `asign_prog_estud` (`ProgrAcade_ID`, `Estud_Estud_ID`) VALUES
	(1, 1),
	(5, 2),
	(12, 3),
	(11, 4),
	(8, 5),
	(9, 6),
	(8, 7),
	(5, 8),
	(1, 9),
	(2, 10),
	(4, 11),
	(10, 12),
	(11, 13),
	(13, 14),
	(3, 15),
	(6, 16),
	(5, 17),
	(7, 18),
	(8, 19),
	(9, 20);

-- Volcando estructura para tabla prueba-tecnica.bloques
CREATE TABLE IF NOT EXISTS `bloques` (
  `Bloque_ID` int NOT NULL AUTO_INCREMENT,
  `Bloque_Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Bloque_ID`),
  UNIQUE KEY `Bloque_Nombre_UNIQUE` (`Bloque_Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.bloques: ~12 rows (aproximadamente)
INSERT IGNORE INTO `bloques` (`Bloque_ID`, `Bloque_Nombre`) VALUES
	(1, 'BLOQUE 1'),
	(11, 'BLOQUE 10'),
	(12, 'BLOQUE 11'),
	(13, 'BLOQUE 12'),
	(3, 'BLOQUE 2'),
	(4, 'BLOQUE 3'),
	(5, 'BLOQUE 4'),
	(6, 'BLOQUE 5'),
	(7, 'BLOQUE 6'),
	(8, 'BLOQUE 7'),
	(9, 'BLOQUE 8'),
	(10, 'BLOQUE 9');

-- Volcando estructura para tabla prueba-tecnica.clases
CREATE TABLE IF NOT EXISTS `clases` (
  `Estudiantes_Estud_ID` int NOT NULL,
  `Asignaturas_Asig_ID` int NOT NULL,
  PRIMARY KEY (`Estudiantes_Estud_ID`,`Asignaturas_Asig_ID`),
  KEY `fk_Estudiantes_has_Asignaturas_Estudiantes1_idx` (`Estudiantes_Estud_ID`),
  KEY `fk_Clases_Asignaturas1_idx` (`Asignaturas_Asig_ID`),
  CONSTRAINT `fk_Clases_Asignaturas1` FOREIGN KEY (`Asignaturas_Asig_ID`) REFERENCES `asignaturas` (`Asig_ID`),
  CONSTRAINT `fk_Estudiantes_has_Asignaturas_Estudiantes1` FOREIGN KEY (`Estudiantes_Estud_ID`) REFERENCES `estudiantes` (`Estud_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.clases: ~22 rows (aproximadamente)
INSERT IGNORE INTO `clases` (`Estudiantes_Estud_ID`, `Asignaturas_Asig_ID`) VALUES
	(1, 1),
	(2, 1),
	(2, 6),
	(3, 1),
	(3, 2),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 2),
	(10, 2),
	(11, 2),
	(12, 2),
	(13, 2),
	(14, 2),
	(15, 2),
	(16, 2),
	(17, 2),
	(18, 2),
	(19, 2),
	(20, 2);

-- Volcando estructura para procedimiento prueba-tecnica.eliminarAsignatura
DELIMITER //
CREATE PROCEDURE `eliminarAsignatura`(IN _id_asignatura INT)
BEGIN
   DELETE FROM asignaturas WHERE _id_asignatura = Asig_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarBloque
DELIMITER //
CREATE PROCEDURE `eliminarBloque`(IN _bloque_id INT)
BEGIN
   DELETE FROM bloques  WHERE Bloque_ID = _bloque_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarEstudiante
DELIMITER //
CREATE PROCEDURE `eliminarEstudiante`(IN _id_estudiante INT)
BEGIN
   DELETE FROM  estudiantes WHERE Estud_ID =_id_estudiante;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarHorario
DELIMITER //
CREATE PROCEDURE `eliminarHorario`( IN _horario_id INT)
BEGIN
  DELETE FROM `prueba-tecnica`.horarios WHERE _horario_id = Horario_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarProgramaAcademico
DELIMITER //
CREATE PROCEDURE `eliminarProgramaAcademico`(IN _programa_id INT)
BEGIN
   DELETE FROM programas_academicos WHERE _programa_id = ProgAcad_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarrClase
DELIMITER //
CREATE PROCEDURE `eliminarrClase`(IN _estudiante_id int, IN _id_asignatura int)
BEGIN
    DELETE FROM  clases WHERE Estudiantes_Estud_ID = _estudiante_id AND Asignaturas_Asig_ID = _id_asignatura ;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarSalon
DELIMITER //
CREATE PROCEDURE `eliminarSalon`(IN _salon_id INT)
BEGIN
   DELETE FROM salones WHERE Salon_ID = _salon_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminartDocente
DELIMITER //
CREATE PROCEDURE `eliminartDocente`(IN _docente_id INT)
BEGIN
   DELETE FROM profesores  WHERE _docente_id = Profe_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarVinculacionAsignaturasConSalones
DELIMITER //
CREATE PROCEDURE `eliminarVinculacionAsignaturasConSalones`(IN _asignatura_id int, IN _horario_salon int)
BEGIN
   DELETE FROM asignar_asig_y_salones WHERE Asignaturas_Asig_ID = _asignatura_id AND Salones_Salon_ID = _horario_salon;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarVinculacionDocenteProgra
DELIMITER //
CREATE PROCEDURE `eliminarVinculacionDocenteProgra`(IN _idDocente INT, IN _id_programa INT)
BEGIN
   DELETE FROM asignar_docente_programa WHERE _idDocente = Profesores_Profe_ID AND  Programas_academicos_ProgAcad_ID = _id_programa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarVinculacionHorarioConAsignatura
DELIMITER //
CREATE PROCEDURE `eliminarVinculacionHorarioConAsignatura`(IN _asignatura_id int, IN _horario_id int)
BEGIN
   DELETE FROM asignar_horario WHERE Asignaturas_Asig_ID = _asignatura_id AND Horarios_Horario_ID = _horario_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.eliminarVinculacionProgramaConEstudiante
DELIMITER //
CREATE PROCEDURE `eliminarVinculacionProgramaConEstudiante`(IN _id_prog_academico INT, IN _estudiante_id INT)
BEGIN
   DELETE FROM asign_prog_estud  WHERE ProgrAcade_ID = _id_prog_academico AND Estud_Estud_ID = _estudiante_id;
END//
DELIMITER ;

-- Volcando estructura para tabla prueba-tecnica.estudiantes
CREATE TABLE IF NOT EXISTS `estudiantes` (
  `Estud_ID` int NOT NULL AUTO_INCREMENT,
  `Estud_Nombres` varchar(30) NOT NULL,
  `Estud_Apellidos` varchar(30) NOT NULL,
  `Estud_Identificacion` varchar(25) NOT NULL,
  `Estud_correo` varchar(50) NOT NULL,
  PRIMARY KEY (`Estud_ID`),
  UNIQUE KEY `Estud_Nombres_UNIQUE` (`Estud_Nombres`,`Estud_Apellidos`),
  UNIQUE KEY `Estud_correo_UNIQUE` (`Estud_correo`),
  UNIQUE KEY `Estud_Identificacion_UNIQUE` (`Estud_Identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.estudiantes: ~20 rows (aproximadamente)
INSERT IGNORE INTO `estudiantes` (`Estud_ID`, `Estud_Nombres`, `Estud_Apellidos`, `Estud_Identificacion`, `Estud_correo`) VALUES
	(1, 'JUAN PABLO', 'HERNANDEZ VEGA', '1002569987', 'JPABLO98@CUC.EDU.CO'),
	(2, 'LUIS', 'CARRASCO VILLA', '1002569988', 'LUIS@CUC.EDU.CO'),
	(3, 'FERNANDO', 'CRISIEN BORRERO', '100258487', 'FERNANDO@CUC.EDU.CO'),
	(4, 'JOSE', 'HERNANDEX CAÑA', '1002569036', 'JOSE@CUC.EDU.CO'),
	(5, 'MARTIN', 'DE LA ROSA FUENTES', '25056569987', 'MARTIN@CUC.EDU.CO'),
	(6, 'ALFONSO', 'ZABALETA RODRIGUEZ', '2502569856', 'ALSONSO@CUC.EDU.CO'),
	(7, 'DEIVIS', 'BYSTAMENTE CABALLERO', '1002569678', 'DEIVIS@CUC.EDU.CO'),
	(8, 'ALFREDO', 'AGUAS VERBEL', '10025693456', 'ALFREDO@CUC.EDU.CO'),
	(9, 'KEVIN', 'CAÑAS AGUAS', '1002569123', 'KEVIN@CUC.EDU.CO'),
	(10, 'YONIER', 'MAURES AMARIZ', '10025198987', 'YONIER@CUC.EDU.CO'),
	(11, 'CRISTIAN', 'OLIVARES SANTOS', '560256972', 'CRISTIAN@CUC.EDU.CO'),
	(12, 'YOITIER', 'HERERA GUERRERO', '745699843', 'YOTIER@CUC.EDU.CO'),
	(13, 'LEONAR', 'OJEDA VILLA', '852569985', 'LEONAR@CUC.EDU.CO'),
	(14, 'ROBERTO', 'CABRERA ARISTISABAL', '456789432', 'ROBERTO@CUC.EDU.CO'),
	(15, 'JAVIER', 'CARRASCAL CABRERA', '105678965', 'JAVIER@CUC.EDU.CO'),
	(16, 'CARLOS', 'PITALUA MAURE', '600256987', 'CARLOS@CUC.EDU.CO'),
	(17, 'DANIEL', 'SANCHEZ GUERRERO', '2002569982', 'DANIEL@CUC.EDU.CO'),
	(18, 'NILSON', 'OLIVARES HERNANDEZ', '10025697654', 'NILSON98@CUC.EDU.CO'),
	(19, 'JANIER', 'OLIVEROS CAMARGO', '100223875', 'JANIER@CUC.EDU.CO'),
	(20, 'ERWIN', 'SARMIENTO PEREZ', '10579451657', 'ERWIN@CUC.EDU.CO');

-- Volcando estructura para tabla prueba-tecnica.horarios
CREATE TABLE IF NOT EXISTS `horarios` (
  `Horario_ID` int NOT NULL AUTO_INCREMENT,
  `Horario_Dia` varchar(10) NOT NULL,
  `Horario_Hora_Inicio` varchar(15) NOT NULL,
  `Horario_Hora_Fin` varchar(45) NOT NULL,
  PRIMARY KEY (`Horario_ID`),
  UNIQUE KEY `Horario_Dia_UNIQUE` (`Horario_Dia`,`Horario_Hora_Inicio`,`Horario_Hora_Fin`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.horarios: ~7 rows (aproximadamente)
INSERT IGNORE INTO `horarios` (`Horario_ID`, `Horario_Dia`, `Horario_Hora_Inicio`, `Horario_Hora_Fin`) VALUES
	(4, 'JUEVES', '8:30 AM', '11:30 AM'),
	(7, 'LUNES', '2:30 PM', '6:30 PM'),
	(1, 'LUNES', '8:30 AM', '11:30 AM'),
	(2, 'MARTES', '8:30 AM', '10:30 AM'),
	(3, 'MIERCOLES', '8:30 AM', '10:30 AM'),
	(6, 'SABADO', '8:30 AM', '9:30 AM'),
	(5, 'VIERNES', '8:30 AM', '10:00 AM');

-- Volcando estructura para procedimiento prueba-tecnica.modificarAsignatura
DELIMITER //
CREATE PROCEDURE `modificarAsignatura`(IN _nombre VARCHAR(30), IN _profe_id int, IN _id_asignatura INT)
BEGIN
   UPDATE asignaturas
   SET
       asig_nombre = UCASE(_nombre),
       profesores_profe_id = _profe_id
   WHERE _id_asignatura = Asig_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarBloque
DELIMITER //
CREATE PROCEDURE `modificarBloque`(IN _bloque_nombre  VARCHAR(45), IN _bloque_id INT)
BEGIN
   UPDATE bloques SET Bloque_Nombre = UCASE(_bloque_nombre)
   WHERE Bloque_ID = _bloque_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarClase
DELIMITER //
CREATE PROCEDURE `modificarClase`(IN _estudiante_id int, IN _id_asignatura int, IN _estudiante_id_act int, IN _id_asignatura_act int)
BEGIN
   UPDATE  clases SET
        Estudiantes_Estud_ID = _estudiante_id_act,
        Asignaturas_Asig_ID = _id_asignatura_act
   WHERE Estudiantes_Estud_ID = _estudiante_id AND Asignaturas_Asig_ID = _id_asignatura ;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarDocente
DELIMITER //
CREATE PROCEDURE `modificarDocente`(IN _nombres varchar(45), IN _apellidos varchar(45),
                                                      IN _identificacion varchar(45), IN _corrreo varchar(50), IN _docente_id INT)
BEGIN
   UPDATE profesores
   SET
       Profe_Nombres = UPPER(_nombres),
       Profe_Apellidos =  UPPER(_apellidos),
       Profe_Identificacion =  UPPER(_identificacion),
       Profe_correo =  UPPER(_corrreo)
    WHERE _docente_id = Profe_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarEstudiante
DELIMITER //
CREATE PROCEDURE `modificarEstudiante`(IN _nombre VARCHAR(30), IN _apellido VARCHAR(30), IN _identificacion VARCHAR(25), IN _correo VARCHAR(50), IN _id_estudiante INT)
BEGIN
   UPDATE estudiantes
   SET
       Estud_Nombres = UCASE(_nombre),
       Estud_Apellidos = UCASE(_apellido),
       Estud_Identificacion =  UCASE(_identificacion),
       Estud_correo = UCASE(_correo)
   WHERE Estud_ID =_id_estudiante;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarHorario
DELIMITER //
CREATE PROCEDURE `modificarHorario`(IN _dia VARCHAR(10), IN _hora_Inicio VARCHAR(15), IN _horario_Hora_Fin VARCHAR(15), IN _horario_id INT)
BEGIN
   UPDATE `prueba-tecnica`.horarios
   SET  Horario_Dia = UCASE(_dia),
       Horario_Hora_Inicio = UCASE(_hora_Inicio),
       Horario_Hora_Fin = UCASE(_horario_Hora_Fin)
   WHERE _horario_id = Horario_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarProgramaAcademico
DELIMITER //
CREATE PROCEDURE `modificarProgramaAcademico`(IN _nombre_programa VARCHAR(45), IN _programa_id INT)
BEGIN
   UPDATE programas_academicos
   SET
       ProgAcad_Nombre = UPPER(_nombre_programa)
    WHERE _programa_id = ProgAcad_ID;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarSalon
DELIMITER //
CREATE PROCEDURE `modificarSalon`(IN _bloque_id int, IN _nombre_salon VARCHAR(45), IN _salon_id INT)
BEGIN
   UPDATE salones SET Bloques_Bloque_ID = _bloque_id, Salon_Nombre = UCASE(_nombre_salon)
   WHERE Salon_ID = _salon_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarVinculacionAsignaturasConSalones
DELIMITER //
CREATE PROCEDURE `modificarVinculacionAsignaturasConSalones`(IN _asignatura_id int, IN _horario_salon int, IN _asignatura_id_act int, IN _horario_salon_act int)
BEGIN
   UPDATE asignar_asig_y_salones  SET Asignaturas_Asig_ID = _asignatura_id_act, Salones_Salon_ID = _horario_salon_act
   WHERE Asignaturas_Asig_ID = _asignatura_id AND Salones_Salon_ID = _horario_salon;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarVinculacionDocenteProgra
DELIMITER //
CREATE PROCEDURE `modificarVinculacionDocenteProgra`(IN _idDocente INT, IN _id_programa INT, IN _idDocente_act INT, IN _id_programa_act INT)
BEGIN
   UPDATE asignar_docente_programa
   SET
       Profesores_Profe_ID = _idDocente_act,
       Programas_academicos_ProgAcad_ID = _id_programa_act
    WHERE _idDocente = Profesores_Profe_ID AND  Programas_academicos_ProgAcad_ID = _id_programa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarVinculacionHorarioConAsignatura
DELIMITER //
CREATE PROCEDURE `modificarVinculacionHorarioConAsignatura`(IN _asignatura_id int, IN _horario_id int, IN _asignatura_id_act int, IN _horario_id_act int)
BEGIN
   UPDATE asignar_horario SET Asignaturas_Asig_ID = _asignatura_id_act, Horarios_Horario_ID = _horario_id_act
   WHERE Asignaturas_Asig_ID = _asignatura_id AND Horarios_Horario_ID = _horario_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.modificarVinculacionProgramaConEstudiante
DELIMITER //
CREATE PROCEDURE `modificarVinculacionProgramaConEstudiante`(IN _id_prog_academico_ant INT, IN _id_prog_academico_act INT, IN _estudianteid__ant int, IN _estudiante_id_act INT)
BEGIN
   UPDATE asign_prog_estud SET
    ProgrAcade_ID = _id_prog_academico_act,
    Estud_Estud_ID =  _estudiante_id_act
   WHERE ProgrAcade_ID = _id_prog_academico_ant AND Estud_Estud_ID = _estudianteid__ant;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.mostraAsignaturasDeUnProfesor
DELIMITER //
CREATE PROCEDURE `mostraAsignaturasDeUnProfesor`(IN _id_profesor INT)
BEGIN
   SELECT p.Profe_Nombres, p.Profe_Apellidos, p.Profe_Identificacion, a.Asig_nombre FROM profesores p JOIN asignaturas a on a.Profesores_Profe_ID = p.Profe_ID WHERE Profe_ID = _id_profesor ;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.mostrarDatosCompletosDeUnProfesor
DELIMITER //
CREATE PROCEDURE `mostrarDatosCompletosDeUnProfesor`(IN _id_profesor INT)
BEGIN
   SELECT
          p.Profe_Nombres, p.Profe_Apellidos, p.Profe_Identificacion,
          a.Asig_nombre,
          pa.ProgAcad_Nombre,
          hr.Horario_Dia, hr.Horario_Hora_Inicio, hr.Horario_Hora_Fin,
          s.Salon_Nombre, b.Bloque_Nombre
   FROM profesores p
       JOIN asignaturas a on a.Profesores_Profe_ID = p.Profe_ID
       JOIN asignar_docente_programa adp on p.Profe_ID = adp.Profesores_Profe_ID
       JOIN programas_academicos pa on adp.Programas_academicos_ProgAcad_ID = pa.ProgAcad_ID
       JOIN asignar_horario ah on a.Asig_ID = ah.Asignaturas_Asig_ID
       JOIN Horarios  hr on ah.Horarios_Horario_ID = hr.Horario_ID
       JOIN asignar_asig_y_salones  asigna on a.Asig_ID = asigna.Asignaturas_Asig_ID
       JOIN salones s on asigna.Salones_Salon_ID = s.Salon_ID
       JOIN bloques b on s.Bloques_Bloque_ID = b.Bloque_ID

    WHERE Profe_ID = _id_profesor ;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.mostrarDatosDeTodosLosEstudiantes
DELIMITER //
CREATE PROCEDURE `mostrarDatosDeTodosLosEstudiantes`()
BEGIN
   SELECT
          est.Estud_Identificacion, est.Estud_Nombres, est.Estud_Apellidos, est.Estud_correo,
          pa.ProgAcad_Nombre, a.Asig_nombre,
          hr.Horario_Dia, hr.Horario_Hora_Inicio, hr.Horario_Hora_Fin,
          s.Salon_Nombre, b.Bloque_Nombre
   FROM estudiantes est
       JOIN clases cl on est.Estud_ID = cl.Estudiantes_Estud_ID
        JOIN asign_prog_estud ape on est.Estud_ID = ape.Estud_Estud_ID
        join programas_academicos pa on ape.ProgrAcade_ID = pa.ProgAcad_ID
       JOIN asignaturas a on cl.Asignaturas_Asig_ID = a.Asig_ID
       join profesores p on a.Profesores_Profe_ID = p.Profe_ID
       JOIN asignar_horario ah on a.Asig_ID = ah.Asignaturas_Asig_ID
       JOIN Horarios  hr on ah.Horarios_Horario_ID = hr.Horario_ID
       JOIN asignar_asig_y_salones  asigna on a.Asig_ID = asigna.Asignaturas_Asig_ID
       JOIN salones s on asigna.Salones_Salon_ID = s.Salon_ID
       JOIN bloques b on s.Bloques_Bloque_ID = b.Bloque_ID;

END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.mostrarProfesores
DELIMITER //
CREATE PROCEDURE `mostrarProfesores`()
BEGIN
   SELECT * FROM profesores;
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.mostrarProgramasAcademicos
DELIMITER //
CREATE PROCEDURE `mostrarProgramasAcademicos`(IN _id_estudiante INT)
BEGIN
   SELECT ProgAcad_Nombre FROM programas_academicos  ;
END//
DELIMITER ;

-- Volcando estructura para tabla prueba-tecnica.profesores
CREATE TABLE IF NOT EXISTS `profesores` (
  `Profe_ID` int NOT NULL AUTO_INCREMENT,
  `Profe_Nombres` varchar(45) NOT NULL,
  `Profe_Apellidos` varchar(45) NOT NULL,
  `Profe_Identificacion` varchar(45) NOT NULL,
  `Profe_correo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Profe_ID`),
  UNIQUE KEY `Profe_Nombres_UNIQUE` (`Profe_Nombres`,`Profe_Apellidos`),
  UNIQUE KEY `Profe_Identificacion_UNIQUE` (`Profe_Identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.profesores: ~6 rows (aproximadamente)
INSERT IGNORE INTO `profesores` (`Profe_ID`, `Profe_Nombres`, `Profe_Apellidos`, `Profe_Identificacion`, `Profe_correo`) VALUES
	(1, 'DEIBER DUBAN', 'OLIVARES OLIVARES', '1007894997', 'DOLIVARE5@CUC.EDU.CO'),
	(2, 'JOSE AGUIRRE', 'MALDONADO PEREZ', '10078989765', 'JOSE@CUC.EDU.CO'),
	(3, 'RAMON', 'ACOSTA ARZIRIA', '224569976', 'RAMON@CUC.EDU.CO'),
	(4, 'LUIS MIGUEL', 'OREJUELA SANCHEZ', '22456997876', 'LUIS@CUC.EDU.CO'),
	(5, 'FELIPE', 'OLIVEROS GUERRERO', '1234567890', 'FELIPE@CUC.EDU.CO'),
	(8, 'EDUADO', 'RIVERA GONZALES', '198235563356', 'EDUARDO@CUC.EDU.CO'),
	(9, 'LUISA', 'JIMENEZ', '107667533', 'LUIS@CUC.EDU.CO');

-- Volcando estructura para tabla prueba-tecnica.programas_academicos
CREATE TABLE IF NOT EXISTS `programas_academicos` (
  `ProgAcad_ID` int NOT NULL AUTO_INCREMENT,
  `ProgAcad_Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`ProgAcad_ID`),
  UNIQUE KEY `ProgAcad_Nombre_UNIQUE` (`ProgAcad_Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.programas_academicos: ~13 rows (aproximadamente)
INSERT IGNORE INTO `programas_academicos` (`ProgAcad_ID`, `ProgAcad_Nombre`) VALUES
	(6, 'ADMINISTRACION DE EMPRESAS'),
	(1, 'ARQUITECTURA'),
	(4, 'CONTADURIA'),
	(3, 'DERECHO'),
	(7, 'INGENIERIA AGROINDUSTRIAL'),
	(8, 'INGENIERIA AMBIENTAL'),
	(12, 'INGENIERIA CIVIL'),
	(13, 'INGENIERIA DE SISTEMAS'),
	(10, 'INGENIERIA ELECTRICA'),
	(9, 'INGENIERIA ELECTRONICA'),
	(11, 'INGENIERIA MECATRONICA'),
	(5, 'NEGOCIOS INTERNACIONALES'),
	(2, 'PSICOLOGIA');

-- Volcando estructura para tabla prueba-tecnica.salones
CREATE TABLE IF NOT EXISTS `salones` (
  `Salon_ID` int NOT NULL AUTO_INCREMENT,
  `Bloques_Bloque_ID` int NOT NULL,
  `Salon_Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Salon_ID`,`Bloques_Bloque_ID`),
  UNIQUE KEY `Salon_Nombre_UNIQUE` (`Salon_Nombre`),
  KEY `fk_Salones_Bloques1_idx` (`Bloques_Bloque_ID`),
  CONSTRAINT `fk_Salones_Bloques1` FOREIGN KEY (`Bloques_Bloque_ID`) REFERENCES `bloques` (`Bloque_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla prueba-tecnica.salones: ~4 rows (aproximadamente)
INSERT IGNORE INTO `salones` (`Salon_ID`, `Bloques_Bloque_ID`, `Salon_Nombre`) VALUES
	(1, 11, 'SALA DE COMPUTO 1'),
	(2, 11, 'SALA DE COMPUTO 2'),
	(7, 3, 'SALA DE COMPUTO 3'),
	(5, 11, 'SALA DE COMPUTO 4'),
	(6, 10, 'SALON 1005');

-- Volcando estructura para procedimiento prueba-tecnica.vincularAsignaturasConSalones
DELIMITER //
CREATE PROCEDURE `vincularAsignaturasConSalones`(IN _asignatura_id int, IN _horario_salon int)
BEGIN
   INSERT INTO asignar_asig_y_salones (Asignaturas_Asig_ID, Salones_Salon_ID)
   VALUES (_asignatura_id, _horario_salon);
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.vincularDocenteConPrograma
DELIMITER //
CREATE PROCEDURE `vincularDocenteConPrograma`(IN _idDocente INT, IN _id_programa INT)
BEGIN
   INSERT INTO asignar_docente_programa (Programas_academicos_ProgAcad_ID, Profesores_Profe_ID)
   VALUES (_id_programa, _idDocente);
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.vincularHorarioConAsignatura
DELIMITER //
CREATE PROCEDURE `vincularHorarioConAsignatura`(IN _asignatura_id int, IN _horario_id int)
BEGIN
   INSERT INTO asignar_horario (Asignaturas_Asig_ID, Horarios_Horario_ID)
   VALUES (_asignatura_id, _horario_id);
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba-tecnica.vincularProgramaConEstudiante
DELIMITER //
CREATE PROCEDURE `vincularProgramaConEstudiante`(IN _id_prog_academico INT, IN _estudiante_id int)
BEGIN
   INSERT INTO asign_prog_estud (ProgrAcade_ID, Estud_Estud_ID)
   VALUES (_id_prog_academico, _estudiante_id);
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
