-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-11-2020 a las 21:15:04
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_biblio_escolar`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarAutor` (IN `Id` INT, IN `Nombre` VARCHAR(100))  BEGIN
IF NOT EXISTS (SELECT * FROM autor WHERE Id_autor = Id) THEN
	INSERT INTO autor (Id_autor, Nombre_autor)
	VALUES (Id, Nombre);
ELSE 
	UPDATE autor SET 
		Nombre_autor = Nombre
	WHERE Id_autor = Id;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarEditorial` (IN `Id` INT, IN `Nombre` VARCHAR(50))  BEGIN 
IF NOT EXISTS (SELECT * FROM editorial WHERE Id_editorial = Id) THEN 
	INSERT INTO editorial (Id_editorial, Nombre_editorial) 
	VALUES (Id, Nombre); 
ELSE 
	UPDATE editorial SET Nombre_editorial = Nombre WHERE Id_editorial = Id; 
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarEspecialidad` (IN `Id` INT, IN `Nombre` VARCHAR(50))  BEGIN 
IF NOT EXISTS (SELECT * FROM especialidad WHERE Id_especialidad = Id) THEN 
	INSERT INTO especialidad (Id_especialidad, Nombre_especialidad) 
	VALUES (Id, Nombre); 
ELSE 
	UPDATE especialidad SET Nombre_especialidad = Nombre WHERE Id_especialidad = Id;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarLibro` (IN `_Titulo` VARCHAR(100), `_ISBN` VARCHAR(20), IN `_Especialidad` INT, IN `_Editorial` INT, IN `_Autor` INT)  BEGIN
IF NOT EXISTS (SELECT * FROM libro WHERE ISBN = _ISBN) THEN
	INSERT INTO libro (Titulo, ISBN, Especialidad , Editorial , Autor)
	VALUES (_Titulo, _ISBN, _Especialidad, _Editorial, _Autor);
ELSE  
	UPDATE libro SET 
		Titulo = _Titulo,
		ISBN = _ISBN,
		Especialidad = _Especialidad,
		Editorial = _Editorial,
		Autor = _Autor
	WHERE ISBN = _ISBN;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarPrestamo` (IN `_Id` INT, IN `_Libro` INT, IN `_Usuario` INT, IN `_Fecha` DATE, IN `_Fin` DATE)  BEGIN
IF NOT EXISTS (SELECT * FROM prestamos WHERE Id_prestamo = _Id) THEN 
	INSERT INTO prestamos (Id_prestamo, Libro, Usuario, FecPrestamo, FecDevolucion)
	VALUES (_Id, _Libro, _Usuario, _Fecha, _Fin);
ELSE 
	UPDATE prestamos SET 
		Libro = _Libro, 
		Usuario = _Usuario,
		FecPrestamo = _Fecha
	WHERE Id_prestamo = _Id;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarUsuario` (IN `_Id` INT, IN `_Nombre` VARCHAR(100), IN `_Mail` VARCHAR(50), IN `_Direccion` VARCHAR(100), IN `_Telefono` INT)  BEGIN								 
IF NOT EXISTS (SELECT * FROM usuario WHERE Id_usuario = _Id) THEN
	INSERT INTO usuario (Id_usuario , Nombre_usuario, Mail, Direccion, Telefono)
	VALUES (_Id, _Nombre, _Mail, _Direccion, _Telefono);
ELSE  
	UPDATE usuario SET 
		Nombre_usuario = _Nombre, 
		Mail = _Mail, 
		Direccion = _Direccion,
		Telefono = _Telefono
	WHERE Id_usuario = _Id;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaAutor` ()  SELECT * FROM autor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaEditorial` ()  SELECT * FROM editorial$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaEspecialidad` ()  SELECT * FROM especialidad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaLibro` ()  SELECT * FROM libro$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaPrestamos` ()  SELECT pres.id_prestamo, lib.titulo, usu.nombre_usuario, fecprestamo, fecdevolucion  FROM prestamos pres
	inner join libro lib on lib.id_libro = pres.libro
	inner join usuario usu on usu.id_usuario = pres.usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaUsuario` ()  SELECT * FROM usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminaAutor` (IN `_Id` INT)  BEGIN 
