-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2025 at 04:00 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_futuretrade`
--

-- --------------------------------------------------------

--
-- Table structure for table `add_country`
--

CREATE TABLE `add_country` (
  `id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `usdt_rate` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `add_country`
--

INSERT INTO `add_country` (`id`, `country_id`, `currency_id`, `usdt_rate`, `status`, `created_at`, `updated_at`) VALUES
(1, 27, 13, 4000.00, 1, '2025-02-26 18:42:55', '2025-02-26 21:10:46'),
(2, 35, 16, 700.00, 1, '2025-02-26 18:43:03', '2025-02-26 19:07:25'),
(3, 13, 5, 300.00, 1, '2025-02-26 18:43:43', '2025-02-26 18:43:43'),
(4, 18, 21, 123.00, 1, '2025-02-26 18:44:46', '2025-02-26 18:44:46'),
(6, 101, 9, 1526.00, 1, '2025-02-26 21:10:10', '2025-02-26 21:28:55'),
(8, 112, 4, 98.00, 1, '2025-02-26 23:33:00', '2025-02-26 23:33:00'),
(11, 10, 2, 5888.00, 1, '2025-02-26 23:34:11', '2025-02-26 23:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `add_user_payment_address`
--

CREATE TABLE `add_user_payment_address` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `add_user_payment_address`
--

INSERT INTO `add_user_payment_address` (`id`, `user_id`, `name`, `wallet_address`, `status`, `created_at`, `updated_at`) VALUES
(1, 5, 'USDT-TRC20-TRX', 'TY9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sT1', 1, '2024-07-14 08:20:01', '2024-07-14 08:20:01'),
(2, 5, 'USDT-TRC20-TRX', 'TY9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sMY', 1, '2024-07-14 08:20:01', '2024-07-14 08:20:01'),
(3, 5, 'USDT-TRC20-TRX', 'TY9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sCW', 1, '2024-07-14 08:20:01', '2024-07-14 08:20:01'),
(4, 5, 'USDT-TRC20-TRX', 'PO9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sT1', 1, '2024-07-14 08:20:01', '2024-07-14 08:20:01'),
(5, 5, 'USDT-TRC20-TRX', 'TIWh7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sT1', 1, '2024-07-14 08:20:01', '2024-07-14 08:20:01'),
(6, 5, 'USDT-TRC20-TRX', 'AY9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sMY', 1, '2025-02-24 08:44:39', '2025-02-24 08:44:39'),
(7, 5, 'USDT-TRC20-TRX', 'JK9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sT1', 1, '2025-02-24 09:23:10', '2025-02-24 09:23:10'),
(9, 5, 'USDT-TRC20-TRX', '23333333333333334', 1, '2025-02-25 10:05:27', '2025-02-25 10:05:27');

-- --------------------------------------------------------

--
-- Table structure for table `api_configs`
--

CREATE TABLE `api_configs` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sn` varchar(255) NOT NULL,
  `api_url` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `api_configs`
--

INSERT INTO `api_configs` (`id`, `name`, `sn`, `api_url`, `key`, `created_at`, `updated_at`) VALUES
(1, 'Create Player', 'guw', 'https://ap.api-bet.net/api/server/create', '2SW80tB9C22800TrO64f9HcA761JR299', '2024-10-17 04:52:28', '2024-10-17 04:52:31'),
(2, 'Credit Transfer', 'guw', 'https://ap.api-bet.net/api/server/transfer', '2SW80tB9C22800TrO64f9HcA761JR299', '2024-10-17 04:52:28', '2024-10-17 04:52:31'),
(3, 'Merchant Quota', 'guw', 'https://ap.api-bet.net/api/server/quota', '2SW80tB9C22800TrO64f9HcA761JR299', '2024-10-17 04:52:28', '2024-10-17 04:52:31'),
(4, 'For Balance', 'guw', 'https://ap.api-bet.net/api/server/balance', '2SW80tB9C22800TrO64f9HcA761JR299', '2024-10-17 04:52:28', '2024-10-17 04:52:31');

-- --------------------------------------------------------

--
-- Table structure for table `api_gamelist_transate`
--

CREATE TABLE `api_gamelist_transate` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `gameid` varchar(255) DEFAULT NULL COMMENT 'ref table api_gamelist',
  `language` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boost_boot_setting`
--

CREATE TABLE `boost_boot_setting` (
  `id` int(11) NOT NULL,
  `mining_categogy_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `total_seconds` int(11) DEFAULT NULL,
  `hours` int(11) DEFAULT NULL,
  `level_cost` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `boost_boot_setting`
--

INSERT INTO `boost_boot_setting` (`id`, `mining_categogy_id`, `name`, `total_seconds`, `hours`, `level_cost`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Level-1', 3600, 1, 0, 1, '2024-07-17 12:39:05', '2024-07-19 14:01:15'),
(2, 1, 'Level-2', 43200, 12, 1, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(3, 1, 'Level-3', 86400, 24, 2, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(4, 1, 'Level-4', 403200, 2880, 10, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(5, 2, 'Level-1', 7200, 2, 0, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(6, 2, 'Level-2', 43200, 12, 2, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(7, 2, 'Level-3', 86400, 24, 5, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(8, 2, 'Level-4', 403200, 2880, 15, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(9, 3, 'Level-1', 14400, 4, 0, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(10, 3, 'Level-2', 43200, 12, 8, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(11, 3, 'Level-3', 86400, 24, 15, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(12, 3, 'Level-4', 403200, 2880, 20, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(13, 4, 'Level-1', 21600, 6, 0, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(14, 4, 'Level-2', 43200, 12, 12, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(15, 4, 'Level-3', 86400, 24, 25, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05'),
(16, 4, 'Level-4', 403200, 2880, 30, 1, '2024-07-17 12:39:05', '2024-07-17 12:39:05');

-- --------------------------------------------------------

--
-- Table structure for table `boost_mining_setting`
--

CREATE TABLE `boost_mining_setting` (
  `id` int(11) NOT NULL,
  `mining_categogy_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `level_cost` int(11) DEFAULT NULL,
  `mining_per_seconds` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `boost_mining_setting`
--

INSERT INTO `boost_mining_setting` (`id`, `mining_categogy_id`, `name`, `level_cost`, `mining_per_seconds`, `sort`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, 'Level-1', 0, 1, 1, '2024-07-16 13:33:31', '2024-07-19 13:25:01', 1),
(2, 1, 'Level-2', 2, 2, 2, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(3, 1, 'Level-3', 3, 3, 3, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(4, 1, 'Level-4', 4, 4, 4, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(5, 1, 'Level-5', 5, 5, 5, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(6, 1, 'Level-6', 6, 6, 6, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(7, 1, 'Level-7', 7, 7, 7, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(8, 1, 'Level-8', 8, 8, 8, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(9, 1, 'Level-9', 9, 9, 9, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(10, 1, 'Max', 10, 10, 10, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(11, 2, 'Level-1', 0, 2, 1, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(12, 2, 'Level-2', 2, 4, 2, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(13, 2, 'Level-3', 3, 6, 3, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(14, 2, 'Level-4', 4, 8, 4, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(15, 2, 'Level-5', 5, 10, 5, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(16, 2, 'Level-6', 6, 12, 6, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(17, 2, 'Level-7', 7, 14, 7, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(18, 2, 'Level-8', 8, 16, 8, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(19, 2, 'Level-9', 9, 18, 9, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(20, 2, 'Level-10', 10, 20, 10, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(21, 3, 'Level-1', 0, 4, 1, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(22, 3, 'Level-2', 2, 8, 2, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(23, 3, 'Level-3', 3, 12, 3, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(24, 3, 'Level-4', 4, 16, 4, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(25, 3, 'Level-5', 5, 20, 5, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(26, 3, 'Level-6', 6, 24, 6, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(27, 3, 'Level-7', 7, 28, 7, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(28, 3, 'Level-8', 8, 32, 8, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(29, 3, 'Level-9', 9, 36, 9, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(30, 3, 'Level-10', 10, 40, 10, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(31, 4, 'Level-1', 0, 6, 1, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(32, 4, 'Level-2', 2, 12, 2, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(33, 4, 'Level-3', 3, 18, 3, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(34, 4, 'Level-4', 4, 24, 4, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(35, 4, 'Level-5', 5, 30, 5, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(36, 4, 'Level-6', 6, 36, 6, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(37, 4, 'Level-7', 7, 42, 7, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(38, 4, 'Level-8', 8, 48, 8, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 1),
(39, 4, 'Level-9', 9, 54, 9, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 0),
(40, 4, 'Level-10', 10, 60, 10, '2024-07-16 13:33:31', '2024-07-16 13:33:31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `buy_token`
--

CREATE TABLE `buy_token` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `usdt_amount` double(10,2) DEFAULT NULL,
  `current_price` varchar(255) DEFAULT NULL COMMENT 'cp',
  `get_token` double(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buy_token`
--

INSERT INTO `buy_token` (`id`, `user_id`, `usdt_amount`, `current_price`, `get_token`, `created_at`, `updated_at`) VALUES
(1, 9, 10.00, '0.0111113333', 899.98, '2024-07-30 21:29:49', '2024-07-30 21:29:49'),
(2, 9, 50.00, '0.001188888889', 42056.07, '2024-07-30 21:34:37', '2024-07-30 21:34:37'),
(3, 9, 21.00, '0.0011244444', 18675.89, '2024-07-31 11:46:22', '2024-07-31 11:46:22'),
(4, 9, 50.00, '0.0011291111', 44282.62, '2024-07-31 11:46:53', '2024-07-31 11:46:53');

-- --------------------------------------------------------

--
-- Table structure for table `categorys`
--

CREATE TABLE `categorys` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `percentage_amt` varchar(100) DEFAULT NULL COMMENT '%',
  `store_price` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keyword` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `file` varchar(255) DEFAULT NULL,
  `bg_images` varchar(255) DEFAULT NULL,
  `store_images` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `mobile_view_class` varchar(255) DEFAULT NULL,
  `keyword` varchar(255) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categorys`
--

INSERT INTO `categorys` (`id`, `name`, `percentage_amt`, `store_price`, `slug`, `language`, `description`, `meta_title`, `meta_description`, `meta_keyword`, `parent_id`, `sort_order`, `file`, `bg_images`, `store_images`, `status`, `mobile_view_class`, `keyword`, `created_at`, `updated_at`) VALUES
(1, '4K Ultra HD', '', NULL, '4k-ultra-hd', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, '4K Ultra HD', '2024-09-09 18:21:09', '2024-09-09 18:21:09'),
(2, '60 FPS', '', NULL, '60-fps', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, '', '2024-09-09 18:21:27', '2024-09-09 18:21:27'),
(3, 'Amateur', '', NULL, 'amateur', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Amateur', '2024-09-09 18:21:38', '2024-09-09 18:21:38'),
(4, 'Anal', '', NULL, 'anal', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Anal', '2024-09-09 18:21:45', '2024-09-09 18:21:45'),
(5, 'Asian', '', NULL, 'asian', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Asian', '2024-09-09 18:21:51', '2024-09-09 18:21:51'),
(6, 'ASMR', '', NULL, 'asmr', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'ASMR', '2024-09-09 18:21:59', '2024-09-09 18:21:59'),
(7, 'BBW', '', NULL, 'bbw', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'BBW', '2024-09-09 18:22:06', '2024-09-09 18:22:06'),
(8, 'BDSM', '', NULL, 'bdsm', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'BDSM', '2024-09-09 18:22:20', '2024-09-09 18:22:20'),
(9, 'Big Ass', '', NULL, 'big-ass', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Big Ass', '2024-09-09 18:22:29', '2024-09-09 18:22:29'),
(10, 'Big Dick', '', NULL, 'big-dick', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Big Dick', '2024-09-09 18:22:35', '2024-09-09 18:22:35'),
(11, 'Big Tits', '', NULL, 'big-tits', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, '', '2024-09-09 18:22:41', '2024-09-09 18:22:41'),
(12, 'Bisexual', '', NULL, 'bisexual', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Bisexual', '2024-09-09 18:22:48', '2024-09-09 18:22:48'),
(13, 'Blonde', '', NULL, 'blonde', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Blonde', '2024-09-09 18:22:56', '2024-09-09 18:22:56'),
(14, 'Blowjob', '', NULL, 'blowjob', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Blowjob', '2024-09-09 18:23:05', '2024-09-09 18:23:05'),
(15, 'Bondage', '', NULL, 'bondage', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Bondage', '2024-09-09 18:23:12', '2024-09-09 18:23:12'),
(16, 'Brunette', '', NULL, 'brunette', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Brunette', '2024-09-09 18:23:19', '2024-09-09 18:23:19'),
(17, 'Bukkake', '', NULL, 'bukkake', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Bukkake', '2024-09-09 18:23:25', '2024-09-09 18:23:25'),
(18, 'Creampie', '', NULL, 'creampie', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Creampie', '2024-09-09 18:23:31', '2024-09-09 18:23:31'),
(19, 'Cumshot', '', NULL, 'cumshot', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Cumshot', '2024-09-09 18:23:37', '2024-09-09 18:23:37'),
(20, 'Double Penetration', '', NULL, 'double-penetration', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Double Penetration', '2024-09-09 18:24:15', '2024-09-09 18:24:15'),
(21, 'Ebony', '', NULL, 'ebony', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Ebony', '2024-09-09 18:24:21', '2024-09-09 18:24:21'),
(22, 'Fat', '', NULL, 'fat', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Fat', '2024-09-09 18:24:27', '2024-09-09 18:24:27'),
(23, 'Fetish', '', NULL, 'fetish', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Fetish', '2024-09-09 18:24:33', '2024-09-09 18:24:33'),
(24, 'Fisting', '', NULL, 'fisting', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Fisting', '2024-09-09 18:24:40', '2024-09-09 18:24:40'),
(25, 'Footjob', '', NULL, 'footjob', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Footjob', '2024-09-09 18:24:50', '2024-09-09 18:24:50'),
(26, 'For Women', '', NULL, 'for-women', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'For Women', '2024-09-09 18:24:57', '2024-09-09 18:25:18'),
(27, 'Gay', '', NULL, 'gay', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Gay', '2024-09-09 18:25:27', '2024-09-09 18:25:27'),
(28, 'Group Sex', '', NULL, 'group-sex', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Group Sex', '2024-09-09 18:25:40', '2024-09-09 18:25:40'),
(29, 'Handjob', '', NULL, 'handjob', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Handjob', '2024-09-09 18:25:48', '2024-09-09 18:25:48'),
(30, 'Hardcore', '', NULL, 'hardcore', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Hardcore', '2024-09-09 18:25:54', '2024-09-09 18:25:54'),
(31, 'HD Porn', '', NULL, 'hd-porn', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'HD Porn', '2024-09-09 18:26:01', '2024-09-09 18:26:01'),
(32, 'HD Sex', '', NULL, 'hd-sex', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'HD Sex', '2024-09-09 18:26:07', '2024-09-09 18:26:07'),
(33, 'Hentai', '', NULL, 'hentai', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Hentai', '2024-09-09 18:26:13', '2024-09-09 18:26:13'),
(34, 'Homemade', '', NULL, 'homemade', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Homemade', '2024-09-09 18:26:21', '2024-09-09 18:26:21'),
(35, 'Hotel', '', NULL, 'hotel', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Hotel', '2024-09-09 18:26:26', '2024-09-09 18:26:26'),
(36, 'Housewives', '', NULL, 'housewives', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Housewives', '2024-09-09 18:26:32', '2024-09-09 18:26:32'),
(37, 'HQ Porn', '', NULL, 'hq-porn', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'HQ Porn', '2024-09-09 18:26:40', '2024-09-09 18:26:40'),
(38, 'Indian', '', NULL, 'indian', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Indian', '2024-09-09 18:26:46', '2024-09-09 18:26:46'),
(39, 'Interracial', '', NULL, 'interracial', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Interracial', '2024-09-09 18:26:52', '2024-09-09 18:26:52'),
(40, 'Japanese', '', NULL, 'japanese', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, '', '2024-09-09 18:27:04', '2024-09-09 18:27:04'),
(41, 'Latina', '', NULL, 'latina', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Latina', '2024-09-09 18:27:11', '2024-09-09 18:27:11'),
(42, 'Lesbian', '', NULL, 'lesbian', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Lesbian', '2024-09-09 18:27:17', '2024-09-09 18:27:17'),
(43, 'Lingerie', '', NULL, 'lingerie', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Lingerie', '2024-09-09 18:27:23', '2024-09-09 18:27:23'),
(44, 'Massage', '', NULL, 'massage', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Massage', '2024-09-09 18:27:30', '2024-09-09 18:27:30'),
(45, 'Masturbation', '', NULL, 'masturbation', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Masturbation', '2024-09-09 18:27:35', '2024-09-09 18:27:35'),
(46, 'Mature', '', NULL, 'mature', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Mature', '2024-09-09 18:27:44', '2024-09-09 18:27:44'),
(47, 'MILF', '', NULL, 'milf', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'MILF', '2024-09-09 18:27:51', '2024-09-09 18:27:51'),
(48, 'Nurses', '', NULL, 'nurses', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Nurses', '2024-09-09 18:27:57', '2024-09-09 18:27:57'),
(49, 'Office', '', NULL, 'office', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Office', '2024-09-09 18:28:09', '2024-09-09 18:28:09'),
(50, 'Older Men', '', NULL, 'older-men', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Older Men', '2024-09-09 18:28:18', '2024-09-09 18:28:18'),
(51, 'Orgy', '', NULL, 'orgy', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Orgy', '2024-09-09 18:28:23', '2024-09-09 18:28:23'),
(52, 'Outdoor', '', NULL, 'outdoor', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Outdoor', '2024-09-09 18:28:28', '2024-09-09 18:28:28'),
(53, 'Petite', '', NULL, 'petite', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Petite', '2024-09-09 18:28:33', '2024-09-09 18:28:33'),
(54, 'Pornstar', '', NULL, 'pornstar', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Pornstar', '2024-09-09 18:28:39', '2024-09-09 18:28:39'),
(55, 'POV', '', NULL, 'pov', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'POV', '2024-09-09 18:28:53', '2024-09-09 18:28:53'),
(56, 'Public', '', NULL, 'public', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Public', '2024-09-09 18:28:58', '2024-09-09 18:28:58'),
(57, 'Redhead', '', NULL, 'redhead', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Redhead', '2024-09-09 18:29:04', '2024-09-09 18:29:04'),
(58, 'Shemale', '', NULL, 'shemale', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Shemale', '2024-09-09 18:29:10', '2024-09-09 18:29:10'),
(59, 'Sleep', '', NULL, 'sleep', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Sleep', '2024-09-09 18:29:17', '2024-09-09 18:29:17'),
(60, 'Small Tits', '', NULL, 'small-tits', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Small Tits', '2024-09-09 18:29:28', '2024-09-09 18:29:28'),
(61, 'Squirt', '', NULL, 'squirt', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Squirt', '2024-09-09 18:29:33', '2024-09-09 18:29:33'),
(62, 'Striptease', '', NULL, 'striptease', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Striptease', '2024-09-09 18:29:39', '2024-09-09 18:29:39'),
(63, 'Students', '', NULL, 'students', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Students', '2024-09-09 18:29:45', '2024-09-09 18:29:45'),
(64, 'Swinger', '', NULL, 'swinger', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Swinger', '2024-09-09 18:29:52', '2024-09-09 18:29:52'),
(65, 'Teen', '', NULL, 'teen', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Teen', '2024-09-09 18:29:58', '2024-09-09 18:29:58'),
(66, 'Threesome', '', NULL, 'threesome', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Threesome', '2024-09-09 18:30:05', '2024-09-09 18:30:05'),
(67, 'Toys', '', NULL, 'toys', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Toys', '2024-09-09 18:30:10', '2024-09-09 18:30:10'),
(68, 'Uncategorized', '', NULL, 'uncategorized', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Uncategorized', '2024-09-09 18:30:18', '2024-09-09 18:30:18'),
(69, 'Uniform', '', NULL, 'uniform', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Uniform', '2024-09-09 18:30:24', '2024-09-09 18:30:24'),
(70, 'Vintage', '', NULL, 'vintage', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Vintage', '2024-09-09 18:30:29', '2024-09-09 18:30:29'),
(71, 'VR Porn', '', NULL, 'vr-porn', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'VR Porn', '2024-09-09 18:30:38', '2024-09-09 18:30:38'),
(72, 'Webcam', '', NULL, 'webcam', 'en', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Webcam', '2024-09-09 18:30:44', '2024-09-09 18:30:44'),
(77, 'ফোর কে আল্ট্রা এইচডি ', '', NULL, '4k-ultra-hd', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, '4K Ultra HD', '2024-09-09 18:21:09', '2024-09-09 18:21:09'),
(78, '৬০ ফপিস', '', NULL, '60-fps', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, '', '2024-09-09 18:21:27', '2024-09-09 18:21:27'),
(79, 'অ্যামেচার ', '', NULL, 'amateur', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Amateur', '2024-09-09 18:21:38', '2024-09-09 18:21:38'),
(80, 'এনাল ', '', NULL, 'anal', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Anal', '2024-09-09 18:21:45', '2024-09-09 18:21:45'),
(81, 'অসমৰ ', '', NULL, 'asmr', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'ASMR', '2024-09-09 18:21:59', '2024-09-09 18:21:59'),
(82, 'বাবু ', '', NULL, 'bbw', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'BBW', '2024-09-09 18:22:06', '2024-09-09 18:22:06'),
(83, 'বিডিএসএম', '', NULL, 'bdsm', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'BDSM', '2024-09-09 18:22:20', '2024-09-09 18:22:20'),
(84, 'বিগ অ্যাস', '', NULL, 'big-ass', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Big Ass', '2024-09-09 18:22:29', '2024-09-09 18:22:29'),
(85, 'বিগ ডিক', '', NULL, 'big-dick', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Big Dick', '2024-09-09 18:22:35', '2024-09-09 18:22:35'),
(86, 'বিগ টিটস', '', NULL, 'big-tits', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, '', '2024-09-09 18:22:41', '2024-09-09 18:22:41'),
(87, 'বিসেক্সচুয়াল', '', NULL, 'bisexual', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Bisexual', '2024-09-09 18:22:48', '2024-09-09 18:22:48'),
(88, 'ব্লন্ডে ', '', NULL, 'blonde', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Blonde', '2024-09-09 18:22:56', '2024-09-09 18:22:56'),
(89, 'ব্লউজবি', '', NULL, 'blowjob', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Blowjob', '2024-09-09 18:23:05', '2024-09-09 18:23:05'),
(90, 'বোন্দাজে', '', NULL, 'brunette', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Brunette', '2024-09-09 18:23:19', '2024-09-09 18:23:19'),
(91, 'ব্রুনেটতে ', '', NULL, 'brunette', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Brunette', '2024-09-09 18:23:19', '2024-09-09 18:23:19'),
(92, 'বুক্কাকে ', '', NULL, 'bukkake', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Bukkake', '2024-09-09 18:23:25', '2024-09-09 18:23:25'),
(93, 'ক্রিমপিএ', '', NULL, 'creampie', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Creampie', '2024-09-09 18:23:31', '2024-09-09 18:23:31'),
(94, 'কামশত', '', NULL, 'cumshot', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Cumshot', '2024-09-09 18:23:37', '2024-09-09 18:23:37'),
(95, 'ডাবল পেনিট্রেশন', '', NULL, 'double-penetration', 'bn', '', '', '', '', 0, 0, NULL, NULL, NULL, 1, NULL, 'Double Penetration', '2024-09-09 18:24:15', '2024-09-09 18:24:15');

-- --------------------------------------------------------

--
-- Table structure for table `community`
--

CREATE TABLE `community` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community`
--

INSERT INTO `community` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Community (English)', 'community-english', 1, '2024-05-28 14:05:53', '2024-05-28 14:05:53'),
(2, 'Community (Chinese)', 'community-chinese', 1, '2024-05-28 14:07:25', '2024-05-28 12:10:52'),
(3, 'Community (Arabic)', 'community-arabic', 1, '2024-05-28 14:07:25', '2024-05-28 12:10:52'),
(4, 'Community (Malasian)', 'community-malasian', 1, '2024-05-28 14:07:25', '2024-05-28 12:10:52'),
(5, 'Community (Hindi/Urdu)', 'community-hindi-urdu', 1, '2024-05-28 14:07:25', '2024-05-28 12:10:52');

-- --------------------------------------------------------

--
-- Table structure for table `countdown`
--

CREATE TABLE `countdown` (
  `id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `currenttime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `countdown`
--

INSERT INTO `countdown` (`id`, `start_time`, `end_time`, `currenttime`) VALUES
(1, '2024-05-01 22:25:43', '2024-05-01 22:30:43', '2024-05-26 13:13:19');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `shortname` varchar(3) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phonecode` int(11) NOT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `shortname`, `name`, `phonecode`, `status`) VALUES
(1, 'AF', 'Afghanistan', 93, 1),
(2, 'AL', 'Albania', 355, 1),
(3, 'DZ', 'Algeria', 213, 1),
(4, 'AS', 'American Samoa', 1684, 1),
(5, 'AD', 'Andorra', 376, 1),
(6, 'AO', 'Angola', 244, 1),
(7, 'AI', 'Anguilla', 1264, 1),
(8, 'AQ', 'Antarctica', 0, 1),
(9, 'AG', 'Antigua And Barbuda', 1268, 1),
(10, 'AR', 'Argentina', 54, 1),
(11, 'AM', 'Armenia', 374, 1),
(12, 'AW', 'Aruba', 297, 1),
(13, 'AU', 'Australia', 61, 1),
(14, 'AT', 'Austria', 43, 1),
(15, 'AZ', 'Azerbaijan', 994, 1),
(16, 'BS', 'Bahamas The', 1242, 1),
(17, 'BH', 'Bahrain', 973, 1),
(18, 'BD', 'Bangladesh', 880, 1),
(19, 'BB', 'Barbados', 1246, 1),
(20, 'BY', 'Belarus', 375, 1),
(21, 'BE', 'Belgium', 32, 1),
(22, 'BZ', 'Belize', 501, 1),
(23, 'BJ', 'Benin', 229, 1),
(24, 'BM', 'Bermuda', 1441, 1),
(25, 'BT', 'Bhutan', 975, 1),
(26, 'BO', 'Bolivia', 591, 1),
(27, 'BA', 'Bosnia and Herzegovina', 387, 1),
(28, 'BW', 'Botswana', 267, 1),
(29, 'BV', 'Bouvet Island', 0, 1),
(30, 'BR', 'Brazil', 55, 1),
(31, 'IO', 'British Indian Ocean Territory', 246, 1),
(32, 'BN', 'Brunei', 673, 1),
(33, 'BG', 'Bulgaria', 359, 1),
(34, 'BF', 'Burkina Faso', 226, 1),
(35, 'BI', 'Burundi', 257, 1),
(36, 'KH', 'Cambodia', 855, 1),
(37, 'CM', 'Cameroon', 237, 1),
(38, 'CA', 'Canada', 1, 1),
(39, 'CV', 'Cape Verde', 238, 1),
(40, 'KY', 'Cayman Islands', 1345, 1),
(41, 'CF', 'Central African Republic', 236, 1),
(42, 'TD', 'Chad', 235, 1),
(43, 'CL', 'Chile', 56, 1),
(44, 'CN', 'China', 86, 1),
(45, 'CX', 'Christmas Island', 61, 1),
(46, 'CC', 'Cocos (Keeling) Islands', 672, 1),
(47, 'CO', 'Colombia', 57, 1),
(48, 'KM', 'Comoros', 269, 1),
(49, 'CG', 'Republic Of The Congo', 242, 1),
(50, 'CD', 'Democratic Republic Of The Congo', 242, 1),
(51, 'CK', 'Cook Islands', 682, 1),
(52, 'CR', 'Costa Rica', 506, 1),
(53, 'CI', 'Cote D\'Ivoire (Ivory Coast)', 225, 1),
(54, 'HR', 'Croatia (Hrvatska)', 385, 1),
(55, 'CU', 'Cuba', 53, 1),
(56, 'CY', 'Cyprus', 357, 1),
(57, 'CZ', 'Czech Republic', 420, 1),
(58, 'DK', 'Denmark', 45, 1),
(59, 'DJ', 'Djibouti', 253, 1),
(60, 'DM', 'Dominica', 1767, 1),
(61, 'DO', 'Dominican Republic', 1809, 1),
(62, 'TP', 'East Timor', 670, 1),
(63, 'EC', 'Ecuador', 593, 1),
(64, 'EG', 'Egypt', 20, 1),
(65, 'SV', 'El Salvador', 503, 1),
(66, 'GQ', 'Equatorial Guinea', 240, 1),
(67, 'ER', 'Eritrea', 291, 1),
(68, 'EE', 'Estonia', 372, 1),
(69, 'ET', 'Ethiopia', 251, 1),
(70, 'XA', 'External Territories of Australia', 61, 1),
(71, 'FK', 'Falkland Islands', 500, 1),
(72, 'FO', 'Faroe Islands', 298, 1),
(73, 'FJ', 'Fiji Islands', 679, 1),
(74, 'FI', 'Finland', 358, 1),
(75, 'FR', 'France', 33, 1),
(76, 'GF', 'French Guiana', 594, 1),
(77, 'PF', 'French Polynesia', 689, 1),
(78, 'TF', 'French Southern Territories', 0, 1),
(79, 'GA', 'Gabon', 241, 1),
(80, 'GM', 'Gambia The', 220, 1),
(81, 'GE', 'Georgia', 995, 1),
(82, 'DE', 'Germany', 49, 1),
(83, 'GH', 'Ghana', 233, 1),
(84, 'GI', 'Gibraltar', 350, 1),
(85, 'GR', 'Greece', 30, 1),
(86, 'GL', 'Greenland', 299, 1),
(87, 'GD', 'Grenada', 1473, 1),
(88, 'GP', 'Guadeloupe', 590, 1),
(89, 'GU', 'Guam', 1671, 1),
(90, 'GT', 'Guatemala', 502, 1),
(91, 'XU', 'Guernsey and Alderney', 44, 1),
(92, 'GN', 'Guinea', 224, 1),
(93, 'GW', 'Guinea-Bissau', 245, 1),
(94, 'GY', 'Guyana', 592, 1),
(95, 'HT', 'Haiti', 509, 1),
(96, 'HM', 'Heard and McDonald Islands', 0, 1),
(97, 'HN', 'Honduras', 504, 1),
(98, 'HK', 'Hong Kong S.A.R.', 852, 1),
(99, 'HU', 'Hungary', 36, 1),
(100, 'IS', 'Iceland', 354, 1),
(101, 'IN', 'India', 91, 1),
(102, 'ID', 'Indonesia', 62, 1),
(103, 'IR', 'Iran', 98, 1),
(104, 'IQ', 'Iraq', 964, 1),
(105, 'IE', 'Ireland', 353, 1),
(106, 'IL', 'Israel', 972, 1),
(107, 'IT', 'Italy', 39, 1),
(108, 'JM', 'Jamaica', 1876, 1),
(109, 'JP', 'Japan', 81, 1),
(110, 'XJ', 'Jersey', 44, 1),
(111, 'JO', 'Jordan', 962, 1),
(112, 'KZ', 'Kazakhstan', 7, 1),
(113, 'KE', 'Kenya', 254, 1),
(114, 'KI', 'Kiribati', 686, 1),
(115, 'KP', 'Korea North', 850, 1),
(116, 'KR', 'Korea South', 82, 1),
(117, 'KW', 'Kuwait', 965, 1),
(118, 'KG', 'Kyrgyzstan', 996, 1),
(119, 'LA', 'Laos', 856, 1),
(120, 'LV', 'Latvia', 371, 1),
(121, 'LB', 'Lebanon', 961, 1),
(122, 'LS', 'Lesotho', 266, 1),
(123, 'LR', 'Liberia', 231, 1),
(124, 'LY', 'Libya', 218, 1),
(125, 'LI', 'Liechtenstein', 423, 1),
(126, 'LT', 'Lithuania', 370, 1),
(127, 'LU', 'Luxembourg', 352, 1),
(128, 'MO', 'Macau S.A.R.', 853, 1),
(129, 'MK', 'Macedonia', 389, 1),
(130, 'MG', 'Madagascar', 261, 1),
(131, 'MW', 'Malawi', 265, 1),
(132, 'MY', 'Malaysia', 60, 1),
(133, 'MV', 'Maldives', 960, 1),
(134, 'ML', 'Mali', 223, 1),
(135, 'MT', 'Malta', 356, 1),
(136, 'XM', 'Man (Isle of)', 44, 1),
(137, 'MH', 'Marshall Islands', 692, 1),
(138, 'MQ', 'Martinique', 596, 1),
(139, 'MR', 'Mauritania', 222, 1),
(140, 'MU', 'Mauritius', 230, 1),
(141, 'YT', 'Mayotte', 269, 1),
(142, 'MX', 'Mexico', 52, 1),
(143, 'FM', 'Micronesia', 691, 1),
(144, 'MD', 'Moldova', 373, 1),
(145, 'MC', 'Monaco', 377, 1),
(146, 'MN', 'Mongolia', 976, 1),
(147, 'MS', 'Montserrat', 1664, 1),
(148, 'MA', 'Morocco', 212, 1),
(149, 'MZ', 'Mozambique', 258, 1),
(150, 'MM', 'Myanmar', 95, 1),
(151, 'NA', 'Namibia', 264, 1),
(152, 'NR', 'Nauru', 674, 1),
(153, 'NP', 'Nepal', 977, 1),
(154, 'AN', 'Netherlands Antilles', 599, 1),
(155, 'NL', 'Netherlands The', 31, 1),
(156, 'NC', 'New Caledonia', 687, 1),
(157, 'NZ', 'New Zealand', 64, 1),
(158, 'NI', 'Nicaragua', 505, 1),
(159, 'NE', 'Niger', 227, 1),
(160, 'NG', 'Nigeria', 234, 1),
(161, 'NU', 'Niue', 683, 1),
(162, 'NF', 'Norfolk Island', 672, 1),
(163, 'MP', 'Northern Mariana Islands', 1670, 1),
(164, 'NO', 'Norway', 47, 1),
(165, 'OM', 'Oman', 968, 1),
(166, 'PK', 'Pakistan', 92, 1),
(167, 'PW', 'Palau', 680, 1),
(168, 'PS', 'Palestinian Territory Occupied', 970, 1),
(169, 'PA', 'Panama', 507, 1),
(170, 'PG', 'Papua new Guinea', 675, 1),
(171, 'PY', 'Paraguay', 595, 1),
(172, 'PE', 'Peru', 51, 1),
(173, 'PH', 'Philippines', 63, 1),
(174, 'PN', 'Pitcairn Island', 0, 1),
(175, 'PL', 'Poland', 48, 1),
(176, 'PT', 'Portugal', 351, 1),
(177, 'PR', 'Puerto Rico', 1787, 1),
(178, 'QA', 'Qatar', 974, 1),
(179, 'RE', 'Reunion', 262, 1),
(180, 'RO', 'Romania', 40, 1),
(181, 'RU', 'Russia', 70, 1),
(182, 'RW', 'Rwanda', 250, 1),
(183, 'SH', 'Saint Helena', 290, 1),
(184, 'KN', 'Saint Kitts And Nevis', 1869, 1),
(185, 'LC', 'Saint Lucia', 1758, 1),
(186, 'PM', 'Saint Pierre and Miquelon', 508, 1),
(187, 'VC', 'Saint Vincent And The Grenadines', 1784, 1),
(188, 'WS', 'Samoa', 684, 1),
(189, 'SM', 'San Marino', 378, 1),
(190, 'ST', 'Sao Tome and Principe', 239, 1),
(191, 'SA', 'Saudi Arabia', 966, 1),
(192, 'SN', 'Senegal', 221, 1),
(193, 'RS', 'Serbia', 381, 1),
(194, 'SC', 'Seychelles', 248, 1),
(195, 'SL', 'Sierra Leone', 232, 1),
(196, 'SG', 'Singapore', 65, 1),
(197, 'SK', 'Slovakia', 421, 1),
(198, 'SI', 'Slovenia', 386, 1),
(199, 'XG', 'Smaller Territories of the UK', 44, 1),
(200, 'SB', 'Solomon Islands', 677, 1),
(201, 'SO', 'Somalia', 252, 1),
(202, 'ZA', 'South Africa', 27, 1),
(203, 'GS', 'South Georgia', 0, 1),
(204, 'SS', 'South Sudan', 211, 1),
(205, 'ES', 'Spain', 34, 1),
(206, 'LK', 'Sri Lanka', 94, 1),
(207, 'SD', 'Sudan', 249, 1),
(208, 'SR', 'Suriname', 597, 1),
(209, 'SJ', 'Svalbard And Jan Mayen Islands', 47, 1),
(210, 'SZ', 'Swaziland', 268, 1),
(211, 'SE', 'Sweden', 46, 1),
(212, 'CH', 'Switzerland', 41, 1),
(213, 'SY', 'Syria', 963, 1),
(214, 'TW', 'Taiwan', 886, 1),
(215, 'TJ', 'Tajikistan', 992, 1),
(216, 'TZ', 'Tanzania', 255, 1),
(217, 'TH', 'Thailand', 66, 1),
(218, 'TG', 'Togo', 228, 1),
(219, 'TK', 'Tokelau', 690, 1),
(220, 'TO', 'Tonga', 676, 1),
(221, 'TT', 'Trinidad And Tobago', 1868, 1),
(222, 'TN', 'Tunisia', 216, 1),
(223, 'TR', 'Turkey', 90, 1),
(224, 'TM', 'Turkmenistan', 7370, 1),
(225, 'TC', 'Turks And Caicos Islands', 1649, 1),
(226, 'TV', 'Tuvalu', 688, 1),
(227, 'UG', 'Uganda', 256, 1),
(228, 'UA', 'Ukraine', 380, 1),
(229, 'AE', 'United Arab Emirates', 971, 1),
(230, 'GB', 'United Kingdom', 44, 1),
(231, 'US', 'United States', 1, 1),
(232, 'UM', 'United States Minor Outlying Islands', 1, 1),
(233, 'UY', 'Uruguay', 598, 1),
(234, 'UZ', 'Uzbekistan', 998, 1),
(235, 'VU', 'Vanuatu', 678, 1),
(236, 'VA', 'Vatican City State (Holy See)', 39, 1),
(237, 'VE', 'Venezuela', 58, 1),
(238, 'VN', 'Vietnam', 84, 1),
(239, 'VG', 'Virgin Islands (British)', 1284, 1),
(240, 'VI', 'Virgin Islands (US)', 1340, 1),
(241, 'WF', 'Wallis And Futuna Islands', 681, 1),
(242, 'EH', 'Western Sahara', 212, 1),
(243, 'YE', 'Yemen', 967, 1),
(244, 'YU', 'Yugoslavia', 38, 1),
(245, 'ZM', 'Zambia', 260, 1),
(246, 'ZW', 'Zimbabwe', 263, 1);

-- --------------------------------------------------------

--
-- Table structure for table `country_wise_bank`
--

CREATE TABLE `country_wise_bank` (
  `id` int(11) NOT NULL,
  `add_country_id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `bank_name` varchar(255) NOT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `ific_code` varchar(255) DEFAULT NULL,
  `swift_code` varchar(255) DEFAULT NULL,
  `others_code` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `country_wise_bank`
--

INSERT INTO `country_wise_bank` (`id`, `add_country_id`, `country_id`, `bank_name`, `account_name`, `account_number`, `ific_code`, `swift_code`, `others_code`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 35, 'DBBL', 'Md. Gtazi Giash Uddin', '55112365696', NULL, '1256', NULL, 1, '2025-02-26 20:57:22', '2025-02-26 23:28:23'),
(2, 6, 101, 'Punjab National Bank (PNB)', 'Jusna', '4511236569659', 'PNB4598', '', '', 1, '2025-02-26 20:59:42', '2025-02-26 23:37:33'),
(3, 6, 101, 'INDIA BANK', 'Pronoy Kumanr11111', '4411236569658', '124569', NULL, NULL, 1, '2025-02-26 21:29:47', '2025-02-26 23:28:42'),
(4, 6, 101, 'HDFC Bank', 'Gazi', '4411236569659', '124568', NULL, NULL, 1, '2025-02-26 23:32:35', '2025-02-26 23:32:35'),
(5, 4, 18, 'DBBL', 'Gazi Giash Uddin', '4511236569658', NULL, '12569DBL', NULL, 1, '2025-02-26 23:34:49', '2025-02-26 23:34:49');

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `symbol` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`id`, `name`, `symbol`, `status`, `created_at`, `updated_at`) VALUES
(1, 'United States Dollar', 'USD', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(2, 'Euro', 'EUR', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(3, 'British Pound', 'GBP', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(4, 'Japanese Yen', 'JPY', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(5, 'Australian Dollar', 'AUD', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(6, 'Canadian Dollar', 'CAD', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(7, 'Swiss Franc', 'CHF', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(8, 'Chinese Yuan', 'CNY', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(9, 'Indian Rupee', 'INR', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(10, 'Russian Ruble', 'RUB', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(11, 'Brazilian Real', 'BRL', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(12, 'South Korean Won', 'KRW', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(13, 'Turkish Lira', 'TRY', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(14, 'South African Rand', 'ZAR', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(15, 'Singapore Dollar', 'SGD', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(16, 'Hong Kong Dollar', 'HKD', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(17, 'Mexican Peso', 'MXN', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(18, 'New Zealand Dollar', 'NZD', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(19, 'United Arab Emirates Dirham', 'AED', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(20, 'Tether (USDT)', 'USDT', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47'),
(21, 'Bangladeshi Taka', 'BDT', 1, '2025-02-26 16:54:47', '2025-02-26 16:54:47');

-- --------------------------------------------------------

--
-- Table structure for table `currency_type`
--

CREATE TABLE `currency_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currency_type`
--

INSERT INTO `currency_type` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'USDT-TRC20-TRX', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(2, 'USDT-ERC20', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(3, 'USDT-OMNI', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(4, 'BTC', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(5, 'LTC', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(6, 'ETH', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(7, 'TRX', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(8, 'ADA', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `name` varchar(225) DEFAULT NULL,
  `addres` varchar(255) DEFAULT NULL,
  `email` varchar(225) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `entry_by` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `name`, `addres`, `email`, `phone`, `entry_by`, `status`, `created_at`, `updated_at`) VALUES
(3, 'Bijon Ahmed', 'Dhaka', 'mdbijon@gmail.com', '5989899', NULL, 1, '2024-02-12 07:15:21', '2024-02-12 07:15:21'),
(4, 'Sumon Ahmed', 'Dhaka', 'sumon@gmail.com', '5748788', NULL, 1, '2024-02-12 07:20:35', '2024-02-12 07:20:35'),
(5, 'Robiul Islam', NULL, 'robiul@gmail.com', '2365989899', NULL, 1, '2024-02-12 07:31:40', '2024-02-12 07:31:40'),
(6, 'Mohammad Ibraheem', NULL, 'ibraheem@gmail.com', '5987999', NULL, 1, '2024-02-12 07:46:55', '2024-02-12 07:46:55');

-- --------------------------------------------------------

--
-- Table structure for table `customer_history`
--

CREATE TABLE `customer_history` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `id` int(11) NOT NULL,
  `depositID` varchar(255) DEFAULT NULL,
  `random_key` varchar(255) DEFAULT NULL,
  `cryptoType` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `gaming_pltform_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `orderId` varchar(255) DEFAULT NULL,
  `deposit_amount` double(10,2) DEFAULT NULL,
  `receivable_amount` double(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0=Review,2=Reject,1=Approved',
  `payment_method` varchar(255) DEFAULT NULL,
  `to_crypto_wallet_address` varchar(255) DEFAULT NULL,
  `depsoit_images` varchar(255) DEFAULT NULL,
  `frm_wallet_address` varchar(255) DEFAULT NULL,
  `trxId` varchar(255) DEFAULT NULL,
  `depscription` text DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `currencySymbol` varchar(255) DEFAULT NULL COMMENT 'For Bank',
  `bank_name` varchar(255) DEFAULT NULL COMMENT 'For Bank',
  `account_name` varchar(255) DEFAULT NULL COMMENT 'For Bank',
  `account_number` varchar(255) DEFAULT NULL COMMENT 'For Bank',
  `ific_code` varchar(255) DEFAULT NULL COMMENT 'For Bank',
  `swift_code` varchar(255) DEFAULT NULL COMMENT 'For Bank',
  `others_code` varchar(255) DEFAULT NULL COMMENT 'For Bank',
  `inputAmount` decimal(10,2) DEFAULT NULL COMMENT 'For Bank',
  `countryId` int(11) DEFAULT NULL COMMENT 'For Bank',
  `country_wise_bank_id` int(11) DEFAULT NULL COMMENT 'For Bank',
  `approved_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deposit`
--

INSERT INTO `deposit` (`id`, `depositID`, `random_key`, `cryptoType`, `user_id`, `gaming_pltform_id`, `currency_id`, `orderId`, `deposit_amount`, `receivable_amount`, `status`, `payment_method`, `to_crypto_wallet_address`, `depsoit_images`, `frm_wallet_address`, `trxId`, `depscription`, `wallet_address`, `currencySymbol`, `bank_name`, `account_name`, `account_number`, `ific_code`, `swift_code`, `others_code`, `inputAmount`, `countryId`, `country_wise_bank_id`, `approved_by`, `created_at`, `updated_at`) VALUES
(1, 'DE.2b763288faedb7707c0748abe015ab6c', NULL, 'BTC', 5, NULL, NULL, NULL, 100.00, 100.00, 1, 'CRYPTO', '', '/backend/deposit_screenshort/mHbhNHRtqPzAMPlzro7r.jpg', '', '67bc0771bc09b', 'DE.2b763288faedb7707c0748abe015ab6c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-02-24 11:45:21', '2025-02-24 11:45:21'),
(2, 'DE.5b5c2e6aacc6ceb83ee96e328e591aea', NULL, 'BTC', 5, NULL, NULL, 'c81e728d9d4c2f636f067f89cc14862c', 1000.00, 1000.00, 1, 'CRYPTO', '', '/backend/deposit_screenshort/tpyRSBhXYS8rW1ZuqEdO.jpg', '', '67bc08b784ddd', 'DE.5b5c2e6aacc6ceb83ee96e328e591aea', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-02-24 11:50:47', '2025-02-24 23:37:22'),
(3, 'DE.0f3c5d0c3666eec8cd311bec6d878915', NULL, 'ETH', 5, NULL, NULL, NULL, 300.00, 300.00, 2, 'CRYPTO', '', '/backend/deposit_screenshort/eZxCw5iivyESopx3sLRF.jpg', '', '67bc49e749d88', 'DE.0f3c5d0c3666eec8cd311bec6d878915', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-02-24 16:28:55', '2025-02-24 23:52:29'),
(4, 'DE.aceacd5df18526f1d96ee1b9714e95eb', NULL, 'BTC', 5, NULL, NULL, NULL, 1950.00, 1950.00, 1, 'CRYPTO', '', '/backend/deposit_screenshort/vHTb9mlGR57M8FmiMxFt.jpg', '', '67bebd821fb03', 'DE.aceacd5df18526f1d96ee1b9714e95eb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-02-26 13:06:42', '2025-02-26 13:58:55'),
(5, 'DE.1db3fa8e5bbd04882892f478a301a311', NULL, 'BTC', 5, NULL, NULL, NULL, 500.00, NULL, 0, 'CRYPTO', '', '/backend/deposit_screenshort/ojxpS04oyc4c8h8H1zQp.jpg', '', '67bf7a9417e79', 'DE.1db3fa8e5bbd04882892f478a301a311', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-02-27 02:33:24', '2025-02-27 02:33:24'),
(6, 'D.344ef5151be171062f42f03e69663ecf', NULL, NULL, 5, NULL, NULL, NULL, 48.78, NULL, 0, 'BANK', NULL, '/backend/deposit_screenshort/wfgFBo3323dwPXBOsvEz.jpg', NULL, '67bf7e2d16dc6', 'D.344ef5151be171062f42f03e69663ecf', NULL, 'BDT', 'DBBL', 'Gazi Giash Uddin', '4511236569658', NULL, '12569DBL', NULL, 6000.00, 18, 5, NULL, '2025-02-27 02:48:45', '2025-02-27 02:48:45'),
(7, 'D.b93f11867481fc6d77908aea58ba6198', NULL, NULL, 5, NULL, NULL, NULL, 6.55, NULL, 0, 'BANK', NULL, '/backend/deposit_screenshort/d5pneEq9uo3ASDxtumy7.jpg', NULL, '67bf7e7366f3d', 'D.b93f11867481fc6d77908aea58ba6198', NULL, 'INR', 'Punjab National Bank (PNB)', 'Jusna', '4511236569659', 'PNB4598', NULL, NULL, 10000.00, 101, 2, NULL, '2025-02-27 02:49:55', '2025-02-27 02:49:55'),
(8, 'D.320e4df890a1a620573db8170f39a093', NULL, NULL, 5, NULL, NULL, NULL, 40.65, NULL, 0, 'BANK', NULL, '/backend/deposit_screenshort/sbk1qOwbZbg0FbZ9FOCn.png', NULL, '67bf878ece8ae', 'D.320e4df890a1a620573db8170f39a093', NULL, 'BDT', 'DBBL', 'Gazi Giash Uddin', '4511236569658', NULL, '12569DBL', NULL, 5000.00, 18, 5, NULL, '2025-02-27 03:28:46', '2025-02-27 03:28:46');

-- --------------------------------------------------------

--
-- Table structure for table `expense_history`
--

CREATE TABLE `expense_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `business_type` varchar(255) DEFAULT NULL,
  `operation_type` varchar(255) DEFAULT NULL,
  `amount_type` varchar(255) DEFAULT NULL,
  `operation_amount` double(10,2) DEFAULT NULL,
  `charge_description` varchar(255) DEFAULT NULL,
  `operation_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_history`
--

INSERT INTO `expense_history` (`id`, `user_id`, `business_type`, `operation_type`, `amount_type`, `operation_amount`, `charge_description`, `operation_date`, `created_at`, `updated_at`) VALUES
(1, 20, NULL, 'Debited', NULL, 2.00, 'ddd [ID: 1] ', '2024-06-22', '2024-06-22 06:59:05', '2024-06-22 06:59:05'),
(2, 20, NULL, 'Debited', NULL, 5.00, 'sss [ID: 2] ', '2024-06-22', '2024-06-22 07:07:37', '2024-06-22 07:07:37'),
(3, 20, NULL, 'Credited', NULL, 2.00, 'dd [ID: 3] ', '2024-06-22', '2024-06-22 07:15:18', '2024-06-22 07:15:18'),
(4, 20, NULL, 'Credited', NULL, 2.00, 'ffff [ID: 4] ', '2024-06-22', '2024-06-22 07:18:42', '2024-06-22 07:18:42'),
(5, 20, NULL, 'Credited', NULL, 2.00, 'fffffffffffffff [ID: 5] ', '2024-06-22', '2024-06-22 07:19:08', '2024-06-22 07:19:08'),
(6, 20, NULL, 'Debited', NULL, 5.00, 'Test [ID: 1] ', '2024-06-22', '2024-06-22 07:24:36', '2024-06-22 07:24:36'),
(7, 3, NULL, 'Debited', NULL, 5.00, 'ssss [ID: 2] ', '2024-06-22', '2024-06-22 07:25:46', '2024-06-22 07:25:46'),
(8, 3, NULL, 'Credited', NULL, 1.00, 'fff [ID: 3] ', '2024-06-22', '2024-06-22 07:27:10', '2024-06-22 07:27:10'),
(9, 9, NULL, 'Debited', NULL, 5000.00, 'sfsf [ID: 4] ', '2024-08-02', '2024-08-02 01:12:03', '2024-08-02 01:12:03'),
(10, 9, NULL, 'Debited', NULL, 10000.00, 'sss [ID: 1] ', '2024-08-02', '2024-08-02 01:17:17', '2024-08-02 01:17:17'),
(11, 9, NULL, 'Debited', NULL, 50000.00, 'Detailed remarksDetailed remarksDetailed remarks [ID: 2] ', '2024-08-02', '2024-08-02 01:20:18', '2024-08-02 01:20:18'),
(12, 9, NULL, 'Debited', NULL, 6000.00, 'dd [ID: 3] ', '2024-08-02', '2024-08-02 01:20:31', '2024-08-02 01:20:31'),
(13, 9, NULL, 'Credited', NULL, 6000.00, 'ddd [ID: 4] ', '2024-08-02', '2024-08-02 01:20:47', '2024-08-02 01:20:47'),
(14, 12, NULL, 'Debited', NULL, 1055.00, 'sfsf [ID: 5] ', '2024-08-02', '2024-08-02 01:50:22', '2024-08-02 01:50:22'),
(15, 12, NULL, 'Debited', NULL, 520.00, 's [ID: 6] ', '2024-08-02', '2024-08-02 01:50:39', '2024-08-02 01:50:39'),
(16, 9, NULL, 'Credited', NULL, 500.00, 'For Reward Purpose [ID: 7] ', '2024-08-02', '2024-08-02 01:51:42', '2024-08-02 01:51:42');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '5d64097e-af0c-492d-931d-2ec78ed2263f', 'database', 'default', '{\"uuid\":\"5d64097e-af0c-492d-931d-2ec78ed2263f\",\"displayName\":\"App\\\\Jobs\\\\LargeExcelJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\LargeExcelJob\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\LargeExcelJob\\\":1:{s:11:\\\"\\u0000*\\u0000filePath\\\";s:53:\\\"huploads\\/yNlsQVYw7dLxM3zU17nsxt6uJUpS0yNnKLANMVXD.csv\\\";}\"}}', 'PDOException: SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'title\' cannot be null in D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php:45\nStack trace:\n#0 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(45): PDOStatement->execute()\n#1 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(816): Illuminate\\Database\\MySqlConnection->Illuminate\\Database\\{closure}(\'insert into `vi...\', Array)\n#2 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(783): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `vi...\', Array, Object(Closure))\n#3 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(50): Illuminate\\Database\\Connection->run(\'insert into `vi...\', Array, Object(Closure))\n#4 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Processors\\MySqlProcessor.php(35): Illuminate\\Database\\MySqlConnection->insert(\'insert into `vi...\', Array, \'id\')\n#5 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(3549): Illuminate\\Database\\Query\\Processors\\MySqlProcessor->processInsertGetId(Object(Illuminate\\Database\\Query\\Builder), \'insert into `vi...\', Array, \'id\')\n#6 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(1982): Illuminate\\Database\\Query\\Builder->insertGetId(Array, \'id\')\n#7 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1334): Illuminate\\Database\\Eloquent\\Builder->__call(\'insertGetId\', Array)\n#8 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1299): Illuminate\\Database\\Eloquent\\Model->insertAndSetId(Object(Illuminate\\Database\\Eloquent\\Builder), Array)\n#9 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1138): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#10 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Eloquent\\Model->save(Array)\n#11 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Illuminate\\Database\\Eloquent\\Model->Illuminate\\Database\\Eloquent\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#12 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#13 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(167): Illuminate\\Database\\Eloquent\\Model->saveOrFail()\n#14 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Object(App\\Models\\Video), 0)\n#15 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(172): Illuminate\\Support\\Collection->each(Object(Closure))\n#16 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Array, 18102)\n#17 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(173): Illuminate\\Support\\Collection->each(Object(Closure))\n#18 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(82): Maatwebsite\\Excel\\Imports\\ModelManager->singleFlush(Object(App\\Imports\\LargeHostersmport))\n#19 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(114): Maatwebsite\\Excel\\Imports\\ModelManager->flush(Object(App\\Imports\\LargeHostersmport), false)\n#20 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(95): Maatwebsite\\Excel\\Imports\\ModelImporter->flush(Object(App\\Imports\\LargeHostersmport), 1, 18102)\n#21 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Sheet.php(258): Maatwebsite\\Excel\\Imports\\ModelImporter->import(Object(PhpOffice\\PhpSpreadsheet\\Worksheet\\Worksheet), Object(App\\Imports\\LargeHostersmport), 1)\n#22 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(116): Maatwebsite\\Excel\\Sheet->import(Object(App\\Imports\\LargeHostersmport), 1)\n#23 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Maatwebsite\\Excel\\Reader->Maatwebsite\\Excel\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#24 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Transactions\\DbTransactionHandler.php(30): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#25 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(130): Maatwebsite\\Excel\\Transactions\\DbTransactionHandler->__invoke(Object(Closure))\n#26 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Excel.php(155): Maatwebsite\\Excel\\Reader->read(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\', \'Csv\', NULL)\n#27 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Facades\\Facade.php(355): Maatwebsite\\Excel\\Excel->import(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\')\n#28 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\app\\Jobs\\largeExcelJob.php(26): Illuminate\\Support\\Facades\\Facade::__callStatic(\'import\', Array)\n#29 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\LargeExcelJob->handle()\n#30 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#31 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#32 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#33 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#34 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#35 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#36 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#37 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#38 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(124): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\LargeExcelJob), false)\n#39 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#40 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#41 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#42 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\LargeExcelJob))\n#43 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#44 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(439): Illuminate\\Queue\\Jobs\\Job->fire()\n#45 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(389): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#46 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(176): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#47 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(138): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#48 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(121): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#49 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#50 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#51 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#52 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#53 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#54 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#55 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Command\\Command.php(326): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#56 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(181): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#57 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(1096): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#58 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#59 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(175): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#60 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(201): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#61 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#62 {main}\n\nNext Illuminate\\Database\\QueryException: SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'title\' cannot be null (Connection: mysql, SQL: insert into `videos_1` (`video_id`, `category`, `title`, `url`, `thumb_src`, `keywords`, `thumb_size`, `length_sec`, `length_min`, `embed`, `status`, `updated_at`, `created_at`) values (18188, Asian, ?, https://www.eporner.com/video-WsDBaYjd63i//, https://static-ca-cdn.eporner.com/thumbs/static4/1/11/115/11502288/8_240.jpg, medium, 48, amateur, , , brunette, asian, pov, 1677, 27, https://www.eporner.com/embed/WsDBaYjd63i/, 2024-10-20 16:09:02, 2024-10-20 16:09:02)) in D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php:829\nStack trace:\n#0 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(783): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `vi...\', Array, Object(Closure))\n#1 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(50): Illuminate\\Database\\Connection->run(\'insert into `vi...\', Array, Object(Closure))\n#2 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Processors\\MySqlProcessor.php(35): Illuminate\\Database\\MySqlConnection->insert(\'insert into `vi...\', Array, \'id\')\n#3 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(3549): Illuminate\\Database\\Query\\Processors\\MySqlProcessor->processInsertGetId(Object(Illuminate\\Database\\Query\\Builder), \'insert into `vi...\', Array, \'id\')\n#4 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(1982): Illuminate\\Database\\Query\\Builder->insertGetId(Array, \'id\')\n#5 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1334): Illuminate\\Database\\Eloquent\\Builder->__call(\'insertGetId\', Array)\n#6 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1299): Illuminate\\Database\\Eloquent\\Model->insertAndSetId(Object(Illuminate\\Database\\Eloquent\\Builder), Array)\n#7 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1138): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#8 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Eloquent\\Model->save(Array)\n#9 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Illuminate\\Database\\Eloquent\\Model->Illuminate\\Database\\Eloquent\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#10 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#11 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(167): Illuminate\\Database\\Eloquent\\Model->saveOrFail()\n#12 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Object(App\\Models\\Video), 0)\n#13 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(172): Illuminate\\Support\\Collection->each(Object(Closure))\n#14 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Array, 18102)\n#15 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(173): Illuminate\\Support\\Collection->each(Object(Closure))\n#16 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(82): Maatwebsite\\Excel\\Imports\\ModelManager->singleFlush(Object(App\\Imports\\LargeHostersmport))\n#17 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(114): Maatwebsite\\Excel\\Imports\\ModelManager->flush(Object(App\\Imports\\LargeHostersmport), false)\n#18 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(95): Maatwebsite\\Excel\\Imports\\ModelImporter->flush(Object(App\\Imports\\LargeHostersmport), 1, 18102)\n#19 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Sheet.php(258): Maatwebsite\\Excel\\Imports\\ModelImporter->import(Object(PhpOffice\\PhpSpreadsheet\\Worksheet\\Worksheet), Object(App\\Imports\\LargeHostersmport), 1)\n#20 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(116): Maatwebsite\\Excel\\Sheet->import(Object(App\\Imports\\LargeHostersmport), 1)\n#21 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Maatwebsite\\Excel\\Reader->Maatwebsite\\Excel\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#22 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Transactions\\DbTransactionHandler.php(30): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#23 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(130): Maatwebsite\\Excel\\Transactions\\DbTransactionHandler->__invoke(Object(Closure))\n#24 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Excel.php(155): Maatwebsite\\Excel\\Reader->read(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\', \'Csv\', NULL)\n#25 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Facades\\Facade.php(355): Maatwebsite\\Excel\\Excel->import(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\')\n#26 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\app\\Jobs\\largeExcelJob.php(26): Illuminate\\Support\\Facades\\Facade::__callStatic(\'import\', Array)\n#27 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\LargeExcelJob->handle()\n#28 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#33 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#34 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#35 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#36 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(124): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\LargeExcelJob), false)\n#37 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#38 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#39 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#40 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\LargeExcelJob))\n#41 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#42 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(439): Illuminate\\Queue\\Jobs\\Job->fire()\n#43 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(389): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#44 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(176): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#45 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(138): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#46 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(121): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#47 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#48 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#49 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#50 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#51 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#52 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#53 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Command\\Command.php(326): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#54 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(181): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#55 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(1096): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#56 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#57 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(175): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#58 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(201): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#59 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#60 {main}', '2024-10-20 10:09:02');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `video_id`, `image_path`, `created_at`, `updated_at`, `status`) VALUES
(1, 497, 'backend/files/14e5e448-aecf-41a8-bafe-87e061f6c364_5_240.jpg', '2024-10-15 03:40:43', '2024-10-15 03:40:43', 1),
(2, 499, 'backend/files/f117c3a5-3235-41a8-b476-56b9d68c4374_5_240.jpg', '2024-10-15 03:40:43', '2024-10-15 03:40:43', 1),
(3, 500, 'backend/files/41d4a37d-f97c-4c66-afa2-9bfb528f3e4f_5_240.jpg', '2024-10-15 03:40:44', '2024-10-15 03:40:44', 1),
(4, 501, 'backend/files/77839784-9303-48fa-a2aa-0898b879c08d_5_240.jpg', '2024-10-15 03:40:45', '2024-10-15 03:40:45', 1),
(5, 501, 'backend/files/e7958389-c867-4ede-b402-538356d71aa6_5_240.jpg', '2024-10-15 03:43:33', '2024-10-15 03:43:33', 1),
(6, 506, 'backend/files/d5175a94-9693-45be-af56-b94cd1fa8d38_5_240.jpg', '2024-10-15 03:43:34', '2024-10-15 03:43:34', 1),
(7, 572, 'backend/files/9353a8a0-0cd5-48f8-ba59-8fb8a3105c9e_5_240.jpg', '2024-10-15 03:43:35', '2024-10-15 03:43:35', 1),
(8, 573, 'backend/files/e8c42334-df7d-4d8a-b7ed-667a285fceeb_5_240.jpg', '2024-10-15 03:43:35', '2024-10-15 03:43:35', 1),
(9, 574, 'backend/files/ab26c029-0de4-4384-b354-02fe41174e64_5_240.jpg', '2024-10-15 03:43:36', '2024-10-15 03:43:36', 1),
(10, 588, 'backend/files/fd9bd8e6-5e11-4af2-b987-6392f5b08369_5_240.jpg', '2024-10-15 03:43:37', '2024-10-15 03:43:37', 1),
(11, 604, 'backend/files/11005dda-0b3d-43a5-9662-3e020a9bd0c9_5_240.jpg', '2024-10-15 03:43:37', '2024-10-15 03:43:37', 1),
(12, 605, 'backend/files/e41c571a-daa8-4b72-969a-236a4702069d_5_240.jpg', '2024-10-15 03:43:38', '2024-10-15 03:43:38', 1),
(13, 496, 'backend/files/ac44a8cb-c16f-406c-a864-caef3d0dc7cb_5_240.jpg', '2024-10-15 03:55:43', '2024-10-15 03:55:43', 1),
(14, 497, 'backend/files/dbb76e1d-e879-4969-9e34-fd67217fc063_5_240.jpg', '2024-10-15 03:55:44', '2024-10-15 03:55:44', 1),
(15, 499, 'backend/files/67b8b054-70be-4077-9783-55331d483ef7_5_240.jpg', '2024-10-15 03:55:44', '2024-10-15 03:55:44', 1),
(16, 500, 'backend/files/5a8b3483-10da-4d7d-b853-8c32af70b751_5_240.jpg', '2024-10-15 03:55:45', '2024-10-15 03:55:45', 1),
(17, 501, 'backend/files/a05642fd-5210-43d2-a0c4-f4fee6b0251f_5_240.jpg', '2024-10-15 03:55:45', '2024-10-15 03:55:45', 1),
(18, 502, 'backend/files/421746c6-d32e-4055-89e1-cb865f7f8b6c_5_240.jpg', '2024-10-15 03:55:46', '2024-10-15 03:55:46', 1),
(19, 503, 'backend/files/a16b034c-1d2c-49f3-98be-10031dcdcc13_5_240.jpg', '2024-10-15 03:55:47', '2024-10-15 03:55:47', 1),
(20, 504, 'backend/files/a3296151-7789-4839-9e30-2122dd662237_5_240.jpg', '2024-10-15 03:55:48', '2024-10-15 03:55:48', 1),
(21, 506, 'backend/files/f9ce1942-f2fc-4850-abe5-8ea3b7a04a65_5_240.jpg', '2024-10-15 03:55:48', '2024-10-15 03:55:48', 1),
(22, 518, 'backend/files/596d9e12-8a68-4866-a886-06f8bcf18aad_5_240.jpg', '2024-10-15 03:55:49', '2024-10-15 03:55:49', 1),
(23, 520, 'backend/files/6f6dadac-27e6-4801-9b18-0d1a2dc259d6_5_240.jpg', '2024-10-15 03:55:49', '2024-10-15 03:55:49', 1),
(24, 521, 'backend/files/56f61908-d84f-41d8-b3e0-0681fcd6cbdb_12_240.jpg', '2024-10-15 03:55:50', '2024-10-15 03:55:50', 1),
(25, 522, 'backend/files/f1755a77-f1e9-4317-b226-e3c34db97ac1_9_240.jpg', '2024-10-15 03:55:51', '2024-10-15 03:55:51', 1),
(26, 526, 'backend/files/3a7a8da5-299c-433a-a36e-77becfeaebb0_8_240.jpg', '2024-10-15 03:55:51', '2024-10-15 03:55:51', 1),
(27, 529, 'backend/files/de29c355-f682-4e56-b672-baa28a9b9e3e_12_240.jpg', '2024-10-15 03:55:52', '2024-10-15 03:55:52', 1),
(28, 530, 'backend/files/516b4fec-0c4e-46c6-a875-8631315c1cf7_13_240.jpg', '2024-10-15 03:55:53', '2024-10-15 03:55:53', 1),
(29, 531, 'backend/files/918a1e05-376e-4684-8860-7d0c8b53d622_8_240.jpg', '2024-10-15 03:55:53', '2024-10-15 03:55:53', 1),
(30, 532, 'backend/files/56e9ca0b-2427-4ad5-b9da-52fc86deba2d_2_240.jpg', '2024-10-15 03:55:54', '2024-10-15 03:55:54', 1),
(31, 533, 'backend/files/b947a2d2-4257-4089-bdf3-6f82d329e104_8_240.jpg', '2024-10-15 03:55:55', '2024-10-15 03:55:55', 1),
(32, 534, 'backend/files/b4643255-238c-437c-ad22-f02ceda3d005_10_240.jpg', '2024-10-15 03:55:56', '2024-10-15 03:55:56', 1),
(33, 535, 'backend/files/1833e20c-d2d5-4566-bc09-26bcef0c9bc3_2_240.jpg', '2024-10-15 03:55:56', '2024-10-15 03:55:56', 1),
(34, 536, 'backend/files/62a5c1b9-258e-4963-b80a-020e89a00540_5_240.jpg', '2024-10-15 03:55:57', '2024-10-15 03:55:57', 1),
(35, 537, 'backend/files/cc514c7c-bc74-4f0a-8fb4-f0aee2787b65_4_240.jpg', '2024-10-15 03:55:58', '2024-10-15 03:55:58', 1),
(36, 539, 'backend/files/00344472-3b05-4ef7-9216-9a34bf32cfeb_5_240.jpg', '2024-10-15 03:55:58', '2024-10-15 03:55:58', 1),
(37, 541, 'backend/files/1cbfffdd-2567-4258-aa80-7d11408ea618_5_240.jpg', '2024-10-15 03:55:59', '2024-10-15 03:55:59', 1),
(38, 543, 'backend/files/16ee0966-14a4-411b-bb37-e3085f4f2085_12_240.jpg', '2024-10-15 03:56:00', '2024-10-15 03:56:00', 1),
(39, 544, 'backend/files/3da6757c-bfb8-44bf-ba70-23e45c804cde_9_240.jpg', '2024-10-15 03:56:00', '2024-10-15 03:56:00', 1),
(76, 605, 'backend/files/29c84a49-b8fc-4f50-b21f-c5de7c4fac6e_5_240.jpg', '2024-10-15 03:56:24', '2024-10-15 03:56:24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `gameplatform`
--

CREATE TABLE `gameplatform` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gameplatform`
--

INSERT INTO `gameplatform` (`id`, `name`, `slug`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'AG', 'ag', '/backend/files/ejFWcZXAadVOauRGnFH4.png', 1, '2024-12-14 11:14:56', '2024-12-15 07:28:11'),
(2, 'BBIN', 'bbin', '/backend/files/irkGgT1YDM0cmErSqwYM.png', 1, '2024-12-14 11:29:11', '2024-12-15 07:57:04'),
(3, 'BG', 'bg', '/backend/files/9GXukSSrd2vdeKRGSmZ2.webp', 1, '2024-12-14 11:29:24', '2024-12-14 13:13:19'),
(4, 'CQ9', 'cq9', '/backend/files/IJcK2X3AfhQIiwPIDgMJ.png', 0, '2024-12-14 11:30:27', '2024-12-18 08:50:29'),
(5, 'MG', 'mg', '/backend/files/OnpYZ7RIEXJ6nSJ6ulUn.png', 1, '2024-12-14 11:31:08', '2024-12-15 07:34:17'),
(7, 'PT', 'pt', '/backend/files/iJJOBT655IP1iG6uZWja.png', 1, '2024-12-14 13:02:57', '2024-12-18 08:50:06'),
(12, 'WW', 'ww', '/backend/files/TpZF62N0jwcLLag5Fs4J.png', 1, '2024-12-14 13:19:00', '2024-12-19 03:27:40'),
(14, 'DB6', 'db6', '/backend/files/nTOBFTXBRdjieY6kwXBs.png', 1, '2024-12-14 13:56:51', '2024-12-18 08:49:25'),
(15, 'FC', 'fc', '/backend/files/ldfja0JX1115qJaSuxIm.png', 1, '2024-12-14 13:57:04', '2024-12-18 08:49:11'),
(16, 'FG', 'fg', '/backend/files/yHgiIgdZHcgmSLuWDEK1.png', 1, '2024-12-14 13:57:16', '2024-12-18 08:48:50'),
(17, 'JDB', 'jdb', '/backend/files/42NgvJStZXI0uHsPAj5m.png', 1, '2024-12-14 13:57:29', '2024-12-15 07:32:50'),
(18, 'JOKER', 'joker', '/backend/files/3ptM3dKajr2IC8exm4nB.png', 1, '2024-12-14 13:57:41', '2024-12-15 07:53:22'),
(19, 'KY', 'ky', '/backend/files/OSZ1OnOxm4RZy5xEIsI4.png', 1, '2024-12-14 13:57:55', '2024-12-18 08:48:19'),
(20, 'Leg', 'leg', '/backend/files/cOcwqYIt8ivuhdEMv7RD.png', 1, '2024-12-14 13:58:08', '2024-12-18 08:48:05'),
(21, 'MT', 'mt', '/backend/files/8dJJTVi2C51I9ooTErEr.png', 1, '2024-12-14 13:58:31', '2024-12-18 08:47:51'),
(22, 'MW', 'mw', '/backend/files/DQRuOKagYOLQ9Udc19Q2.png', 1, '2024-12-14 13:58:46', '2024-12-15 07:59:09'),
(23, 'NW', 'nw', '/backend/files/HpzFc37Gt6r3gDxXZESZ.png', 1, '2024-12-14 13:58:57', '2024-12-18 08:47:13'),
(25, 'VG', 'vg', '/backend/files/qQN2roVdwyGPhncVMtMc.png', 1, '2024-12-14 13:59:21', '2024-12-18 08:46:58'),
(26, 'W', 'w', '/backend/files/48TySDUnTZgkhsfyKU2I.png', 1, '2024-12-14 13:59:34', '2024-12-18 08:46:46'),
(27, 'boya', 'boya', '/backend/files/JwmP3HFXAJkCiWHqoNta.png', 1, '2024-12-14 14:01:49', '2024-12-18 08:46:31'),
(30, 'XGD', 'xgd', '/backend/files/mJ1Zw3ALCu7ougUlucyI.png', 1, '2024-12-14 14:04:29', '2024-12-18 08:46:12'),
(31, 'Yoo', 'yoo', '/backend/files/NXb2djIsaF3SZqrq7Ji3.png', 1, '2024-12-14 14:04:40', '2024-12-18 08:45:42'),
(32, 'AS', 'as', '/backend/files/WchXDt9trfSX5viZP7AU.png', 1, '2024-12-17 05:00:38', '2024-12-18 08:45:27'),
(33, 'DB2', 'db2', '/backend/files/w9aBsgvNrdkihcthx3zQ.png', 1, '2024-12-17 05:01:03', '2024-12-18 08:45:09'),
(93, 'KM', 'km', '/backend/files/ORYoDCuYjlu2RMlZ5JGy.png', 1, '2024-12-17 05:10:50', '2024-12-18 08:44:52'),
(94, 'LGD', 'lgd', '/backend/files/KXthziaQXucrwuv7FfAc.png', 1, '2024-12-17 05:11:10', '2024-12-18 08:44:58'),
(103, 'PP', 'pp', '/backend/files/FPBZtRdm7sGA0rpvT63J.png', 1, '2024-12-17 05:12:30', '2024-12-18 08:44:35'),
(106, 'T1', 't1', '/backend/files/iv3AQDGr0rCOoaqJ7v8U.png', 1, '2024-12-17 05:13:01', '2024-12-18 08:44:16'),
(107, 'WL', 'wl', '/backend/files/a8ExTzisO95s842xxzN4.png', 1, '2024-12-17 05:13:15', '2024-12-18 08:44:05'),
(108, 'RSG', 'rsg', '/backend/files/7gt7h4hNUP1lTDu7PS17.png', 1, '2024-12-17 05:22:59', '2024-12-18 08:43:35'),
(109, 'PG', 'pg', '/backend/files/A8YLUxFU2uc8sTj7w66Y.png', 1, '2024-12-17 05:23:31', '2024-12-18 08:43:27'),
(110, 'DB7', 'db7', '/backend/files/0pSzj19SoWHDxH0ybr7L.png', 1, '2024-12-17 05:25:17', '2024-12-18 08:46:20'),
(111, 'Lottery', 'lottery', '/backend/files/3s5pbo3InBq6e9XOjlAN.png', 1, '2024-12-18 06:32:31', '2024-12-18 08:40:56');

-- --------------------------------------------------------

--
-- Table structure for table `game_platform`
--

CREATE TABLE `game_platform` (
  `id` int(11) NOT NULL,
  `game_type_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `game_platform`
--

INSERT INTO `game_platform` (`id`, `game_type_id`, `name`, `slug`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 4, 'AG', 'ag', '/backend/files/0NJSTCpOoz0dJnEW0rKE.png', 1, '2024-12-18 05:53:15', '2024-12-18 05:53:15'),
(2, 4, 'allbet', 'allbet', '/backend/files/U57zNjxTRshvgJYATHVk.png', 0, '2024-12-18 06:04:32', '2024-12-18 06:04:32'),
(3, 4, 'BBIN', 'bbin', '/backend/files/GqcsE8zLJTEC0CmaJUOl.png', 0, '2024-12-18 06:06:03', '2024-12-18 11:45:11'),
(4, 4, 'BG', 'bg', '/backend/files/JDEaWtjmz8ZtyXtKxsIW.png', 0, '2024-12-18 06:06:35', '2024-12-18 06:06:35'),
(5, 4, 'CQ9', 'cq9', '/backend/files/9C97x7tTpemDe8mHNQyk.png', 1, '2024-12-18 06:06:56', '2024-12-18 06:06:56'),
(6, 4, 'DB1', 'db1', '/backend/files/kasxVuREPYPBpezWZFYE.png', 0, '2024-12-18 06:07:43', '2024-12-18 06:13:20'),
(7, 4, 'DG', 'dg', '/backend/files/B7DfhP6YSgfx1BtUFkmg.png', 0, '2024-12-18 06:08:03', '2024-12-18 06:08:03'),
(8, 4, 'EVO', 'evo', '/backend/files/WcPH9RGdB3IVcXFxoshy.png', 0, '2024-12-18 06:08:49', '2024-12-18 06:08:49'),
(9, 4, 'MG', 'mg', '/backend/files/qwL4BPB1TRso2wZfGeQM.png', 1, '2024-12-18 06:09:12', '2024-12-18 06:09:12'),
(10, 4, 'OG', 'og', '/backend/files/F7AVUgr17D8XSsv7hhIV.png', 0, '2024-12-18 06:09:41', '2024-12-18 11:46:15'),
(11, 4, 'PT', 'pt', '/backend/files/fOHn1I2UjsPHvqwzSCwx.png', 0, '2024-12-18 06:10:34', '2024-12-18 06:10:34'),
(12, 4, 'Sexy', 'sexy', '/backend/files/3YlW2TJx7c3oOcCAY2G9.png', 0, '2024-12-18 06:11:10', '2024-12-18 11:46:43'),
(13, 4, 'WE', 'we', '/backend/files/DRrX5cJvL4zB4nyL1jF6.png', 0, '2024-12-18 06:11:56', '2024-12-18 06:11:56'),
(14, 4, 'XG', 'xg', '/backend/files/cUDnbqpujDQjBUcJFEV4.png', 0, '2024-12-18 06:13:00', '2024-12-18 06:13:00'),
(15, 3, 'AG', 'ag', '/backend/files/PphkXeUlGTdh2i7cyJ42.png', 0, '2024-12-18 06:15:24', '2024-12-18 06:15:24'),
(16, 3, 'BBIN', 'bbin', '/backend/files/k3uqlYi0HdfknUzeU7Qx.png', 0, '2024-12-18 06:16:10', '2024-12-18 11:44:56'),
(17, 3, 'CQ9', 'cq9', '/backend/files/D9mb0h3jUenqP5Xn3C4K.png', 1, '2024-12-18 06:16:33', '2024-12-18 07:24:03'),
(18, 3, 'FC', 'fc', '/backend/files/9WOHg6fbSckRGPW22gMc.png', 0, '2024-12-18 06:17:05', '2024-12-18 06:17:05'),
(19, 3, 'FG', 'fg', '/backend/files/uJcvaDvkq9KL61gNslWo.png', 0, '2024-12-18 06:18:36', '2024-12-18 06:18:36'),
(20, 3, 'FTG', 'ftg', '/backend/files/xUgINEamVYOzY1hOjTOZ.png', 0, '2024-12-18 06:19:19', '2024-12-18 06:19:19'),
(21, 3, 'GB', 'gb', '/backend/files/zKJHUGD7XvRlNLXZOj01.png', 0, '2024-12-18 06:20:04', '2024-12-18 06:20:04'),
(22, 3, 'HB', 'hb', '/backend/files/uq1HhwLM2204lb3XMam6.png', 0, '2024-12-18 06:20:36', '2024-12-18 06:20:36'),
(23, 3, 'jdb', 'jdb', '/backend/files/Qfz6bUHDe7ZnYhepHYVx.png', 1, '2024-12-18 06:21:04', '2024-12-18 06:21:04'),
(24, 3, 'Joker', 'joker', '/backend/files/xsbOsjjKQp2mghY9fxkz.png', 0, '2024-12-18 06:21:53', '2024-12-18 06:21:53'),
(25, 3, 'MG', 'mg', '/backend/files/22gCZTFO7yvj8bkt0iR3.png', 1, '2024-12-18 06:22:18', '2024-12-18 07:05:00'),
(26, 3, 'MT', 'mt', '/backend/files/BFDJzWz1FssvIbR18VBs.png', 0, '2024-12-18 06:23:05', '2024-12-18 07:25:07'),
(27, 3, 'MW', 'mw', '/backend/files/09e4Pgcegcx8bEcC5NuQ.png', 0, '2024-12-18 06:23:59', '2024-12-18 06:23:59'),
(28, 3, 'PG', 'pg', '/backend/files/mX6OTonHwJ5GAWYGT8J7.png', 1, '2024-12-18 06:24:31', '2024-12-18 07:24:34'),
(29, 4, 'pp', 'pp', '/backend/files/HxHP3OfIsarXaFPPmCmi.png', 1, '2024-12-18 06:26:02', '2024-12-18 10:53:42'),
(30, 3, 'PS', 'ps', '/backend/files/yKTxTc6lFx5hgQcD5EC3.png', 0, '2024-12-18 06:26:53', '2024-12-18 07:10:11'),
(31, 3, 'PT', 'pt', '/backend/files/7qmx0m1Qeam5jgHgIvKX.png', 0, '2024-12-18 06:27:18', '2024-12-18 06:27:18'),
(32, 3, 'r88', 'r88', '/backend/files/6ijjt6MXxjSgWYGWok4e.png', 0, '2024-12-18 06:27:59', '2024-12-18 06:27:59'),
(33, 3, 'SG', 'sg', '/backend/files/WYbUTKLfi3f2wulZESGn.png', 0, '2024-12-18 06:28:31', '2024-12-18 06:28:31'),
(34, 3, 't1', 't1', '/backend/files/mRzwjFcJF0dGXJfiKc8u.png', 0, '2024-12-18 06:29:03', '2024-12-18 06:29:03'),
(35, 3, 'TTG', 'ttg', '/backend/files/VPCtpeSGswCvAWiTw7H5.png', 0, '2024-12-18 06:29:44', '2024-12-18 07:12:59'),
(36, 3, 'SPider man', 'spider-man', '/backend/files/nQrfp9WlRBnM1K9POK32.png', 0, '2024-12-18 06:30:14', '2024-12-18 06:30:14'),
(37, 2, 'DB3', 'db3', '/backend/files/UdFXjF4I9MkNbHb2ygS6.png', 0, '2024-12-18 06:33:34', '2024-12-18 06:33:34'),
(38, 2, 'GW', 'gw', '/backend/files/L4teH2O9K13AUwQYNBcU.png', 0, '2024-12-18 06:35:08', '2024-12-18 06:35:08'),
(39, 2, 'IG', 'ig', '/backend/files/7GS66JAsX0PGojDbbZCh.png', 0, '2024-12-18 06:35:36', '2024-12-18 06:35:36'),
(40, 2, 'SGWIN', 'sgwin', '/backend/files/FiY8mN7wiTC81GYV0B2E.png', 0, '2024-12-18 06:36:17', '2024-12-18 06:36:17'),
(41, 2, 'TCG', 'tcg', '/backend/files/vIz5b9JeFGy3uMgmqmWR.png', 0, '2024-12-18 06:36:50', '2024-12-18 06:36:50'),
(42, 2, 'VR', 'vr', '/backend/files/iIhc3IclU8EqGBlOcuW6.png', 0, '2024-12-18 06:37:04', '2024-12-18 06:37:04'),
(43, 2, 'WW', 'ww', '/backend/files/JavEOb6ssrMrXcBQ9k6M.png', 0, '2024-12-18 06:37:34', '2024-12-18 06:37:34'),
(44, 1, 'AP', 'ap', '/backend/files/slgvQQpnuy5seR83Wg7w.png', 0, '2024-12-18 06:38:50', '2024-12-18 06:38:50'),
(45, 1, 'CMD', 'cmd', '/backend/files/p8cRlsZHRbyuePiKVsKB.png', 0, '2024-12-18 06:39:07', '2024-12-18 06:39:07'),
(46, 1, 'Crown', 'crown', '/backend/files/X8byuErHMRr9vHFpKXv5.png', 0, '2024-12-18 06:39:28', '2024-12-18 06:39:28'),
(47, 1, 'FB', 'fb', '/backend/files/oasiMShxxASRrpVd64RJ.png', 1, '2024-12-18 06:39:49', '2024-12-18 06:39:49'),
(48, 1, 'IM', 'im', '/backend/files/BgWvUqPXIH2a2HlA0RjL.png', 0, '2024-12-18 06:40:09', '2024-12-18 06:40:09'),
(49, 1, 'NewBB', 'newbb', '/backend/files/ZkFC3mzI2RfI1VptJJde.png', 0, '2024-12-18 06:40:27', '2024-12-18 06:40:27'),
(50, 1, 'Panda', 'panda', '/backend/files/zoYYlNnXByjlJUrrRClM.png', 0, '2024-12-18 06:40:50', '2024-12-18 06:40:50'),
(51, 1, 'Sabah', 'sabah', '/backend/files/W5SRFCXg8a3OolypsZqJ.png', 0, '2024-12-18 06:41:22', '2024-12-18 06:41:22'),
(52, 1, 'SBO', 'sbo', '/backend/files/pDn3B6pPrWE9JLLpJ4hy.png', 1, '2024-12-18 06:41:33', '2024-12-18 06:41:33'),
(53, 1, 'SS', 'ss', '/backend/files/yoZd4BIAKV5l2dIyCV2o.png', 0, '2024-12-18 06:41:48', '2024-12-18 06:41:48'),
(54, 1, 'UG', 'ug', '/backend/files/WVkQdpFO66o73Fp1AqPf.png', 0, '2024-12-18 06:42:02', '2024-12-18 06:42:02'),
(55, 1, 'WL', 'wl', '/backend/files/0WetMiLrh4FAA98u2wxk.png', 0, '2024-12-18 06:42:47', '2024-12-18 06:42:47'),
(56, 1, 'XJ', 'xj', '/backend/files/6g6PXLg5b6OsUDwVPJbZ.png', 0, '2024-12-18 06:43:07', '2024-12-18 06:43:07'),
(57, 5, 'DB5', 'db5', '/backend/files/Zynqdv2j82M4nOJFtSF2.png', 0, '2024-12-18 06:44:27', '2024-12-18 06:44:27'),
(58, 5, 'TF', 'tf', '/backend/files/kn5lrVCHdRPb2DRGdCIg.png', 0, '2024-12-18 06:44:56', '2024-12-18 06:44:56'),
(59, 5, 'ESB', 'esb', '/backend/files/Ig5U0wvAwtwW07ppM3sG.png', 0, '2024-12-18 06:45:47', '2024-12-18 06:45:47'),
(60, 6, 'AG', 'ag', '/backend/files/n3tRtI8K3kDhhoO8Ve51.png', 0, '2024-12-18 06:50:15', '2024-12-18 06:50:15'),
(61, 2, 'BBIN', 'bbin', '/backend/files/UYcJtvBgZayGfGhZbqc0.png', 0, '2024-12-18 06:51:00', '2024-12-18 11:44:40'),
(62, 6, 'BBIN', 'bbin', '/backend/files/cvtLj9P62u6QHH7eSjjq.png', 0, '2024-12-18 06:51:18', '2024-12-18 11:44:26'),
(63, 7, 'BBIN', 'bbin', '/backend/files/WbuZjzwzYtPt2VspzO2o.png', 0, '2024-12-18 06:51:32', '2024-12-18 11:44:07'),
(64, 6, 'BG', 'bg', '/backend/files/6swrrXi3zGdGIJ5Vj1FX.png', 0, '2024-12-18 06:51:57', '2024-12-18 06:51:57'),
(65, 7, 'BG', 'bg', '/backend/files/8C5dOYM7OdqTmr3AhCPi.png', 0, '2024-12-18 06:52:09', '2024-12-18 06:52:09'),
(66, 7, 'BOYA', 'boya', '/backend/files/Y3QjRx9oJ4u55GZVzdMu.png', 0, '2024-12-18 06:52:55', '2024-12-18 06:52:55'),
(67, 3, 'CQ9', 'cq9', '/backend/files/mj0QYkPwnBGGo6EKMCyA.png', 1, '2024-12-18 06:53:38', '2024-12-18 06:53:38'),
(68, 6, 'CQ9', 'cq9', '/backend/files/gJPHzxZCSTvwqoLWKSLR.png', 1, '2024-12-18 06:53:52', '2024-12-18 06:53:52'),
(69, 3, 'DB2', 'db2', '/backend/files/MLv7EKdRiL3fXzqGJb7Z.png', 0, '2024-12-18 06:54:28', '2024-12-18 06:54:28'),
(70, 6, 'DB6', 'db6', '/backend/files/7KOjMYr7j1nDNiCJLR3a.png', 0, '2024-12-18 06:55:05', '2024-12-18 06:55:05'),
(71, 7, 'DB7', 'db7', '/backend/files/yEKJMQpY4gCc7aqVfTSf.png', 0, '2024-12-18 06:55:36', '2024-12-18 06:55:36'),
(72, 6, 'FC', 'fc', '/backend/files/X783TA3lX41ITCFL6T2E.png', 0, '2024-12-18 06:56:39', '2024-12-18 06:56:39'),
(73, 6, 'FG', 'fg', '/backend/files/3zUxGWj6LCn4mMxVMRQt.png', 0, '2024-12-18 06:57:05', '2024-12-18 06:57:05'),
(74, 7, 'FG', 'fg', '/backend/files/pdh10xLNRTxGPCZab51z.png', 0, '2024-12-18 06:57:14', '2024-12-18 06:57:14'),
(75, 6, 'JDB', 'jdb', '/backend/files/HTupGERPl6q40eeFtcCx.png', 1, '2024-12-18 06:58:28', '2024-12-18 06:58:28'),
(76, 7, 'JDB', 'jdb', '/backend/files/ObkMFWBIVHK67dOE89FW.png', 1, '2024-12-18 06:58:41', '2024-12-18 06:58:41'),
(77, 3, 'JILI', 'jili', '/backend/files/qjCEdol3OtffdexcjGdZ.png', 0, '2024-12-18 06:59:58', '2024-12-18 06:59:58'),
(78, 6, 'Joker', 'joker', '/backend/files/Huqvc6WG95KRR1VcBlJi.png', 0, '2024-12-18 07:00:20', '2024-12-18 07:00:20'),
(79, 3, 'KA', 'ka', '/backend/files/7LU8X7IQOWdmmimF0Lq2.png', 0, '2024-12-18 07:01:10', '2024-12-18 07:01:10'),
(80, 3, 'km', 'km', '/backend/files/NOFf69v3UTLeqUg305fz.png', 0, '2024-12-18 07:01:24', '2024-12-18 07:01:24'),
(81, 6, 'ky', 'ky', '/backend/files/EHSfZcecWKKc4IsDEiKh.png', 0, '2024-12-18 07:02:05', '2024-12-18 07:02:05'),
(82, 7, 'ky', 'ky', '/backend/files/1pgxIlMLhOv67aZlCcWY.png', 0, '2024-12-18 07:02:13', '2024-12-18 07:02:13'),
(83, 6, 'leg', 'leg', '/backend/files/Wy7oMiWB75oJakqqyNfP.png', 0, '2024-12-18 07:02:30', '2024-12-18 07:02:30'),
(84, 7, 'leg', 'leg', '/backend/files/kctaXTuDig6mqGDNTyvB.png', 0, '2024-12-18 07:02:39', '2024-12-18 07:02:39'),
(85, 3, 'lgd', 'lgd', '/backend/files/CMAt3JXfeDA6aOLrXgfT.png', 0, '2024-12-18 07:03:28', '2024-12-18 07:03:28'),
(86, 6, 'MG', 'mg', '/backend/files/YS2wwfzfAjGHOco7xQfW.png', 1, '2024-12-18 07:03:56', '2024-12-18 07:04:49'),
(87, 7, 'MG', 'mg', '/backend/files/hOZ2UC61qYJlh4i8y30f.png', 1, '2024-12-18 07:04:11', '2024-12-18 07:04:39'),
(88, 6, 'MT', 'mt', '/backend/files/ZTwZv2UKDsJoP5ckDM8b.png', 0, '2024-12-18 07:05:38', '2024-12-18 07:05:38'),
(89, 7, 'MT', 'mt', '/backend/files/UtWkSK1sEfQwKq647609.png', 0, '2024-12-18 07:05:53', '2024-12-18 07:05:53'),
(90, 6, 'NW', 'nw', '/backend/files/Tvs8HM9jjWhI9G4G8oCF.png', 0, '2024-12-18 07:07:11', '2024-12-18 07:07:11'),
(91, 7, 'NW', 'nw', '/backend/files/7gdKYm8CyB5QK3owvBIL.png', 0, '2024-12-18 07:07:33', '2024-12-18 07:07:33'),
(92, 3, 'PNG', 'png', '/backend/files/WekTkIK2zU3RYO2IpQkM.png', 0, '2024-12-18 07:08:32', '2024-12-18 07:08:32'),
(93, 3, 'PP', 'pp', '/backend/files/OI1KOfwW4iz1ENHhkny7.png', 1, '2024-12-18 07:09:04', '2024-12-18 07:09:04'),
(94, 3, 'RT', 'rt', '/backend/files/k8iy8bkCmpDyF5tICqaN.png', 0, '2024-12-18 07:10:51', '2024-12-18 07:10:51'),
(95, 4, 'S', 's', '/backend/files/fao1WPgYFJuWjSU9k2yF.png', 0, '2024-12-18 07:11:35', '2024-12-18 07:11:35'),
(96, 6, 'VG', 'vg', '/backend/files/RNf7dH6mLrK1ktW7AfuT.png', 0, '2024-12-18 07:13:32', '2024-12-18 07:13:32'),
(97, 7, 'VG', 'vg', '/backend/files/e3nuDAeFBTfhSF7XZyMv.png', 0, '2024-12-18 07:13:47', '2024-12-18 07:13:47'),
(98, 4, 'wm', 'wm', '/backend/files/WEJvTpyBuZV31Bt3MmgL.png', 0, '2024-12-18 07:15:02', '2024-12-18 07:15:02'),
(99, 2, 'WW', 'ww', '/backend/files/YCFXlDIiULsyhrzdfRwn.png', 0, '2024-12-18 07:15:25', '2024-12-18 07:15:25'),
(100, 7, 'WW', 'ww', '/backend/files/1RdmjodpyMwmlhAPyyt8.png', 0, '2024-12-18 07:15:37', '2024-12-18 07:15:37'),
(101, 7, 'xD', 'xd', '/backend/files/RoYOtXiim4jYRVYop0ZI.png', 0, '2024-12-18 07:16:17', '2024-12-18 07:16:17'),
(102, 7, 'yoo', 'yoo', '/backend/files/vXooAWmpxXFs23JhaabI.png', 0, '2024-12-18 07:16:46', '2024-12-18 07:16:46');

-- --------------------------------------------------------

--
-- Table structure for table `game_type`
--

CREATE TABLE `game_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `gameTypecode` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `game_type`
--

INSERT INTO `game_type` (`id`, `name`, `slug`, `gameTypecode`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Sports', 'sports', '4', '/backend/files/Ltje5rhclteLpQs9zMMv.png', 1, '2024-10-14 05:41:16', '2024-12-15 03:07:27'),
(2, 'Lottery', 'lottery', '3', '/backend/files/Sagq2zzPY6TdNaYanMx3.png', 1, '2024-10-14 05:41:16', '2024-12-15 03:07:13'),
(3, 'Slot machine', 'slot-machine', '2', '/backend/files/YkI306AYFUQ5PVyNdf6h.png', 1, '2024-10-14 05:41:16', '2024-12-15 03:07:05'),
(4, 'Video', 'video', '1', '/backend/files/HWX2FYvXwU8R8035eVTx.png', 1, '2024-10-14 05:41:16', '2024-12-15 03:06:53'),
(5, 'E-sports', 'e-sports', '5', '/backend/files/Qlj8CzFytfQRkIHYHFaS.png', 1, '2024-12-14 11:01:09', '2024-12-15 03:07:43'),
(6, 'Hunting', 'hunting', '6', '/backend/files/gn11ejBne1uTziALhopz.png', 1, '2024-12-14 11:01:29', '2024-12-15 03:08:07'),
(7, 'Chess and cards', 'chess-and-cards', '7', '/backend/files/yI9ueYNKrFwhOqwhAPfx.png', 1, '2024-12-14 11:01:44', '2024-12-15 03:08:28');

-- --------------------------------------------------------

--
-- Table structure for table `global_wallet_address`
--

CREATE TABLE `global_wallet_address` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `lock_unlock` int(11) NOT NULL COMMENT '1=lock,0=unlock',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `global_wallet_address`
--

INSERT INTO `global_wallet_address` (`id`, `name`, `status`, `lock_unlock`, `created_at`, `updated_at`) VALUES
(1, 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 1, 1, '2024-07-12 18:37:40', '2024-07-15 22:18:01'),
(2, 'TKpRQQeykiNPuTjy5vw8do1QK3G64U6VxR', 1, 1, '2024-07-12 18:37:49', '2024-07-16 17:44:30'),
(3, 'TPuP8UP5CRBG5RxGy4fSQ1xf69ft5iwDWP', 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:40:19'),
(4, 'TKhvhGhUjkn1GzTZrpM9hwoMZhXaPt9iVt', 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:46:32'),
(5, 'TPNPcdTMUnq9HS1ejeZzGf7BJukq3NscQV', 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:49:20'),
(6, 'TBhZ5ZyMbZjGpqYm8cxip9M2Nm3SjFeAgR', 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:51:50'),
(7, 'TSZHRpspB9vZyUnX2JvHVjDo8MhpiNLjz9', 1, 0, '2024-07-12 18:37:49', '2024-07-13 05:38:18'),
(8, 'TZBt8EZmyFdxnRy7nCDUuNE1LFisSTqkLh', 1, 0, '2024-07-12 18:37:49', '2024-07-13 06:16:18'),
(9, 'TNkpRg6Zy6pZAM4hbCQe8jt3XVqM6HRRU5', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(10, 'TVp7PV8q3wSVKoj32DhpoMgH6Dd6SxN3jC', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(11, 'TVp7PV8q3wSVKoj232DhpoMgH6Dd6SxN3jC', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(12, 'TVp7PV8q3wSVKoj232DhpoMg2H6Dd6SxN3jC', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(13, 'TVp7PV8q3wSVKoj23223DhpoMg2H6Dd6SxN3jC', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(14, 'TVp7PV8q3wSVKoj232223DhpoMg2H6Dd6SxN3jC', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(15, 'TVp7PV8q3wSVKoj232223DhpoM3g2H6Dd6SxN3jC', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(16, 'TVp7PV8q3wSVKoj233DhpoM3g2H6Dd6SxN3jC', 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(17, 'dfsdfsfsfsadasdadasdsadasdasd', 1, 0, '2024-07-13 12:38:57', '2024-07-13 12:38:57'),
(18, '111111111###slfjldfjlsfjklskfl45', 1, 0, '2024-07-13 12:40:30', '2024-07-13 12:50:05');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `reserved_at` timestamp NULL DEFAULT NULL,
  `available_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc`
--

CREATE TABLE `kyc` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `dl_front` varchar(255) DEFAULT NULL,
  `dl_back` varchar(255) DEFAULT NULL,
  `frontFile_nid` varchar(255) DEFAULT NULL,
  `backFile_nid` varchar(255) DEFAULT NULL,
  `passport` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 0 COMMENT '0=admin not approval\r\n1=admin approval',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kyc`
--

INSERT INTO `kyc` (`id`, `name`, `user_id`, `dl_front`, `dl_back`, `frontFile_nid`, `backFile_nid`, `passport`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 5, NULL, NULL, '/backend/files/DiPqUBLZKr0xqmjXJa72.jpeg', '/backend/files/fZcqyArQIYljlQs4cZ2e.jpeg', NULL, 1, '2025-02-25 16:12:33', '2025-02-26 05:07:38'),
(2, NULL, 5, NULL, NULL, NULL, NULL, '/backend/files/xZwsWR2Zv0UW9qLVuKeX.jpg', 1, '2025-02-25 16:12:45', '2025-02-26 05:07:38'),
(3, NULL, 5, '/backend/files/wIzJrMK3OCrxmdv1bvwh.jpeg', '/backend/files/KV9yfS0SkFblwD2UsJ7G.jpg', NULL, NULL, NULL, 1, '2025-02-25 16:12:55', '2025-02-26 05:07:38');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(10) NOT NULL,
  `status` int(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `status`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 1, '2024-10-26 11:34:03', '2024-10-26 11:34:03'),
(2, 'Bengali', 'bn', 1, '2024-10-26 11:34:03', '2024-10-27 06:00:00'),
(3, 'Hindi', 'hi', 0, '2024-10-26 11:34:03', '2024-10-26 11:34:03'),
(4, 'Tamil', 'ta', 0, '2024-10-26 11:34:03', '2024-10-27 10:16:45'),
(5, 'Chinese', 'zh', 0, '2024-10-26 11:34:03', '2024-10-27 11:10:21'),
(6, 'Spanish', 'es', 0, '2024-10-26 11:34:03', '2024-10-26 11:34:03');

-- --------------------------------------------------------

--
-- Table structure for table `loan_pay_history`
--

CREATE TABLE `loan_pay_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `referrance_name` varchar(255) DEFAULT NULL COMMENT 'table ',
  `last_id` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1=Loan,2=Pay',
  `amount` double(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_pay_history`
--

INSERT INTO `loan_pay_history` (`id`, `user_id`, `referrance_name`, `last_id`, `type`, `amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 9, 'loan_request', 3, 1, -900.00, 0, '2024-08-02 18:38:15', '2024-08-02 18:38:15'),
(3, 9, 'loan_request', 1, 1, -1200.00, 0, '2024-08-02 18:38:39', '2024-08-02 18:38:39'),
(13, 9, 'loan_request', 2, 1, -800.00, 0, '2024-08-02 18:38:39', '2024-08-02 18:38:39'),
(14, 9, 'loan_return_request', 2, 2, 100.00, 1, '2024-08-02 19:39:09', '2024-08-02 19:39:09'),
(15, 9, 'loan_return_request', 1, 2, 200.00, 1, '2024-08-02 19:39:40', '2024-08-02 19:39:40'),
(16, 9, 'loan_request', 4, 1, -1200.00, 0, '2024-08-02 19:47:29', '2024-08-02 19:47:29'),
(17, 9, 'loan_return_request', 3, 2, 3800.00, 0, '2024-08-03 05:02:21', '2024-08-03 05:02:21');

-- --------------------------------------------------------

--
-- Table structure for table `loan_request`
--

CREATE TABLE `loan_request` (
  `id` int(11) NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `loan_value` float(10,2) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT ' 	0=Review,2=Reject,1=Approved 	',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_request`
--

INSERT INTO `loan_request` (`id`, `loan_id`, `loan_value`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1200.00, 9, 1, '2024-08-02 18:37:49', '2024-08-02 18:38:39'),
(2, 2, 800.00, 9, 1, '2024-08-02 18:37:52', '2024-08-02 18:38:19'),
(3, 3, 900.00, 9, 1, '2024-08-02 18:37:54', '2024-08-02 18:38:15'),
(4, 4, 1200.00, 9, 1, '2024-08-02 19:47:00', '2024-08-02 19:47:29');

-- --------------------------------------------------------

--
-- Table structure for table `loan_return_request`
--

CREATE TABLE `loan_return_request` (
  `id` int(11) NOT NULL,
  `loanID` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `deposit_amount` double(10,2) DEFAULT NULL,
  `receivable_amount` double(10,2) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `to_crypto_wallet_address` varchar(255) DEFAULT NULL,
  `frm_wallet_address` varchar(255) DEFAULT NULL,
  `trxId` varchar(255) DEFAULT NULL,
  `depscription` text DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0=Review,2=Reject,1=Approved',
  `approved_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_return_request`
--

INSERT INTO `loan_return_request` (`id`, `loanID`, `user_id`, `deposit_amount`, `receivable_amount`, `payment_method`, `to_crypto_wallet_address`, `frm_wallet_address`, `trxId`, `depscription`, `wallet_address`, `status`, `approved_by`, `created_at`, `updated_at`) VALUES
(1, 'LOAN.d768f8ec110b0207ba7a209f7975fbb1', 9, 200.00, 200.00, 'TRX(TRC20)', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'LOAN.d768f8ec110b0207ba7a209f7975fbb1', NULL, 1, 1, '2024-08-03 00:39:29', '2024-08-03 01:39:40'),
(2, 'LOAN.e327b1649d06bf74fceb4fe73f83bdba', 9, 100.00, 100.00, 'TRX(TRC20)', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'LOAN.e327b1649d06bf74fceb4fe73f83bdba', NULL, 1, 1, '2024-08-03 00:39:51', '2024-08-03 01:22:45'),
(3, 'LOAN.c203e4a1bdef9372cb9864bfc9b511cc', 9, 3800.00, 3800.00, 'TRX(TRC20)', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 'LOAN.c203e4a1bdef9372cb9864bfc9b511cc', NULL, 1, 1, '2024-08-03 10:50:57', '2024-08-03 11:02:21');

-- --------------------------------------------------------

--
-- Table structure for table `loan_settings`
--

CREATE TABLE `loan_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_settings`
--

INSERT INTO `loan_settings` (`id`, `name`, `thumnail_img`, `value`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Request', '/backend/files/ZIwd8fQVPpekqByETY8T.png', 5000, 1, '2024-08-01 16:44:27', '2024-08-01 18:55:18'),
(2, 'Request', '/backend/files/kZjPn8NZRnqJZCqc5ouO.png', 900, 1, '2024-08-01 16:45:32', '2024-08-01 18:55:14'),
(3, 'Request', '/backend/files/r9Mv0aZvFEzNOXrMcFit.png', 800, 1, '2024-08-01 16:45:32', '2024-08-01 18:55:08'),
(4, 'Request', '/backend/files/JcZbVp74ykwMNbYQxrOw.png', 1200, 1, '2024-08-01 16:45:32', '2024-08-01 18:55:02');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `method` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manual_adjustment`
--

CREATE TABLE `manual_adjustment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `adjustment_type` int(11) DEFAULT NULL COMMENT '1=loan\r\n2=reward',
  `adjustment_amount` int(11) DEFAULT NULL,
  `detailed_remarks` varchar(255) DEFAULT NULL,
  `entry_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `manual_adjustment`
--

INSERT INTO `manual_adjustment` (`id`, `user_id`, `adjustment_type`, `adjustment_amount`, `detailed_remarks`, `entry_by`, `created_at`, `updated_at`) VALUES
(2, 9, 1, 50000, 'For Loan Purpose ', 1, '2024-08-01 19:20:18', '2024-08-01 19:20:18'),
(3, 9, 1, 6000, 'For Loan Purpose ', 1, '2024-08-01 19:20:31', '2024-08-01 19:20:31'),
(4, 9, 2, 6000, 'For Reward Purpose ', 1, '2024-08-01 19:20:47', '2024-08-01 19:20:47'),
(5, 9, 1, 1055, 'For Loan Purpose ', 1, '2024-08-01 19:50:22', '2024-08-01 19:50:22'),
(6, 9, 1, 520, 'For Loan Purpose ', 1, '2024-08-01 19:50:39', '2024-08-01 19:50:39'),
(7, 9, 2, 500, 'For Reward Purpose', 1, '2024-08-01 19:51:42', '2024-08-01 19:51:42');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `community_slug` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `username`, `community_slug`, `message`, `created_at`, `updated_at`) VALUES
(1, 3, 'b@gmail.com', 'community-english', 'Hi', '2024-06-12 10:15:21', '2024-06-12 10:15:21'),
(2, 3, 'b@gmail.com', 'community-english', 'Boss', '2024-06-12 10:15:24', '2024-06-12 10:15:24'),
(3, 3, 'b@gmail.com', 'community-english', 'how are you', '2024-06-12 10:15:29', '2024-06-12 10:15:29'),
(4, 2, 'r@gmail.com', 'community-english', 'yes sir good', '2024-06-12 10:16:09', '2024-06-12 10:16:09'),
(5, 2, 'r@gmail.com', 'community-english', 'what about now', '2024-06-12 10:16:14', '2024-06-12 10:16:14'),
(6, 3, 'b@gmail.com', 'community-chinese', 'HI', '2024-06-12 10:16:39', '2024-06-12 10:16:39');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 2),
(3, '2019_08_19_000000_create_failed_jobs_table', 3),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `mininghistory`
--

CREATE TABLE `mininghistory` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mining_date` date DEFAULT NULL,
  `mining_amount` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mining_categogy`
--

CREATE TABLE `mining_categogy` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `duration_in_hour` int(11) DEFAULT NULL,
  `minute` int(11) DEFAULT NULL,
  `second` int(11) DEFAULT NULL,
  `minining_amount_per_secnd` varchar(255) DEFAULT NULL,
  `daily_mining_amount` varchar(255) DEFAULT NULL,
  `mining_value_mention_at_hour` varchar(255) DEFAULT NULL,
  `offer_description` text DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `entry_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mining_categogy`
--

INSERT INTO `mining_categogy` (`id`, `name`, `slug`, `duration_in_hour`, `minute`, `second`, `minining_amount_per_secnd`, `daily_mining_amount`, `mining_value_mention_at_hour`, `offer_description`, `status`, `entry_by`, `created_at`, `updated_at`) VALUES
(1, 'Dolphin Digger', 'dolphin-digger', 1, 60, 3600, '0.00000000', 'null', '0.00000000', 'Save $0.00 max mining $13 max mining 1 hour Live Support', 1, 1, '2024-05-25 12:33:49', '2024-07-19 11:43:45'),
(2, 'Shark Driller', 'shark-driller', 2, 120, 7200, '0.00000000', 'null', '0.00000000', 'Save $0.00 max mining $13 max mining 1 hour Live Support', 1, 1, '2024-05-25 12:34:10', '2024-07-19 11:39:22'),
(3, 'Orca Drillmaster', 'orca-drillmaster', 4, 240, 14400, '0.0000005', 'null', 'null', 'Save $0.00 max mining $13 max mining 1 hour Live Support', 1, 1, '2024-05-25 12:34:29', '2024-07-19 11:39:15'),
(4, 'Whale Excavator', 'whale-excavator', 6, 360, 21600, '0.00000000', '0', '0.00000000', 'Save $0.00 max mining $13 max mining 1 hour Live Support', 1, 1, '2024-05-25 12:34:57', '2024-07-19 11:39:11');

-- --------------------------------------------------------

--
-- Table structure for table `mining_categogy_duration`
--

CREATE TABLE `mining_categogy_duration` (
  `id` int(11) NOT NULL,
  `mining_category_id` int(11) DEFAULT NULL,
  `packages_name` varchar(255) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `prices` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mining_categogy_duration`
--

INSERT INTO `mining_categogy_duration` (`id`, `mining_category_id`, `packages_name`, `duration`, `prices`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Dolphin Digger (30 Days)', '30', 10, 1, '2024-07-14 08:44:55', '2024-07-14 08:45:57'),
(2, 1, 'Dolphin Digger (60 Days)', '60', 18, 1, '2024-07-14 08:46:21', '2024-07-14 08:46:21'),
(3, 1, 'Dolphin Digger (90 Days)', '90', 25, 1, '2024-07-14 08:46:44', '2024-07-14 08:46:44'),
(4, 1, 'Dolphin Digger (120 Days)', '120', 32, 1, '2024-07-14 08:47:09', '2024-07-14 08:47:09'),
(5, 2, 'Shark Driller (30 Days)', '30', 10, 1, '2024-07-14 08:48:31', '2024-07-14 08:48:31'),
(6, 2, 'Shark Driller (60 Days)', '60', 18, 1, '2024-07-14 08:49:01', '2024-07-14 08:49:01'),
(7, 2, 'Shark Driller (90 Days)', '90', 25, 1, '2024-07-14 08:49:21', '2024-07-14 08:49:21'),
(8, 2, 'Shark Driller (120 Days)', '120', 32, 1, '2024-07-14 08:49:43', '2024-07-14 08:49:43'),
(9, 3, 'Orca Drillmaster (30 Days)', '30', 10, 1, '2024-07-14 08:50:56', '2024-07-14 08:50:56'),
(10, 3, 'Orca Drillmaster (60 Days)', '60', 18, 1, '2024-07-14 08:51:10', '2024-07-14 08:51:10'),
(11, 3, 'Orca Drillmaster (90 Days)', '90', 25, 1, '2024-07-14 08:51:25', '2024-07-14 08:51:25'),
(12, 3, 'Orca Drillmaster (120 Days)', '120', 32, 1, '2024-07-14 08:51:45', '2024-07-14 08:51:45'),
(13, 4, 'Whale Excavator (30 Days)', '30', 10, 1, '2024-07-14 08:52:35', '2024-07-14 08:52:35'),
(14, 4, 'Whale Excavator (60 Days)', '60', 18, 1, '2024-07-14 08:52:51', '2024-07-14 08:52:51'),
(15, 4, 'Whale Excavator (90 Days)', '90', 25, 1, '2024-07-14 08:53:13', '2024-07-14 08:53:13'),
(16, 4, 'Whale Excavator (120 Days)', '120', 32, 1, '2024-07-14 08:53:25', '2024-07-14 08:53:25');

-- --------------------------------------------------------

--
-- Table structure for table `mining_process_history`
--

CREATE TABLE `mining_process_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `mining_category_id` int(11) DEFAULT NULL,
  `boost_boot_setting_id` int(11) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1=active, 0=inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mining_process_history`
--

INSERT INTO `mining_process_history` (`id`, `user_id`, `start_time`, `end_time`, `duration`, `mining_category_id`, `boost_boot_setting_id`, `ip`, `status`, `created_at`, `updated_at`) VALUES
(1, 9, '2024-07-18 14:21:57', '2024-07-19 02:21:57', 12, 1, 2, '127.0.0.1', 0, '2024-07-18 14:21:57', '2024-07-18 14:22:29'),
(2, 9, '2024-07-18 14:22:16', '2024-07-19 14:22:16', 24, 1, 3, '127.0.0.1', 1, '2024-07-18 14:22:16', '2024-07-18 14:22:16'),
(3, 9, '2024-07-18 14:22:29', '2024-11-15 14:22:29', 2880, 1, 4, '127.0.0.1', 1, '2024-07-18 14:22:29', '2024-07-18 14:22:29'),
(4, 9, '2024-07-18 14:26:42', '2024-07-18 16:26:42', 2, 2, 5, '127.0.0.1', 0, '2024-07-18 14:26:42', '2024-07-30 10:37:51'),
(5, 9, '2024-07-18 14:26:45', '2024-07-19 02:26:45', 12, 2, 6, '127.0.0.1', 1, '2024-07-18 14:26:45', '2024-07-18 14:26:45'),
(6, 9, '2024-07-18 14:27:41', '2024-07-18 18:27:41', 4, 3, 9, '127.0.0.1', 0, '2024-07-18 14:27:41', '2024-07-31 17:29:01'),
(7, 9, '2024-07-18 14:28:27', '2024-07-18 20:28:27', 6, 4, 13, '127.0.0.1', 0, '2024-07-18 14:28:27', '2024-07-18 14:28:32'),
(8, 9, '2024-07-18 14:28:29', '2024-07-19 02:28:29', 12, 4, 14, '127.0.0.1', 1, '2024-07-18 14:28:29', '2024-07-18 14:28:29'),
(9, 9, '2024-07-18 14:28:30', '2024-07-19 14:28:30', 24, 4, 15, '127.0.0.1', 1, '2024-07-18 14:28:30', '2024-07-18 14:28:30'),
(10, 9, '2024-07-18 14:28:32', '2024-11-15 14:28:32', 2880, 4, 16, '127.0.0.1', 1, '2024-07-18 14:28:32', '2024-07-18 14:28:32'),
(11, 8, '2024-07-18 18:11:31', '2024-07-18 19:11:31', 1, 1, 0, '127.0.0.1', 1, '2024-07-18 18:11:31', '2024-07-18 18:11:31'),
(12, 8, '2024-07-18 18:13:44', '2024-07-18 20:13:44', 2, 2, 0, '127.0.0.1', 1, '2024-07-18 18:13:44', '2024-07-18 18:13:44'),
(13, 8, '2024-07-18 18:17:56', '2024-07-18 22:17:56', 4, 3, 0, '127.0.0.1', 1, '2024-07-18 18:17:56', '2024-07-18 18:17:56'),
(14, 8, '2024-07-18 18:19:26', '2024-07-19 00:19:26', 6, 4, 0, '127.0.0.1', 1, '2024-07-18 18:19:26', '2024-07-18 18:19:26'),
(15, 9, '2024-07-21 04:39:37', '2024-07-21 18:39:37', 12, 2, 6, '127.0.0.1', 1, '2024-07-21 04:39:37', '2024-07-21 04:39:37'),
(16, 9, '2024-07-21 04:39:51', '2024-07-21 12:39:51', 4, 3, 9, '127.0.0.1', 1, '2024-07-21 04:39:51', '2024-07-21 04:39:51'),
(17, 9, '2024-07-30 10:37:51', '2024-07-31 00:37:51', 12, 2, 6, '127.0.0.1', 1, '2024-07-30 10:37:51', '2024-07-30 10:37:51'),
(18, 9, '2024-07-31 17:29:01', '2024-08-01 01:29:01', 4, 3, 9, '127.0.0.1', 1, '2024-07-31 17:29:01', '2024-07-31 17:29:01');

-- --------------------------------------------------------

--
-- Table structure for table `mining_service_buy_history`
--

CREATE TABLE `mining_service_buy_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `purchase_by` int(11) DEFAULT NULL,
  `mining_category_id` int(11) DEFAULT NULL,
  `mining_category_duration_id` int(11) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `service_price` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mining_service_buy_history`
--

INSERT INTO `mining_service_buy_history` (`id`, `user_id`, `purchase_by`, `mining_category_id`, `mining_category_duration_id`, `duration`, `service_price`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 8, NULL, 1, 1, '30', 10, '2024-07-16', '2024-08-16', NULL, '2024-07-15 20:53:58', '2024-07-15 20:53:58'),
(2, 8, NULL, 4, 13, '30', 10, '2024-07-16', '2024-08-16', NULL, '2024-07-15 20:54:07', '2024-07-15 20:54:07'),
(3, 8, NULL, 3, 12, '120', 32, '2024-07-16', '2024-11-16', NULL, '2024-07-15 21:00:01', '2024-07-15 21:00:01'),
(4, 9, NULL, 1, 1, '30', 10, '2024-07-16', '2024-08-16', NULL, '2024-07-15 22:18:34', '2024-07-15 22:18:34'),
(5, 8, NULL, 2, 5, '30', 10, '2024-07-16', '2024-08-16', NULL, '2024-07-16 11:52:28', '2024-07-16 11:52:28'),
(10, 17, 8, 3, 9, '30', 10, '2024-07-16', '2024-08-16', NULL, '2024-07-16 12:00:49', '2024-07-16 12:00:49'),
(11, 17, NULL, 4, 13, '30', 10, '2024-07-17', '2024-08-17', NULL, '2024-07-17 17:04:34', '2024-07-17 17:04:34'),
(12, 9, NULL, 3, 9, '30', 10, '2024-07-18', '2024-08-18', NULL, '2024-07-17 20:02:02', '2024-07-17 20:02:02'),
(13, 9, NULL, 4, 16, '120', 32, '2024-07-18', '2024-11-18', NULL, '2024-07-17 20:53:47', '2024-07-17 20:53:47'),
(14, 9, NULL, 2, 5, '30', 10, '2024-07-18', '2024-08-18', NULL, '2024-07-17 23:19:29', '2024-07-17 23:19:29');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `name` mediumtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `name`, `created_at`, `updated_at`) VALUES
(3, 'Cancelled Orde', '2024-06-27 15:17:28', '2024-06-27 15:17:28'),
(4, 'Great Speed Notify ', '2024-06-27 15:17:28', '2024-06-27 15:17:28'),
(5, 'Test Notification', '2024-06-27 16:10:04', '2024-06-27 16:10:04'),
(6, 'Web development', '2024-06-27 16:10:13', '2024-06-27 16:10:13'),
(7, 'Data Science', '2024-06-27 16:10:21', '2024-06-27 16:10:21');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `orderId` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `transfer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `selling_price` double(10,2) DEFAULT NULL,
  `profit` double(10,2) DEFAULT NULL,
  `buying_price` double(10,2) DEFAULT NULL COMMENT 'cost price',
  `user_balance` double(10,2) DEFAULT NULL,
  `user_mul_balance` double(10,2) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `product_qty` int(11) DEFAULT 1,
  `order_status` int(11) NOT NULL DEFAULT 1 COMMENT '1=To be paid\r\n                                                        2=To be confiremed\r\n                                                        3=Goods To be received\r\n                                                        4=Platform procced\r\n                                                        5=To be shipped\r\n                                                        6=Complete\r\n                                                        7=Canceled\r\n                                                        8=Returning\r\n                                                        9=Return complete\r\n                                                        10=Abnormal order',
  `status` int(11) DEFAULT 1,
  `order_type` varchar(255) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `order_inactive_time` varchar(255) DEFAULT NULL,
  `pay_confirm_time` timestamp NULL DEFAULT NULL COMMENT 'After click on payment button',
  `goods_to_be_received_time` timestamp NULL DEFAULT NULL COMMENT '+30',
  `platform_proceed_Time` timestamp NULL DEFAULT NULL COMMENT '+60',
  `to_be_shipped_time` timestamp NULL DEFAULT NULL COMMENT '+90',
  `complete_time` timestamp NULL DEFAULT NULL COMMENT '+120',
  `cancel_time` timestamp NULL DEFAULT NULL,
  `return_time` timestamp NULL DEFAULT NULL,
  `return_complete_time` timestamp NULL DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp(),
  `abnormal_order_time` timestamp NULL DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `schedule_time` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`id`, `name`, `description`, `schedule_time`, `status`, `created_at`, `updated_at`) VALUES
(1, 'To be paid', 'To be paid', NULL, 1, '2023-12-04 11:15:23', '2023-12-04 05:55:06'),
(2, 'To be confiremed', 'To be confiremed', NULL, 1, '2023-12-04 11:15:23', '2023-12-04 05:55:48'),
(3, 'Goods To be received', 'Goods To be received', '30', 1, '2023-12-04 11:15:23', '2023-12-04 05:56:14'),
(4, 'Platform procced', 'Platform procced', '30', 1, '2023-12-04 11:15:23', '2023-12-04 05:56:45'),
(5, 'To be shipped', 'To be shipped', '30', 1, '2023-12-04 11:15:23', '2023-12-04 05:57:14'),
(6, 'Complete', 'Complete', '30', 1, '2023-12-04 11:15:23', '2023-12-04 05:57:42'),
(7, 'Canceled', 'Canceled', NULL, 1, '2023-12-04 11:15:23', '2023-12-04 05:58:19'),
(8, 'Returning', 'Returning', NULL, 1, '2023-12-04 11:15:23', '2023-12-04 05:58:53'),
(9, 'Return complete', 'Return complete', NULL, 1, '2023-12-04 11:15:23', '2023-12-04 05:59:17'),
(10, 'Abnormal order', 'Abnormal order', NULL, 1, '2023-12-04 11:15:23', '2023-12-04 05:59:17');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`) VALUES
(1, 'gazigiashuddin@gmail.com', 'cBk8LmFh6xfydQ2ao78Qznbj4XtNcPMSJRlNxSUePN07sEr9Vg2yCl3Ou9Y9', '2024-07-11 17:39:05'),
(2, 'gazigiashuddin@gmail.com', 'mhEUCcET2u0JHkrS9srpcahx1Uz9g7D4AcohXUW4VutHE5qiNw73Ozjifyi4', '2024-07-11 17:44:39');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `api_code` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `show_password` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `user_id`, `account`, `api_key`, `api_code`, `username`, `show_password`, `password`, `created_at`, `updated_at`) VALUES
(1, 5, 'fg88888', '16c5e06db5eb441d9a205892006b7966', 'AG', 'Ibraheem', 'Ibraheem', '$2y$10$3PXAwipvxWhXURZ08FsFv.dAd.xvMlcWQWSZDtZ4bWxL/S2UBBZca', '2024-10-17 15:05:59', '2024-10-17 15:05:59'),
(2, 6, 'fg88888', '16c5e06db5eb441d9a205892006b7966', 'AG', 'ayesha', 'ayesha', '$2y$10$H8gBmnMk4Kiuc8XyWb3Z5uNQKQvNZCXwXxHP2CvG95CyloCH7J4oa', '2024-10-17 15:07:17', '2024-10-17 15:07:17'),
(3, 3, 'fg88888', '16c5e06db5eb441d9a205892006b7966', 'AG', 'mamunahmed', 'Password', '$2y$10$L53y8kGnH7XRqY5Bgr6LaOuhWKtxcZfbzIlLFqoevJVynD9LOipfm', '2024-10-17 15:07:17', '2024-10-17 15:07:17'),
(4, 4, 'fg88888', '16c5e06db5eb441d9a205892006b7966', 'AG', 'kabirahmed', 'kabirahmed', '$2y$10$lmzA0KbNyMantkLl55QsWO1VzooI7rpLZXTozHrOatTLhSn3wSZ/i', '2024-10-17 15:07:17', '2024-10-17 15:07:17');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description_short` text DEFAULT NULL,
  `description_full` text DEFAULT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `entry_by` int(11) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_category`
--

CREATE TABLE `post_category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_category`
--

INSERT INTO `post_category` (`id`, `name`, `status`) VALUES
(1, 'Announcement', 1),
(2, 'Event', 1),
(3, 'FAQs', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description_short` text DEFAULT NULL,
  `description_full` text DEFAULT NULL,
  `selling_price` double(10,2) DEFAULT NULL,
  `profit` double(10,2) DEFAULT NULL,
  `buying_price` double(10,2) DEFAULT NULL,
  `qty_status` int(11) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keyword` varchar(255) DEFAULT NULL,
  `product_tag` varchar(255) DEFAULT NULL,
  `brand` int(11) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `external_link` varchar(255) DEFAULT NULL,
  `sell_qty` int(11) DEFAULT NULL,
  `balance_qty` int(11) DEFAULT NULL,
  `cash_dev_status` int(11) DEFAULT NULL,
  `price` double(10,2) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `stock_qty` int(11) DEFAULT NULL,
  `stock_mini_qty` int(11) DEFAULT NULL,
  `stock_status` int(11) DEFAULT NULL,
  `manufacturer` int(11) DEFAULT NULL,
  `download_link` varchar(255) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `discount` double(10,2) DEFAULT NULL,
  `discount_status` int(11) DEFAULT NULL,
  `shipping_days` int(11) DEFAULT NULL,
  `free_shopping` int(11) DEFAULT NULL,
  `flat_rate_status` int(11) DEFAULT NULL,
  `flat_rate_price` double(10,5) DEFAULT NULL,
  `draw_details` text DEFAULT NULL,
  `vat` varchar(255) DEFAULT NULL,
  `vat_status` int(11) DEFAULT NULL,
  `tax` varchar(255) DEFAULT NULL,
  `tax_status` int(11) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `entry_by` int(11) DEFAULT NULL,
  `counter` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produc_categories`
--

CREATE TABLE `produc_categories` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produc_img_history`
--

CREATE TABLE `produc_img_history` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `images` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_games`
--

CREATE TABLE `request_games` (
  `id` int(11) NOT NULL,
  `traceId` varchar(255) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `gameid` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `lang` varchar(100) DEFAULT NULL,
  `uname` varchar(255) DEFAULT NULL,
  `nick` varchar(255) DEFAULT NULL,
  `app_id` varchar(255) DEFAULT NULL,
  `cid` int(11) NOT NULL,
  `sign` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rewards_centers_settings`
--

CREATE TABLE `rewards_centers_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rewards_centers_settings`
--

INSERT INTO `rewards_centers_settings` (`id`, `name`, `thumnail_img`, `value`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Loan', '/backend/files/7kuJrvCYXGqWeCcJwftV.png', 100000, 1, '2024-08-01 01:38:34', '2024-08-01 16:50:01'),
(2, 'Cliam', '/backend/files/ExVOYf8TdmqpZk82YaLz.png', 900, 1, '2024-08-01 01:38:41', '2024-08-01 14:12:39'),
(3, 'Cliam', '/backend/files/SwjkvAaQvIYiZilAIJ45.png', 89, 1, '2024-08-01 01:38:41', '2024-08-01 14:12:22'),
(4, 'Cliam', '/backend/files/l6VRRqPRBZuyTJWdkhNz.png', 70, 1, '2024-08-01 01:38:41', '2024-08-01 14:12:13'),
(5, 'Cliam', '/backend/files/neOnOd2xWHfImGNyjNvJ.png', 60, 1, '2024-08-01 01:38:41', '2024-08-01 14:12:05'),
(6, 'Cliam', '/backend/files/bGpjwIcmtZAdRrNuEWtd.png', 560, 1, '2024-08-01 01:38:41', '2024-08-01 18:54:43'),
(7, 'Cliam', '/backend/files/AdKo1qz6rHkXbl4IDm7e.png', 230, 1, '2024-08-01 01:38:41', '2024-08-01 18:54:51');

-- --------------------------------------------------------

--
-- Table structure for table `reward_center_request`
--

CREATE TABLE `reward_center_request` (
  `id` int(11) NOT NULL,
  `reward_center_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT ' 	0=Review,2=Reject,1=Approved 	',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reward_center_request`
--

INSERT INTO `reward_center_request` (`id`, `reward_center_id`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 7, 9, 1, '2024-08-01 14:39:32', '2024-08-01 14:39:32'),
(2, 6, 9, 0, '2024-08-01 14:39:37', '2024-08-01 14:39:37'),
(3, 1, 9, 0, '2024-08-01 14:39:54', '2024-08-01 14:39:54'),
(4, 4, 8, 0, '2024-08-01 14:42:21', '2024-08-01 16:26:17'),
(6, 5, 9, 0, '2024-08-01 16:26:28', '2024-08-01 16:26:28'),
(7, 2, 9, 0, '2024-08-01 17:58:22', '2024-08-01 17:58:22');

-- --------------------------------------------------------

--
-- Table structure for table `rule`
--

CREATE TABLE `rule` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rule`
--

INSERT INTO `rule` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 1, '2024-04-16 10:33:46', '2024-04-16 10:33:46'),
(2, 'Player', 1, '2024-04-16 10:56:15', '2024-04-16 10:56:15'),
(3, 'Admin', 1, '2024-04-16 10:56:27', '2024-04-16 10:56:27'),
(4, 'Agent', 1, '2024-04-16 10:56:39', '2024-04-16 10:56:39');

-- --------------------------------------------------------

--
-- Table structure for table `seller_review`
--

CREATE TABLE `seller_review` (
  `id` bigint(20) NOT NULL,
  `orderId` varchar(255) NOT NULL,
  `review` text NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL,
  `seller_id` bigint(20) NOT NULL,
  `buyer_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `seller_review`
--

INSERT INTO `seller_review` (`id`, `orderId`, `review`, `rating`, `seller_id`, `buyer_id`, `created_at`, `updated_at`) VALUES
(1, '392777-24', 'Your ReviewYour ReviewYour ReviewYour ReviewYour ReviewYour ReviewYour ReviewYour ReviewYour ReviewYour Review', 3, 2, 3, '2024-10-21 12:52:30', '2024-10-21 12:52:30');

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `deposit_service_charge` int(11) DEFAULT NULL COMMENT '%',
  `convert_php_amt` float DEFAULT NULL,
  `withdraw_service_charge` int(11) DEFAULT NULL COMMENT '%',
  `withdraw_minimum_amount` int(11) DEFAULT NULL,
  `withdraw_maximum_amount` int(11) DEFAULT NULL,
  `minimum_trade_amount` int(11) DEFAULT NULL,
  `minimum_purchages_amt` int(11) DEFAULT NULL,
  `minimum_deposit_amount` int(11) DEFAULT NULL,
  `trade_fee` int(11) DEFAULT NULL COMMENT '%',
  `tel` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` mediumtext NOT NULL,
  `whatsApp` varchar(255) NOT NULL,
  `emergency` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `description` mediumtext NOT NULL,
  `copyright` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `admin_photo` varchar(244) NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `admin_email` varchar(255) NOT NULL,
  `admin_phone` varchar(255) NOT NULL,
  `meta_keywords` mediumtext DEFAULT NULL,
  `meta_description` mediumtext DEFAULT NULL,
  `pphoto` varchar(255) NOT NULL,
  `bg_color` varchar(255) DEFAULT NULL,
  `currency` varchar(150) DEFAULT NULL,
  `openinig_balance_date` date DEFAULT NULL,
  `reffer_bonus` int(11) DEFAULT NULL,
  `maximum_supply` double(10,2) DEFAULT NULL,
  `total_supply` varchar(255) DEFAULT NULL,
  `openinig_balance_comments` mediumtext DEFAULT NULL,
  `fblink` varchar(255) DEFAULT NULL,
  `twitterlink` varchar(255) DEFAULT NULL,
  `linkdinlink` varchar(255) DEFAULT NULL,
  `instragramlink` varchar(255) DEFAULT NULL,
  `store_policy` longtext DEFAULT NULL,
  `crypto_wallet_address` varchar(255) DEFAULT NULL,
  `master_pass_acc_no` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `telegram` varchar(255) DEFAULT NULL,
  `register_bonus` int(11) DEFAULT NULL,
  `mininmum_deposit_amount` double(10,2) DEFAULT NULL,
  `maximum_deposit_amount` double(10,2) DEFAULT NULL,
  `minimum_withdrawal` double(10,2) DEFAULT NULL,
  `maximum_withdrawal` double(10,2) DEFAULT NULL,
  `level_1_bonus` int(11) DEFAULT NULL,
  `level_2_bonus` int(11) DEFAULT NULL,
  `level_3_bonus` int(11) DEFAULT NULL,
  `ocn_purchage` double(10,2) DEFAULT NULL,
  `daily_max_withdraw_request` double(10,2) DEFAULT NULL,
  `withdrawal_free_amount` double(10,2) DEFAULT NULL,
  `withdrawal_free_on_percentage` double(10,2) DEFAULT NULL,
  `maximum_supply_level` varchar(255) DEFAULT NULL,
  `mimumun_transfer_amount_to_other_user` double(10,2) DEFAULT NULL,
  `maximum_transfer_amount_to_other_user` double(10,2) DEFAULT NULL,
  `transfer_fee_fixed_amount` double(10,2) DEFAULT NULL,
  `traansfer_fee_on_percentage` double(10,2) DEFAULT NULL,
  `total_supply_level` varchar(255) DEFAULT NULL,
  `liquidity_total_supply` varchar(255) DEFAULT NULL,
  `beganing_price` varchar(255) DEFAULT NULL,
  `circlation` varchar(255) DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `name`, `deposit_service_charge`, `convert_php_amt`, `withdraw_service_charge`, `withdraw_minimum_amount`, `withdraw_maximum_amount`, `minimum_trade_amount`, `minimum_purchages_amt`, `minimum_deposit_amount`, `trade_fee`, `tel`, `email`, `address`, `whatsApp`, `emergency`, `photo`, `description`, `copyright`, `status`, `admin_photo`, `admin_name`, `admin_email`, `admin_phone`, `meta_keywords`, `meta_description`, `pphoto`, `bg_color`, `currency`, `openinig_balance_date`, `reffer_bonus`, `maximum_supply`, `total_supply`, `openinig_balance_comments`, `fblink`, `twitterlink`, `linkdinlink`, `instragramlink`, `store_policy`, `crypto_wallet_address`, `master_pass_acc_no`, `website`, `telegram`, `register_bonus`, `mininmum_deposit_amount`, `maximum_deposit_amount`, `minimum_withdrawal`, `maximum_withdrawal`, `level_1_bonus`, `level_2_bonus`, `level_3_bonus`, `ocn_purchage`, `daily_max_withdraw_request`, `withdrawal_free_amount`, `withdrawal_free_on_percentage`, `maximum_supply_level`, `mimumun_transfer_amount_to_other_user`, `maximum_transfer_amount_to_other_user`, `transfer_fee_fixed_amount`, `traansfer_fee_on_percentage`, `total_supply_level`, `liquidity_total_supply`, `beganing_price`, `circlation`, `update_by`, `created_at`, `updated_at`) VALUES
(1, 'OCN TRADE AI', 5, 64, 5, 20, 4000, 5, 20, 20, 6, '+44245454545', 'ocn@abcd.com', 'Addres', '00000055555', '+000000', 'pic/2tAjiUpJ0X8GziIrKJJJ.png', 'Business Description', 'Copyright © 2025 uic . All Rights Reserved', 1, 'pic/ZOdc8nsWAMY1YELkp9zH.jpg', 'admin', 'info@admin.com', '+44245454545', NULL, NULL, '', '#ffffff', '$', '2020-05-13', 5, 30000000.00, '4500000', NULL, 'https://www.fiverr.com', 'https://www.facebook.com', 'https://web.whatsapp.com/', '#', '', 'TPpMvdKfhENfJqYZsDJQLgEopMRBy15jeU', '225588996633', 'http://winup360.com', '116898999999', 5, 55.00, 5.00, 20.00, 3690.00, 3, 2, 1, NULL, 5.00, 5.00, 5.00, '30 MILLION', 5.00, 5.00, 5.00, 50.00, '4.5 MILLION', '5000', '0.0011244444', 'null', 2993, '2024-05-12 05:32:50', '2024-05-12 03:42:05');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `images` varchar(255) DEFAULT NULL,
  `redirect_url` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `star_gallary`
--

CREATE TABLE `star_gallary` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  `rank` varchar(255) DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `ethnicity` varchar(255) DEFAULT NULL,
  `raw_measurement` varchar(255) DEFAULT NULL,
  `boobs` varchar(255) DEFAULT NULL,
  `hair` varchar(255) DEFAULT NULL,
  `ass` varchar(255) DEFAULT NULL,
  `bust` varchar(255) DEFAULT NULL,
  `cupsize` varchar(255) DEFAULT NULL,
  `eye` varchar(255) DEFAULT NULL,
  `hip` varchar(255) DEFAULT NULL,
  `piercings` varchar(255) DEFAULT NULL,
  `shoesize` varchar(255) DEFAULT NULL,
  `tots` varchar(255) DEFAULT NULL,
  `waist` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `thumnail` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `star_gallary_history`
--

CREATE TABLE `star_gallary_history` (
  `id` int(11) NOT NULL,
  `star_gallary_id` int(11) NOT NULL,
  `files` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `star_video_gallary`
--

CREATE TABLE `star_video_gallary` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `video_source_link` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `thumnail` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_configs`
--

CREATE TABLE `system_configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `config_group` varchar(255) DEFAULT 'basic',
  `type` varchar(255) NOT NULL DEFAULT 'text',
  `value` text NOT NULL,
  `data_config` varchar(255) NOT NULL,
  `link_html` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `lang` varchar(255) NOT NULL DEFAULT 'zh_cn',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_configs`
--

INSERT INTO `system_configs` (`id`, `name`, `title`, `config_group`, `type`, `value`, `data_config`, `link_html`, `description`, `is_open`, `lang`, `created_at`, `updated_at`) VALUES
(1, 'remote_api_domain', 'Branch API domain name', 'remote_api', 'text', 'https://api.yibo-api.com', '', '', '', 0, 'common', '2020-12-19 08:06:44', '2023-08-29 09:47:17'),
(2, 'remote_api_id', 'API ID', 'remote_api', 'text', 'ygdemo', '', '', '', 0, 'common', '2020-12-19 08:06:44', '2023-09-06 09:25:58'),
(3, 'remote_api_key', 'api_key', 'remote_api', 'text', '5183f8842c354792b804b96640dc6a4a', '', '', '', 0, 'common', '2020-12-19 08:06:44', '2023-09-06 09:25:46'),
(4, 'remote_api_prefix', 'API Key', 'remote_api', 'text', '', '', '', '', 0, 'common', '2020-12-19 08:06:44', '2021-06-06 15:31:30'),
(5, 'mobile_category_json', 'Mobile home page icon configuration', 'basic', 'text', '[{\"title\":\"热门\",\"game_type\":\"-1\",\"icon_before\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764823_5QAXlk8NR0.png\",\"icon_after\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764830_qLuaYep1PJ.png\",\"weight\":\"10\",\"is_open\":\"true\"},{\"title\":\"电子\",\"game_type\":\"3\",\"icon_before\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764851_8DaKDAXYFA.png\",\"icon_after\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764858_bPyZEMNmta.png\",\"weight\":\"7\",\"is_open\":\"true\"},{\"title\":\"真人\",\"game_type\":\"1\",\"icon_before\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764876_mEWl9ATJCt.png\",\"icon_after\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764883_fhdm0eBtff.png\",\"weight\":\"8\",\"is_open\":\"true\"},{\"title\":\"捕鱼\",\"game_type\":\"2\",\"icon_before\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764897_EAcvY7hVKc.png\",\"icon_after\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764904_laFtx8N9Jl.png\",\"weight\":\"5\",\"is_open\":\"true\"},{\"title\":\"棋牌\",\"game_type\":\"6\",\"icon_before\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202106/05/gameicon_1622854662_rLfhtfWPFQ.png\",\"icon_after\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202106/05/gameicon_1622855020_EIKRV3YIkH.png\",\"weight\":\"6\",\"is_open\":\"true\"},{\"title\":\"体育\",\"game_type\":\"5\",\"icon_before\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764977_ubQwTOhQmK.png\",\"icon_after\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764983_eGncPXhqKo.png\",\"weight\":\"9\",\"is_open\":\"true\"},{\"title\":\"彩票\",\"game_type\":\"4\",\"icon_before\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764956_F7kWmh31OZ.png\",\"icon_after\":\"https://demo01act.yiboapi.com/storage/uploads/gameicon/202104/30/gameicon_1619764963_sIpgVOxdwt.png\",\"weight\":\"4\",\"is_open\":\"true\"}]', '', '', '', 0, 'common', '2020-12-19 08:06:44', '2023-07-30 07:53:35'),
(21, 'is_system_maintenance', 'Whether to enable system maintenance', 'system', 'boolean', '0', '', '', '', 1, 'common', '2020-12-19 08:06:44', '2021-07-20 20:10:14'),
(22, 'system_maintenance_whitelist', 'System maintenance IP whitelist', 'system', 'textarea', '47.56.182.24|1.1.1.1', '', '', '', 1, 'common', '2020-12-19 08:06:44', '2021-07-20 18:37:06'),
(26, 'site_domain', 'Active site domain name', 'system', 'text', 'https://demo01act.yiboapi.com', '', '', '', 1, 'common', '2020-12-19 08:06:44', '2023-07-30 07:53:35'),
(28, 'wap_qrcode', 'Mobile APP download QR code', 'system', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202101/24/config_1611478597_BAGR4Q1Vwb.png', '', '', '', 1, 'common', '2020-12-19 08:06:44', '2023-07-30 07:53:35'),
(30, 'service_link', 'Customer Service Link', 'service', 'text', 'https://www.baidu.com/', '', '', '', 1, 'zh_cn', '2020-12-19 08:06:44', '2022-04-04 07:27:19'),
(32, 'site_logo', 'Website Logo', 'system', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202309/21/config_1695306615_diPjszun0B.png', '', '', '', 1, 'common', '2020-12-19 08:06:44', '2023-09-21 14:30:44'),
(33, 'site_logo2', 'Website backup LOGO', 'system', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202309/21/config_1695306623_b1JW2CZRRo.png', '', '', '', 1, 'common', '2020-12-19 08:06:44', '2023-09-21 14:30:44'),
(36, 'site_email', 'Website mailbox', 'admin', 'text', 'sales@atbgaming.com', '', '', '', 1, 'common', '2020-12-19 08:06:44', '2021-06-27 15:45:32'),
(37, 'site_slogan', 'Website secondary logo', 'system', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202309/21/config_1695306631_awo1kElpd0.png', '', '', '图片尺寸：宽240px，高60px', 1, 'common', '2020-12-19 08:06:44', '2023-09-21 14:30:44'),
(38, 'site_pc', 'Computer address', 'system', 'text', 'https://demo01www.yiboapi.com/', '', '', '需要包含http://前缀', 1, 'common', '2020-12-19 08:06:44', '2023-07-30 07:53:11'),
(39, 'site_mobile', 'Mobile website', 'system', 'text', 'https://demo01wap.yiboapi.com/', '', '', '需要包含http://前缀', 1, 'common', '2020-12-19 08:06:44', '2023-07-30 07:53:11'),
(90, 'system_maintenance_message', 'Website maintenance reminder information', 'site', 'textarea', '网站维护时间是 xxx ~ xxx', '', '', '', 1, 'zh_cn', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(91, 'system_maintenance_message', 'Website maintenance reminder information', 'site', 'textarea', '網站維護時間是 xxx ~ xxx', '', '', '', 1, 'zh_hk', '2020-12-26 07:28:51', '2020-12-26 08:48:16'),
(92, 'system_maintenance_message', 'Website maintenance reminder information', 'site', 'textarea', '网站维护时间是 xxx ~ xxx', '', '', '', 1, 'en', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(93, 'system_maintenance_message', 'Website maintenance reminder information', 'site', 'textarea', '网站维护时间是 xxx ~ xxx', '', '', '', 1, 'th', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(94, 'system_maintenance_message', 'Website maintenance reminder information', 'site', 'textarea', '网站维护时间是 xxx ~ xxx', '', '', '', 1, 'vi', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(104, 'site_title', 'Website Title', 'site', 'text', '壹博API演示站', '', '', '', 1, 'vi', '2020-12-26 07:28:51', '2023-07-23 13:37:50'),
(105, 'site_keyword', 'Website keywords', 'site', 'textarea', '网站，关键字', '', '', '', 1, 'zh_cn', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(106, 'site_keyword', 'Website keywords', 'site', 'textarea', '网站，关键字', '', '', '', 1, 'zh_hk', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(107, 'site_keyword', 'Website keywords', 'site', 'textarea', '网站，关键字', '', '', '', 1, 'en', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(108, 'site_keyword', 'Website keywords', 'site', 'textarea', '网站，关键字', '', '', '', 1, 'th', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(109, 'site_keyword', 'Website keywords', 'site', 'textarea', '网站，关键字', '', '', '', 1, 'vi', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(110, 'site_name', 'Website Name', 'site', 'text', '壹博API演示站', '', '', '', 1, 'zh_cn', '2020-12-26 07:28:51', '2023-07-23 13:37:50'),
(164, 'wheel_rule', '幸运大转盘活动条款与规则', 'activity_about', 'editor', '<p>1. Mọi ch&iacute;nh s&aacute;ch ưu ti&ecirc;n được đặt trong RMB, v&agrave; số lượng tiền mặt v&agrave; tiền đặt hiệu quả được t&iacute;nh theo thời gian đ&ocirc;ng, tức l&agrave; 12:00trưa mỗi ng&agrave;y tới 12:00trưa ng&agrave;y h&ocirc;m sau;</p>\n<p>2. Số bảng xoay sản xuất c&ugrave;ng một ng&agrave;y sẽ c&oacute; t&aacute;c dụng v&agrave;o giờ h&agrave;ng 14:00 Bắc Kinh v&agrave;o ng&agrave;y h&ocirc;m sau. Sau khi sử dụng n&oacute;, bạn c&oacute; thể tham gia v&agrave;o vật l&yacute; giải tr&iacute; Jinsha v&agrave; l&agrave;m những hoạt động xoay may mắn với t&agrave;i khoản của bạn. Số lượng may mắn c&oacute; thể t&iacute;ch lũy l&ecirc;n tới ba lần, v&agrave; số dư sẽ bị xo&aacute; sau khi bảo tr&igrave; v&agrave;o thứ ba mỗi tuần;</p>\n<p>Ba. Để tham quan năm ng&agrave;y Trung Quốc, Hong Kong, Macau v&agrave; Đ&agrave;i Loan, v&agrave; bảy ng&agrave;y du lịch sang trọng của Đ&ocirc;ng Nam &Aacute;, h&atilde;y li&ecirc;n lạc với dịch vụ kh&aacute;ch h&agrave;ng trực tuyến để được ứng dụng lần đầu ti&ecirc;n. du lịch đặc biệt được chọn bởi Jinsha Entertainment. Hai người du lịch c&ugrave;ng nhau, bao gồm thẻ th&ocirc;ng h&agrave;nh của Hong Kong, Macao v&agrave; Đ&agrave;i Loan, v&eacute; m&aacute;y bay v&ograve;ng quốc tế, v&eacute; du lịch du lịch du lịch Trung Quốc, người dẫn đường.Bao gồm xe bu&yacute;t hạng sang, xe du lịch, g&oacute;i thức ăn v&agrave; hộ l&yacute; đầy đủ, v&agrave; lời khuy&ecirc;n hướng dẫn du lịch.</p>\n<p>4. Nếu bạn thắng giải thể h&igrave;nh iPhone x256g (đen, 256g, Bank of China) kh&ocirc;ng thể giảm gi&aacute; được. H&atilde;y li&ecirc;n lạc với dịch vụ kh&aacute;ch h&agrave;ng của ch&uacute;ng t&ocirc;i trong v&ograve;ng ba ng&agrave;y sau khi tr&uacute;ng giải thưởng để cung cấp địa chỉ ph&aacute;t nhanh, t&ecirc;n v&agrave; số li&ecirc;n lạc. Phần thưởng sẽ được gửi ra chỉ trong mười ng&agrave;y sau khi th&agrave;nh vi&ecirc;n thắng cuộc cung cấp địa chỉ h&agrave;ng đặc biệt,Nếu kh&ocirc;ng li&ecirc;n lạc với c&ocirc;ng ty để x&aacute;c nhận địa chỉ tiếp nhận trong v&ograve;ng ba ng&agrave;y l&agrave;m việc sau khi tr&uacute;ng giải thưởng, hoặc nếu h&agrave;ng kh&ocirc;ng thể được gởi v&agrave; trả lại bằng đơn ph&aacute;t nhanh do th&ocirc;ng tin nhận chưa đầy đủ hay kh&ocirc;ng đ&uacute;ng, c&aacute; nh&acirc;n cung cấp hay kh&ocirc;ng thể li&ecirc;n lạc qua điện thoại, th&igrave; n&oacute; sẽ được coi l&agrave; c&ocirc;ng ty sẽ tự động từ bỏ giao dịch;</p>\n<p>Năm. Những th&agrave;nh vi&ecirc;n đ&atilde; thắng \"phỉnh tiền mặt\" trong hoạt động n&agrave;y kh&ocirc;ng cần phải li&ecirc;n lạc để ứng dụng. Hệ thống s ẽ tự động th&ecirc;m v&agrave;o số t&agrave;i khoản của th&agrave;nh vi&ecirc;n thắng cuộc trong v&ograve;ng ba mươi ph&uacute;t, v&agrave; họ c&oacute; thể y&ecirc;u cầu r&uacute;t lui với d&ograve;ng chảy thời gian;</p>\n<p>6. Những người thắng \"e-game k&iacute; gửi XXX v&agrave; gửi XXX coupons\" trong hoạt động n&agrave;y phải gửi XXX yuan trong c&ugrave;ng ng&agrave;y với US Eastern time, v&agrave; sau đ&oacute; li&ecirc;n lạc với dịch vụ kh&aacute;ch h&agrave;ng trực tuyến để xin giảm gi&aacute; cho XXX yuan (bạn kh&ocirc;ng thể đặt cược trong suốt qu&aacute; tr&igrave;nh ứng dụng, nếu kh&ocirc;ng n&oacute; sẽ được coi l&agrave; kh&ocirc;ng th&agrave;nh phiếu). Việc k&iacute; gửi v&agrave; gửi giảm gi&aacute; chỉ c&oacute; thể được ho&agrave;n t ất sau khi ho&agrave;n th&agrave;nh (vốn dựa dựa dựa tr&ecirc;n chuỗi).</p>\n<p>7. Mỗi th&agrave;nh vi&ecirc;n, mỗi địa chỉ, mỗi địa chỉ e mail, mỗi số điện thoại, c&ugrave;ng một phương ph&aacute;p thanh to &aacute;n (c&ugrave;ng thẻ t&iacute;n dụng/ t&agrave;i khoản ng&acirc;n h&agrave;ng ch&iacute;nh ch&iacute;nh) v&agrave; địa chỉ IP chỉ c&oacute; thể c&oacute; &iacute;t nhất ba cơ hội xoay ngược trong c&ugrave;ng ng&agrave;y. Nếu một th&agrave;nh vi&ecirc;n log in v&agrave;o nhiều t&agrave;i khoản tại c&ugrave;ng IP, th&igrave; c&ocirc;ng ty c&oacute; quyền từ chối cung cấp tiền v&agrave; đ&oacute;ng băng số t&agrave;i khoản của m&igrave;nh để đảm bảo lợi &iacute;ch của những người chơi xổ số;</p>\n<p>8. Tất cả c&aacute;c ch&iacute;nh s &aacute;ch ưu ti&ecirc;n d&agrave;nh cho Jinsha giải tr&iacute; l&agrave; d&agrave;nh ri&ecirc;ng cho những th&agrave;nh vi&ecirc;n của n&oacute;. Nếu một nh&oacute;m hay một c&aacute; nh&acirc;n n&agrave;o đ&oacute; bị ph&aacute;t hiện lừa dối hay đe dọa lạm dụng c&aacute;c ch&iacute;nh s&aacute;ch ưu ti&ecirc;n, Jinsha sẽ d&agrave;nh quyền đ&oacute;ng băng hay hủy bỏ số dư của nh&oacute;m hay t&agrave;i khoản c&aacute; nh&acirc;n;</p>\n<p>9. Jinsha Entertainment d&agrave;nh quyền được giải th&iacute;ch cuối c&ugrave;ng của sự kiện v&agrave; c&oacute; quyền thay đổi hoặc chấm dứt sự kiện m&agrave; kh&ocirc;ng c&oacute; th&ocirc;ng b&aacute;o.</p>', '', '', '', 1, 'vi', '2020-12-26 07:28:51', '2021-07-06 10:15:22'),
(165, 'credit_detail', '借呗活动详情', 'credit', 'editor', '<p><span>即日起，凡是在金沙娱乐</span><span>的&lsquo;电子、棋牌、捕鱼、真人&rsquo;升级模式等级达到</span><span style=\"color: #e03e2d;\">1级</span><span>的会员，均可申请无利息借贷，0抵押，0担保！所借款的额度，直接添加至会员账号，可直接提款。可借款总额=电子信用额度+真人信用额度+信用借支。</span></p>', '', '', '', 1, 'zh_cn', '2020-12-26 07:28:51', '2021-01-24 09:02:42'),
(248, 'app_xima_text', '洗码说明', 'app_content', 'editor', '', '', '', '', 1, 'th', '2020-12-26 07:28:51', '2020-12-26 07:28:51'),
(251, 'site_wap_logo', '手机网站Logo', 'system', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202309/21/config_1695306641_7ex6kZ0I6A.png', '', '', '', 1, 'common', '2021-02-09 08:40:30', '2023-09-21 14:30:44'),
(254, 'vip1_is_register_sms_open', '是否开启注册短信验证', 'register', 'boolean', '0', '', '', '', 1, 'common', '2021-03-20 11:05:30', '2022-04-24 05:29:09'),
(256, 'service_link', 'Customer Service Link', 'service', 'text', '越南客服', '', '', '', 1, 'vi', '2021-03-20 11:05:30', '2021-05-11 13:36:21'),
(257, 'service_link', 'Customer Service Link', 'service', 'text', '泰国客服', '', '', '', 1, 'th', '2021-03-20 11:05:30', '2021-05-11 13:36:21'),
(258, 'service_link', 'Customer Service Link', 'service', 'text', 'http://kf.baabb.cn/', '', '', '', 1, 'en', '2021-03-20 11:05:30', '2021-07-05 17:28:49'),
(259, 'service_line', 'Line', 'line', 'text', '中文line', '', '', '', 1, 'zh_cn', '2021-03-20 11:05:30', '2021-05-11 13:36:21'),
(260, 'service_line', 'Line', 'line', 'text', '越南line', '', '', '', 1, 'vi', '2021-03-20 11:05:30', '2021-05-11 13:36:21'),
(261, 'service_line', 'Line', 'line', 'text', '泰国line', '', '', '', 1, 'th', '2021-03-20 11:05:30', '2021-05-11 13:36:21'),
(262, 'service_line', 'Line', 'line', 'text', '英语line', '', '', '', 1, 'en', '2021-03-20 11:05:30', '2021-05-11 13:36:21'),
(263, 'service_phone', 'Telephone', 'system', 'text', '0823189999', '', '', '', 1, 'zh_cn', '2021-03-20 11:05:30', '2021-06-08 00:17:36'),
(264, 'service_phone', 'Telephone', 'system', 'text', '0823188888', '', '', '', 1, 'vi', '2021-03-20 11:05:30', '2021-06-08 00:18:26'),
(265, 'service_phone', 'Telephone', 'system', 'text', '0823187777', '', '', '', 1, 'th', '2021-03-20 11:05:30', '2021-06-08 00:18:26'),
(266, 'service_phone', 'Telephone', 'system', 'text', '0823186666', '', '', '', 1, 'en', '2021-03-20 11:05:30', '2021-06-08 00:18:26'),
(267, 'service_skype', 'Skype', 'admin', 'text', 'live:atbgaming', '', '', '', 1, 'common', '2021-03-26 10:02:33', '2021-06-27 15:45:32'),
(268, 'service_telegram', 'Telegram', 'admin', 'text', 'atbgaming', '', '', '', 1, 'common', '2021-03-26 10:02:53', '2021-06-27 15:45:32'),
(269, 'service_line_pic', 'service_line_pic', 'line', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202106/08/config_1623108793_oT08wKhUp3.png', '', '', '', 1, 'zh_cn', '2021-03-26 10:21:08', '2023-07-30 07:53:35'),
(270, 'service_line_pic', 'service_line_pic', 'line', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202104/22/config_1619091211_24y5JeUW7U.png', '', '', '', 1, 'vi', '2021-03-26 10:21:23', '2023-07-30 07:53:35'),
(271, 'service_line_pic', 'service_line_pic', 'line', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202104/22/config_1619091226_fbJZAglj0T.png', '', '', '', 1, 'th', '2021-03-26 10:21:42', '2023-07-30 07:53:35'),
(272, 'service_line_pic', 'service_line_pic', 'line', 'picture', 'https://demo01act.yiboapi.com/storage/uploads/config/202104/22/config_1619091239_3HFNIxY3JF.png', '', '', '', 1, 'en', '2021-03-26 10:21:57', '2023-07-30 07:53:35'),
(273, 'is_backend_google_auth', 'Whether to enable Google verification code for background login', 'register', 'boolean', '0', '', '', '', 1, 'common', '2021-03-27 13:42:52', '2023-07-01 09:02:25'),
(275, 'service_logo_link', 'LOGO', 'admin', 'text', 'http://www.atbgmaing.com', '', '', '', 1, 'common', '2021-04-30 05:24:14', '2021-06-27 15:45:32'),
(276, 'vip1_lang_default', 'Front-end default language', 'language', 'text', 'zh_cn', '', '', '', 1, 'common', '2021-05-09 07:13:02', '2022-03-16 00:15:52'),
(279, 'service_phone2', 'Telephone', 'system', 'text', '电话CN2', '', '', '', 1, 'zh_cn', '2021-06-18 10:58:32', '2021-06-18 10:58:32'),
(280, 'service_phone2', 'Telephone', 'system', 'text', '电话VI2', '', '', '', 1, 'vi', '2021-06-18 10:58:43', '2021-06-18 10:58:43'),
(281, 'service_phone2', 'Telephone', 'system', 'text', '电话TH2', '', '', '', 1, 'th', '2021-06-18 10:58:53', '2021-06-18 10:58:53'),
(282, 'service_phone2', 'Telephone', 'system', 'text', '电话EN2', '', '', '', 1, 'en', '2021-06-18 10:59:06', '2021-06-18 10:59:06'),
(287, 'service_link', 'Customer Service Link', 'service', 'text', 'http://www.baidu.com/zh_cn', '', '', '', 1, 'zh_hk', '2021-07-05 04:55:27', '2021-07-05 04:55:27');

-- --------------------------------------------------------

--
-- Table structure for table `trade`
--

CREATE TABLE `trade` (
  `id` int(11) NOT NULL,
  `tradeID` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `market_price` decimal(10,2) DEFAULT NULL,
  `trade_amount` decimal(10,2) DEFAULT NULL,
  `selected_duration` int(11) DEFAULT NULL COMMENT 'Seconds',
  `selected_percentage` int(11) DEFAULT NULL COMMENT '% Percetage',
  `percentage_result` decimal(10,2) DEFAULT NULL,
  `close_price` decimal(10,2) DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `selectedCurrency` varchar(255) DEFAULT NULL,
  `fee` int(11) DEFAULT 0,
  `start_datetime` timestamp NULL DEFAULT NULL,
  `end_datetime` timestamp NULL DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL COMMENT 'WIN/LOSS',
  `closingPNL` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 0 COMMENT '0=Ruining\r\n1=Complete',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `request_datetime` timestamp NULL DEFAULT current_timestamp(),
  `unique_md5` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trade`
--

INSERT INTO `trade` (`id`, `tradeID`, `user_id`, `market_price`, `trade_amount`, `selected_duration`, `selected_percentage`, `percentage_result`, `close_price`, `action_type`, `selectedCurrency`, `fee`, `start_datetime`, `end_datetime`, `action`, `closingPNL`, `status`, `created_at`, `updated_at`, `request_datetime`, `unique_md5`) VALUES
(1, 'TID000001', 5, 86712.52, 100.00, 60, 50, 10.00, 86688.94, 'LONG', 'BTC', 0, '2025-02-27 23:19:52', '2025-02-27 23:20:52', 'LOSS', '-100.00', 1, '2025-02-27 23:19:52', '2025-02-28 14:42:33', '2025-02-27 23:19:52', 'e244e1f1e0967a65ba64eb73e66b71b7'),
(2, 'TID000002', 5, 84436.00, 150.00, 120, 75, 20.00, 26688.94, 'SHORT', 'BTC', 0, '2025-02-27 23:25:52', '2025-02-27 23:27:52', 'WIN', '262.5', 1, '2025-02-27 23:25:52', '2025-02-28 14:35:34', '2025-02-27 23:25:52', '27169078817e34ac467609fbcf489f13'),
(3, 'TID000003', 5, 84603.78, 100.00, 300, 100, 30.00, 86688.00, 'LONG', 'BTC', 0, '2025-02-27 23:29:23', '2025-02-27 23:34:23', 'WIN', '200', 1, '2025-02-27 23:29:23', '2025-02-28 14:58:43', '2025-02-27 23:29:23', '0e5deeea38a2c124fedd866287d04b1e'),
(4, 'TID000004', 5, 84782.42, 100.00, 30, 25, 40.00, 26688.94, 'LONG', 'BTC', 0, '2025-02-28 00:01:59', '2025-02-28 00:02:29', 'LOSS', '-100.00', 1, '2025-02-28 00:01:59', '2025-02-28 14:58:07', '2025-02-28 00:01:59', 'd64979186b1b1c461c19eb79fc404621');

-- --------------------------------------------------------

--
-- Table structure for table `trading_category`
--

CREATE TABLE `trading_category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `banner_images` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trading_category`
--

INSERT INTO `trading_category` (`id`, `name`, `slug`, `thumnail_img`, `banner_images`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Crypto', 'crypto', '/backend/files/yoKAPslcqTiQkMkiBRyk.png', '/backend/files/gskUbw8F5jmzDshrYqwB.png', 1, '2024-07-25 16:40:29', '2024-07-25 20:50:11'),
(2, 'Currencies', 'currencies', '/backend/files/d4EXYljnzD8ORAInwHoe.png', '/backend/files/C629dEQal4JPMlUBHUYX.png', 1, '2024-07-25 16:40:29', '2024-07-25 22:13:26'),
(3, 'Stocks', 'stocks', '/backend/files/fDiGtIAi0hJVCoVcqDJN.png', '/backend/files/zMMuNgFwTwV9rP6ULBSA.png', 1, '2024-07-25 16:40:29', '2024-07-25 22:13:22'),
(4, 'Commodities', 'commodities', '/backend/files/9brQBFRK7okGdbJW0P0q.png', '/backend/files/r4AQrbj2WuBAkpmrSu5u.png', 1, '2024-07-25 16:40:29', '2024-07-25 22:13:18');

-- --------------------------------------------------------

--
-- Table structure for table `trading_duration`
--

CREATE TABLE `trading_duration` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL COMMENT '%',
  `hours` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trading_duration`
--

INSERT INTO `trading_duration` (`id`, `name`, `percentage`, `hours`, `status`, `created_at`, `updated_at`) VALUES
(1, '1D', 5, 24, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49'),
(2, '3D', 7, 72, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49'),
(3, '7D', 10, 168, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49'),
(4, '15D', 15, 360, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49'),
(5, '30D', 20, 720, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49'),
(6, '45D', 25, 1080, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49'),
(7, '60D', 30, 1440, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49'),
(8, '90D', 35, 2160, 1, '2024-07-26 15:30:49', '2024-07-26 15:30:49');

-- --------------------------------------------------------

--
-- Table structure for table `trading_subcategory`
--

CREATE TABLE `trading_subcategory` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `trading_amunt` text DEFAULT NULL COMMENT 'need to daily update',
  `min_trade` int(11) DEFAULT NULL,
  `selected_graph` varchar(255) DEFAULT NULL COMMENT ' 	1=Crypto,2=Currencies,3=Stocks,4=Commodities 	',
  `trading_fee` int(11) DEFAULT NULL COMMENT '%',
  `status` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trading_subcategory`
--

INSERT INTO `trading_subcategory` (`id`, `category_id`, `name`, `slug`, `thumnail_img`, `trading_amunt`, `min_trade`, `selected_graph`, `trading_fee`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'BTC', 'btc-1', '/backend/files/enSgCCBZbGoMlNiq2C7p.png', '1000000000000', 20, '1', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:24:20'),
(2, 1, 'ETH', 'eth-1', '/backend/files/Cic9k79Sf7ppCjWA0Jy4.png', '1000000000000', 20, '1', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:24:07'),
(4, 1, 'SOL', 'sql-1', '/backend/files/agMG5prdanWkXot3gUng.png', '1000000000000', 20, '1', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:23:54'),
(5, 1, 'XRP', 'xrp-1', '/backend/files/Zjfissb682nCBmPofYft.png', '1000000000000', 20, '1', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:23:28'),
(6, 2, 'BTC', 'btc-2', '/backend/files/i8ujz0IL3jBwZkG3kf2Y.png', '1000000000000', 20, '2', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:23:17'),
(7, 2, 'ETH', 'eth-2', '/backend/files/mmpcM0CEcPQvdkNU1L9V.png', '1000000000000', 20, '2', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:23:02'),
(9, 2, 'SOL', 'sql-2', '/backend/files/JNcRYeJ5pThs9KW1vkUw.png', '1000000000000', 20, '2', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:21:33'),
(10, 2, 'XRP', 'xrp-2', '/backend/files/hFEYzC1r2zzVb4OG4h48.png', '1000000000000', 20, '2', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:21:11'),
(11, 3, 'BTC', 'btc-3', '/backend/files/GODJNzzx40MFaMSqxa86.png', '1000000000000', 20, '3', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:21:00'),
(12, 3, 'ETH', 'eth-3', '/backend/files/pWVFLE6mSbZlXxMuCCvu.png', '1000000000000', 20, '3', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:20:46'),
(14, 3, 'SOL', 'sol-3', '/backend/files/ZN7ZUNHUPvGFywdujjSy.png', '1000000000000', 20, '3', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:20:31'),
(15, 3, 'XRP', 'xrp-3', '/backend/files/GU1FmCRG8AH1JcFI5D6U.png', '1000000000000', 20, '3', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:20:17'),
(16, 4, 'BTC', 'btc-4', '/backend/files/TCWZujXkCpH7SovKkFLq.png', '1000000000000', 20, '4', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:14:34'),
(17, 4, 'ETH', 'eth-4', '/backend/files/DpIzDXpDx0hCrchjZkm9.png', '1000000000000', 20, '4', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:14:19'),
(19, 4, 'SOL', 'sol-4', '/backend/files/OlqYf7qhVa7X1N0w1TAD.png', '1000000000000', 20, '4', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:14:04'),
(20, 4, 'XRP', 'xrp-4', '/backend/files/l753f8m3yKGoAELNx5dA.png', '1000000000000', 20, '4', 5, 1, '2024-07-25 16:51:19', '2024-07-26 15:13:45');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_history`
--

CREATE TABLE `transaction_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1=deposit,2=withdraw,3=machine purchase,4=Send/Receive',
  `last_Id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_history`
--

INSERT INTO `transaction_history` (`id`, `user_id`, `type`, `last_Id`, `description`, `amount`, `created_at`, `updated_at`) VALUES
(1, 8, 1, 7, 'Deposit', '22', '2024-07-13 18:32:34', '2024-07-13 18:32:34'),
(2, 8, 1, 8, 'Deposit', '23', '2024-07-13 18:34:02', '2024-07-13 18:34:02'),
(3, 8, 1, 9, 'Deposit', '26', '2024-07-13 22:42:24', '2024-07-13 22:42:24'),
(4, 8, 1, 1, 'Deposit', '24', '2024-07-13 22:52:20', '2024-07-13 22:52:20'),
(5, 8, 1, 2, 'Deposit', '151', '2024-07-13 22:52:44', '2024-07-13 22:52:44'),
(6, 8, 1, 3, 'Deposit', '801', '2024-07-13 22:52:55', '2024-07-13 22:52:55'),
(7, 8, 1, 4, 'Deposit', '901', '2024-07-13 22:53:09', '2024-07-13 22:53:09'),
(8, 8, 1, 5, 'Deposit', '23', '2024-07-13 22:53:34', '2024-07-13 22:53:34'),
(9, 8, 1, 6, 'Deposit', '21', '2024-07-14 05:58:58', '2024-07-14 05:58:58'),
(10, 8, 2, 1, 'Withdraw', '22', '2024-07-14 14:35:43', '2024-07-14 14:35:43'),
(11, 8, 2, 1, 'Withdraw', '22', '2024-07-14 14:37:46', '2024-07-14 14:37:46'),
(12, 8, 2, 2, 'Withdraw', '22', '2024-07-14 14:39:17', '2024-07-14 14:39:17'),
(13, 8, 2, 3, 'Withdraw', '18', '2024-07-14 14:39:51', '2024-07-14 14:39:51'),
(14, 8, 2, 4, 'Withdraw', '10', '2024-07-14 14:42:26', '2024-07-14 14:42:26'),
(15, 8, 2, 5, 'Withdraw', '15', '2024-07-14 14:45:04', '2024-07-14 14:45:04'),
(16, 8, 2, 6, 'Withdraw', '22', '2024-07-14 14:48:20', '2024-07-14 14:48:20'),
(17, 8, 2, 7, 'Withdraw', '22', '2024-07-14 14:49:17', '2024-07-14 14:49:17'),
(18, 8, 2, 8, 'Withdraw', '22', '2024-07-14 14:50:10', '2024-07-14 14:50:10'),
(19, 8, 2, 9, 'Withdraw', '22', '2024-07-14 14:50:25', '2024-07-14 14:50:25'),
(20, 8, 2, 10, 'Withdraw', '22', '2024-07-14 14:50:53', '2024-07-14 14:50:53'),
(21, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 60', NULL, '2024-07-14 21:52:04', '2024-07-14 21:52:04'),
(22, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 60', '18', '2024-07-14 22:14:38', '2024-07-14 22:14:38'),
(23, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 60', '18', '2024-07-14 22:15:51', '2024-07-14 22:15:51'),
(24, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-14 22:24:39', '2024-07-14 22:24:39'),
(25, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-14 22:26:53', '2024-07-14 22:26:53'),
(26, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-14 22:27:28', '2024-07-14 22:27:28'),
(27, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-14 22:29:33', '2024-07-14 22:29:33'),
(28, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-14 22:33:07', '2024-07-14 22:33:07'),
(29, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-14 22:55:10', '2024-07-14 22:55:10'),
(30, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-14 23:09:07', '2024-07-14 23:09:07'),
(31, 8, 1, 7, 'Deposit', '501', '2024-07-15 12:02:33', '2024-07-15 12:02:33'),
(32, 8, 3, 2, 'Mining Machine : [Shark Driller], Duration : 30', '10', '2024-07-15 12:34:30', '2024-07-15 12:34:30'),
(33, 8, 3, 3, 'Mining Machine : [Orca Drillmaster], Duration : 30', '10', '2024-07-15 12:34:44', '2024-07-15 12:34:44'),
(34, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-15 12:40:45', '2024-07-15 12:40:45'),
(35, 8, 3, 2, 'Mining Machine : [Shark Driller], Duration : 30', '10', '2024-07-15 12:41:16', '2024-07-15 12:41:16'),
(36, 8, 3, 3, 'Mining Machine : [Orca Drillmaster], Duration : 120', '32', '2024-07-15 13:33:44', '2024-07-15 13:33:44'),
(37, 8, 3, 4, 'Mining Machine : [Whale Excavator], Duration : 30', '10', '2024-07-15 13:34:25', '2024-07-15 13:34:25'),
(38, 8, 3, 5, 'Mining Machine : [Whale Excavator], Duration : 90', '25', '2024-07-15 14:36:21', '2024-07-15 14:36:21'),
(39, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-15 16:01:02', '2024-07-15 16:01:02'),
(40, 8, 3, 2, 'Mining Machine : [Shark Driller], Duration : 30', '10', '2024-07-15 16:15:50', '2024-07-15 16:15:50'),
(41, 8, 3, 3, 'Mining Machine : [Orca Drillmaster], Duration : 30', '10', '2024-07-15 20:20:57', '2024-07-15 20:20:57'),
(42, 8, 3, 4, 'Mining Machine : [Whale Excavator], Duration : 120', '32', '2024-07-15 20:25:14', '2024-07-15 20:25:14'),
(43, 8, 3, 5, 'Mining Machine : [Whale Excavator], Duration : 60', '18', '2024-07-15 20:33:26', '2024-07-15 20:33:26'),
(44, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-15 20:36:48', '2024-07-15 20:36:48'),
(45, 8, 3, 2, 'Mining Machine : [Orca Drillmaster], Duration : 120', '32', '2024-07-15 20:36:59', '2024-07-15 20:36:59'),
(46, 8, 3, 3, 'Mining Machine : [Shark Driller], Duration : 30', '10', '2024-07-15 20:43:00', '2024-07-15 20:43:00'),
(47, 8, 3, 4, 'Mining Machine : [Whale Excavator], Duration : 60', '18', '2024-07-15 20:43:11', '2024-07-15 20:43:11'),
(48, 8, 3, 1, 'Mining Machine : [Shark Driller], Duration : 60', '18', '2024-07-15 20:48:41', '2024-07-15 20:48:41'),
(49, 8, 3, 2, 'Mining Machine : [Dolphin Digger], Duration : 120', '32', '2024-07-15 20:49:09', '2024-07-15 20:49:09'),
(50, 8, 3, 1, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-15 20:53:58', '2024-07-15 20:53:58'),
(51, 8, 3, 2, 'Mining Machine : [Whale Excavator], Duration : 30', '10', '2024-07-15 20:54:07', '2024-07-15 20:54:07'),
(52, 8, 3, 3, 'Mining Machine : [Orca Drillmaster], Duration : 120', '32', '2024-07-15 21:00:01', '2024-07-15 21:00:01'),
(53, 9, 1, 8, 'Deposit', '10001', '2024-07-15 22:18:09', '2024-07-15 22:18:09'),
(54, 9, 3, 4, 'Mining Machine : [Dolphin Digger], Duration : 30', '10', '2024-07-15 22:18:34', '2024-07-15 22:18:34'),
(55, 8, 3, 5, 'Mining Machine : [Shark Driller], Duration : 30', '10', '2024-07-16 11:52:28', '2024-07-16 11:52:28'),
(56, 17, 3, 6, 'Mining Machine : [Shark Driller], Duration : 30', '10', '2024-07-16 11:53:50', '2024-07-16 11:53:50'),
(57, 17, 3, 7, 'Mining Machine : [Whale Excavator], Duration : 120', '32', '2024-07-16 11:54:39', '2024-07-16 11:54:39'),
(58, 17, 3, 8, 'Mining Machine : [Whale Excavator], Duration : 120', '32', '2024-07-16 11:57:38', '2024-07-16 11:57:38'),
(59, 17, 3, 9, 'Mining Machine : [Orca Drillmaster], Duration : 30', '10', '2024-07-16 11:59:54', '2024-07-16 11:59:54'),
(60, 17, 3, 10, 'Mining Machine : [Orca Drillmaster], Duration : 30', '10', '2024-07-16 12:00:49', '2024-07-16 12:00:49'),
(61, 17, 1, 9, 'Deposit', '501', '2024-07-16 17:44:37', '2024-07-16 17:44:37'),
(62, 17, 3, 11, 'Mining Machine : [Whale Excavator], Duration : 30', '10', '2024-07-17 17:04:34', '2024-07-17 17:04:34'),
(63, 9, 3, 12, 'Mining Machine : [Orca Drillmaster], Duration : 30', '10', '2024-07-17 20:02:02', '2024-07-17 20:02:02'),
(64, 9, 3, 13, 'Mining Machine : [Whale Excavator], Duration : 120', '32', '2024-07-17 20:53:47', '2024-07-17 20:53:47'),
(65, 9, 3, 14, 'Mining Machine : [Shark Driller], Duration : 30', '10', '2024-07-17 23:19:29', '2024-07-17 23:19:29'),
(66, 9, 1, 10, 'Deposit', '20001', '2024-07-31 10:14:50', '2024-07-31 10:14:50'),
(67, 9, 1, 11, 'Deposit', '20001', '2024-07-31 10:14:51', '2024-07-31 10:14:51'),
(68, 9, 1, 12, 'Deposit', '20001', '2024-07-31 10:14:51', '2024-07-31 10:14:51'),
(69, 9, 1, 13, 'Deposit', '1000', '2024-07-31 10:19:02', '2024-07-31 10:19:02'),
(70, 9, 1, 14, 'Deposit', '200', '2024-08-02 11:57:31', '2024-08-02 11:57:31'),
(71, 9, 2, 1, 'Withdraw', '500', '2024-08-03 04:34:06', '2024-08-03 04:34:06'),
(72, 6, 1, 15, 'Deposit', NULL, '2025-01-13 13:21:55', '2025-01-13 13:21:55'),
(73, 6, 1, 16, 'Deposit', NULL, '2025-01-13 15:10:59', '2025-01-13 15:10:59'),
(74, 6, 1, 17, 'Deposit', NULL, '2025-01-13 15:13:14', '2025-01-13 15:13:14'),
(75, 6, 1, 18, 'Deposit', NULL, '2025-01-13 15:13:45', '2025-01-13 15:13:45'),
(76, 6, 1, 19, 'Deposit', NULL, '2025-01-13 15:18:58', '2025-01-13 15:18:58'),
(77, 6, 1, 20, 'Deposit', NULL, '2025-01-13 15:29:27', '2025-01-13 15:29:27'),
(78, 6, 1, 21, 'Deposit', NULL, '2025-01-13 15:40:25', '2025-01-13 15:40:25'),
(79, 6, 1, 22, 'Deposit', NULL, '2025-01-13 15:40:48', '2025-01-13 15:40:48'),
(80, 6, 1, 23, 'Deposit', NULL, '2025-01-13 15:41:02', '2025-01-13 15:41:02'),
(81, 6, 1, 24, 'Deposit', NULL, '2025-01-13 15:41:52', '2025-01-13 15:41:52'),
(82, 6, 1, 25, 'Deposit', NULL, '2025-01-13 15:43:36', '2025-01-13 15:43:36'),
(83, 6, 1, 26, 'Deposit', NULL, '2025-01-13 15:43:41', '2025-01-13 15:43:41'),
(84, 6, 1, 27, 'Deposit', NULL, '2025-01-13 15:43:48', '2025-01-13 15:43:48'),
(85, 6, 1, 28, 'Deposit', NULL, '2025-01-13 16:10:29', '2025-01-13 16:10:29'),
(86, 6, 1, 29, 'Deposit', NULL, '2025-01-13 16:11:13', '2025-01-13 16:11:13'),
(87, 6, 1, 30, 'Deposit', NULL, '2025-01-13 16:11:32', '2025-01-13 16:11:32'),
(88, 6, 1, 31, 'Deposit', NULL, '2025-01-13 16:13:22', '2025-01-13 16:13:22'),
(89, 6, 1, 32, 'Deposit', NULL, '2025-01-13 16:13:45', '2025-01-13 16:13:45'),
(90, 6, 1, 33, 'Deposit', NULL, '2025-01-13 16:14:28', '2025-01-13 16:14:28'),
(91, 6, 1, 34, 'Deposit', NULL, '2025-01-13 16:16:46', '2025-01-13 16:16:46'),
(92, 6, 1, 35, 'Deposit', NULL, '2025-01-13 16:18:51', '2025-01-13 16:18:51'),
(93, 6, 1, 36, 'Deposit', NULL, '2025-01-13 16:21:43', '2025-01-13 16:21:43'),
(94, 6, 1, 37, 'Deposit', NULL, '2025-01-13 16:23:05', '2025-01-13 16:23:05'),
(95, 6, 1, 38, 'Deposit', NULL, '2025-01-13 16:27:05', '2025-01-13 16:27:05'),
(96, 6, 1, 39, 'Deposit', NULL, '2025-01-13 16:27:33', '2025-01-13 16:27:33'),
(97, 6, 1, 40, 'Deposit', NULL, '2025-01-13 16:28:25', '2025-01-13 16:28:25'),
(98, 6, 1, 41, 'Deposit', NULL, '2025-01-13 16:53:08', '2025-01-13 16:53:08'),
(99, 6, 1, 42, 'Deposit', NULL, '2025-01-13 17:05:37', '2025-01-13 17:05:37'),
(100, 6, 1, 43, 'Deposit', NULL, '2025-01-13 17:09:11', '2025-01-13 17:09:11'),
(101, 6, 1, 44, 'Deposit', NULL, '2025-01-13 17:53:19', '2025-01-13 17:53:19'),
(102, 6, 1, 45, 'Deposit', NULL, '2025-01-13 17:53:48', '2025-01-13 17:53:48'),
(103, 6, 1, 46, 'Deposit', NULL, '2025-01-13 17:54:25', '2025-01-13 17:54:25'),
(104, 6, 1, 47, 'Deposit', NULL, '2025-01-13 17:56:40', '2025-01-13 17:56:40'),
(105, 6, 1, 1, 'Deposit', NULL, '2025-01-13 17:57:38', '2025-01-13 17:57:38'),
(106, 6, 1, 2, 'Deposit', NULL, '2025-01-13 17:58:28', '2025-01-13 17:58:28'),
(107, 6, 1, 3, 'Deposit', NULL, '2025-01-13 18:28:14', '2025-01-13 18:28:14'),
(108, 6, 1, 4, 'Deposit', NULL, '2025-01-13 18:30:50', '2025-01-13 18:30:50'),
(109, 6, 1, 5, 'Deposit', NULL, '2025-01-14 10:28:22', '2025-01-14 10:28:22'),
(110, 6, 1, 6, 'Deposit', NULL, '2025-01-14 14:40:44', '2025-01-14 14:40:44'),
(111, 6, 1, 7, 'Deposit', NULL, '2025-01-15 14:16:54', '2025-01-15 14:16:54'),
(112, 6, 1, 8, 'Deposit', NULL, '2025-01-15 14:22:25', '2025-01-15 14:22:25'),
(113, 6, 1, 9, 'Deposit', NULL, '2025-01-15 15:24:50', '2025-01-15 15:24:50'),
(114, 6, 1, 10, 'Deposit', NULL, '2025-01-15 15:33:57', '2025-01-15 15:33:57'),
(115, 6, 1, 1, 'Deposit', NULL, '2025-01-15 15:37:51', '2025-01-15 15:37:51'),
(116, 6, 1, 1, 'Deposit', NULL, '2025-01-15 15:57:02', '2025-01-15 15:57:02'),
(117, 6, 1, 2, 'Deposit', NULL, '2025-01-15 18:11:35', '2025-01-15 18:11:35'),
(118, 6, 1, 3, 'Deposit', NULL, '2025-01-15 19:02:08', '2025-01-15 19:02:08'),
(119, 6, 1, 4, 'Deposit', NULL, '2025-01-15 19:03:34', '2025-01-15 19:03:34'),
(120, 6, 1, 5, 'Deposit', NULL, '2025-01-15 20:06:31', '2025-01-15 20:06:31'),
(121, 6, 1, 6, 'Deposit', NULL, '2025-01-15 20:07:16', '2025-01-15 20:07:16'),
(122, 6, 1, 1, 'Deposit', NULL, '2025-01-15 20:12:58', '2025-01-15 20:12:58'),
(123, 6, 1, 2, 'Deposit', NULL, '2025-01-15 20:15:17', '2025-01-15 20:15:17'),
(124, 6, 1, 3, 'Deposit', NULL, '2025-01-15 20:24:16', '2025-01-15 20:24:16'),
(125, 6, 1, 1, 'Deposit', NULL, '2025-01-15 20:41:49', '2025-01-15 20:41:49'),
(126, 6, 1, 2, 'Deposit', NULL, '2025-01-15 20:50:26', '2025-01-15 20:50:26'),
(127, 6, 1, 3, 'Deposit', NULL, '2025-01-15 22:29:21', '2025-01-15 22:29:21'),
(128, 6, 1, 4, 'Deposit', NULL, '2025-01-15 22:31:02', '2025-01-15 22:31:02'),
(129, 6, 1, 5, 'Deposit', NULL, '2025-01-16 19:22:20', '2025-01-16 19:22:20'),
(130, 6, 1, 6, 'Deposit', NULL, '2025-01-16 19:26:27', '2025-01-16 19:26:27'),
(131, 6, 1, 7, 'Deposit', NULL, '2025-01-16 19:27:59', '2025-01-16 19:27:59'),
(132, 6, 1, 8, 'Deposit', NULL, '2025-01-16 19:28:43', '2025-01-16 19:28:43'),
(133, 6, 1, 9, 'Deposit', NULL, '2025-01-16 19:29:51', '2025-01-16 19:29:51'),
(134, 6, 1, 10, 'Deposit', NULL, '2025-01-16 19:32:03', '2025-01-16 19:32:03'),
(135, 6, 1, 11, 'Deposit', NULL, '2025-01-16 19:33:21', '2025-01-16 19:33:21'),
(136, 6, 1, 12, 'Deposit', NULL, '2025-01-16 19:34:40', '2025-01-16 19:34:40'),
(137, 6, 1, 13, 'Deposit', NULL, '2025-01-16 19:50:00', '2025-01-16 19:50:00'),
(138, 6, 1, 14, 'Deposit', NULL, '2025-01-16 19:52:38', '2025-01-16 19:52:38'),
(139, 6, 1, 15, 'Deposit', NULL, '2025-01-16 19:55:07', '2025-01-16 19:55:07'),
(140, 6, 1, 16, 'Deposit', NULL, '2025-01-16 19:56:03', '2025-01-16 19:56:03'),
(141, 6, 1, 17, 'Deposit', NULL, '2025-01-16 20:31:33', '2025-01-16 20:31:33'),
(142, 6, 1, 18, 'Deposit', NULL, '2025-01-16 20:48:47', '2025-01-16 20:48:47'),
(143, 6, 1, 19, 'Deposit', NULL, '2025-01-16 20:49:59', '2025-01-16 20:49:59'),
(144, 6, 1, 20, 'Deposit', NULL, '2025-01-16 20:53:00', '2025-01-16 20:53:00'),
(145, 6, 1, 21, 'Deposit', NULL, '2025-01-16 20:53:57', '2025-01-16 20:53:57'),
(146, 6, 1, 22, 'Deposit', NULL, '2025-01-16 20:57:44', '2025-01-16 20:57:44'),
(147, 6, 1, 1, 'Deposit', NULL, '2025-01-16 21:00:15', '2025-01-16 21:00:15'),
(148, 6, 1, 2, 'Deposit', NULL, '2025-01-16 21:01:10', '2025-01-16 21:01:10'),
(149, 6, 1, 3, 'Deposit', NULL, '2025-01-16 21:02:18', '2025-01-16 21:02:18'),
(150, 6, 1, 4, 'Deposit', NULL, '2025-01-16 21:03:40', '2025-01-16 21:03:40'),
(151, 6, 1, 5, 'Deposit', NULL, '2025-01-16 21:09:11', '2025-01-16 21:09:11'),
(152, 6, 1, 6, 'Deposit', NULL, '2025-01-16 21:10:08', '2025-01-16 21:10:08'),
(153, 6, 1, 7, 'Deposit', NULL, '2025-01-16 21:11:39', '2025-01-16 21:11:39'),
(154, 6, 1, 8, 'Deposit', NULL, '2025-01-16 21:13:19', '2025-01-16 21:13:19'),
(155, 6, 1, 9, 'Deposit', NULL, '2025-01-16 21:22:57', '2025-01-16 21:22:57'),
(156, 6, 1, 10, 'Deposit', NULL, '2025-01-16 21:25:14', '2025-01-16 21:25:14'),
(157, 6, 1, 11, 'Deposit', NULL, '2025-01-16 21:28:08', '2025-01-16 21:28:08'),
(158, 6, 1, 12, 'Deposit', NULL, '2025-01-16 21:29:50', '2025-01-16 21:29:50'),
(159, 6, 1, 13, 'Deposit', NULL, '2025-01-16 21:32:34', '2025-01-16 21:32:34'),
(160, 6, 1, 14, 'Deposit', NULL, '2025-01-16 21:34:46', '2025-01-16 21:34:46'),
(161, 6, 1, 15, 'Deposit', NULL, '2025-01-16 21:36:34', '2025-01-16 21:36:34'),
(162, 6, 1, 16, 'Deposit', NULL, '2025-01-16 21:48:00', '2025-01-16 21:48:00'),
(163, 6, 1, 17, 'Deposit', NULL, '2025-01-16 21:53:57', '2025-01-16 21:53:57'),
(164, 6, 1, 1, 'Deposit', NULL, '2025-01-16 21:57:34', '2025-01-16 21:57:34'),
(165, 6, 1, 2, 'Deposit', NULL, '2025-01-16 22:06:16', '2025-01-16 22:06:16'),
(166, 6, 1, 3, 'Deposit', NULL, '2025-01-16 22:09:21', '2025-01-16 22:09:21'),
(167, 6, 1, 4, 'Deposit', NULL, '2025-01-16 22:23:38', '2025-01-16 22:23:38'),
(168, 6, 1, 5, 'Deposit', NULL, '2025-01-16 22:27:06', '2025-01-16 22:27:06'),
(169, 6, 1, 6, 'Deposit', NULL, '2025-01-16 22:38:55', '2025-01-16 22:38:55'),
(170, 6, 1, 7, 'Deposit', NULL, '2025-01-16 22:49:43', '2025-01-16 22:49:43'),
(171, 6, 1, 8, 'Deposit', NULL, '2025-01-16 22:53:07', '2025-01-16 22:53:07'),
(172, 6, 1, 9, 'Deposit', NULL, '2025-01-16 22:56:31', '2025-01-16 22:56:31'),
(173, 6, 1, 10, 'Deposit', NULL, '2025-01-22 04:50:23', '2025-01-22 04:50:23'),
(174, 6, 1, 11, 'Deposit', NULL, '2025-01-27 16:14:34', '2025-01-27 16:14:34'),
(175, 6, 1, 12, 'Deposit', NULL, '2025-01-29 15:54:51', '2025-01-29 15:54:51'),
(176, 6, 1, 13, 'Deposit', NULL, '2025-01-29 17:27:38', '2025-01-29 17:27:38'),
(177, 6, 1, 14, 'Deposit', NULL, '2025-02-03 18:34:20', '2025-02-03 18:34:20'),
(178, 51, 1, 15, 'Deposit', NULL, '2025-02-04 17:01:17', '2025-02-04 17:01:17'),
(179, 51, 1, 16, 'Deposit', NULL, '2025-02-04 17:05:28', '2025-02-04 17:05:28'),
(180, 51, 1, 17, 'Deposit', NULL, '2025-02-04 20:36:51', '2025-02-04 20:36:51'),
(181, 51, 1, 18, 'Deposit', NULL, '2025-02-05 01:41:50', '2025-02-05 01:41:50'),
(182, 51, 1, 19, 'Deposit', NULL, '2025-02-05 02:44:25', '2025-02-05 02:44:25'),
(183, 51, 1, 20, 'Deposit', NULL, '2025-02-05 02:45:42', '2025-02-05 02:45:42'),
(184, 51, 1, 2, 'withdrawa', NULL, '2025-02-07 17:25:11', '2025-02-07 17:25:11'),
(185, 51, 1, 3, 'withdrawa', '10', '2025-02-07 18:01:08', '2025-02-07 18:01:08'),
(186, 51, 1, 4, 'withdrawa', '1', '2025-02-07 18:20:36', '2025-02-07 18:20:36'),
(187, 5, 1, 21, 'Deposit', NULL, '2025-02-24 05:36:01', '2025-02-24 05:36:01'),
(188, 5, 1, 22, 'Deposit', NULL, '2025-02-24 05:37:07', '2025-02-24 05:37:07');

-- --------------------------------------------------------

--
-- Table structure for table `transfer`
--

CREATE TABLE `transfer` (
  `id` int(11) NOT NULL,
  `previous_user_id` int(11) DEFAULT NULL,
  `transer_user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `language_code` varchar(10) NOT NULL,
  `translation_key` varchar(255) NOT NULL,
  `translated_value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `language_code`, `translation_key`, `translated_value`, `created_at`, `updated_at`) VALUES
(4, 'en', 'level_deposit', 'Deposit', '2024-10-27 09:26:42', '2024-11-02 13:04:22'),
(5, 'en', 'level_sign_in', 'Sign in', '2024-10-27 09:26:42', '2024-10-27 09:43:43'),
(6, 'en', 'level_sign_up', 'Sign up', '2024-10-27 09:26:42', '2024-10-27 09:42:47'),
(7, 'en', 'lvl_left_sidebar_video', 'Video', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(8, 'en', 'lvl_left_sidebar_model', 'Model', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(9, 'en', 'lvl_left_sidebar_star', 'Star', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(10, 'en', 'lvl_left_sidebar_games', 'Games', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(11, 'en', 'lvl_left_sidebar_profile', 'Profile', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(12, 'en', 'lvl_left_live_game', 'Slots', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(13, 'en', 'lvl_left_game_1', 'Spribe', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(14, 'en', 'lvl_left_electro_game', 'Multiplayer Interactive', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(15, 'en', 'lvl_left_sports_game', 'Sports', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(16, 'en', 'lvl_left_chess_game', 'Chess', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(17, 'en', 'lvl_left_esports', 'E-sports', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(18, 'en', 'lvl_left_uprofile', 'User Profile', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(19, 'en', 'lvl_left_wallet', 'Wallet', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(20, 'en', 'lvl_left_withdraw', 'Withdraw', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(21, 'en', 'lvl_left_bethistory', 'Bet History', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(22, 'en', 'lvl_left_transaction', 'Transaction', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(23, 'en', 'lvl_index_casino', 'Aviator', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(24, 'en', 'lvl_index_sports', 'JILI', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(25, 'en', 'lvl_index_lottery', 'PP MAX', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(26, 'en', 'lvl_index_racing', 'Racing', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(27, 'en', 'lvl_index_updown', 'Mini Games', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(28, 'en', 'lvl_index_bingo', 'Bingo', '2024-10-27 09:26:42', '2024-10-27 09:42:49'),
(32, 'bn', 'level_deposit', 'ডিপোজিট', '2024-10-27 09:26:42', '2024-10-27 09:42:57'),
(33, 'bn', 'level_sign_in', 'সাইন ইন', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(34, 'bn', 'level_sign_up', 'সাইন আপ', '2024-10-27 09:26:42', '2024-10-27 09:43:15'),
(35, 'bn', 'lvl_left_sidebar_video', 'ভিডিও', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(36, 'bn', 'lvl_left_sidebar_model', 'মডেল', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(37, 'bn', 'lvl_left_sidebar_star', 'ষ্টার', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(38, 'bn', 'lvl_left_sidebar_games', 'গেমস', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(39, 'bn', 'lvl_left_sidebar_profile', 'প্রোফাইল', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(40, 'bn', 'lvl_left_live_game', 'লাইভ', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(41, 'bn', 'lvl_left_fishing_game', 'ফিশিং', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(42, 'bn', 'lvl_left_electro_game', 'ইলেকট্রনিক', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(43, 'bn', 'lvl_left_sports_game', 'স্পোর্টস', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(44, 'bn', 'lvl_left_chess_game', 'চেস', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(45, 'bn', 'lvl_left_esports', 'ই-স্পোর্টস', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(46, 'bn', 'lvl_left_uprofile', 'ইউজার প্রোফাইল', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(47, 'bn', 'lvl_left_wallet', 'ওয়ালেট', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(48, 'bn', 'lvl_left_deposit', 'ডিপোজিট', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(49, 'bn', 'lvl_left_withdraw', 'উইথড্র', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(50, 'bn', 'lvl_left_bethistory', 'বেট হিস্ট্রি', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(51, 'bn', 'lvl_left_transaction', 'লেনদেন', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(52, 'bn', 'lvl_index_casino', 'ক্যাসিনো', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(53, 'bn', 'lvl_index_sports', 'খেলাধুলা', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(54, 'bn', 'lvl_index_lottery', 'লটারি', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(55, 'bn', 'lvl_index_racing', 'দৌড়', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(56, 'bn', 'lvl_index_updown', 'আপডন', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(57, 'bn', 'lvl_index_bingo', 'বিঙ্গো', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(108, 'zh', 'level_deposit', '订金', '2024-10-27 11:10:41', '2024-10-27 11:11:21'),
(109, 'zh', 'level_sign_in', '登入', '2024-10-27 11:10:41', '2024-10-27 11:11:35'),
(110, 'zh', 'level_sign_up', '报名', '2024-10-27 11:10:41', '2024-10-27 11:11:42'),
(133, 'en', 'lvl_sing_up_name', 'Name', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(134, 'en', 'lvl_sing_up_email', 'Email', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(135, 'en', 'lvl_sing_up_username', 'Username', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(136, 'en', 'lvl_sing_up_password', 'Password', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(137, 'en', 'lvl_sing_up_repassword', 'Retype Password', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(138, 'en', 'lvl_ref_code_op', 'Referal code (Optional)', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(139, 'en', 'lvl_alreadyhaveaccount', 'Already have an account?', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(161, 'bn', 'lvl_sing_up_name', 'নাম', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(162, 'bn', 'lvl_sing_up_email', 'ইমেইল', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(163, 'bn', 'lvl_sing_up_username', 'ইউজার নেম', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(164, 'bn', 'lvl_sing_up_password', 'পাসওয়ার্ড', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(165, 'bn', 'lvl_sing_up_repassword', 'পাসওয়ার্ড পুনরায় টাইপ করুন', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(166, 'bn', 'lvl_ref_code_op', 'রেফারেল কোড (অপশনাল)', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(167, 'bn', 'lvl_alreadyhaveaccount', 'অলরেডি হ্যাভ এবং একাউন্ট?', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(168, 'en', 'lvl_forget_pass', 'Forget Password?', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(169, 'bn', 'lvl_forget_pass', 'ফরগেট পাসওয়ার্ড?', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(170, 'en', 'lvl_new_here', 'New here?', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(171, 'bn', 'lvl_new_here', 'এখানে', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(172, 'en', 'lvl_footer_fg_game', 'Casinos online have not always been around, but we can safely say that online casinos have been used a lot since they came on the market. And it\'s not in short demand nor options, and now in 2023, we have 1000s and 1000s to pick from – it\'s just a matter of what you like and what payment options you would like to see at the casino.\r\n\r\nPlayers are always looking for something new, which will help make the gaming experience so much better and more accessible. Allowing the player to focus on the absolute fun of a casino, that\'s right, the games themselves.', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(173, 'bn', 'lvl_footer_fg_game', 'অনলাইন ক্যাসিনো সবসময় আশেপাশে থাকে না, তবে আমরা নিরাপদে বলতে পারি যে অনলাইন ক্যাসিনো বাজারে আসার পর থেকে অনেক বেশি ব্যবহার করা হয়েছে। এবং এটি স্বল্প চাহিদা বা বিকল্পগুলির মধ্যে নয়, এবং এখন 2023 সালে, আমাদের কাছে 1000 এবং 1000গুলি থেকে বাছাই করার জন্য রয়েছে - এটি কেবলমাত্র আপনি কী পছন্দ করেন এবং ক্যাসিনোতে আপনি কী অর্থপ্রদানের বিকল্পগুলি দেখতে চান তার বিষয়।\r\n\r\nখেলোয়াড়রা সর্বদা নতুন কিছু খুঁজছেন, যা গেমিং অভিজ্ঞতাকে আরও ভাল এবং আরও অ্যাক্সেসযোগ্য করতে সাহায্য করবে। প্লেয়ারকে একটি ক্যাসিনোর নিখুঁত মজার উপর ফোকাস করার অনুমতি দেওয়া, এটি ঠিক, গেমগুলি নিজেই।', '2024-10-28 06:30:50', '2024-10-28 06:30:50'),
(174, 'en', 'lvl_left_game_2', 'PG', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(175, 'en', 'lvl_left_game_3', 'JILI', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(176, 'en', 'lvl_left_game_4', 'PP MAX', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(177, 'en', 'lvl_left_game_5', 'OMG MINI', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(178, 'en', 'lvl_left_game_6', 'Mini Game', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(179, 'en', 'lvl_left_game_7', 'OMG CRYPTO', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(180, 'en', 'lvl_left_game_8', 'Hacksaw', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(181, 'en', 'lvl_left_game_9', 'PP', '2024-10-27 09:26:42', '2024-10-27 09:26:42'),
(182, 'en', 'lvl_left_game_all', 'All Games', '2024-10-27 09:26:42', '2024-10-27 09:26:42');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fg_id` varchar(255) DEFAULT NULL,
  `fg_wallet_address` varchar(255) DEFAULT NULL,
  `inviteCode` varchar(255) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL COMMENT '1=Super admin,2=Player,3=Admin',
  `email` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `phone_number` varchar(225) DEFAULT NULL,
  `available_balance` double(10,8) DEFAULT NULL,
  `mining_amount` varchar(255) DEFAULT NULL,
  `level_commission` int(11) DEFAULT NULL,
  `show_password` varchar(225) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `real_name` varchar(255) DEFAULT NULL,
  `image` varchar(225) DEFAULT NULL,
  `doc_file` varchar(255) DEFAULT NULL,
  `address` varchar(225) DEFAULT NULL,
  `address_1` varchar(255) DEFAULT NULL,
  `address_2` varchar(255) DEFAULT NULL,
  `website` varchar(225) DEFAULT NULL,
  `github` varchar(225) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `twitter` varchar(225) DEFAULT NULL,
  `instagram` varchar(225) DEFAULT NULL,
  `nationality_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `register_bonus` int(11) DEFAULT NULL,
  `otp` int(11) DEFAULT NULL,
  `facebook` varchar(225) DEFAULT NULL,
  `wallet_balance` decimal(10,2) DEFAULT NULL,
  `old_pin` varchar(255) DEFAULT '000000',
  `new_pin` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `telegram` varchar(255) DEFAULT NULL,
  `whtsapp` varchar(255) DEFAULT NULL,
  `withdrwal_wallet_address` varchar(255) DEFAULT NULL,
  `othersway_connect` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `entry_by` int(11) DEFAULT NULL,
  `register_ip` varchar(255) DEFAULT NULL,
  `lastlogin_ip` varchar(255) DEFAULT NULL,
  `lastlogin_country` varchar(255) DEFAULT NULL,
  `lastlogin_datetime` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `logged_out` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fg_id`, `fg_wallet_address`, `inviteCode`, `ref_id`, `employee_id`, `role_id`, `email`, `username`, `phone_number`, `available_balance`, `mining_amount`, `level_commission`, `show_password`, `password`, `name`, `real_name`, `image`, `doc_file`, `address`, `address_1`, `address_2`, `website`, `github`, `gender`, `date_of_birth`, `twitter`, `instagram`, `nationality_id`, `state_id`, `register_bonus`, `otp`, `facebook`, `wallet_balance`, `old_pin`, `new_pin`, `email_verified_at`, `telegram`, `whtsapp`, `withdrwal_wallet_address`, `othersway_connect`, `remember_token`, `entry_by`, `register_ip`, `lastlogin_ip`, `lastlogin_country`, `lastlogin_datetime`, `created_at`, `updated_at`, `status`, `logged_out`) VALUES
(1, NULL, '6f21357fs863ce24ce21c1a82f49a7d5d13', '0000123', 0, 4, 1, 'dev1@mail.com', NULL, NULL, 1.00000000, NULL, 1, 'dev1@mail.com', '$2a$12$O.hHt1uQsC5ANQ6yhiIkMu7p9XPmbjzvVn5UIdq5NNHjE2wIbVQJq', 'Mamun', NULL, '/backend/files/hZkagctUSINKsFU64UJr.png', NULL, 'Dhaka', '', '', 'http://localhost:3000/profile', 'http://localhost:3000/profile', '', '1982-01-30', 'http://localhost:3000/profile', 'http://localhost:3000/profile', 0, 0, 0, NULL, 'http://localhost:3000/profile', NULL, '000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '127.0.0.1', NULL, '2025-02-28 17:29:22', '2023-06-22 03:20:43', '2025-02-28 11:29:22', 1, NULL),
(2, 'FG000000002', 'be036e59dd06bfa6d13d36110d3d96a3', '9234087', 0, NULL, 2, 'mrmamun@gmail.com', 'mamun', NULL, 5.00000000, NULL, NULL, 'Password', '$2y$10$VQOKQNqr6/WAhN004ea0Nu.N/j4Tgy2TQL8rzAeEGhm.LBeoUzW5a', 'Mamun', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 07:13:54', '2025-02-24 18:47:37', 1, NULL),
(3, 'FG000000003', '52f02f16c2f22a233e76a84fe87f73f4', '2843662', 0, NULL, 2, 'mrmamunahmed@gmail.com', 'mamunahmed', NULL, 5.00000000, NULL, NULL, 'Password', '$2y$10$L53y8kGnH7XRqY5Bgr6LaOuhWKtxcZfbzIlLFqoevJVynD9LOipfm', 'Mamun', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 07:14:44', '2024-10-17 07:14:44', 1, NULL),
(4, 'FG000000004', '0294d090cc9b186adac2d2f0bd8ced42', '4941998', 0, NULL, 2, 'kabirahmed@gmail.com', 'kabirahmed', NULL, 5.00000000, NULL, NULL, 'kabirahmed', '$2y$10$lmzA0KbNyMantkLl55QsWO1VzooI7rpLZXTozHrOatTLhSn3wSZ/i', 'Kabir', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 07:18:14', '2024-10-17 07:18:14', 1, NULL),
(5, 'TRADE000000005', '36382ada933618db3adf513951503d6d', '9116288', 4, NULL, 2, 'jannat123456@gmail.com', 'jannat123456', '01915728987', 5.00000000, NULL, NULL, 'jannat123456', '$2y$10$DaPhaog7jYkeFTTuTRvu1uYL7zgPogZ.D6Al4Ary86EDCdmIPXeO2', 'jannat123456', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2025-02-23 18:38:31', '2025-02-25 10:27:51', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_bot_history`
--

CREATE TABLE `user_bot_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mining_category_id` int(11) DEFAULT NULL,
  `boost_setting_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `level_cost` int(11) DEFAULT NULL,
  `hours` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_bot_history`
--

INSERT INTO `user_bot_history` (`id`, `user_id`, `mining_category_id`, `boost_setting_id`, `name`, `level_cost`, `hours`, `created_at`, `updated_at`) VALUES
(1, 9, 1, 1, 'Level-1', 0, 1, '2024-07-18 14:21:42', '2024-07-18 14:21:42'),
(2, 9, 1, 2, 'Level-2', 1, 12, '2024-07-18 14:21:57', '2024-07-18 14:21:57'),
(3, 9, 1, 3, 'Level-3', 2, 24, '2024-07-18 14:22:16', '2024-07-18 14:22:16'),
(4, 9, 1, 4, 'Level-4', 10, 2880, '2024-07-18 14:22:29', '2024-07-18 14:22:29'),
(5, 9, 2, 5, 'Level-1', 0, 2, '2024-07-18 14:26:42', '2024-07-18 14:26:42'),
(6, 9, 2, 6, 'Level-2', 2, 12, '2024-07-18 14:26:45', '2024-07-18 14:26:45'),
(7, 9, 3, 9, 'Level-1', 0, 4, '2024-07-18 14:27:41', '2024-07-18 14:27:41'),
(8, 9, 4, 13, 'Level-1', 0, 6, '2024-07-18 14:28:27', '2024-07-18 14:28:27'),
(9, 9, 4, 14, 'Level-2', 12, 12, '2024-07-18 14:28:29', '2024-07-18 14:28:29'),
(10, 9, 4, 15, 'Level-3', 25, 24, '2024-07-18 14:28:30', '2024-07-18 14:28:30'),
(11, 9, 4, 16, 'Level-4', 30, 2880, '2024-07-18 14:28:32', '2024-07-18 14:28:32');

-- --------------------------------------------------------

--
-- Table structure for table `user_mining_history`
--

CREATE TABLE `user_mining_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mining_category_id` int(11) DEFAULT NULL,
  `boost_mining_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `level_cost` int(11) DEFAULT NULL,
  `mining_per_seconds` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_mining_history`
--

INSERT INTO `user_mining_history` (`id`, `user_id`, `mining_category_id`, `boost_mining_id`, `name`, `level_cost`, `mining_per_seconds`, `created_at`, `updated_at`) VALUES
(1, 9, 1, 1, 'Level-1', 0, 1, '2024-07-18 17:56:14', '2024-07-18 17:56:14'),
(2, 9, 1, 2, 'Level-2', 2, 2, '2024-07-18 17:56:26', '2024-07-18 17:56:26'),
(3, 9, 1, 3, 'Level-3', 3, 3, '2024-07-18 18:07:33', '2024-07-18 18:07:33'),
(4, 9, 1, 4, 'Level-4', 4, 4, '2024-07-18 18:07:48', '2024-07-18 18:07:48'),
(5, 8, 2, 11, 'Level-1', 0, 2, '2024-07-18 18:13:36', '2024-07-18 18:13:36'),
(6, 8, 2, 12, 'Level-2', 2, 4, '2024-07-18 18:13:38', '2024-07-18 18:13:38'),
(7, 8, 2, 13, 'Level-3', 3, 6, '2024-07-18 18:14:01', '2024-07-18 18:14:01'),
(8, 8, 2, 14, 'Level-4', 4, 8, '2024-07-18 18:14:56', '2024-07-18 18:14:56'),
(9, 8, 1, 1, 'Level-1', 0, 1, '2024-07-18 18:15:55', '2024-07-18 18:15:55'),
(10, 8, 1, 2, 'Level-2', 2, 2, '2024-07-18 18:16:08', '2024-07-18 18:16:08'),
(11, 8, 3, 21, 'Level-1', 0, 4, '2024-07-18 18:17:42', '2024-07-18 18:17:42'),
(12, 8, 3, 22, 'Level-2', 2, 8, '2024-07-18 18:17:44', '2024-07-18 18:17:44'),
(13, 8, 3, 23, 'Level-3', 3, 12, '2024-07-18 18:17:45', '2024-07-18 18:17:45'),
(14, 8, 3, 24, 'Level-4', 4, 16, '2024-07-18 18:17:46', '2024-07-18 18:17:46'),
(15, 8, 3, 25, 'Level-5', 5, 20, '2024-07-18 18:17:47', '2024-07-18 18:17:47'),
(16, 8, 3, 26, 'Level-6', 6, 24, '2024-07-18 18:17:49', '2024-07-18 18:17:49'),
(17, 8, 4, 31, 'Level-1', 0, 6, '2024-07-18 18:19:38', '2024-07-18 18:19:38'),
(18, 8, 4, 32, 'Level-2', 2, 12, '2024-07-18 18:19:39', '2024-07-18 18:19:39'),
(19, 8, 4, 33, 'Level-3', 3, 18, '2024-07-18 18:19:40', '2024-07-18 18:19:40'),
(20, 8, 4, 34, 'Level-4', 4, 24, '2024-07-18 18:19:42', '2024-07-18 18:19:42'),
(21, 8, 4, 35, 'Level-5', 5, 30, '2024-07-18 18:19:43', '2024-07-18 18:19:43'),
(22, 8, 4, 36, 'Level-6', 6, 36, '2024-07-18 18:19:45', '2024-07-18 18:19:45'),
(23, 8, 4, 37, 'Level-7', 7, 42, '2024-07-18 18:19:46', '2024-07-18 18:19:46'),
(24, 8, 4, 38, 'Level-8', 8, 48, '2024-07-18 18:19:48', '2024-07-18 18:19:48'),
(25, 8, 4, 39, 'Level-9', 9, 54, '2024-07-18 18:19:50', '2024-07-18 18:19:50'),
(26, 8, 4, 40, 'Level-10', 10, 60, '2024-07-18 18:19:51', '2024-07-18 18:19:51'),
(27, 9, 2, 11, 'Level-1', 0, 2, '2024-07-18 18:22:12', '2024-07-18 18:22:12'),
(28, 9, 2, 12, 'Level-2', 2, 4, '2024-07-18 18:22:14', '2024-07-18 18:22:14'),
(29, 9, 2, 13, 'Level-3', 3, 6, '2024-07-18 18:22:15', '2024-07-18 18:22:15'),
(30, 9, 2, 14, 'Level-4', 4, 8, '2024-07-18 18:22:17', '2024-07-18 18:22:17'),
(31, 9, 2, 15, 'Level-5', 5, 10, '2024-07-18 18:22:18', '2024-07-18 18:22:18');

-- --------------------------------------------------------

--
-- Table structure for table `user_mining_log`
--

CREATE TABLE `user_mining_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mining_cat_id` int(11) DEFAULT NULL,
  `ocn_balance` varchar(255) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_mining_log`
--

INSERT INTO `user_mining_log` (`id`, `user_id`, `mining_cat_id`, `ocn_balance`, `created_at`, `updated_at`) VALUES
(1, 9, 1, '716', '2024-07-17 23:18:52', '2024-08-03 05:21:35'),
(2, 9, 2, NULL, '2024-07-17 23:18:54', '2024-08-03 05:21:36'),
(4, 9, 4, '1377', '2024-07-17 23:18:55', '2024-08-03 05:21:40'),
(13, 9, 3, NULL, '2024-07-21 04:40:40', '2024-08-03 05:21:40'),
(14, 8, 1, NULL, '2024-08-01 14:42:11', '2024-08-01 14:42:11'),
(15, 8, 2, NULL, '2024-08-01 14:42:14', '2024-08-01 14:42:14'),
(16, 8, 3, NULL, '2024-08-01 14:42:15', '2024-08-01 14:42:15'),
(17, 8, 4, NULL, '2024-08-01 14:42:15', '2024-08-01 14:42:15');

-- --------------------------------------------------------

--
-- Table structure for table `user_wallet_address`
--

CREATE TABLE `user_wallet_address` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `global_user_wall_add_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `delete_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_wallet_address`
--

INSERT INTO `user_wallet_address` (`id`, `user_id`, `global_user_wall_add_id`, `name`, `status`, `created_at`, `updated_at`, `delete_time`) VALUES
(5, 9, 1, 'TJ1GEtjoXfy8kRmJvQ44ekEj8DeAVKMDqo', 1, '2024-07-15 22:18:01', '2024-07-15 22:18:01', '2024-07-15 22:48:01'),
(6, 17, 2, 'TKpRQQeykiNPuTjy5vw8do1QK3G64U6VxR', 1, '2024-07-16 17:44:30', '2024-07-16 17:44:30', '2024-07-16 18:14:30');

-- --------------------------------------------------------

--
-- Table structure for table `verifyemail`
--

CREATE TABLE `verifyemail` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1=active,0=inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `verifyemail`
--

INSERT INTO `verifyemail` (`id`, `email`, `code`, `status`, `created_at`, `updated_at`) VALUES
(1, 'mdbijon@gmail.com', '7251', 0, '2024-07-10 15:05:57', '2024-07-10 15:05:57'),
(2, 'mdbijon1@gmail.com', '9868', 0, '2024-07-10 15:14:12', '2024-07-10 15:14:12'),
(3, 'mdbijon11@gmail.com', '6674', 0, '2024-07-10 15:14:54', '2024-07-10 15:14:54'),
(4, 'mdbijon1q1@gmail.com', '2004', 0, '2024-07-10 15:16:20', '2024-07-10 15:16:20'),
(5, 'mdbijon1qq1@gmail.com', '3999', 0, '2024-07-10 15:20:49', '2024-07-10 15:20:49'),
(6, 'mdbijon1qeq1@gmail.com', '8809', 0, '2024-07-10 15:24:36', '2024-07-10 15:24:36'),
(7, 'mdbijon1qeq221@gmail.com', '8683', 0, '2024-07-10 15:31:43', '2024-07-10 15:31:43'),
(8, 'mdbijon11131@gmail.com', '7725', 0, '2024-07-10 16:05:34', '2024-07-10 16:05:34'),
(9, 'mdbijon311131@gmail.com', '5044', 0, '2024-07-10 16:07:59', '2024-07-10 16:07:59'),
(10, 'mdbijo1n311131@gmail.com', '1044', 0, '2024-07-10 16:11:14', '2024-07-10 16:11:14'),
(11, 'kamal@gmail.com', '7228', 0, '2024-07-10 16:14:11', '2024-07-10 16:14:11'),
(12, 'rana@gmail.com', '8771', 0, '2024-07-10 16:18:30', '2024-07-10 16:18:30'),
(13, 'rana233@gmail.com', '6958', 0, '2024-07-10 16:19:43', '2024-07-10 16:19:43'),
(14, 'mdbijon123@gmail.com', '2406', 0, '2024-07-10 16:20:35', '2024-07-10 16:20:35'),
(15, 'gazigiashuddin@gmail.com', '7742', 0, '2024-07-10 16:22:13', '2024-07-10 16:22:13'),
(16, 'jannat@gmail.com', '8951', 1, '2024-07-11 12:44:25', '2024-07-11 12:44:25'),
(17, 'ibraheem@gmail.com', '5445', 0, '2024-07-11 13:42:14', '2024-07-11 13:42:14'),
(18, 'ibraheem1@gmail.com', '8566', 0, '2024-07-11 19:26:23', '2024-07-11 19:26:23'),
(19, 'ibraheem2@gmail.com', '4731', 0, '2024-07-11 19:27:25', '2024-07-11 19:27:25'),
(20, 'ibraheem3@gmail.com', '3245', 0, '2024-07-11 19:28:19', '2024-07-11 19:28:19'),
(21, 'ayesha1@gmail.com', '1719', 0, '2024-07-11 19:30:44', '2024-07-11 19:30:44'),
(22, 'ayesha2@gmail.com', '3859', 0, '2024-07-11 19:31:16', '2024-07-11 19:31:16'),
(23, 'sharmin1@gmail.com', '9260', 0, '2024-07-11 19:34:20', '2024-07-11 19:34:20'),
(24, 'sharmin2@gmail.com', '5895', 0, '2024-07-11 19:35:06', '2024-07-11 19:35:06'),
(25, 'sharmin3@gmail.com', '2254', 0, '2024-07-11 19:35:59', '2024-07-11 19:35:59'),
(26, 'gazi1@gmail.com', '5841', 0, '2024-07-11 19:37:33', '2024-07-11 19:37:33'),
(27, 'gazi2@gmail.com', '4783', 0, '2024-07-11 19:38:24', '2024-07-11 19:38:24'),
(28, 'kamal1@gmail.com', '3423', 0, '2024-07-11 19:53:16', '2024-07-11 19:53:16'),
(29, 'kamal2@gmail.com', '2941', 0, '2024-07-11 19:55:01', '2024-07-11 19:55:01'),
(30, 'harun1@gmail.com', '4939', 0, '2024-07-11 20:00:35', '2024-07-11 20:00:35'),
(31, 'lokman@gmail.com', '1040', 0, '2024-07-11 20:08:56', '2024-07-11 20:08:56');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw`
--

CREATE TABLE `withdraw` (
  `id` int(11) NOT NULL,
  `withdrawID` varchar(255) DEFAULT NULL,
  `depscription` text DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `withdrawal_amount` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `receivable_amount` int(11) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `gaming_pltform_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `orderId` varchar(255) DEFAULT NULL,
  `withdrawal_pin` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `transection_fee` int(11) NOT NULL COMMENT '%',
  `payable_amount` double(10,2) DEFAULT NULL COMMENT 'After 5% deduction amount',
  `status` int(11) DEFAULT NULL COMMENT ' 	0=Review,2=Reject,1=Approved 	',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdraw`
--

INSERT INTO `withdraw` (`id`, `withdrawID`, `depscription`, `payment_method`, `withdrawal_amount`, `user_id`, `receivable_amount`, `wallet_address`, `gaming_pltform_id`, `currency_id`, `orderId`, `withdrawal_pin`, `remarks`, `approved_by`, `transection_fee`, `payable_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 'W:c92383002f757cddd52df84e68894b5e', 'W:c92383002f757cddd52df84e68894b5e', 'TRC20', '23', 5, NULL, 'AY9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sMY', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, '2025-02-24 09:59:41', '2025-02-24 09:59:41'),
(2, 'W:c831e9b5f6c9bab6b23c26c2dab2a29c', 'W:c831e9b5f6c9bab6b23c26c2dab2a29c', 'TRC20', '230', 5, NULL, 'AY9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sMY', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, '2025-02-24 10:00:14', '2025-02-24 10:00:14'),
(3, 'W:4dea382d82666332fb564f2e711cbc71', 'W:4dea382d82666332fb564f2e711cbc71', 'TRC20', '20', 5, NULL, 'TIWh7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sT1', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2, '2025-02-24 10:00:51', '2025-02-24 17:58:02'),
(4, 'W:c4c42505a03f2e969b4c0a97ee9b34e7', 'W:c4c42505a03f2e969b4c0a97ee9b34e7', 'TRC20', '35', 5, NULL, 'TIWh7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sT1', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2, '2025-02-24 10:08:08', '2025-02-24 18:03:18'),
(5, 'W:5fcc629edc0cfa360016263112fe8058', 'W:5fcc629edc0cfa360016263112fe8058', 'TRC20', '10', 5, NULL, 'PO9h7s4aQ2hX4N8b4C1Jv2L3pW4ZmR7sT1', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, '2025-02-24 10:30:07', '2025-02-24 18:02:52');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawal_method`
--

CREATE TABLE `withdrawal_method` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `currency_type_id` int(11) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_country`
--
ALTER TABLE `add_country`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `currency_id` (`currency_id`),
  ADD UNIQUE KEY `country_id` (`country_id`);

--
-- Indexes for table `add_user_payment_address`
--
ALTER TABLE `add_user_payment_address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wallet_address` (`wallet_address`);

--
-- Indexes for table `api_configs`
--
ALTER TABLE `api_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_gamelist_transate`
--
ALTER TABLE `api_gamelist_transate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boost_boot_setting`
--
ALTER TABLE `boost_boot_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `boost_mining_setting`
--
ALTER TABLE `boost_mining_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `buy_token`
--
ALTER TABLE `buy_token`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categorys`
--
ALTER TABLE `categorys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `community`
--
ALTER TABLE `community`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countdown`
--
ALTER TABLE `countdown`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country_wise_bank`
--
ALTER TABLE `country_wise_bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `currency_type`
--
ALTER TABLE `currency_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_history`
--
ALTER TABLE `customer_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposit`
--
ALTER TABLE `deposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_history`
--
ALTER TABLE `expense_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gameplatform`
--
ALTER TABLE `gameplatform`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `game_platform`
--
ALTER TABLE `game_platform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `game_type`
--
ALTER TABLE `game_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `global_wallet_address`
--
ALTER TABLE `global_wallet_address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `kyc`
--
ALTER TABLE `kyc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `loan_pay_history`
--
ALTER TABLE `loan_pay_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_request`
--
ALTER TABLE `loan_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_return_request`
--
ALTER TABLE `loan_return_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_settings`
--
ALTER TABLE `loan_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `manual_adjustment`
--
ALTER TABLE `manual_adjustment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mininghistory`
--
ALTER TABLE `mininghistory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mining_categogy`
--
ALTER TABLE `mining_categogy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mining_categogy_duration`
--
ALTER TABLE `mining_categogy_duration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mining_process_history`
--
ALTER TABLE `mining_process_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mining_service_buy_history`
--
ALTER TABLE `mining_service_buy_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orderId` (`orderId`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
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
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_category`
--
ALTER TABLE `post_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produc_categories`
--
ALTER TABLE `produc_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produc_img_history`
--
ALTER TABLE `produc_img_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `request_games`
--
ALTER TABLE `request_games`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rewards_centers_settings`
--
ALTER TABLE `rewards_centers_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_center_request`
--
ALTER TABLE `reward_center_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rule`
--
ALTER TABLE `rule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seller_review`
--
ALTER TABLE `seller_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `star_gallary`
--
ALTER TABLE `star_gallary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `star_gallary_history`
--
ALTER TABLE `star_gallary_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `star_video_gallary`
--
ALTER TABLE `star_video_gallary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_configs`
--
ALTER TABLE `system_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `system_configs_name_unique` (`name`,`lang`),
  ADD KEY `system_configs_name_index` (`name`),
  ADD KEY `system_configs_is_open_index` (`is_open`),
  ADD KEY `system_configs_config_group_index` (`config_group`);

--
-- Indexes for table `trade`
--
ALTER TABLE `trade`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tradeID` (`tradeID`),
  ADD UNIQUE KEY `unique_md5` (`unique_md5`);

--
-- Indexes for table `trading_category`
--
ALTER TABLE `trading_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trading_duration`
--
ALTER TABLE `trading_duration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trading_subcategory`
--
ALTER TABLE `trading_subcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_history`
--
ALTER TABLE `transaction_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfer`
--
ALTER TABLE `transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `language_code` (`language_code`,`translation_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `fg_wallet_address` (`fg_wallet_address`),
  ADD UNIQUE KEY `fg_id` (`fg_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_bot_history`
--
ALTER TABLE `user_bot_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_mining_history`
--
ALTER TABLE `user_mining_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_mining_log`
--
ALTER TABLE `user_mining_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_wallet_address`
--
ALTER TABLE `user_wallet_address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `verifyemail`
--
ALTER TABLE `verifyemail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw`
--
ALTER TABLE `withdraw`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdrawal_method`
--
ALTER TABLE `withdrawal_method`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add_country`
--
ALTER TABLE `add_country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `add_user_payment_address`
--
ALTER TABLE `add_user_payment_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `api_configs`
--
ALTER TABLE `api_configs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `api_gamelist_transate`
--
ALTER TABLE `api_gamelist_transate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `boost_boot_setting`
--
ALTER TABLE `boost_boot_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `boost_mining_setting`
--
ALTER TABLE `boost_mining_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buy_token`
--
ALTER TABLE `buy_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categorys`
--
ALTER TABLE `categorys`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `community`
--
ALTER TABLE `community`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `countdown`
--
ALTER TABLE `countdown`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `country_wise_bank`
--
ALTER TABLE `country_wise_bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `currency_type`
--
ALTER TABLE `currency_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customer_history`
--
ALTER TABLE `customer_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposit`
--
ALTER TABLE `deposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `expense_history`
--
ALTER TABLE `expense_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `gameplatform`
--
ALTER TABLE `gameplatform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `game_platform`
--
ALTER TABLE `game_platform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `game_type`
--
ALTER TABLE `game_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `global_wallet_address`
--
ALTER TABLE `global_wallet_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `kyc`
--
ALTER TABLE `kyc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `loan_pay_history`
--
ALTER TABLE `loan_pay_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `loan_request`
--
ALTER TABLE `loan_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loan_return_request`
--
ALTER TABLE `loan_return_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `loan_settings`
--
ALTER TABLE `loan_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `manual_adjustment`
--
ALTER TABLE `manual_adjustment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mininghistory`
--
ALTER TABLE `mininghistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mining_categogy`
--
ALTER TABLE `mining_categogy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mining_categogy_duration`
--
ALTER TABLE `mining_categogy_duration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mining_process_history`
--
ALTER TABLE `mining_process_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `mining_service_buy_history`
--
ALTER TABLE `mining_service_buy_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_category`
--
ALTER TABLE `post_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produc_categories`
--
ALTER TABLE `produc_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produc_img_history`
--
ALTER TABLE `produc_img_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_games`
--
ALTER TABLE `request_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rewards_centers_settings`
--
ALTER TABLE `rewards_centers_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `reward_center_request`
--
ALTER TABLE `reward_center_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rule`
--
ALTER TABLE `rule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `seller_review`
--
ALTER TABLE `seller_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `star_gallary`
--
ALTER TABLE `star_gallary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `star_gallary_history`
--
ALTER TABLE `star_gallary_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `star_video_gallary`
--
ALTER TABLE `star_video_gallary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_configs`
--
ALTER TABLE `system_configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=288;

--
-- AUTO_INCREMENT for table `trade`
--
ALTER TABLE `trade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trading_category`
--
ALTER TABLE `trading_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trading_duration`
--
ALTER TABLE `trading_duration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `trading_subcategory`
--
ALTER TABLE `trading_subcategory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `transaction_history`
--
ALTER TABLE `transaction_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `transfer`
--
ALTER TABLE `transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_bot_history`
--
ALTER TABLE `user_bot_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_mining_history`
--
ALTER TABLE `user_mining_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `user_mining_log`
--
ALTER TABLE `user_mining_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user_wallet_address`
--
ALTER TABLE `user_wallet_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `verifyemail`
--
ALTER TABLE `verifyemail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `withdraw`
--
ALTER TABLE `withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `withdrawal_method`
--
ALTER TABLE `withdrawal_method`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
