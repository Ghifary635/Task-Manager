-- phpMyAdmin SQL Dump
-- Compatible version (MySQL 5.7+ / MariaDB / MySQL 8)
-- Database: task_manager

DROP DATABASE IF EXISTS task_manager;
CREATE DATABASE task_manager
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE task_manager;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

SET NAMES utf8mb4;

-- --------------------------------------------------------
-- Table: users
-- --------------------------------------------------------

CREATE TABLE users (
  id int NOT NULL AUTO_INCREMENT,
  username varchar(50) NOT NULL,
  full_name varchar(255) DEFAULT NULL,
  email varchar(100) NOT NULL,
  password_hash varchar(255) NOT NULL,
  profile_image text,
  xp int DEFAULT 0,
  created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table: todos
-- --------------------------------------------------------

CREATE TABLE todos (
  id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  title varchar(100) NOT NULL,
  description text,
  category varchar(50) DEFAULT 'General',
  priority varchar(20) DEFAULT 'MEDIUM',
  status varchar(20) DEFAULT 'PENDING',
  due_date datetime DEFAULT NULL,
  created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  xp_awarded tinyint(1) DEFAULT 0,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  CONSTRAINT todos_ibfk_1
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE CASCADE
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Data: users
-- --------------------------------------------------------

INSERT INTO users
(id, username, full_name, email, password_hash, profile_image, xp, created_at)
VALUES
(1, 'Winston Demo', NULL, 'demo@test.com',
 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', NULL, 50, '2026-01-07 10:20:13'),
(2, 'cecep', 'Fathur Demo', 'Fathur@gmail.com',
 '2dd3472cc7d7524a742f810ae1cc612835325895d9b55cd13266e911dff3dbc1', '', 40, '2026-01-07 11:28:14'),
(3, 'test123', NULL, 'test123@gmail.com',
 'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', NULL, 0, '2026-01-07 11:35:07'),
(4, 'akmaludin', 'AKMAL YAASIR', 'akmaludin@gmail.com',
 '087a2919d55418fa063d934dea70bfa0cde06051e8eaf9cd9c7496150327ad85', NULL, 140, '2026-01-07 11:50:27');

-- --------------------------------------------------------
-- Data: todos
-- --------------------------------------------------------

INSERT INTO todos
(id, user_id, title, description, category, priority, status,
 due_date, created_at, xp_awarded)
VALUES
(1, 1, 'Selesaikan Coding Java', 'Implementasi fitur Gamification', 'Kuliah',
 'HIGH', 'IN_PROGRESS', '2026-01-09 00:00:00', '2026-01-07 10:20:14', 0),
(2, 1, 'Beli Makanan Kucing', 'Jangan lupa beli merk Whiskas', 'Personal',
 'LOW', 'PENDING', '2026-01-12 00:00:00', '2026-01-07 10:20:14', 0),
(3, 1, 'Lari Pagi', 'Jogging keliling komplek', 'Health',
 'MEDIUM', 'COMPLETED', '2026-01-06 00:00:00', '2026-01-07 10:20:14', 0),
(4, 2, 'Test', 'test', 'Personal',
 'LOW', 'COMPLETED', '2026-01-07 03:02:00', '2026-01-07 11:33:23', 1),
(5, 4, 'TESTTEST1', 'MANTAPs', 'Personal',
 'MEDIUM', 'PENDING', '2026-01-07 00:00:00', '2026-01-07 12:35:43', 0),
(6, 4, 'MANTAP', '', 'Personal',
 'HIGH', 'IN_PROGRESS', '2026-01-24 00:00:00', '2026-01-07 12:44:05', 0);

COMMIT;