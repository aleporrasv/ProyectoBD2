-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-11-2017 a las 20:42:18
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `amigosecreto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amigos`
--

CREATE TABLE `amigos` (
  `idUsuario1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `idUsuario2` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `aceptado` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `amigos`
--

INSERT INTO `amigos` (`idUsuario1`, `idUsuario2`, `aceptado`, `created_at`, `updated_at`) VALUES
('amatson', 'gpmonico', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amatson', 'oacastillejo', 0, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amporras', 'amventura', 1, '2017-10-16 07:57:26', '2017-10-16 16:52:14'),
('jazacarias', 'amporras', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jazacarias', 'jdorive', NULL, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jcsanchez', 'amatson', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jdorive', 'amporras', 0, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jdorive', 'oacastillejo', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('oacastillejo', 'amventura', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('vmprado', 'amventura', NULL, '2017-10-16 07:50:50', '2017-10-16 07:50:50'),
('vmprado', 'gpmonico', 1, '2017-10-16 07:49:27', '2017-10-16 08:11:38'),
('vmprado', 'jazacarias', 0, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('vmprado', 'jdorive', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00');

--
-- Disparadores `amigos`
--
DELIMITER $$
CREATE TRIGGER `checkIfExistsAmigo` BEFORE DELETE ON `amigos` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(*) into aux
FROM amigos
WHERE amigos.idUsuario1 = old.idUsuario1 AND
		amigos.idUsuario2 = old.idUsuario2;
IF aux = 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: Esa amistad no existe!!!';
end IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `comprobarAmigo` BEFORE INSERT ON `amigos` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(*) into aux
FROM amigos
WHERE amigos.idUsuario1 = new.idUsuario1 AND
		amigos.idUsuario2 = new.idUsuario2;
IF aux > 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ERROR: El amigo  ya existe!';
end IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `idGrupo` int(10) UNSIGNED NOT NULL,
  `idAdmin` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `idTipoGrupo` int(10) UNSIGNED NOT NULL,
  `nombreGrupo` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `precioMax` double(8,2) DEFAULT NULL,
  `precioMin` double(8,2) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `sorteo` tinyint(1) DEFAULT NULL,
  `fintercambio` date NOT NULL,
  `direccion` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`idGrupo`, `idAdmin`, `idTipoGrupo`, `nombreGrupo`, `precioMax`, `precioMin`, `estado`, `sorteo`, `fintercambio`, `direccion`, `created_at`, `updated_at`) VALUES
(1, 'amporras', 1, 'Navidad', 5.00, 10.00, 1, 1, '2017-10-28', 'casa de Cosme', '2017-10-15 14:52:27', '2017-10-15 14:52:27'),
(2, 'amporras', 2, 'Navidad Resmasterizada', 0.00, 12.00, 0, 0, '2017-12-24', 'En algun lugar', '2017-10-15 14:53:44', '2017-10-15 14:53:44'),
(3, 'amatson', 1, 'Lacritax', 0.00, 2.00, 1, NULL, '2017-11-25', 'El guamo', '2017-10-15 14:55:00', '2017-10-15 14:55:00');

--
-- Disparadores `grupo`
--
DELIMITER $$
CREATE TRIGGER `checkIfExistsGrupo` BEFORE DELETE ON `grupo` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(*) into aux
FROM grupo
WHERE grupo.idGrupo = old.idGrupo;
IF aux = 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: El Grupo no existe!!!';
end IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `comprobarGrupo` BEFORE INSERT ON `grupo` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(grupo.id) into aux
FROM grupo
WHERE grupo.idGrupo = new.idGrupo;
IF aux > 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ERROR: El ya existe!';
end IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1),
('2017_10_12_144937_amigos', 2),
('2017_10_12_145049_TipoDeGrupo', 2),
('2017_10_12_145235_TipoTienda', 2),
('2017_10_12_145334_TipoProducto', 2),
('2017_10_12_145217_Tienda', 3),
('2017_10_12_145320_Producto', 3),
('2017_10_12_145258_TiendaFav', 4),
('2017_10_12_145434_ProductoFav', 5),
('2017_10_12_145017_Grupo', 6),
('2017_10_12_145458_Productos_X_Tienda', 6),
('2017_10_12_145117_UsuariosDeGrupo', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(10) UNSIGNED NOT NULL,
  `idTipoProducto` int(10) UNSIGNED NOT NULL,
  `nombreProducto` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `idTipoProducto`, `nombreProducto`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 1, 'Russell', 'Camisa Deportiva modelo R58', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(2, 3, 'JuniorBot', 'Robot aspiradora en forma de perro', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(3, 1, 'Raqueta Modesta', 'Raqueta de tenis Marca Modesta modelo 12e', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(4, 1, 'Sudadedera 43ds3S', 'Sudaderas marca Shyann ', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(5, 2, 'Nicholaus', 'Vestido tipo coctel diseñado por Nicholaus R.', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(6, 3, 'Disco Duro Externo 1GB', 'Memoria portatil de 1GB ', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(7, 1, 'Zapatos Olen24', 'Zapatos para trotar Marca Olen Modelo r4s2 ', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(8, 3, 'Lillian', 'Esposa Robot', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(9, 3, 'Kamren', 'Software de asistente personal', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(10, 3, 'Travis', 'Software de asistencia personal Stark', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(11, 2, 'Cartera Coco', 'Cartera marca Coco modelo 34r', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(12, 2, 'Franela star wors', 'Franela del personaje yonda de la famosa serie star wors ', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(13, 3, 'Pendrive 4gb', 'Pendrive marca Acme de 4gb', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(14, 1, 'Tacos 43dc4', 'Tacos de futbol para hombres marca Naike modelo 43dc4', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(15, 2, 'Traje de baño Lillie13', 'Traje de baño Lillie para damas modelo 13Ll3', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(16, 2, 'Sueter Mekhi', 'Sueter estampado del diseñador Mekhi ', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(17, 3, 'Antivirus Savanah', 'Version Full de la mas reciente version 3.54 del antirivirus Savanah', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(18, 3, 'Mouse Aaron', 'Mouse inalambrico Aaron ', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(19, 3, 'Teclado Marjory', 'Teclado Gamer marca Marjory', '2017-10-15 01:10:51', '2017-10-15 01:10:51'),
(20, 1, 'Flotador El Salvador', 'Conjunto de flotadores inflables para niños y niñas', '2017-10-15 01:10:51', '2017-10-15 01:10:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productofav`
--

CREATE TABLE `productofav` (
  `idUsuario` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `idProducto` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `productofav`
--

INSERT INTO `productofav` (`idUsuario`, `idProducto`, `created_at`, `updated_at`) VALUES
('amatson', 2, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amatson', 14, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amatson', 18, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amporras', 11, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amporras', 15, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amventura', 6, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amventura', 12, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('gpmonico', 4, '2017-10-15 05:47:05', '2017-10-15 05:47:05'),
('gpmonico', 9, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('gpmonico', 13, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jazacarias', 19, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jcsanchez', 19, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jdorive', 14, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('oacastillejo', 17, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('vmprado', 4, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('vmprado', 10, '2017-10-16 07:32:18', '2017-10-16 07:32:18');

--
-- Disparadores `productofav`
--
DELIMITER $$
CREATE TRIGGER `checkIfExistsProductoFav` BEFORE DELETE ON `productofav` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(*) into aux
FROM productofav
WHERE productofav.idProducto = old.idProducto AND
		productofav.idUsuario = old.IdUsuario;
IF aux = 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: el Producto no existe!!!';
end IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `comprobarProductoFav` BEFORE INSERT ON `productofav` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(*) into aux
FROM productofav
WHERE productofav.idUsuario = new.idUsuario AND
		productofav.idProducto = new.idProducto;
IF aux > 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El producto ya esta en sus favoritos';
end IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_x_tienda`
--

CREATE TABLE `productos_x_tienda` (
  `idProducto` int(10) UNSIGNED NOT NULL,
  `idTienda` int(10) UNSIGNED NOT NULL,
  `precio` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `productos_x_tienda`
--

INSERT INTO `productos_x_tienda` (`idProducto`, `idTienda`, `precio`, `created_at`, `updated_at`) VALUES
(2, 19, 6, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(4, 10, 9, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(5, 1, 1, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(5, 11, 9, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(6, 3, 6, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(6, 12, 6, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(6, 14, 4, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(7, 13, 8, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(7, 14, 7, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(8, 2, 3, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(8, 10, 9, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(9, 19, 9, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(10, 9, 1, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(11, 4, 4, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(11, 5, 6, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(13, 8, 8, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(15, 12, 3, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(15, 18, 3, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(16, 13, 2, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(17, 10, 4, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(18, 19, 7, '2017-10-15 02:10:29', '2017-10-15 02:10:29'),
(19, 4, 9, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(19, 9, 6, '2017-10-15 02:10:28', '2017-10-15 02:10:28'),
(20, 1, 4, '2017-10-15 02:10:29', '2017-10-15 02:10:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tienda`
--

CREATE TABLE `tienda` (
  `idTienda` int(10) UNSIGNED NOT NULL,
  `nombreTienda` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `idTipoTienda` int(10) UNSIGNED NOT NULL,
  `direccion` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tienda`
--

INSERT INTO `tienda` (`idTienda`, `nombreTienda`, `idTipoTienda`, `direccion`, `created_at`, `updated_at`) VALUES
(1, 'HP', 3, '145 Francesco Springs\nErdmanfort, MA 76747', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(2, 'El turquito', 3, '31138 Witting Walk\nLake Unique, MD 22351-2306', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(3, 'Pocholin', 2, '84408 Jermey Knoll Suite 449\nJayburgh, IL 23292', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(4, 'Adidos', 1, '18781 Verla Plaza\nSchultzfort, MN 34365-9298', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(5, 'Gorditas', 2, '4063 Marvin Street Apt. 121\nWest Bobbie, CT 37972-2092', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(6, 'Flaquitas', 2, '835 Trantow Stream\nSouth Kassandramouth, AZ 77924-6263', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(7, 'Inversiones Solar', 3, '95352 Luz Pines\nDeliastad, KS 54793', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(8, 'Naike', 1, '9158 Jacobi Valleys\nEast Kaciview, NY 70433-0054', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(9, 'Leopardo', 1, '7140 Hettinger Camp Suite 140\nSouth Emmetside, ID 40647', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(10, 'Sudafrica Sports', 1, '56869 Bartell Lodge\nSchusterfort, CT 62607-4001', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(11, 'Inversiones Nichole ', 2, '7230 Gutmann Extensions\nNew Florenciomouth, MO 10215-0008', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(12, 'Perolero', 2, '951 Rosie Ramp\nCassinview, NY 91524-4005', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(13, 'Phillips tecnology', 3, '799 Konopelski Mall\nWest Ari, HI 41026-5751', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(14, 'Ardidos', 1, '3443 Jayden Mountain\nMatttown, FL 23531', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(15, 'Nique', 1, '17259 Stracke Mills Suite 381\nFabianport, KY 82829', '2017-10-15 01:10:15', '2017-10-15 01:10:15'),
(16, 'Chuito World', 3, '926 Moen Lights\nHudsonside, NM 19156-1901', '2017-10-15 01:10:16', '2017-10-15 01:10:16'),
(17, 'Sifrinitos', 2, '4293 Lesley Mills Suite 042\nSelenaberg, WV 60234-9214', '2017-10-15 01:10:16', '2017-10-15 01:10:16'),
(18, 'Todo a mil', 2, '4910 Kemmer Estates\nBusterfort, LA 31971', '2017-10-15 01:10:16', '2017-10-15 01:10:16'),
(19, 'Todo a dos mil', 2, '2868 Klein Trafficway\nRutherfordville, MA 30834', '2017-10-15 01:10:16', '2017-10-15 01:10:16'),
(20, 'Pumita', 1, '5815 Connie Knolls\nLake Cesar, MA 94569', '2017-10-15 01:10:16', '2017-10-15 01:10:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiendafav`
--

CREATE TABLE `tiendafav` (
  `idUsuario` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `idTienda` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tiendafav`
--

INSERT INTO `tiendafav` (`idUsuario`, `idTienda`, `created_at`, `updated_at`) VALUES
('amatson', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amatson', 4, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amporras', 5, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amporras', 6, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amventura', 13, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('amventura', 18, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('gpmonico', 5, '2017-10-15 04:21:51', '2017-10-15 04:21:51'),
('gpmonico', 10, '2017-10-15 04:21:57', '2017-10-15 04:21:57'),
('gpmonico', 14, '2017-10-15 04:27:35', '2017-10-15 04:27:35'),
('gpmonico', 17, '2017-10-15 04:21:54', '2017-10-15 04:21:54'),
('gpmonico', 18, '2017-10-15 05:13:02', '2017-10-15 05:13:02'),
('jazacarias', 4, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('jcsanchez', 16, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('oacastillejo', 10, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('vmprado', 2, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
('vmprado', 4, '2017-10-16 07:32:14', '2017-10-16 07:32:14');

--
-- Disparadores `tiendafav`
--
DELIMITER $$
CREATE TRIGGER `checkIfExistsTiendaFav` BEFORE DELETE ON `tiendafav` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(*) into aux
FROM tiendafav
WHERE tiendafav.idTienda = old.idTienda AND
		tiendafav.idUsuario = old.IdUsuario;
IF aux = 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: La tienda no existe!!!';
end IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `comprobarTiendaFav` BEFORE INSERT ON `tiendafav` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(*) into aux
FROM tiendafav
WHERE tiendafav.idUsuario = new.idUsuario AND
		tiendafav.idTienda = new.idTienda;
IF aux > 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La Tienda ya esta en sus favoritas';
end IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoproducto`
--

CREATE TABLE `tipoproducto` (
  `idTipoProducto` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tipoproducto`
--

INSERT INTO `tipoproducto` (`idTipoProducto`, `tipo`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'Articulos deportivos', 'Preda u Objeto para hacer deportes', '2017-10-15 01:10:13', '2017-10-15 01:10:13'),
(2, 'Ropa', 'Prenda de vestir', '2017-10-15 01:10:13', '2017-10-15 01:10:13'),
(3, 'Tecnologia', 'Objeto electronico', '2017-10-15 01:10:13', '2017-10-15 01:10:13'),
(4, 'Art. Deportivos Us.', 'Articulos deportivos usados', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(5, 'Ropa de niños', 'Prenda de vestir', '2017-10-15 01:10:50', '2017-10-15 01:10:50'),
(6, 'Electrodomesticos', 'Objeto electronico', '2017-10-15 01:10:50', '2017-10-15 01:10:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposdegrupo`
--

CREATE TABLE `tiposdegrupo` (
  `idTipoGrupo` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tiposdegrupo`
--

INSERT INTO `tiposdegrupo` (`idTipoGrupo`, `tipo`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'Clasico', 'Se pueden ver los datos de la persona a la cual regalar', '2017-10-15 14:49:59', '2017-10-15 14:49:59'),
(2, 'Secreto', 'Solo se puede ver los favoritos de la persona a regalar', '2017-10-15 14:50:52', '2017-10-15 14:50:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipotienda`
--

CREATE TABLE `tipotienda` (
  `idTipoTienda` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tipotienda`
--

INSERT INTO `tipotienda` (`idTipoTienda`, `tipo`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'Deportiva', 'tienda de objetos deportivos', '2017-10-15 01:10:14', '2017-10-15 01:10:14'),
(2, 'Tienda de ropa', 'Tienda que provee distintos tipos de prendas de vestir', '2017-10-15 01:10:14', '2017-10-15 01:10:14'),
(3, 'Tecnologica', 'Tienda con aparatos electronicos de los mas recientes', '2017-10-15 01:10:14', '2017-10-15 01:10:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `nombreUsuario` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `FechaDeNac` date DEFAULT NULL,
  `Sexo` enum('Masculino','Femenino','Otros') COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccion` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tlfn` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `role` enum('user','admin','admin_t') COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `nombreUsuario`, `FechaDeNac`, `Sexo`, `direccion`, `tlfn`, `email`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
('amatson', 'Alexander Matson', '1996-10-10', 'Masculino', 'Urb Las Peras', '04268181881', 'amatson@hotmail.com', '$2y$10$OvyouqzgyJqR2DGoaOWm.ut4VWP58J4YbIiRe6HhCFgL/nLQ9J4we', 'user', 'is1f58BStak68LLfVBxXU19zTvbL5nmlWc1UFKQX', '2017-10-15 18:09:05', '2017-10-15 18:09:05'),
('amporras', 'Alejandro Porras', '1990-10-10', 'Masculino', 'Urb los Leñadores de Bonsai', '04148686886', 'amporras@gmail.com', '$2y$10$cM/v3soQhMtday4sA7KdcuzdOoO4zWLGYJWXp4h342EHmBs5kFvLi', 'user', 'FYbh5J2qMMNvvUa1160eIWqHySDZj8NGAR29vWq71mZqva35cTLYKoWeMXxe', '2017-10-15 18:03:41', '2017-10-16 07:58:36'),
('amventura', 'Abraham Ventura', '1995-12-04', 'Masculino', 'Urb Los Mangos', '04148484884', 'amv@hotmail.com', '$2y$10$cYGE5ir/ePx3hr7.VjKcfuiyihKqWK5/eB32xQxF9dE8Fyf.5QSE6', 'user', 'KDCt9jsUAYf6jQtqqP1K13MJJ1INNJeYXF0vFzBbRofv77GAsALbpdqYjcTm', '2017-10-15 17:58:44', '2017-10-16 16:55:36'),
('gpmonico', 'Gino Monico', '1996-10-10', 'Masculino', 'Urb Los Aguacates', '04148585885', 'gpmonico@gmail.com', '$2y$10$jFVY3GPB4Ke6FItRaN7l9eJpDVRryivzPmtTfKPaLULK2QC0NLtNW', 'user', '7yC49NQDUOWhaoa8JV4K3RT9GlhjUcOlW1puUhIhFFY92zo4yvouBfKa7Ijk', '2017-10-14 02:15:44', '2017-10-16 16:50:59'),
('jazacarias', 'Jose Zacarias', '1998-10-10', 'Masculino', 'Urb Los Altos', '04148888884', 'jazacarias@hotmail.com', '1233456', 'user', 'tjynhtgfsdas@BfasdfdV5141saffafsadsfvx', '2017-11-05 15:49:29', '2017-11-05 15:49:29'),
('jcsanchez', 'Juan Sanchez', '1998-10-10', 'Masculino', 'Urb Los Bajos', '04148888878', 'jcsanchez@hotmail.com', '1234567', 'user', 'tjynhtgfsdas@Bfasdfd5V5141saffafsadsfvx', '2017-11-05 15:49:29', '2017-11-05 15:49:29'),
('jdorive', 'Jose Orive', '1998-10-10', 'Masculino', 'Urb Los Bajos', '04148888888', 'jdorive@hotmail.com', '123456', 'user', 'tjynhtgfsdas@BfasdfdV5141saffafsadsfvx', '2017-11-05 15:46:42', '2017-11-05 15:46:42'),
('oacastillejo', 'Oscar Castillejo', '1998-10-10', 'Masculino', 'Urb Los Bajos', '04148887688', 'oacastillejo@hotmail.com', '123456', 'user', 'tjynhtgfsdas@BfasdfdV5141saffafsadsfvx', '2017-11-05 15:49:30', '2017-11-05 15:49:30'),
('vmprado', 'Victor Prado', '1995-11-10', 'Masculino', 'Urb Narnia', '04148787887', 'vmprado@gmail.com', '$2y$10$Hp5cDuOZXgAngMbcfmodXuGY9XnYcumTrDdLXx/C2n8kuI1wiRp7C', 'user', 'ARtZy0VNI3xFIOExnuryxyyoKdmWbMjH9o15t5s65eCjfh7fmPBaoKu4N4mS', '2017-10-15 06:20:15', '2017-10-18 01:07:58');

--
-- Disparadores `users`
--
DELIMITER $$
CREATE TRIGGER `checkIfExists` BEFORE DELETE ON `users` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(users.id) into aux
FROM users
WHERE users.id = old.id AND
		users.email = old.email;
IF aux = 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: El usuario no existe!!!';
end IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `comprobarUsuario` BEFORE INSERT ON `users` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(users.id) into aux
FROM users
WHERE users.id = new.id OR
		users.email = new.email;
IF aux > 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El usuario ya se encuentra registrado';
end IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariosdegrupo`
--

CREATE TABLE `usuariosdegrupo` (
  `idGrupo` int(10) UNSIGNED NOT NULL,
  `idAdmin` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `idUsuario` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `regala` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `confirmacion` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuariosdegrupo`
--

INSERT INTO `usuariosdegrupo` (`idGrupo`, `idAdmin`, `idUsuario`, `regala`, `confirmacion`, `created_at`, `updated_at`) VALUES
(1, 'amporras', 'amventura', 'amporras', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(1, 'amporras', 'jazacarias', 'amporras', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(1, 'amporras', 'jcsanchez', 'jazacarias', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(1, 'amporras', 'jdorive', '', 0, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(1, 'amporras', 'oacastillejo', 'vmprado', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(1, 'amporras', 'vmprado', 'amventura', 1, '2017-10-15 14:56:02', '2017-10-15 14:56:02'),
(2, 'amporras', 'amatson', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(2, 'amporras', 'gpmonico', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(2, 'amporras', 'jazacarias', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(2, 'amporras', 'jdorive', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(2, 'amporras', 'vmprado', '', 1, '2017-10-15 14:57:55', '2017-10-15 14:57:55'),
(2, 'amventura', 'amventura', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(3, 'amatson', 'amporras', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(3, 'amatson', 'amventura', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(3, 'amatson', 'jazacarias', '', 1, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(3, 'amatson', 'jdorive', '', 0, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(3, 'amatson', 'oacastillejo', '', NULL, '2017-11-05 04:00:00', '2017-11-05 04:00:00'),
(3, 'amatson', 'vmprado', '', 1, '2017-10-15 14:58:57', '2017-10-16 06:40:25');

--
-- Disparadores `usuariosdegrupo`
--
DELIMITER $$
CREATE TRIGGER `checkIfExistsGroup` BEFORE DELETE ON `usuariosdegrupo` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(usuariosdegrupo.idUsuario) into aux
FROM users
WHERE usuariosdegrupo.idGrupo = old.idGrupo AND
		usuariosdegrupo.idUsuario = old.idUsuario;
IF aux > 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: El usuario no esta en este grupo';
end IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `comprobarUsuarioGrupo` BEFORE INSERT ON `usuariosdegrupo` FOR EACH ROW BEGIN

DECLARE aux int;

SELECT COUNT(usuariosdegrupo.idUsuario) into aux
FROM users
WHERE usuariosdegrupo.idGrupo = new.idGrupo AND
		usuariosdegrupo.idUsuario = new.idUsuario;
IF aux > 0 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El usuario ya se encuentra en el grupo';
end IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `amigos`
--
ALTER TABLE `amigos`
  ADD PRIMARY KEY (`idUsuario1`,`idUsuario2`) USING BTREE,
  ADD KEY `amigos_idusuario2_foreign` (`idUsuario2`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`idGrupo`,`idAdmin`) USING BTREE,
  ADD KEY `grupo_idadmin_index` (`idAdmin`),
  ADD KEY `grupo_idtipogrupo_index` (`idTipoGrupo`),
  ADD KEY `grupo_estado_index` (`estado`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `producto_idtipoproducto_foreign` (`idTipoProducto`);

--
-- Indices de la tabla `productofav`
--
ALTER TABLE `productofav`
  ADD PRIMARY KEY (`idUsuario`,`idProducto`) USING BTREE,
  ADD KEY `productofav_idproducto_index` (`idProducto`);

--
-- Indices de la tabla `productos_x_tienda`
--
ALTER TABLE `productos_x_tienda`
  ADD PRIMARY KEY (`idProducto`,`idTienda`) USING BTREE,
  ADD KEY `productos_x_tienda_idtienda_foreign` (`idTienda`),
  ADD KEY `productos_x_tienda_precio_index` (`precio`);

--
-- Indices de la tabla `tienda`
--
ALTER TABLE `tienda`
  ADD PRIMARY KEY (`idTienda`),
  ADD KEY `tienda_idtipotienda_index` (`idTipoTienda`);

--
-- Indices de la tabla `tiendafav`
--
ALTER TABLE `tiendafav`
  ADD PRIMARY KEY (`idUsuario`,`idTienda`) USING BTREE,
  ADD KEY `tiendafav_idtienda_index` (`idTienda`);

--
-- Indices de la tabla `tipoproducto`
--
ALTER TABLE `tipoproducto`
  ADD PRIMARY KEY (`idTipoProducto`);

--
-- Indices de la tabla `tiposdegrupo`
--
ALTER TABLE `tiposdegrupo`
  ADD PRIMARY KEY (`idTipoGrupo`);

--
-- Indices de la tabla `tipotienda`
--
ALTER TABLE `tipotienda`
  ADD PRIMARY KEY (`idTipoTienda`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_idusuario_unique` (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_nombreusuario_index` (`nombreUsuario`),
  ADD KEY `users_edad` (`FechaDeNac`);

--
-- Indices de la tabla `usuariosdegrupo`
--
ALTER TABLE `usuariosdegrupo`
  ADD PRIMARY KEY (`idGrupo`,`idAdmin`,`idUsuario`) USING BTREE,
  ADD KEY `usuariosdegrupo_idusuario_foreign` (`idUsuario`),
  ADD KEY `usuariosdegrupo_idadmin_foreign` (`idAdmin`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `grupo`
--
ALTER TABLE `grupo`
  MODIFY `idGrupo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idProducto` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `tienda`
--
ALTER TABLE `tienda`
  MODIFY `idTienda` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `tipoproducto`
--
ALTER TABLE `tipoproducto`
  MODIFY `idTipoProducto` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `tiposdegrupo`
--
ALTER TABLE `tiposdegrupo`
  MODIFY `idTipoGrupo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tipotienda`
--
ALTER TABLE `tipotienda`
  MODIFY `idTipoTienda` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `amigos`
--
ALTER TABLE `amigos`
  ADD CONSTRAINT `amigos_idusuario1_foreign` FOREIGN KEY (`idUsuario1`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `amigos_idusuario2_foreign` FOREIGN KEY (`idUsuario2`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `grupo_idadmin_foreign` FOREIGN KEY (`idAdmin`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `grupo_idtipogrupo_foreign` FOREIGN KEY (`idTipoGrupo`) REFERENCES `tiposdegrupo` (`idTipoGrupo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_idtipoproducto_foreign` FOREIGN KEY (`idTipoProducto`) REFERENCES `tipoproducto` (`idTipoProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productofav`
--
ALTER TABLE `productofav`
  ADD CONSTRAINT `productofav_idproducto_foreign` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `productofav_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos_x_tienda`
--
ALTER TABLE `productos_x_tienda`
  ADD CONSTRAINT `productos_x_tienda_idproducto_foreign` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_x_tienda_idtienda_foreign` FOREIGN KEY (`idTienda`) REFERENCES `tienda` (`idTienda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tienda`
--
ALTER TABLE `tienda`
  ADD CONSTRAINT `tienda_idtipotienda_foreign` FOREIGN KEY (`idTipoTienda`) REFERENCES `tipotienda` (`idTipoTienda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tiendafav`
--
ALTER TABLE `tiendafav`
  ADD CONSTRAINT `tiendafav_idtienda_foreign` FOREIGN KEY (`idTienda`) REFERENCES `tienda` (`idTienda`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tiendafav_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuariosdegrupo`
--
ALTER TABLE `usuariosdegrupo`
  ADD CONSTRAINT `usuariosdegrupo_idadmin_foreign` FOREIGN KEY (`idAdmin`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuariosdegrupo_idgrupo_foreign` FOREIGN KEY (`idGrupo`) REFERENCES `grupo` (`idGrupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuariosdegrupo_idusuario_foreign` FOREIGN KEY (`idUsuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
