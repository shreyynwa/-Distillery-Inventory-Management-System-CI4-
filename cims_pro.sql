-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2025 at 08:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cims_pro`
--

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `code`, `address`, `phone`, `email`, `manager_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Main Distillery Unit', 'MDU-01', 'Kathmandu, Nepal', NULL, NULL, NULL, 'active', '2025-12-06 16:51:34', '2025-12-06 16:51:34');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `parent_id`, `status`, `created_at`) VALUES
(1, 'Whiskey', 'Single Malts, Blends, Scotch, Bourbon', NULL, 'active', '2025-12-06 17:38:37'),
(2, 'Wine', 'Red, White, Rose, Sparkling', NULL, 'active', '2025-12-06 17:38:37'),
(3, 'Beer', 'Lager, Ale, Stout, Craft', NULL, 'active', '2025-12-06 17:38:37'),
(4, 'Cider', 'Apple, Pear, Fruit Ciders', NULL, 'active', '2025-12-06 17:38:37'),
(5, 'Vodka', 'Plain and Flavored', NULL, 'active', '2025-12-06 17:38:37'),
(6, 'Rum', 'White, Dark, Spiced', NULL, 'active', '2025-12-06 17:38:37'),
(7, 'Gin', 'London Dry, Plymouth, Old Tom', NULL, 'active', '2025-12-06 17:38:37'),
(8, 'Tequila', 'Blanco, Reposado, Añejo', NULL, 'active', '2025-12-06 17:38:37');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `customer_code` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `customer_type` enum('retail','wholesale','corporate') DEFAULT 'retail',
  `credit_limit` decimal(10,2) DEFAULT 0.00,
  `outstanding_balance` decimal(10,2) DEFAULT 0.00,
  `status` enum('active','inactive','blocked') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `lot_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `reserved_quantity` int(11) DEFAULT 0,
  `available_quantity` int(11) GENERATED ALWAYS AS (`quantity` - `reserved_quantity`) STORED,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `product_id`, `branch_id`, `lot_id`, `quantity`, `reserved_quantity`, `last_updated`) VALUES
(1, 1, 1, 1, 44, 0, '2025-12-07 05:35:27'),
(2, 2, 1, 2, 50, 5, '2025-12-06 17:49:34'),
(3, 3, 1, 3, 20, 0, '2025-12-06 17:49:34'),
(4, 4, 1, NULL, 500, 20, '2025-12-06 17:49:34'),
(5, 6, 1, 4, 90, 0, '2025-12-06 17:49:34');

-- --------------------------------------------------------

--
-- Table structure for table `lots`
--

CREATE TABLE `lots` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `lot_number` varchar(100) NOT NULL,
  `batch_number` varchar(100) DEFAULT NULL,
  `manufacture_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `initial_quantity` int(11) NOT NULL,
  `current_quantity` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `status` enum('active','expired','exhausted','recalled') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lots`
--

INSERT INTO `lots` (`id`, `product_id`, `lot_number`, `batch_number`, `manufacture_date`, `expiry_date`, `initial_quantity`, `current_quantity`, `branch_id`, `supplier_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'LOT-OLD-001', NULL, '2023-01-01', '2025-12-21', 100, 45, 1, 1, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(2, 2, 'LOT-YAR-888', NULL, '2024-01-01', '2030-01-01', 50, 50, 1, 1, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(3, 3, 'LOT-BEER-EXP', NULL, '2022-01-01', '2025-12-01', 200, 20, 1, 2, 'expired', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(4, 6, 'LOT-VOD-007', NULL, '2024-02-01', '2028-01-01', 100, 90, 1, 1, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34');

-- --------------------------------------------------------

--
-- Table structure for table `po_approval_history`
--

CREATE TABLE `po_approval_history` (
  `id` int(11) NOT NULL,
  `po_id` int(11) NOT NULL,
  `approver_id` int(11) NOT NULL,
  `approver_role` varchar(50) DEFAULT NULL,
  `approval_step` enum('branch_manager','head_procurement') DEFAULT NULL,
  `action` enum('approved','rejected','requested_changes') DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `po_items`
--

CREATE TABLE `po_items` (
  `id` int(11) NOT NULL,
  `po_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `tax_rate` decimal(5,2) DEFAULT 0.00,
  `line_total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `unit_price`) STORED,
  `received_quantity` int(11) DEFAULT 0,
  `pending_quantity` int(11) GENERATED ALWAYS AS (`quantity` - `received_quantity`) STORED,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `sku` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `unit` varchar(20) DEFAULT 'pcs',
  `purchase_price` decimal(10,2) DEFAULT 0.00,
  `selling_price` decimal(10,2) DEFAULT 0.00,
  `tax_rate` decimal(5,2) DEFAULT 0.00,
  `min_stock` int(11) DEFAULT 10,
  `max_stock` int(11) DEFAULT 1000,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `name`, `description`, `category_id`, `unit`, `purchase_price`, `selling_price`, `tax_rate`, `min_stock`, `max_stock`, `status`, `created_at`, `updated_at`) VALUES
(1, 'WHI-OLD-DUR', 'Old Durbar Black Chimney', NULL, 1, 'bottle', 2800.00, 3200.00, 0.00, 50, 1000, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(2, 'WHI-YAR-12', 'Yarchagumba Gold Reserve', NULL, 1, 'bottle', 8500.00, 10000.00, 0.00, 10, 1000, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(3, 'BEE-GOR-STR', 'Gorkha Strong Beer 650ml', NULL, 3, 'can', 310.00, 380.00, 0.00, 200, 1000, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(4, 'BEE-ARNA-LGT', 'Arna Light', NULL, 3, 'can', 290.00, 350.00, 0.00, 150, 1000, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(5, 'WIN-DIV-RED', 'Divine Red Wine', NULL, 2, 'bottle', 900.00, 1200.00, 0.00, 30, 1000, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34'),
(6, 'VOD-RUS-88', 'Ruslan Vodka', NULL, 5, 'bottle', 1400.00, 1800.00, 0.00, 60, 1000, 'active', '2025-12-06 17:49:34', '2025-12-06 17:49:34');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` int(11) NOT NULL,
  `po_number` varchar(50) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `expected_delivery` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `grand_total` decimal(10,2) DEFAULT 0.00,
  `created_by` int(11) NOT NULL,
  `branch_manager_approved` tinyint(1) DEFAULT 0,
  `branch_manager_id` int(11) DEFAULT NULL,
  `branch_manager_approved_at` timestamp NULL DEFAULT NULL,
  `branch_manager_notes` text DEFAULT NULL,
  `head_procurement_approved` tinyint(1) DEFAULT 0,
  `head_procurement_id` int(11) DEFAULT NULL,
  `head_procurement_approved_at` timestamp NULL DEFAULT NULL,
  `head_procurement_notes` text DEFAULT NULL,
  `status` enum('draft','pending_branch_manager','pending_head_procurement','approved','rejected','ordered','partially_received','fully_received','cancelled') DEFAULT 'draft',
  `is_urgent` tinyint(1) DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_name` varchar(200) DEFAULT NULL,
  `customer_phone` varchar(20) DEFAULT NULL,
  `sale_type` enum('walk_in','home_delivery','courier','store_pickup','wholesale','online','credit') DEFAULT 'walk_in',
  `sale_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_items` int(11) DEFAULT 0,
  `subtotal` decimal(10,2) DEFAULT 0.00,
  `discount` decimal(10,2) DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `grand_total` decimal(10,2) DEFAULT 0.00,
  `amount_paid` decimal(10,2) DEFAULT 0.00,
  `change_amount` decimal(10,2) DEFAULT 0.00,
  `payment_method` enum('cash','card','upi','credit') DEFAULT 'cash',
  `status` enum('pending','completed','cancelled','refunded') DEFAULT 'pending',
  `sold_by` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `invoice_number`, `branch_id`, `customer_id`, `customer_name`, `customer_phone`, `sale_type`, `sale_date`, `total_items`, `subtotal`, `discount`, `tax_amount`, `grand_total`, `amount_paid`, `change_amount`, `payment_method`, `status`, `sold_by`, `notes`, `created_at`) VALUES
(1, 'INV-20251207-1765085727', 1, NULL, NULL, NULL, 'walk_in', '2025-12-07 05:35:27', 0, 3200.00, 0.00, 416.00, 3616.00, 4000.00, 384.00, 'cash', 'completed', 2, NULL, '2025-12-06 23:50:27');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `lot_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) DEFAULT 0.00,
  `line_total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `unit_price` - `discount`) STORED,
  `cost_price` decimal(10,2) DEFAULT NULL,
  `profit` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `unit_price` - `discount` - `quantity` * `cost_price`) STORED,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `lot_id`, `quantity`, `unit_price`, `discount`, `cost_price`, `created_at`) VALUES
(1, 1, 1, 1, 1, 3200.00, 0.00, 2800.00, '2025-12-07 05:35:27');

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustments`
--

CREATE TABLE `stock_adjustments` (
  `id` int(11) NOT NULL,
  `adjustment_number` varchar(50) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `lot_id` int(11) DEFAULT NULL,
  `adjustment_type` enum('addition','subtraction','damage','expired','theft') NOT NULL,
  `quantity` int(11) NOT NULL,
  `reason` text DEFAULT NULL,
  `adjusted_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `status` enum('pending','approved','rejected','completed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_transfers`
--

CREATE TABLE `stock_transfers` (
  `id` int(11) NOT NULL,
  `transfer_number` varchar(50) NOT NULL,
  `from_branch_id` int(11) NOT NULL,
  `to_branch_id` int(11) NOT NULL,
  `requested_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `transfer_date` date NOT NULL,
  `expected_delivery` date DEFAULT NULL,
  `status` enum('requested','approved','processing','in_transit','received','cancelled','rejected') DEFAULT 'requested',
  `total_items` int(11) DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `tax_id` varchar(50) DEFAULT NULL,
  `payment_terms` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `code`, `name`, `contact_person`, `email`, `phone`, `address`, `tax_id`, `payment_terms`, `status`, `created_at`) VALUES
(1, 'SUP-001', 'Himalayan Malts Ltd', NULL, 'sales@himalayan.com', NULL, NULL, NULL, NULL, 'active', '2025-12-06 17:49:34'),
(2, 'SUP-002', 'Kathmandu Brewery', NULL, 'orders@ktmbrewery.com', NULL, NULL, NULL, NULL, 'active', '2025-12-06 17:49:34'),
(3, 'SUP-003', 'Global Wines Import', NULL, 'import@globalwines.com', NULL, NULL, NULL, NULL, 'active', '2025-12-06 17:49:34');

-- --------------------------------------------------------

--
-- Table structure for table `transfer_items`
--

CREATE TABLE `transfer_items` (
  `id` int(11) NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `lot_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `sent_quantity` int(11) DEFAULT 0,
  `received_quantity` int(11) DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Clerk','Branch Manager','Head of Procurement') NOT NULL,
  `designation` varchar(100) DEFAULT 'Staff Member',
  `branch_id` int(11) DEFAULT NULL,
  `status` enum('active','pending','inactive') DEFAULT 'pending',
  `profile_picture` varchar(255) DEFAULT 'default_avatar.png',
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `email`, `password`, `role`, `designation`, `branch_id`, `status`, `profile_picture`, `phone`, `address`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'head_proc', 'Amit (Head Procurement)', 'head@shreydistillery.com', '$2y$10$U4Mrsel.PMUlW5r2QkXIHuSV5fVLRZlTW7EGvUCl8NEXRmmZ0ou3q', 'Head of Procurement', 'Staff Member', 1, 'active', 'default_avatar.png', NULL, NULL, NULL, '2025-12-06 11:06:34', '2025-12-06 16:51:35'),
(2, 'manager_1', 'Bikash (Manager)', 'manager@shreydistillery.com', '$2y$10$42wod23/dFYuvpUOrct.OuXm956GFhqbGL6/kYzPBFpea2WsUogsu', 'Branch Manager', 'Staff Member', 1, 'active', 'default_avatar.png', NULL, NULL, NULL, '2025-12-06 11:06:34', '2025-12-06 16:51:35'),
(3, 'clerk_1', 'Chandra (Clerk)', 'clerk@shreydistillery.com', '$2y$10$QQDl4Y8PaPSpG92.PegYIOBvP9X3zsDcDcs3GpRAwiV7fnJ5CJmJO', 'Clerk', 'Staff Member', 1, 'active', 'default_avatar.png', NULL, NULL, NULL, '2025-12-06 11:06:35', '2025-12-06 16:51:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `manager_id` (`manager_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_code` (`customer_code`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_product_branch_lot` (`product_id`,`branch_id`,`lot_id`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `lot_id` (`lot_id`);

--
-- Indexes for table `lots`
--
ALTER TABLE `lots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lot_number` (`lot_number`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `po_approval_history`
--
ALTER TABLE `po_approval_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `po_id` (`po_id`),
  ADD KEY `approver_id` (`approver_id`);

--
-- Indexes for table `po_items`
--
ALTER TABLE `po_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `po_id` (`po_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `po_number` (`po_number`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `branch_manager_id` (`branch_manager_id`),
  ADD KEY `head_procurement_id` (`head_procurement_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `sold_by` (`sold_by`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `lot_id` (`lot_id`);

--
-- Indexes for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `adjustment_number` (`adjustment_number`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `lot_id` (`lot_id`),
  ADD KEY `adjusted_by` (`adjusted_by`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transfer_number` (`transfer_number`),
  ADD KEY `from_branch_id` (`from_branch_id`),
  ADD KEY `to_branch_id` (`to_branch_id`),
  ADD KEY `requested_by` (`requested_by`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `transfer_items`
--
ALTER TABLE `transfer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_id` (`transfer_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `lot_id` (`lot_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `branch_id` (`branch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lots`
--
ALTER TABLE `lots`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `po_approval_history`
--
ALTER TABLE `po_approval_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `po_items`
--
ALTER TABLE `po_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transfer_items`
--
ALTER TABLE `transfer_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventory_ibfk_3` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `lots`
--
ALTER TABLE `lots`
  ADD CONSTRAINT `lots_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lots_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lots_ibfk_3` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `po_approval_history`
--
ALTER TABLE `po_approval_history`
  ADD CONSTRAINT `po_approval_history_ibfk_1` FOREIGN KEY (`po_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `po_approval_history_ibfk_2` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `po_items`
--
ALTER TABLE `po_items`
  ADD CONSTRAINT `po_items_ibfk_1` FOREIGN KEY (`po_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `po_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_orders_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_orders_ibfk_4` FOREIGN KEY (`branch_manager_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchase_orders_ibfk_5` FOREIGN KEY (`head_procurement_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`sold_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `sale_items_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_items_ibfk_3` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  ADD CONSTRAINT `stock_adjustments_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_adjustments_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_adjustments_ibfk_3` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `stock_adjustments_ibfk_4` FOREIGN KEY (`adjusted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_adjustments_ibfk_5` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  ADD CONSTRAINT `stock_transfers_ibfk_1` FOREIGN KEY (`from_branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_transfers_ibfk_2` FOREIGN KEY (`to_branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_transfers_ibfk_3` FOREIGN KEY (`requested_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_transfers_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `transfer_items`
--
ALTER TABLE `transfer_items`
  ADD CONSTRAINT `transfer_items_ibfk_1` FOREIGN KEY (`transfer_id`) REFERENCES `stock_transfers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transfer_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transfer_items_ibfk_3` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
