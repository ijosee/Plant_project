-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 26-08-2019 a las 16:16:05
-- Versión del servidor: 10.0.28-MariaDB-2+b1
-- Versión de PHP: 7.3.4-2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Arduino_plant`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CALENDAR_EVENT`
--

CREATE TABLE `CALENDAR_EVENT` (
  `id` int(11) NOT NULL,
  `title` varchar(45) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HIGROMETER_LOGS`
--

CREATE TABLE `HIGROMETER_LOGS` (
  `id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HUMIDITY_LOGS`
--

CREATE TABLE `HUMIDITY_LOGS` (
  `id` int(11) NOT NULL,
  `value` float NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `LIGHT_LOGS`
--

CREATE TABLE `LIGHT_LOGS` (
  `id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `mode` int(11) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TEMPERATURE_LOGS`
--

CREATE TABLE `TEMPERATURE_LOGS` (
  `id` int(11) NOT NULL,
  `value` float NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `WATTERPUMP_LOGS`
--

CREATE TABLE `WATTERPUMP_LOGS` (
  `id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `flow` int(11) NOT NULL,
  `openedTimeInSeconds` int(11) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `CALENDAR_EVENT`
--
ALTER TABLE `CALENDAR_EVENT`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `HIGROMETER_LOGS`
--
ALTER TABLE `HIGROMETER_LOGS`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `HUMIDITY_LOGS`
--
ALTER TABLE `HUMIDITY_LOGS`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `LIGHT_LOGS`
--
ALTER TABLE `LIGHT_LOGS`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `TEMPERATURE_LOGS`
--
ALTER TABLE `TEMPERATURE_LOGS`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `WATTERPUMP_LOGS`
--
ALTER TABLE `WATTERPUMP_LOGS`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `CALENDAR_EVENT`
--
ALTER TABLE `CALENDAR_EVENT`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `HIGROMETER_LOGS`
--
ALTER TABLE `HIGROMETER_LOGS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83677;
--
-- AUTO_INCREMENT de la tabla `HUMIDITY_LOGS`
--
ALTER TABLE `HUMIDITY_LOGS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38635;
--
-- AUTO_INCREMENT de la tabla `LIGHT_LOGS`
--
ALTER TABLE `LIGHT_LOGS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83599;
--
-- AUTO_INCREMENT de la tabla `TEMPERATURE_LOGS`
--
ALTER TABLE `TEMPERATURE_LOGS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38609;
--
-- AUTO_INCREMENT de la tabla `WATTERPUMP_LOGS`
--
ALTER TABLE `WATTERPUMP_LOGS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10279;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