IF EXISTS (SELECT * FROM autor WHERE Id_autor = _Id) THEN 
	DELETE FROM autor WHERE Id_autor = _Id; 
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminaEditorial` (IN `_Id` INT)  BEGIN 
IF EXISTS (SELECT * FROM editorial WHERE Id_editorial = _Id) THEN 
	DELETE FROM editorial WHERE Id_editorial = _Id; 
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminaEspecialidad` (IN `_Id` INT)  BEGIN 
IF EXISTS (SELECT * FROM especialidad WHERE Id_especialidad = _Id) THEN 
	DELETE FROM especialidad WHERE Id_especialidad = _Id; 
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminaLibro` (IN `_Id` INT)  BEGIN 
IF EXISTS (SELECT * FROM libro WHERE Id_libro = _Id) THEN 
	DELETE FROM libro WHERE Id_libro = _Id; 
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminaPrestamos` (IN `_Id` INT)  BEGIN 
IF EXISTS (SELECT * FROM prestamos WHERE Id_prestamo = _Id) THEN 
	DELETE FROM prestamos WHERE Id_prestamo = _Id; 
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminaUsuario` (IN `_Id` INT)  BEGIN 
IF EXISTS (SELECT * FROM usuario WHERE Id_usuario = _Id) THEN 
	DELETE FROM usuario WHERE Id_usuario = _Id; 
END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `marcaDevolucion` (IN `_Id` INT, IN `_Fecha` DATE)  BEGIN
IF EXISTS (SELECT * FROM prestamos WHERE Id_prestamo = _Id) THEN
	UPDATE prestamos SET 
		FecDevolucion = _Fecha
	WHERE Id_prestamo = _Id;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `Id_autor` int(11) NOT NULL,
  `Nombre_autor` varchar(100) COLLATE utf32_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `editorial`
--

CREATE TABLE `editorial` (
  `Id_editorial` int(11) NOT NULL,
  `Nombre_editorial` varchar(50) COLLATE utf32_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `Id_especialidad` int(11) NOT NULL,
  `Nombre_especialidad` varchar(50) COLLATE utf32_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `Id_libro` int(11) NOT NULL,
  `Titulo` varchar(100) COLLATE utf32_spanish_ci NOT NULL,
  `ISBN` varchar(20) COLLATE utf32_spanish_ci DEFAULT NULL,
  `Especialidad` int(11) NOT NULL,
  `Editorial` int(11) NOT NULL,
  `Autor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `Id_prestamo` int(11) NOT NULL,
  `Libro` int(11) NOT NULL,
  `Usuario` int(11) NOT NULL,
  `FecPrestamo` date NOT NULL DEFAULT current_timestamp(),
  `FecDevolucion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `Id_usuario` int(11) NOT NULL,
  `Nombre_usuario` varchar(100) COLLATE utf32_spanish_ci NOT NULL,
  `Mail` varchar(50) COLLATE utf32_spanish_ci DEFAULT NULL,
  `Direccion` varchar(100) COLLATE utf32_spanish_ci DEFAULT NULL,
  `Telefono` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`Id_autor`);

--
-- Indices de la tabla `editorial`
--
ALTER TABLE `editorial`
  ADD PRIMARY KEY (`Id_editorial`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`Id_especialidad`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`Id_libro`),
  ADD KEY `libro_especialidad` (`Especialidad`),
  ADD KEY `libro_editorial` (`Editorial`),
  ADD KEY `libro_autor` (`Autor`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`Id_prestamo`),
  ADD KEY `prestamos_libro` (`Libro`),
  ADD KEY `prestamos_usuario` (`Usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`Id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autor`
--
ALTER TABLE `autor`
  MODIFY `Id_autor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `editorial`
--
ALTER TABLE `editorial`
  MODIFY `Id_editorial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `Id_especialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `libro`
--
ALTER TABLE `libro`
  MODIFY `Id_libro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `Id_prestamo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `Id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `libro`
--
ALTER TABLE `libro`
  ADD CONSTRAINT `libro_autor` FOREIGN KEY (`Autor`) REFERENCES `autor` (`Id_autor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `libro_editorial` FOREIGN KEY (`Editorial`) REFERENCES `editorial` (`Id_editorial`) ON UPDATE CASCADE,
  ADD CONSTRAINT `libro_especialidad` FOREIGN KEY (`Especialidad`) REFERENCES `especialidad` (`Id_especialidad`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `prestamos_libro` FOREIGN KEY (`Libro`) REFERENCES `libro` (`Id_libro`) ON UPDATE CASCADE,
  ADD CONSTRAINT `prestamos_usuario` FOREIGN KEY (`Usuario`) REFERENCES `usuario` (`Id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
