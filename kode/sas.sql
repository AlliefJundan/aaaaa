-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2024 at 05:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sas`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `kode_barang` varchar(11) NOT NULL,
  `nama_barang` varchar(70) NOT NULL,
  `merk` varchar(25) NOT NULL,
  `jenis` varchar(25) NOT NULL,
  `jumlah` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `kode_barang`, `nama_barang`, `merk`, `jenis`, `jumlah`) VALUES
(239, 'BG003', 'asd', 'asd', 'asd', 99),
(240, 'BG007', 'asd', 'asd', 'asd', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_peminjam` int(11) NOT NULL,
  `kode_brg` varchar(10) NOT NULL,
  `tgl_pinjam` datetime NOT NULL,
  `tgl_kembali` datetime NOT NULL,
  `jml_brg` int(11) NOT NULL,
  `keperluan` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL,
  `id_login` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_peminjam`, `kode_brg`, `tgl_pinjam`, `tgl_kembali`, `jml_brg`, `keperluan`, `status`, `id_login`) VALUES
(28, 1, 'BG001', '2024-05-27 09:46:11', '2024-05-27 10:02:10', 1, '1', 'Kembali', 1),
(29, 11, 'BG007', '2024-05-27 09:46:45', '2024-05-27 10:06:18', 11, '21', 'Kembali', 11),
(30, 123, 'BG007', '2024-05-27 09:52:14', '2024-05-27 09:52:25', 1, '1', 'Kembali', 123),
(31, 1, 'BG003', '2024-05-27 10:12:13', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(32, 1, 'BG003', '2024-05-27 10:12:39', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(33, 123, 'BG007', '2024-05-27 10:13:09', '0000-00-00 00:00:00', 1, 'lapar', 'Dipinjam', 123),
(34, 2232, 'BG003', '2024-05-27 10:13:24', '0000-00-00 00:00:00', 10, '1', 'Dipinjam', 2232),
(35, 234, 'BG007', '2024-05-27 10:13:40', '0000-00-00 00:00:00', 10, '1', 'Dipinjam', 234),
(36, 1, 'BG003', '2024-05-27 10:14:31', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(37, 1, 'BG007', '2024-05-27 10:14:43', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(38, 1, 'BG007', '2024-05-27 10:16:35', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(39, 1, 'BG007', '2024-05-27 10:16:51', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(40, 2, 'BG007', '2024-05-27 10:17:02', '0000-00-00 00:00:00', 2, '2', 'Dipinjam', 2),
(41, 1, 'BG007', '2024-05-27 10:19:21', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(42, 1, 'BG003', '2024-05-27 10:21:53', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(43, 1, 'BG007', '2024-05-27 10:22:04', '0000-00-00 00:00:00', 1, '1', 'Dipinjam', 1),
(44, 1, 'BG007', '2024-05-27 10:22:22', '0000-00-00 00:00:00', 10, '1', 'Dipinjam', 1),
(45, 10, 'BG003', '2024-05-27 10:22:44', '0000-00-00 00:00:00', 10, 'lapar', 'Dipinjam', 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(25) NOT NULL,
  `role` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama_user`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin', 'admin', 'admin'),
(2, 'user', 'user1', '123', 'user2');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
