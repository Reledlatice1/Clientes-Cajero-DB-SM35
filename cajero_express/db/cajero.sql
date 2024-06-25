-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-06-2024 a las 21:03:25
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cajero`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarEstadoCliente` (IN `cliente_id` INT)   BEGIN
    UPDATE tb_clientes 
    SET estado = 'Activo' 
    WHERE id_cliente = cliente_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarEstadoCliente_inactivo` (IN `cliente_id` INT)   BEGIN
    UPDATE tb_clientes 
    SET estado = 'Inactivo' 
    WHERE id_cliente = cliente_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_cliente_tarjeta` (IN `sp_n_tarjeta` VARCHAR(16), IN `sp_nip` VARCHAR(4))   BEGIN
SELECT id_tarjeta, n_tarjeta, nip, saldo,tb_tarjeta.id_cliente, nombre, ap_paterno, ap_materno
            FROM tb_tarjeta INNER JOIN tb_clientes ON
            tb_tarjeta.id_cliente = tb_clientes.id_cliente
            WHERE n_tarjeta = sp_n_tarjeta AND nip = sp_nip;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id_movimiento` int(11) NOT NULL,
  `monto` decimal(7,2) DEFAULT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_tarjeta` int(11) DEFAULT NULL,
  `id_tipo_movimiento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`id_movimiento`, `monto`, `fecha_hora`, `id_tarjeta`, `id_tipo_movimiento`) VALUES
(1, 99999.99, '2024-06-25 17:54:42', 1, 4),
(2, 1.00, '2024-06-25 18:23:58', 1, 4),
(3, 1.00, '2024-06-25 18:27:37', 1, 4),
(4, 100.00, '2024-06-25 18:28:11', 1, 4),
(5, 90.00, '2024-06-25 18:30:30', 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_clientes`
--

CREATE TABLE `tb_clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(25) DEFAULT NULL,
  `ap_paterno` varchar(25) DEFAULT NULL,
  `ap_materno` varchar(25) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Inactivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_clientes`
--

INSERT INTO `tb_clientes` (`id_cliente`, `nombre`, `ap_paterno`, `ap_materno`, `estado`) VALUES
(1, 'Ricardo', 'Beltran', 'Cetina', 'Activo'),
(2, 'Juan', 'Perez', 'Martines', 'Inactivo'),
(3, 'Carlos', 'Jimenez', 'Lopez', 'Inactivo'),
(4, 'Angel', 'Martinez', 'De la cruz', 'Inactivo'),
(5, 'Emiliano', 'Juarez', 'Lopez', 'Inactivo');

--
-- Disparadores `tb_clientes`
--
DELIMITER $$
CREATE TRIGGER `tb_log_clientes_delete` BEFORE DELETE ON `tb_clientes` FOR EACH ROW BEGIN 
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES ('DELETE', OLD.id_cliente, CONCAT (
        OLD.nombre, '',  OLD.ap_paterno, '', OLD.ap_materno 
            ) 
        ); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_log_clientes_insert` AFTER INSERT ON `tb_clientes` FOR EACH ROW BEGIN 
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES ('INSERT', NEW.id_cliente, CONCAT (
        NEW.nombre, ' ',  NEW.ap_paterno, ' ', NEW.ap_materno 
    )
); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_log_clientes_update` AFTER UPDATE ON `tb_clientes` FOR EACH ROW BEGIN 
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES ('UPDATE', OLD.id_cliente, CONCAT (
            'viejo: ', OLD.nombre,' nuevo: ',NEW.nombre,
            ' ',
            'viejo: ', OLD.ap_paterno,' nuevo: ', NEW.ap_paterno,
            ' ',
            'viejo: ', OLD.ap_materno,' nuevo: ', NEW.ap_materno
        )
    ); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_login_clientes` AFTER UPDATE ON `tb_clientes` FOR EACH ROW BEGIN
IF NEW.estado = 'Activo' AND OLD.estado <> 'Activo' THEN
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES('LOGIN', NEW.id_cliente, CONCAT(NEW.nombre, ' ', NEW.ap_paterno, ' ', NEW.ap_materno));
END IF;
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_logout_clientes` AFTER UPDATE ON `tb_clientes` FOR EACH ROW BEGIN
IF NEW.estado = 'Inactivo' AND OLD.estado <> 'Inactivo' THEN
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES('LOGOUT', OLD.id_cliente, CONCAT(OLD.nombre, ' ', OLD.ap_paterno, ' ', OLD.ap_materno));
END IF;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_log_clientes`
--

CREATE TABLE `tb_log_clientes` (
  `id_log_cliente` int(11) NOT NULL,
  `accion` varchar(20) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `nombre_completo` varchar(250) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_log_clientes`
