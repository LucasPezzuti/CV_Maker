-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 03, 2025 at 05:38 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cvtorta`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comidas`
--

CREATE TABLE `comidas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `calorias` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comidas`
--

INSERT INTO `comidas` (`id`, `user_id`, `fecha`, `tipo`, `descripcion`, `calorias`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-08-08', 'Almuerzo', 'Milanesa con puré', 450, '2025-08-08 18:17:31', '2025-08-08 18:17:31'),
(2, 1, '2025-08-21', 'Almuerzo', 'pepitos', 180, '2025-08-21 16:02:27', '2025-08-21 16:02:27'),
(3, 1, '2025-08-21', 'Cena', 'poio con arroz', 350, '2025-08-21 16:11:11', '2025-08-21 16:11:11'),
(4, 1, '2025-08-21', 'Desayuno', 'asado con achuras', 650, '2025-08-21 16:28:42', '2025-08-21 16:28:42');

-- --------------------------------------------------------

--
-- Table structure for table `cv_educations`
--

CREATE TABLE `cv_educations` (
  `id` bigint UNSIGNED NOT NULL,
  `cv_profile_id` bigint UNSIGNED NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institucion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estudiando_actualmente` tinyint(1) NOT NULL DEFAULT '0',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `promedio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orden` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cv_educations`
--

INSERT INTO `cv_educations` (`id`, `cv_profile_id`, `titulo`, `institucion`, `ubicacion`, `fecha_inicio`, `fecha_fin`, `estudiando_actualmente`, `descripcion`, `promedio`, `orden`, `created_at`, `updated_at`) VALUES
(1, 2, 'asds', 'adasdasdasd', 'asd', '2025-09-02', NULL, 0, NULL, NULL, 0, '2025-09-03 20:10:29', '2025-09-03 20:10:29');

-- --------------------------------------------------------

--
-- Table structure for table `cv_experiences`
--

CREATE TABLE `cv_experiences` (
  `id` bigint UNSIGNED NOT NULL,
  `cv_profile_id` bigint UNSIGNED NOT NULL,
  `puesto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `empresa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `trabajo_actual` tinyint(1) NOT NULL DEFAULT '0',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `logros` json DEFAULT NULL,
  `orden` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cv_experiences`
--

INSERT INTO `cv_experiences` (`id`, `cv_profile_id`, `puesto`, `empresa`, `ubicacion`, `fecha_inicio`, `fecha_fin`, `trabajo_actual`, `descripcion`, `logros`, `orden`, `created_at`, `updated_at`) VALUES
(1, 2, 'adasd', 'asdasd', NULL, '2025-09-02', '2025-09-04', 0, 'asdasd', '[]', 0, '2025-09-03 20:10:29', '2025-09-03 20:10:29');

-- --------------------------------------------------------

--
-- Table structure for table `cv_profiles`
--

CREATE TABLE `cv_profiles` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_postal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portfolio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titulo_profesional` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resumen_profesional` text COLLATE utf8mb4_unicode_ci,
  `template` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'modern',
  `configuracion` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cv_profiles`
--

INSERT INTO `cv_profiles` (`id`, `user_id`, `nombre`, `apellido`, `email`, `telefono`, `direccion`, `ciudad`, `codigo_postal`, `linkedin`, `github`, `portfolio`, `titulo_profesional`, `resumen_profesional`, `template`, `configuracion`, `created_at`, `updated_at`) VALUES
(2, 1, 'asd', 'asdasd', 'aaa@a.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'asdad', 'adas', 'modern', NULL, '2025-09-03 20:10:29', '2025-09-03 20:10:29');

-- --------------------------------------------------------

--
-- Table structure for table `cv_skills`
--

CREATE TABLE `cv_skills` (
  `id` bigint UNSIGNED NOT NULL,
  `cv_profile_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('tecnica','blanda','idioma','certificacion') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nivel` int NOT NULL DEFAULT '1',
  `nivel_texto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orden` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cv_skills`
--

INSERT INTO `cv_skills` (`id`, `cv_profile_id`, `nombre`, `categoria`, `nivel`, `nivel_texto`, `orden`, `created_at`, `updated_at`) VALUES
(1, 2, 'asdasdasdasd', 'tecnica', 3, NULL, 0, '2025-09-03 20:10:29', '2025-09-03 20:10:29');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_08_06_115229_create_personal_access_tokens_table', 1),
(5, '2025_08_06_115600_create_comidas_table', 2),
(6, '2025_08_21_153544_create_user_profiles_table', 3),
(7, '2025_08_21_153655_create_weight_records_table', 3),
(8, '2025_08_21_153655_create_water_records_table', 4),
(9, '0001_01_01_000001_create_cv_profiles_table', 5),
(10, '0001_01_01_000002_create_cv_experiences_table', 6),
(11, '0001_01_01_000002_create_cv_skills_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', 'aab9a6180f97e9404f823722f7641f929f299c0889bfbeaa54947589478f58a8', '[\"*\"]', NULL, NULL, '2025-08-06 19:39:29', '2025-08-06 19:39:29'),
(2, 'App\\Models\\User', 1, 'auth_token', 'dc72c4caa7b4d4ee53f334508109b28549a276e25e5c8cbeca7bbb8cb377c9ad', '[\"*\"]', NULL, NULL, '2025-08-06 20:21:06', '2025-08-06 20:21:06'),
(3, 'App\\Models\\User', 1, 'auth_token', '7c5ffe7820adfeff10b06c4f6341875da7a44e99dcca58b6a8ed0d3aa7be97d7', '[\"*\"]', NULL, NULL, '2025-08-06 20:24:37', '2025-08-06 20:24:37'),
(4, 'App\\Models\\User', 1, 'auth_token', 'e91bc96a6ec53e7bf0e3298a3225e67871c56ee63269877470b15ddb6e1eb26d', '[\"*\"]', NULL, NULL, '2025-08-06 20:39:51', '2025-08-06 20:39:51'),
(5, 'App\\Models\\User', 1, 'auth_token', '2396833374d665fd014231f14691e815ead1df64644182fb0a8df5f18c4cbb76', '[\"*\"]', NULL, NULL, '2025-08-06 20:41:14', '2025-08-06 20:41:14'),
(6, 'App\\Models\\User', 1, 'auth_token', '61ccf560e38c2f8281362e37b701155e502799d8bbadde3713bee912589dab46', '[\"*\"]', NULL, NULL, '2025-08-06 20:42:22', '2025-08-06 20:42:22'),
(7, 'App\\Models\\User', 1, 'auth_token', '6b320127ecdfe82dcdd5f45d9693ebba2e9a7203f1def9e5c02e7853fba20ab9', '[\"*\"]', NULL, NULL, '2025-08-06 20:44:47', '2025-08-06 20:44:47'),
(8, 'App\\Models\\User', 1, 'auth_token', 'abb6007f983cf208f14f7755d414326483b568d71a90339863768e84dd32f600', '[\"*\"]', NULL, NULL, '2025-08-06 20:48:32', '2025-08-06 20:48:32'),
(9, 'App\\Models\\User', 1, 'auth_token', 'ad4b6c91cb379cf9353da8eb53281ce05acc7d0f335f3f6f8fd6b5bf04c1304e', '[\"*\"]', NULL, NULL, '2025-08-06 20:48:58', '2025-08-06 20:48:58'),
(10, 'App\\Models\\User', 1, 'auth_token', '0e85e2d849ab5246035bbf47eed63d54a931da75bca4a2bdd432a38d0e9a1952', '[\"*\"]', NULL, NULL, '2025-08-06 20:49:32', '2025-08-06 20:49:32'),
(11, 'App\\Models\\User', 1, 'auth_token', '3f991dcefa2f11098056c10a8c75a59e565589841749b2bbeac0a65c7decc2a2', '[\"*\"]', NULL, NULL, '2025-08-08 14:54:07', '2025-08-08 14:54:07'),
(12, 'App\\Models\\User', 1, 'auth_token', '489a45046671607da268d753038af7d283a1ea99a4de272203fbaf131c5f050d', '[\"*\"]', NULL, NULL, '2025-08-08 15:07:04', '2025-08-08 15:07:04'),
(13, 'App\\Models\\User', 1, 'auth_token', '509540c2330016ebd6a5e3482b2aac84b0f6c2bfc30a0a72f62415af5859b05e', '[\"*\"]', NULL, NULL, '2025-08-08 15:20:35', '2025-08-08 15:20:35'),
(14, 'App\\Models\\User', 1, 'auth_token', '36e200e08d496e49a83ce69660a777c120cc896407ef135007c6c05908072c70', '[\"*\"]', NULL, NULL, '2025-08-08 15:32:12', '2025-08-08 15:32:12'),
(15, 'App\\Models\\User', 1, 'auth_token', '514859aa5c73aeaacb25b17069615fba90cf544b1ea29abc1d9d18939e132703', '[\"*\"]', NULL, NULL, '2025-08-08 15:36:05', '2025-08-08 15:36:05'),
(16, 'App\\Models\\User', 1, 'auth_token', 'a0972371c8f5687673df585806e17636175a656147059814ace8d20b460e4a00', '[\"*\"]', NULL, NULL, '2025-08-08 15:37:11', '2025-08-08 15:37:11'),
(17, 'App\\Models\\User', 1, 'auth_token', '65f0b24075ea21b7daabf33ec38ee23b0c6b3ed2a84216ced44a85dc12fcea48', '[\"*\"]', NULL, NULL, '2025-08-08 15:39:47', '2025-08-08 15:39:47'),
(18, 'App\\Models\\User', 1, 'auth_token', '0762c79307fc168fc6801116f3c2122dc3d07ada4a2ee0996a63eece601c4520', '[\"*\"]', NULL, NULL, '2025-08-08 15:43:57', '2025-08-08 15:43:57'),
(19, 'App\\Models\\User', 1, 'auth_token', '688f92c1e1b09521db3a7365fc13616de8947d87506bdc6035fb696a3aa137b4', '[\"*\"]', NULL, NULL, '2025-08-08 15:44:36', '2025-08-08 15:44:36'),
(20, 'App\\Models\\User', 1, 'auth_token', 'ae020f2abd4c1a0ef42276ec8ede2ec7adda8081223bf0cc1505b770770b9591', '[\"*\"]', NULL, NULL, '2025-08-08 15:46:29', '2025-08-08 15:46:29'),
(21, 'App\\Models\\User', 1, 'auth_token', '1ea047e4c9bbeeb1cc770b467ceeec73034b81cc4684d9e2ad7f91652d190779', '[\"*\"]', NULL, NULL, '2025-08-08 15:49:03', '2025-08-08 15:49:03'),
(22, 'App\\Models\\User', 1, 'auth_token', 'e6293f4e813af336b540da7d3982d24904d151fdc7bd8056b7024c32bd242251', '[\"*\"]', NULL, NULL, '2025-08-08 15:49:26', '2025-08-08 15:49:26'),
(23, 'App\\Models\\User', 1, 'auth_token', 'dd6690a48ee0bcb9eaef608af5d939b77d694913e13ee14f638552338ba2faf0', '[\"*\"]', NULL, NULL, '2025-08-08 15:49:35', '2025-08-08 15:49:35'),
(24, 'App\\Models\\User', 1, 'auth_token', '9c2ef54de62c094bb4c1dc6371835b59ea81204db95a6f7a654274686896eac7', '[\"*\"]', NULL, NULL, '2025-08-08 15:50:29', '2025-08-08 15:50:29'),
(25, 'App\\Models\\User', 1, 'auth_token', '4542f38bc65dbe41d8e50135285a6f70c79d0989a8246468b326ac8b8650033b', '[\"*\"]', NULL, NULL, '2025-08-08 15:51:37', '2025-08-08 15:51:37'),
(26, 'App\\Models\\User', 1, 'auth_token', 'be4d207158cc8115e3baddd55cb864a2229d02b5edc66ff0bc5099a9fbbfda2a', '[\"*\"]', NULL, NULL, '2025-08-08 16:02:04', '2025-08-08 16:02:04'),
(27, 'App\\Models\\User', 1, 'auth_token', '3a8aa43329831c730bf3a5897259806eac1350efe0fda290559373b6239c4448', '[\"*\"]', NULL, NULL, '2025-08-08 16:03:41', '2025-08-08 16:03:41'),
(28, 'App\\Models\\User', 1, 'auth_token', 'bedd3719b05401625af3047cb3300c7070fb1664970813e2111fe503050e7111', '[\"*\"]', NULL, NULL, '2025-08-08 16:05:37', '2025-08-08 16:05:37'),
(29, 'App\\Models\\User', 1, 'auth_token', '494aba1b8fdfb07a9029a4c3557aba7b0f3ee947c14b0acb453dcd791afb632f', '[\"*\"]', NULL, NULL, '2025-08-08 16:06:36', '2025-08-08 16:06:36'),
(30, 'App\\Models\\User', 1, 'auth_token', '0d6c92e96a6c0e3d8af315dc80236441ef0ec267370e2992097e50f9cb3ab7e5', '[\"*\"]', NULL, NULL, '2025-08-08 16:16:04', '2025-08-08 16:16:04'),
(31, 'App\\Models\\User', 1, 'auth_token', '028ae05f67d2b317208f1686782b1a62b2800fdc2329a987894160ca196551df', '[\"*\"]', NULL, NULL, '2025-08-08 16:16:52', '2025-08-08 16:16:52'),
(32, 'App\\Models\\User', 1, 'auth_token', '18a2827cce6eeb852564ed6350e1e14200fdac399d4233f9f3fe3e2512aafd84', '[\"*\"]', NULL, NULL, '2025-08-08 16:18:02', '2025-08-08 16:18:02'),
(33, 'App\\Models\\User', 1, 'auth_token', 'ca311c03dc84f4b875326e1d120e562438825631df9f23c9f4b87c2c4f59d360', '[\"*\"]', NULL, NULL, '2025-08-08 16:18:20', '2025-08-08 16:18:20'),
(34, 'App\\Models\\User', 1, 'auth_token', '54580b7d458332caec953fa03abb0919f1d6d1452c3fc6a1664067e1471505db', '[\"*\"]', NULL, NULL, '2025-08-08 16:19:02', '2025-08-08 16:19:02'),
(35, 'App\\Models\\User', 1, 'auth_token', '91bd9f25998ad42d434d6b1412e39445eacbebc5a474d24bbb6de6a5c86c7192', '[\"*\"]', NULL, NULL, '2025-08-08 16:19:15', '2025-08-08 16:19:15'),
(36, 'App\\Models\\User', 1, 'auth_token', 'bcc1fd78dfe89d78db08902a6b0126aa53a3160f03c27203d0c6c3f3098ebd1a', '[\"*\"]', NULL, NULL, '2025-08-08 16:21:08', '2025-08-08 16:21:08'),
(37, 'App\\Models\\User', 1, 'auth_token', 'e564b253d68f9a2db95e1c2510457810260b354416e8b4721405782e62c7d52f', '[\"*\"]', NULL, NULL, '2025-08-08 16:21:39', '2025-08-08 16:21:39'),
(38, 'App\\Models\\User', 1, 'auth_token', '2e2b62b88dedd4188c3ea20fd58aab848ec8cedf0137580d1772db35afe7598b', '[\"*\"]', NULL, NULL, '2025-08-08 16:22:14', '2025-08-08 16:22:14'),
(39, 'App\\Models\\User', 1, 'auth_token', '5f52549fbd2dc47e43fee2da9485be4fd02505ebfb4593a000809ce7129d6640', '[\"*\"]', NULL, NULL, '2025-08-08 16:24:46', '2025-08-08 16:24:46'),
(40, 'App\\Models\\User', 1, 'auth_token', '4593d7551273ac4e676c337816e98cc6b681b9ee7bd63ffe20d8ffa1a79e80b9', '[\"*\"]', '2025-08-21 19:31:05', NULL, '2025-08-08 16:27:29', '2025-08-21 19:31:05'),
(41, 'App\\Models\\User', 1, 'auth_token', 'a29eca29c6b193955e637787cb3997719d674cb695d6215e14899d149eab1ce6', '[\"*\"]', '2025-08-21 19:37:24', NULL, '2025-08-21 19:37:15', '2025-08-21 19:37:24'),
(42, 'App\\Models\\User', 1, 'auth_token', '376f2edc2b85b96db7301a859f6c7f0f7ae6f7846177d049c0d6049750157ebd', '[\"*\"]', '2025-08-21 19:51:09', NULL, '2025-08-21 19:51:01', '2025-08-21 19:51:09'),
(43, 'App\\Models\\User', 1, 'auth_token', 'e13564a15c69cbe27130142c953dff44a9db848210b9ea2a775a9c9b7dad3b73', '[\"*\"]', '2025-08-21 19:53:13', NULL, '2025-08-21 19:52:59', '2025-08-21 19:53:13'),
(44, 'App\\Models\\User', 1, 'auth_token', 'b26a13026f4726e9d25ed4d3d7cbccc57e5ec59dc937e70f489194608c40d79f', '[\"*\"]', '2025-08-21 20:27:30', NULL, '2025-08-21 20:27:20', '2025-08-21 20:27:30'),
(45, 'App\\Models\\User', 1, 'auth_token', '7d60aa1e1a58e6cd966f0188d960e79a6f4185a59d057b6d680d4195a14e55a5', '[\"*\"]', '2025-08-21 20:33:41', NULL, '2025-08-21 20:31:30', '2025-08-21 20:33:41'),
(46, 'App\\Models\\User', 1, 'auth_token', 'b6c4051cb89f138e9a7e786069aaf82f13e5bd4eea5f48117599de277bf4032a', '[\"*\"]', '2025-08-21 20:35:30', NULL, '2025-08-21 20:35:24', '2025-08-21 20:35:30'),
(47, 'App\\Models\\User', 1, 'auth_token', '70a3fe900a421a1b0feae5d94aafd533c7402ee46ccf5bbf1cecffadcbe4b676', '[\"*\"]', '2025-08-21 20:36:51', NULL, '2025-08-21 20:36:42', '2025-08-21 20:36:51'),
(48, 'App\\Models\\User', 1, 'auth_token', 'cc52ff21352cf65e657bd53ceccf88e0d0302a8ece585107c574860cd89fd510', '[\"*\"]', '2025-08-22 18:14:15', NULL, '2025-08-21 20:39:44', '2025-08-22 18:14:15'),
(49, 'App\\Models\\User', 1, 'auth_token', '6ed8ec2dcb07af10bf72063ed38fb4eb135a6ef01f7b971d066b775542e0c906', '[\"*\"]', '2025-08-22 18:15:55', NULL, '2025-08-22 18:15:48', '2025-08-22 18:15:55'),
(50, 'App\\Models\\User', 1, 'auth_token', '47764547f46d3a5eda442c98bffa44823a7e1b1033eeb8ab8555fd074dcc5711', '[\"*\"]', '2025-08-22 19:24:06', NULL, '2025-08-22 18:18:20', '2025-08-22 19:24:06'),
(51, 'App\\Models\\User', 1, 'auth_token', '0519ad8a87dc830a1840197a86d79d2351d033dfdb48e8fdf608988a1f10334f', '[\"*\"]', '2025-08-22 19:26:52', NULL, '2025-08-22 19:26:15', '2025-08-22 19:26:52'),
(52, 'App\\Models\\User', 1, 'auth_token', '6a173c83dd36ae0246d9e3260f0bb7b32667b9e378dcd16bd3ca7f23e183dcac', '[\"*\"]', '2025-08-22 19:29:00', NULL, '2025-08-22 19:26:59', '2025-08-22 19:29:00'),
(53, 'App\\Models\\User', 1, 'auth_token', '5cf30958fec84fce23efc870df11b05d8eb7924b51a668d0781f0b47fdd446be', '[\"*\"]', NULL, NULL, '2025-08-22 19:29:28', '2025-08-22 19:29:28'),
(54, 'App\\Models\\User', 1, 'auth_token', '9afa2b6d528860484cc6b83eeeb40cf825d31e456b6f9b43fd7aae233f5a8272', '[\"*\"]', '2025-08-22 19:30:28', NULL, '2025-08-22 19:30:14', '2025-08-22 19:30:28'),
(55, 'App\\Models\\User', 1, 'auth_token', 'e1c49019e668f8d41a490f0efce9edee1af96726578d114695adf6b15e3d8ca4', '[\"*\"]', '2025-08-22 19:41:26', NULL, '2025-08-22 19:34:37', '2025-08-22 19:41:26'),
(56, 'App\\Models\\User', 1, 'auth_token', 'ed8aa8236390189c14771565232c64a278923376749d89c97bb07b5a6799c809', '[\"*\"]', '2025-08-22 19:44:49', NULL, '2025-08-22 19:44:11', '2025-08-22 19:44:49'),
(57, 'App\\Models\\User', 1, 'auth_token', '5546fcbe6e2228cd74b1d32245c526fe77d175e5dee5317df3da13e63113a14e', '[\"*\"]', '2025-09-03 20:11:34', NULL, '2025-08-22 19:46:48', '2025-09-03 20:11:34');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Lucas Pezzuti', 'lucas@ejemplo.com', NULL, '$2y$12$gYfl0/ZJEMSBaRHFMOxDFOyLyLu2OyDgzvkBWSsln3uGFzIzXBcxC', NULL, '2025-08-06 17:50:36', '2025-08-06 17:50:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `edad` int DEFAULT NULL,
  `genero` enum('Masculino','Femenino','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `altura` decimal(5,2) DEFAULT NULL COMMENT 'Altura en cm',
  `objetivo` enum('Perder peso','Mantener peso','Ganar masa muscular','Mejorar salud general') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nivel_actividad` enum('Sedentario','Ligera','Moderada','Activa','Muy activa') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `user_id`, `edad`, `genero`, `altura`, `objetivo`, `nivel_actividad`, `created_at`, `updated_at`) VALUES
(1, 1, 22, 'Masculino', 160.00, 'Ganar masa muscular', 'Ligera', '2025-08-21 18:48:43', '2025-08-21 18:48:43');

-- --------------------------------------------------------

--
-- Table structure for table `water_records`
--

CREATE TABLE `water_records` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `cantidad_ml` decimal(8,2) NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `water_records`
--

INSERT INTO `water_records` (`id`, `user_id`, `fecha`, `cantidad_ml`, `tipo`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-08-29', 500.00, 'vaso_500ml', '2025-08-29 18:09:41', '2025-08-29 18:09:41'),
(2, 1, '2025-08-29', 1000.00, 'botella_1l', '2025-08-29 18:10:48', '2025-08-29 18:10:48');

-- --------------------------------------------------------

--
-- Table structure for table `weight_records`
--

CREATE TABLE `weight_records` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `peso` decimal(5,2) NOT NULL COMMENT 'Peso en kg',
  `imc` decimal(4,1) DEFAULT NULL COMMENT 'Índice de Masa Corporal',
  `variacion` decimal(5,2) DEFAULT NULL COMMENT 'Variación respecto al registro anterior',
  `es_actual` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si es el registro más actual',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `weight_records`
--

INSERT INTO `weight_records` (`id`, `user_id`, `peso`, `imc`, `variacion`, `es_actual`, `created_at`, `updated_at`) VALUES
(1, 1, 100.00, 39.1, NULL, 0, '2025-08-21 18:48:43', '2025-08-21 18:48:43'),
(2, 1, 99.30, 38.4, -0.70, 0, '2025-08-22 20:48:43', '2025-08-21 20:48:43'),
(3, 1, 99.60, 38.4, 0.30, 0, '2025-08-23 20:48:43', '2025-08-21 20:48:43'),
(4, 1, 98.60, 38.4, -1.00, 0, '2025-08-24 20:48:43', '2025-08-21 20:48:43'),
(5, 1, 98.00, 39.1, -0.60, 0, '2025-08-25 18:48:43', '2025-08-21 18:48:43'),
(6, 1, 97.30, 38.4, -0.70, 0, '2025-08-26 20:48:43', '2025-08-21 20:48:43'),
(7, 1, 96.60, 38.4, -0.70, 0, '2025-08-27 20:48:43', '2025-08-21 20:48:43'),
(8, 1, 96.90, 38.4, 0.30, 0, '2025-08-28 20:48:43', '2025-08-29 18:11:14'),
(10, 1, 90.00, 35.2, -6.90, 1, '2025-08-29 18:11:15', '2025-08-29 18:11:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comidas`
--
ALTER TABLE `comidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comidas_user_id_foreign` (`user_id`);

--
-- Indexes for table `cv_educations`
--
ALTER TABLE `cv_educations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cv_experiences`
--
ALTER TABLE `cv_experiences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cv_experiences_cv_profile_id_foreign` (`cv_profile_id`);

--
-- Indexes for table `cv_profiles`
--
ALTER TABLE `cv_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cv_profiles_user_id_foreign` (`user_id`);

--
-- Indexes for table `cv_skills`
--
ALTER TABLE `cv_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cv_skills_cv_profile_id_foreign` (`cv_profile_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_profiles_user_id_unique` (`user_id`);

--
-- Indexes for table `water_records`
--
ALTER TABLE `water_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `water_records_user_id_fecha_index` (`user_id`,`fecha`);

--
-- Indexes for table `weight_records`
--
ALTER TABLE `weight_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `weight_records_user_id_index` (`user_id`),
  ADD KEY `weight_records_user_id_es_actual_index` (`user_id`,`es_actual`),
  ADD KEY `weight_records_created_at_index` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comidas`
--
ALTER TABLE `comidas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cv_educations`
--
ALTER TABLE `cv_educations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cv_experiences`
--
ALTER TABLE `cv_experiences`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cv_profiles`
--
ALTER TABLE `cv_profiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cv_skills`
--
ALTER TABLE `cv_skills`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `water_records`
--
ALTER TABLE `water_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `weight_records`
--
ALTER TABLE `weight_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comidas`
--
ALTER TABLE `comidas`
  ADD CONSTRAINT `comidas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cv_experiences`
--
ALTER TABLE `cv_experiences`
  ADD CONSTRAINT `cv_experiences_cv_profile_id_foreign` FOREIGN KEY (`cv_profile_id`) REFERENCES `cv_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cv_profiles`
--
ALTER TABLE `cv_profiles`
  ADD CONSTRAINT `cv_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cv_skills`
--
ALTER TABLE `cv_skills`
  ADD CONSTRAINT `cv_skills_cv_profile_id_foreign` FOREIGN KEY (`cv_profile_id`) REFERENCES `cv_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `user_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `water_records`
--
ALTER TABLE `water_records`
  ADD CONSTRAINT `water_records_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `weight_records`
--
ALTER TABLE `weight_records`
  ADD CONSTRAINT `weight_records_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