--

INSERT INTO `tb_log_clientes` (`id_log_cliente`, `accion`, `id_cliente`, `nombre_completo`, `fecha`) VALUES
(1, 'INSERT', 6, 'NUEVOqwertyuioqwertyui', '2024-06-17 17:20:13'),
(2, 'UPDATE', 6, 'viejo: NUEVO nuevo: ttyuyuytiy7ui viejo: qwertyuio nuevo: qwertyuio viejo: qwertyui nuevo: qwertyui', '2024-06-17 17:20:34'),
(3, 'DELETE', 6, 'ttyuyuytiy7uiqwertyuioqwertyui', '2024-06-17 17:20:50'),
(4, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:25:12'),
(5, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:26:10'),
(6, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:27:10'),
(7, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:27:17'),
(8, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:39:40'),
(9, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:46:28'),
(10, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:46:55'),
(11, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:48:50'),
(12, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:50:57'),
(13, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 12:54:07'),
(14, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-19 12:58:16'),
(15, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 13:01:38'),
(16, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-19 13:01:38'),
(17, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-19 13:01:44'),
(18, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-19 13:01:44'),
(19, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-20 15:17:29'),
(20, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-20 15:18:53'),
(21, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-20 15:20:34'),
(22, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-20 15:20:34'),
(23, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-20 15:20:42'),
(24, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-20 15:20:42'),
(25, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-20 15:24:28'),
(26, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-20 15:24:28'),
(27, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-20 15:54:54'),
(28, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-20 15:54:54'),
(29, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 12:52:55'),
(30, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 12:52:55'),
(31, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 12:53:13'),
(32, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 12:53:13'),
(33, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 12:54:15'),
(34, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 12:54:15'),
(35, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 12:54:47'),
(36, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 12:54:47'),
(37, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 12:54:59'),
(38, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 12:54:59'),
(39, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 13:16:33'),
(40, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 13:16:33'),
(41, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 13:17:59'),
(42, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 13:24:49'),
(43, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 13:24:49'),
(44, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 13:26:56'),
(45, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 13:26:56'),
(46, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 13:37:35'),
(47, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 13:37:45'),
(48, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 13:37:45'),
(49, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 13:38:50'),
(50, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 13:38:50'),
(51, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 14:02:30'),
(52, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 14:02:30'),
(53, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 14:02:33'),
(54, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 14:02:33'),
(55, 'UPDATE', 2, 'viejo: Juan nuevo: Juan viejo: Perez nuevo: Perez viejo: Martines nuevo: Martines', '2024-06-21 14:02:55'),
(56, 'LOGIN', 2, 'JuanPerezMartines', '2024-06-21 14:02:55'),
(57, 'UPDATE', 2, 'viejo: Juan nuevo: Juan viejo: Perez nuevo: Perez viejo: Martines nuevo: Martines', '2024-06-21 14:03:41'),
(58, 'LOGOUT', 2, 'JuanPerezMartines', '2024-06-21 14:03:41'),
(59, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 14:03:51'),
(60, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 14:03:51'),
(61, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 14:04:01'),
(62, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 14:04:01'),
(63, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 14:26:57'),
(64, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-21 14:26:57'),
(65, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-21 14:27:08'),
(66, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-21 14:27:08'),
(67, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-24 15:46:05'),
(68, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-24 15:46:05'),
(69, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-24 15:47:26'),
(70, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-24 15:47:26'),
(71, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-24 15:47:37'),
(72, 'LOGIN', 1, 'RicardoBeltranCetina', '2024-06-24 15:47:37'),
(73, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-24 15:47:58'),
(74, 'LOGOUT', 1, 'RicardoBeltranCetina', '2024-06-24 15:47:58'),
(75, 'UPDATE', 2, 'viejo: Juan nuevo: Juan viejo: Perez nuevo: Perez viejo: Martines nuevo: Martines', '2024-06-24 16:03:39'),
(76, 'LOGIN', 2, 'JuanPerezMartines', '2024-06-24 16:03:39'),
(77, 'UPDATE', 2, 'viejo: Juan nuevo: Juan viejo: Perez nuevo: Perez viejo: Martines nuevo: Martines', '2024-06-24 16:03:54'),
(78, 'LOGOUT', 2, 'JuanPerezMartines', '2024-06-24 16:03:54'),
(79, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-24 17:22:57'),
(80, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-24 17:22:57'),
(81, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-24 17:23:06'),
(82, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-24 17:23:06'),
(83, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 16:00:08'),
(84, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 16:00:08'),
(85, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 16:18:17'),
(86, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 16:18:17'),
(87, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 16:18:26'),
(88, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 16:18:26'),
(89, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 17:40:46'),
(90, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 17:40:46'),
(91, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 17:40:55'),
(92, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 17:40:55'),
(93, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 17:41:50'),
(94, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 17:56:16'),
(95, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 17:56:16'),
(96, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 17:56:26'),
(97, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 17:56:26'),
(98, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:25:43'),
(99, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:25:43'),
(100, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:25:51'),
(101, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:25:51'),
(102, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:27:21'),
(103, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:27:21'),
(104, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:27:33'),
(105, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:27:33'),
(106, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:27:50'),
(107, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:27:50'),
(108, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:28:07'),
(109, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:28:07'),
(110, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:30:04'),
(111, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:30:04'),
(112, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:30:12'),
(113, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:30:12'),
(114, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:30:43'),
(115, 'LOGOUT', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:30:43'),
(116, 'UPDATE', 1, 'viejo: Ricardo nuevo: Ricardo viejo: Beltran nuevo: Beltran viejo: Cetina nuevo: Cetina', '2024-06-25 18:43:23'),
(117, 'LOGIN', 1, 'Ricardo Beltran Cetina', '2024-06-25 18:43:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_log_tarjetas`
--

CREATE TABLE `tb_log_tarjetas` (
  `id_log_tarjetas` int(11) NOT NULL,
  `accion` varchar(20) DEFAULT NULL,
  `id_tarjeta` int(11) DEFAULT NULL,
  `n_tarjeta` varchar(20) DEFAULT NULL,
  `saldo` decimal(20,2) DEFAULT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_log_tarjetas`
--

INSERT INTO `tb_log_tarjetas` (`id_log_tarjetas`, `accion`, `id_tarjeta`, `n_tarjeta`, `saldo`, `id_cliente`) VALUES
(1, 'INSERT', 20, '1234567890123456', 999999999999999999.99, 5),
(2, 'UPDATE', 20, 'viejo: 1234567890123', 0.00, 0),
(3, 'DELETE', 20, '1234567890123456', 999999.99, 5),
(4, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(5, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(6, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(7, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(8, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(9, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(10, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(11, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(12, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(13, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0),
(14, 'UPDATE', 1, 'viejo: 2020202020202', 0.00, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_log_tipo_movimiento`
--

CREATE TABLE `tb_log_tipo_movimiento` (
  `id_log_tipo_movimiento` int(11) NOT NULL,
  `accion` varchar(20) DEFAULT NULL,
  `id_tipo_movimiento` int(11) DEFAULT NULL,
  `tipo_movimiento` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_log_tipo_movimiento`
--

INSERT INTO `tb_log_tipo_movimiento` (`id_log_tipo_movimiento`, `accion`, `id_tipo_movimiento`, `tipo_movimiento`) VALUES
(1, 'INSERT', 2, 'consulta'),
(2, 'UPDATE', 2, 'viejo: consulta nuevo: retiro'),
(3, 'DELETE', 2, 'retiro'),
(4, 'INSERT', 3, 'consulta'),
(5, 'INSERT', 4, 'retiro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tarjeta`
--

CREATE TABLE `tb_tarjeta` (
  `id_tarjeta` int(11) NOT NULL,
  `n_tarjeta` varchar(16) DEFAULT NULL,
  `nip` varchar(4) DEFAULT NULL,
  `saldo` decimal(20,2) DEFAULT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_tarjeta`
--

INSERT INTO `tb_tarjeta` (`id_tarjeta`, `n_tarjeta`, `nip`, `saldo`, `id_cliente`) VALUES
(1, '2020202020202020', '1234', 5.00, 1),
(2, '2121212121212121', '4567', 1000000000000.00, 1),
(3, '2222222222222222', '3483', 9999999999999.99, 2),
(4, '2323232323232323', '9085', 9999999999999.99, 2),
(5, '2424242424242424', '2801', 9999999999999.99, 3),
(6, '2525252525252525', '2077', 9999999999999.99, 3),
(7, '26262626262626', '3457', 3415234915490.99, 4),
(8, '27272727272727', '4524', 9999999999999.99, 4),
(9, '2828282828282828', '6562', 9999999999999.99, 5),
(10, '2929292929292929', '5626', 9999999999999.99, 5);

--
-- Disparadores `tb_tarjeta`
--
DELIMITER $$
CREATE TRIGGER `tb_log_tarjetas_delete` BEFORE DELETE ON `tb_tarjeta` FOR EACH ROW BEGIN 
    INSERT INTO tb_log_tarjetas (accion, id_tarjeta, n_tarjeta, saldo, id_cliente)
    VALUES (
        'DELETE', 
        OLD.id_tarjeta, 
        OLD.n_tarjeta, 
        OLD.saldo, 
        OLD.id_cliente
    );
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_log_tarjetas_insert` AFTER INSERT ON `tb_tarjeta` FOR EACH ROW BEGIN 
    INSERT INTO tb_log_tarjetas (accion, id_tarjeta, n_tarjeta, saldo, id_cliente)
    VALUES ('INSERT', NEW.id_tarjeta, NEW.n_tarjeta, NEW.saldo, NEW.id_cliente);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_log_tarjetas_update` AFTER UPDATE ON `tb_tarjeta` FOR EACH ROW BEGIN 
    INSERT INTO tb_log_tarjetas (accion, id_tarjeta, n_tarjeta, saldo, id_cliente)
    VALUES (
        'UPDATE', 
        OLD.id_tarjeta, 
        CONCAT('viejo: ', OLD.n_tarjeta, ' nuevo: ', NEW.n_tarjeta), 
        CONCAT('viejo: ', OLD.saldo, ' nuevo: ', NEW.saldo), 
        CONCAT('viejo: ', OLD.id_cliente, ' nuevo: ', NEW.id_cliente)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tg_retiro` BEFORE UPDATE ON `tb_tarjeta` FOR EACH ROW BEGIN 

    DECLARE v_saldo DECIMAL(20,2);
    DECLARE v_monto DECIMAL(20, 2);
    DECLARE retiro_id INT;

  
    SELECT id_tipo_movimiento INTO retiro_id 
    FROM tb_tipo_movimiento
    WHERE tipo = "retiro";

    SET v_saldo = OLD.saldo;
    SET v_monto = NEW.saldo - OLD.saldo;

    IF v_monto < 0 THEN
       
        SET v_monto = -v_monto;
            IF v_saldo >= v_monto THEN
                INSERT INTO movimientos(monto, id_tarjeta, id_tipo_movimiento)
                VALUE (v_monto, OLD.id_tarjeta, retiro_id);

                
                SET NEW.saldo = OLD.saldo - v_saldo;
                ELSE 
                
              
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
            END IF;
    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tipo_movimiento`
--

CREATE TABLE `tb_tipo_movimiento` (
  `id_tipo_movimiento` int(11) NOT NULL,
  `tipo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_tipo_movimiento`
--

INSERT INTO `tb_tipo_movimiento` (`id_tipo_movimiento`, `tipo`) VALUES
(3, 'consulta'),
(4, 'retiro');

--
-- Disparadores `tb_tipo_movimiento`
--
DELIMITER $$
CREATE TRIGGER `tb_log_tipo_movimiento_delete` BEFORE DELETE ON `tb_tipo_movimiento` FOR EACH ROW BEGIN 
    INSERT INTO tb_log_tipo_movimiento (accion, id_tipo_movimiento, tipo_movimiento)
    VALUES (
        'DELETE', 
        OLD.id_tipo_movimiento, 
        OLD.tipo_movimiento
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_log_tipo_movimiento_insert` AFTER INSERT ON `tb_tipo_movimiento` FOR EACH ROW BEGIN 
    INSERT INTO tb_log_tipo_movimiento (accion, id_tipo_movimiento, tipo_movimiento)
    VALUES ('INSERT', NEW.id_tipo_movimiento, NEW.tipo_movimiento);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tb_log_tipo_movimiento_update` AFTER UPDATE ON `tb_tipo_movimiento` FOR EACH ROW BEGIN 
    INSERT INTO tb_log_tipo_movimiento (accion, id_tipo_movimiento, tipo_movimiento)
    VALUES (
        'UPDATE', 
        OLD.id_tipo_movimiento, 
        CONCAT('viejo: ', OLD.tipo_movimiento, ' nuevo: ', NEW.tipo_movimiento)
    );
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `id_tarjeta` (`id_tarjeta`),
  ADD KEY `id_tipo_movimiento` (`id_tipo_movimiento`);

--
-- Indices de la tabla `tb_clientes`
--
ALTER TABLE `tb_clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tb_log_clientes`
--
ALTER TABLE `tb_log_clientes`
  ADD PRIMARY KEY (`id_log_cliente`);

--
-- Indices de la tabla `tb_log_tarjetas`
--
ALTER TABLE `tb_log_tarjetas`
  ADD PRIMARY KEY (`id_log_tarjetas`);

--
-- Indices de la tabla `tb_log_tipo_movimiento`
--
ALTER TABLE `tb_log_tipo_movimiento`
  ADD PRIMARY KEY (`id_log_tipo_movimiento`);

--
-- Indices de la tabla `tb_tarjeta`
--
ALTER TABLE `tb_tarjeta`
  ADD PRIMARY KEY (`id_tarjeta`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `tb_tipo_movimiento`
--
ALTER TABLE `tb_tipo_movimiento`
  ADD PRIMARY KEY (`id_tipo_movimiento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tb_clientes`
--
ALTER TABLE `tb_clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tb_log_clientes`
--
ALTER TABLE `tb_log_clientes`
  MODIFY `id_log_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT de la tabla `tb_log_tarjetas`
--
ALTER TABLE `tb_log_tarjetas`
  MODIFY `id_log_tarjetas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `tb_log_tipo_movimiento`
--
ALTER TABLE `tb_log_tipo_movimiento`
  MODIFY `id_log_tipo_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tb_tarjeta`
--
ALTER TABLE `tb_tarjeta`
  MODIFY `id_tarjeta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `tb_tipo_movimiento`
--
ALTER TABLE `tb_tipo_movimiento`
  MODIFY `id_tipo_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD CONSTRAINT `movimientos_ibfk_1` FOREIGN KEY (`id_tarjeta`) REFERENCES `tb_tarjeta` (`id_tarjeta`),
  ADD CONSTRAINT `movimientos_ibfk_2` FOREIGN KEY (`id_tipo_movimiento`) REFERENCES `tb_tipo_movimiento` (`id_tipo_movimiento`);

--
-- Filtros para la tabla `tb_tarjeta`
--
ALTER TABLE `tb_tarjeta`
  ADD CONSTRAINT `tb_tarjeta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `tb_clientes` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
