-- =====================================================================
-- TechNova Solutions - Training Database
-- A small fictional company dataset for learning SQL with MariaDB
-- =====================================================================
--
-- HOW TO IMPORT (command line):
--   mariadb -u root -p < technova_solutions.sql
--
-- HOW TO IMPORT (MySQL Workbench / HeidiSQL / DBeaver etc.):
--   Open this file and run/execute it as a script.
--
-- The script drops and recreates the "company_training" database,
-- so it is safe to re-run whenever you want to reset the data.
-- =====================================================================

DROP DATABASE IF EXISTS company_training;
CREATE DATABASE company_training CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE company_training;

-- ---------------------------------------------------------------------
-- Table: departments
-- ---------------------------------------------------------------------
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(50) NOT NULL,
    location      VARCHAR(50) NOT NULL
);

INSERT INTO departments (department_id, name, location) VALUES
(1, 'Executive', 'Berlin'),
(2, 'Engineering', 'Berlin'),
(3, 'Sales', 'Munich'),
(4, 'Marketing', 'Munich'),
(5, 'Human Resources', 'Hamburg');

-- ---------------------------------------------------------------------
-- Table: employees
-- manager_id references another employee (self-referencing FK).
-- The CEO (employee_id 1) has no manager -> NULL.
-- Employee 25 is a new intern who has not been assigned to a
-- department yet -> department_id / manager_id are NULL.
-- ---------------------------------------------------------------------
CREATE TABLE employees (
    employee_id   INT PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    hire_date     DATE NOT NULL,
    salary        DECIMAL(10,2) NOT NULL,
    department_id INT,
    manager_id    INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, salary, department_id, manager_id) VALUES
(1,  'Anna',     'Keller',      'anna.keller@technova.com',      '2015-01-10', 145000.00, 1, NULL),
(2,  'Markus',   'Vogel',       'markus.vogel@technova.com',     '2015-03-01', 125000.00, 2, 1),
(3,  'Julia',    'Hoffmann',    'julia.hoffmann@technova.com',   '2016-02-15', 118000.00, 3, 1),
(4,  'Thomas',   'Bauer',       'thomas.bauer@technova.com',     '2016-05-20', 112000.00, 4, 1),
(5,  'Sophie',   'Wagner',      'sophie.wagner@technova.com',    '2017-01-09', 105000.00, 5, 1),
(6,  'Felix',    'Schmidt',     'felix.schmidt@technova.com',    '2018-04-01', 78000.00,  2, 2),
(7,  'Laura',    'Fischer',     'laura.fischer@technova.com',    '2018-06-15', 80000.00,  2, 2),
(8,  'Jonas',    'Meyer',       'jonas.meyer@technova.com',      '2019-02-11', 76000.00,  2, 2),
(9,  'Nina',     'Schulz',      'nina.schulz@technova.com',      '2019-09-23', 82000.00,  2, 2),
(10, 'Paul',     'Weber',       'paul.weber@technova.com',       '2020-01-13', 74000.00,  2, 2),
(11, 'Hannah',   'Becker',      'hannah.becker@technova.com',    '2020-08-04', 77000.00,  2, 2),
(12, 'Lukas',    'Hartmann',    'lukas.hartmann@technova.com',   '2018-03-19', 62000.00,  3, 3),
(13, 'Marie',    'Lang',        'marie.lang@technova.com',       '2018-11-02', 65000.00,  3, 3),
(14, 'David',    'Krueger',     'david.krueger@technova.com',    '2019-05-17', 60000.00,  3, 3),
(15, 'Lena',     'Schmitt',     'lena.schmitt@technova.com',     '2020-02-28', 63000.00,  3, 3),
(16, 'Tim',      'Neumann',     'tim.neumann@technova.com',      '2021-03-15', 58000.00,  3, 3),
(17, 'Sarah',    'Zimmermann',  'sarah.zimmermann@technova.com', '2021-07-09', 59000.00,  3, 3),
(18, 'Jan',      'Braun',       'jan.braun@technova.com',        '2019-01-21', 61000.00,  4, 4),
(19, 'Emily',    'Krause',      'emily.krause@technova.com',     '2019-10-10', 63000.00,  4, 4),
(20, 'Max',      'Lehmann',     'max.lehmann@technova.com',      '2021-02-01', 57000.00,  4, 4),
(21, 'Clara',    'Peters',      'clara.peters@technova.com',     '2018-06-06', 59000.00,  5, 5),
(22, 'Simon',    'Richter',     'simon.richter@technova.com',    '2020-09-14', 56000.00,  5, 5),
(23, 'Elias',    'Vogt',        'elias.vogt@technova.com',       '2022-04-11', 72000.00,  2, 2),
(24, 'Mia',      'Koenig',      'mia.koenig@technova.com',       '2022-08-01', 55000.00,  3, 3),
(25, 'Ben',      'Fuchs',       'ben.fuchs@technova.com',        '2023-01-16', 42000.00,  NULL, NULL);

-- ---------------------------------------------------------------------
-- Table: customers
-- Customers 28-30 intentionally have no orders (see order data below)
-- so students can practice LEFT JOIN / NOT EXISTS queries.
-- ---------------------------------------------------------------------
CREATE TABLE customers (
    customer_id  INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    email        VARCHAR(100),
    city         VARCHAR(50),
    country      VARCHAR(50)
);

INSERT INTO customers (customer_id, company_name, contact_name, email, city, country) VALUES
(1,  'Nordwind Handels GmbH',    'Peter Albrecht',   'contact@nordwind.de',        'Hamburg',      'Germany'),
(2,  'Alpen Trading AG',         'Claudia Steiner',  'c.steiner@alpentrading.ch',  'Zurich',       'Switzerland'),
(3,  'Rheinblick Software GmbH','Michael Roth',      'm.roth@rheinblick.de',       'Cologne',      'Germany'),
(4,  'Blaue Welle Logistik',     'Anke Fricke',       'a.fricke@blauewelle.de',     'Bremen',       'Germany'),
(5,  'Sonnenschein Retail',      'Oliver Graf',       'o.graf@sonnenschein.de',     'Stuttgart',    'Germany'),
(6,  'Berg und Tal Consulting',  'Petra Sommer',      'p.sommer@bergtal.at',        'Vienna',       'Austria'),
(7,  'Nordlicht Media',          'Frank Winter',      'f.winter@nordlicht.de',      'Kiel',         'Germany'),
(8,  'Goldstadt Manufacturing',  'Ingrid Falk',       'i.falk@goldstadt.de',        'Pforzheim',    'Germany'),
(9,  'Seehafen Import Export',   'Rainer Busch',      'r.busch@seehafen.de',        'Rostock',      'Germany'),
(10, 'Waldblick Furniture',      'Katharina Herrmann','k.herrmann@waldblick.de',    'Freiburg',     'Germany'),
(11, 'Nordsee Fisch GmbH',       'Jens Albers',       'j.albers@nordseefisch.de',   'Bremerhaven',  'Germany'),
(12, 'Sternenhimmel Events',     'Franziska Otto',    'f.otto@sternenhimmel.de',    'Dresden',      'Germany'),
(13, 'Bayern Elektronik AG',     'Wolfgang Huber',    'w.huber@bayernelektronik.de','Munich',       'Germany'),
(14, 'Rhein-Main Logistics',     'Sabine Kraus',      's.kraus@rheinmain.de',       'Frankfurt',    'Germany'),
(15, 'Ostsee Ferienhaus',        'Dirk Lorenz',       'd.lorenz@ostseeferien.de',   'Ruegen',       'Germany'),
(16, 'Alpenpanorama Tourismus',  'Monika Seidel',     'm.seidel@alpenpanorama.at',  'Salzburg',     'Austria'),
(17, 'Donau Transport',          'Herbert Kramer',    'h.kramer@donautransport.at', 'Linz',         'Austria'),
(18, 'Zuerichsee Finance',       'Barbara Egli',      'b.egli@zsfinance.ch',        'Zurich',       'Switzerland'),
(19, 'Genfer Design Studio',     'Nicolas Perret',    'n.perret@genferdesign.ch',   'Geneva',       'Switzerland'),
(20, 'Nordkap Energie',          'Lars Johansen',     'l.johansen@nordkap.no',      'Oslo',         'Norway'),
(21, 'Fjord Fisheries',          'Ingrid Haugen',     'i.haugen@fjordfish.no',      'Bergen',       'Norway'),
(22, 'Tulip Trading BV',         'Willem de Vries',   'w.devries@tuliptrading.nl',  'Amsterdam',    'Netherlands'),
(23, 'Delta Logistics BV',       'Anneke Bakker',     'a.bakker@deltalogistics.nl', 'Rotterdam',    'Netherlands'),
(24, 'Champs Elysees Mode',      'Camille Dubois',    'c.dubois@celysees.fr',       'Paris',        'France'),
(25, 'Provence Gourmet',         'Julien Marchand',   'j.marchand@provencegourmet.fr','Marseille',  'France'),
(26, 'Adriatic Shipping',        'Marco Rossi',       'm.rossi@adriaticshipping.it','Venice',       'Italy'),
(27, 'Toscana Vineria',          'Giulia Bianchi',    'g.bianchi@toscanavineria.it','Florence',     'Italy'),
(28, 'Northern Lights Tech',     'Emma Andersson',    'e.andersson@nlights.se',     'Stockholm',    'Sweden'),
(29, 'Baltic Software House',    'Piotr Kowalski',    'p.kowalski@balticsoft.pl',   'Gdansk',       'Poland'),
(30, 'Danube Analytics',         'Zoltan Nagy',       'z.nagy@danubeanalytics.hu',  'Budapest',     'Hungary');

-- ---------------------------------------------------------------------
-- Table: suppliers
-- ---------------------------------------------------------------------
CREATE TABLE suppliers (
    supplier_id  INT PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    email        VARCHAR(100),
    country      VARCHAR(50)
);

INSERT INTO suppliers (supplier_id, name, contact_name, email, country) VALUES
(1, 'Silicon Components Ltd',  'James Carter',  'sales@siliconcomp.co.uk',  'United Kingdom'),
(2, 'EuroChip Manufacturing',  'Andrea Rossi',  'contact@eurochip.it',      'Italy'),
(3, 'Nordic Metals AB',        'Erik Lindqvist','info@nordicmetals.se',     'Sweden'),
(4, 'Pacific Plastics Inc',    'Wei Zhang',     'w.zhang@pacificplastics.cn','China'),
(5, 'Global Textiles Co',      'Raj Patel',     'r.patel@globaltextiles.in','India'),
(6, 'Alpine Precision GmbH',   'Stefan Moser',  's.moser@alpineprecision.at','Austria'),
(7, 'Iberia Components SL',    'Marta Gomez',   'm.gomez@iberiacomp.es',    'Spain'),
(8, 'American Circuits LLC',   'John Miller',   'j.miller@amcircuits.com',  'USA');

-- ---------------------------------------------------------------------
-- Table: products
-- ---------------------------------------------------------------------
CREATE TABLE products (
    product_id     INT PRIMARY KEY AUTO_INCREMENT,
    name           VARCHAR(100) NOT NULL,
    category       VARCHAR(50) NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    supplier_id    INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

INSERT INTO products (product_id, name, category, price, stock_quantity, supplier_id) VALUES
(1,  'Laptop Pro 15',                    'Computer Hardware', 1299.00, 45,  1),
(2,  'Laptop Air 13',                    'Computer Hardware', 999.00,  60,  1),
(3,  'Desktop Workstation X1',           'Computer Hardware', 1599.00, 25,  4),
(4,  '27 Inch 4K Monitor',               'Electronics',       449.00,  80,  3),
(5,  'Wireless Mouse',                   'Accessories',       29.90,   300, 4),
(6,  'Mechanical Keyboard',              'Accessories',       89.90,   150, 4),
(7,  'USB-C Docking Station',            'Electronics',       129.00,  100, 1),
(8,  'Noise-Cancelling Headphones',      'Electronics',       199.00,  90,  8),
(9,  'Webcam HD 1080p',                  'Electronics',       59.90,   120, 8),
(10, 'Office Chair Ergo',                'Office Furniture',  349.00,  40,  6),
(11, 'Standing Desk',                    'Office Furniture',  599.00,  20,  6),
(12, 'Filing Cabinet',                   'Office Furniture',  189.00,  35,  6),
(13, 'Whiteboard 120x90',                'Office Supplies',   79.00,   50,  6),
(14, 'Printer LaserJet 400',             'Electronics',       249.00,  30,  3),
(15, 'External SSD 1TB',                 'Computer Hardware', 119.00,  200, 4),
(16, 'Network Switch 24-Port',           'Electronics',       349.00,  15,  3),
(17, 'CRM Software License (per seat)',  'Software',          49.00,   1000,8),
(18, 'Project Management Suite License', 'Software',          39.00,   1000,8),
(19, 'Antivirus Enterprise License',     'Software',          25.00,   1000,8),
(20, 'Conference Room Speakerphone',     'Electronics',       149.00,  60,  8);

-- ---------------------------------------------------------------------
-- Table: orders
-- ---------------------------------------------------------------------
CREATE TABLE orders (
    order_id    INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date  DATE NOT NULL,
    status      ENUM('Pending', 'Shipped', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO orders (order_id, customer_id, employee_id, order_date, status) VALUES
(1,  1,  12, '2023-08-03', 'Completed'),
(2,  2,  13, '2023-08-05', 'Completed'),
(3,  3,  14, '2023-08-10', 'Completed'),
(4,  4,  15, '2023-08-12', 'Shipped'),
(5,  5,  16, '2023-08-15', 'Completed'),
(6,  6,  17, '2023-08-18', 'Completed'),
(7,  7,  24, '2023-08-20', 'Pending'),
(8,  8,  12, '2023-08-22', 'Completed'),
(9,  9,  13, '2023-08-25', 'Completed'),
(10, 10, 14, '2023-08-28', 'Cancelled'),
(11, 11, 15, '2023-09-02', 'Completed'),
(12, 12, 16, '2023-09-05', 'Completed'),
(13, 13, 17, '2023-09-08', 'Shipped'),
(14, 14, 24, '2023-09-10', 'Completed'),
(15, 15, 12, '2023-09-14', 'Completed'),
(16, 16, 13, '2023-09-18', 'Completed'),
(17, 17, 14, '2023-09-20', 'Pending'),
(18, 18, 15, '2023-09-23', 'Completed'),
(19, 19, 16, '2023-09-27', 'Completed'),
(20, 20, 17, '2023-10-01', 'Completed'),
(21, 21, 24, '2023-10-04', 'Shipped'),
(22, 22, 12, '2023-10-08', 'Completed'),
(23, 23, 13, '2023-10-11', 'Completed'),
(24, 24, 14, '2023-10-15', 'Cancelled'),
(25, 25, 15, '2023-10-18', 'Completed'),
(26, 26, 16, '2023-10-21', 'Completed'),
(27, 27, 17, '2023-10-25', 'Completed'),
(28, 1,  24, '2023-10-29', 'Completed'),
(29, 2,  12, '2023-11-02', 'Shipped'),
(30, 3,  13, '2023-11-05', 'Completed'),
(31, 4,  14, '2023-11-09', 'Completed'),
(32, 5,  15, '2023-11-12', 'Pending'),
(33, 6,  16, '2023-11-15', 'Completed'),
(34, 7,  17, '2023-11-19', 'Completed'),
(35, 8,  24, '2023-11-22', 'Completed'),
(36, 9,  12, '2023-11-26', 'Shipped'),
(37, 10, 13, '2023-11-29', 'Completed'),
(38, 11, 14, '2023-12-03', 'Completed'),
(39, 12, 15, '2023-12-06', 'Completed'),
(40, 13, 16, '2023-12-10', 'Cancelled'),
(41, 14, 17, '2023-12-13', 'Completed'),
(42, 15, 24, '2023-12-17', 'Completed'),
(43, 16, 12, '2023-12-20', 'Shipped'),
(44, 17, 13, '2024-01-08', 'Completed'),
(45, 18, 14, '2024-01-12', 'Completed'),
(46, 19, 15, '2024-01-16', 'Completed'),
(47, 20, 16, '2024-01-20', 'Pending'),
(48, 21, 17, '2024-01-24', 'Completed'),
(49, 22, 24, '2024-01-28', 'Completed'),
(50, 23, 12, '2024-02-02', 'Shipped'),
(51, 24, 13, '2024-02-06', 'Completed'),
(52, 25, 14, '2024-02-10', 'Completed'),
(53, 26, 15, '2024-02-14', 'Completed'),
(54, 27, 16, '2024-02-18', 'Cancelled'),
(55, 1,  17, '2024-02-22', 'Completed'),
(56, 5,  24, '2024-02-26', 'Completed'),
(57, 9,  12, '2024-03-02', 'Shipped'),
(58, 13, 13, '2024-03-06', 'Completed'),
(59, 17, 14, '2024-03-10', 'Completed'),
(60, 21, 15, '2024-03-14', 'Completed');

-- ---------------------------------------------------------------------
-- Table: order_items
-- Junction table between orders and products (many-to-many), with
-- quantity and the unit_price actually charged at the time of sale.
-- ---------------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id      INT NOT NULL,
    product_id    INT NOT NULL,
    quantity      INT NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 3, 1299.00),
(2, 2, 8, 1, 199.00),
(3, 2, 5, 24, 29.90),
(4, 3, 19, 16, 25.00),
(5, 4, 1, 1, 1299.00),
(6, 5, 8, 1, 199.00),
(7, 5, 17, 20, 49.00),
(8, 6, 18, 10, 39.00),
(9, 6, 14, 4, 249.00),
(10, 7, 1, 4, 1299.00),
(11, 7, 6, 13, 89.90),
(12, 8, 5, 13, 29.90),
(13, 8, 7, 1, 129.00),
(14, 9, 13, 6, 79.00),
(15, 10, 12, 4, 189.00),
(16, 10, 9, 20, 59.90),
(17, 10, 2, 1, 999.00),
(18, 11, 3, 3, 1599.00),
(19, 11, 18, 21, 39.00),
(20, 11, 10, 2, 349.00),
(21, 12, 2, 2, 999.00),
(22, 13, 3, 1, 1599.00),
(23, 13, 8, 4, 199.00),
(24, 14, 15, 2, 119.00),
(25, 14, 12, 3, 189.00),
(26, 15, 7, 2, 129.00),
(27, 15, 9, 20, 59.90),
(28, 15, 3, 2, 1599.00),
(29, 16, 15, 3, 119.00),
(30, 16, 13, 23, 79.00),
(31, 17, 11, 2, 599.00),
(32, 17, 2, 1, 999.00),
(33, 18, 13, 9, 79.00),
(34, 18, 9, 21, 59.90),
(35, 18, 3, 3, 1599.00),
(36, 19, 16, 4, 349.00),
(37, 19, 13, 7, 79.00),
(38, 20, 5, 20, 29.90),
(39, 20, 8, 3, 199.00),
(40, 21, 19, 10, 25.00),
(41, 21, 13, 7, 79.00),
(42, 21, 12, 4, 189.00),
(43, 22, 2, 1, 999.00),
(44, 23, 6, 22, 89.90),
(45, 23, 14, 1, 249.00),
(46, 24, 13, 11, 79.00),
(47, 24, 15, 1, 119.00),
(48, 24, 17, 24, 49.00),
(49, 25, 18, 11, 39.00),
(50, 26, 4, 2, 449.00),
(51, 26, 10, 4, 349.00),
(52, 26, 14, 1, 249.00),
(53, 27, 17, 19, 49.00),
(54, 27, 6, 6, 89.90),
(55, 28, 17, 7, 49.00),
(56, 28, 7, 3, 129.00),
(57, 29, 18, 3, 39.00),
(58, 29, 17, 22, 49.00),
(59, 30, 16, 3, 349.00),
(60, 30, 1, 3, 1299.00),
(61, 30, 4, 2, 449.00),
(62, 31, 8, 1, 199.00),
(63, 32, 16, 1, 349.00),
(64, 33, 5, 20, 29.90),
(65, 33, 16, 2, 349.00),
(66, 34, 17, 9, 49.00),
(67, 34, 14, 2, 249.00),
(68, 35, 13, 17, 79.00),
(69, 35, 12, 4, 189.00),
(70, 36, 8, 2, 199.00),
(71, 37, 11, 1, 599.00),
(72, 38, 19, 3, 25.00),
(73, 38, 8, 1, 199.00),
(74, 39, 8, 1, 199.00),
(75, 40, 11, 1, 599.00),
(76, 41, 9, 9, 59.90),
(77, 41, 16, 2, 349.00),
(78, 42, 8, 1, 199.00),
(79, 42, 16, 1, 349.00),
(80, 42, 14, 4, 249.00),
(81, 42, 7, 3, 129.00),
(82, 43, 14, 1, 249.00),
(83, 43, 15, 1, 119.00),
(84, 43, 2, 4, 999.00),
(85, 44, 4, 2, 449.00),
(86, 44, 8, 4, 199.00),
(87, 44, 7, 2, 129.00),
(88, 45, 6, 10, 89.90),
(89, 45, 9, 5, 59.90),
(90, 45, 15, 4, 119.00),
(91, 46, 2, 1, 999.00),
(92, 47, 8, 2, 199.00),
(93, 48, 16, 4, 349.00),
(94, 48, 20, 1, 149.00),
(95, 48, 7, 2, 129.00),
(96, 49, 1, 4, 1299.00),
(97, 49, 13, 12, 79.00),
(98, 49, 9, 16, 59.90),
(99, 50, 5, 4, 29.90),
(100, 50, 7, 1, 129.00),
(101, 50, 10, 3, 349.00),
(102, 50, 19, 4, 25.00),
(103, 51, 19, 18, 25.00),
(104, 52, 2, 1, 999.00),
(105, 52, 17, 8, 49.00),
(106, 53, 20, 1, 149.00),
(107, 54, 13, 21, 79.00),
(108, 54, 4, 2, 449.00),
(109, 55, 20, 1, 149.00),
(110, 56, 19, 13, 25.00),
(111, 56, 20, 3, 149.00),
(112, 56, 17, 9, 49.00),
(113, 57, 8, 2, 199.00),
(114, 57, 9, 24, 59.90),
(115, 57, 13, 23, 79.00),
(116, 58, 15, 1, 119.00),
(117, 58, 11, 1, 599.00),
(118, 59, 20, 2, 149.00),
(119, 59, 19, 19, 25.00),
(120, 59, 4, 3, 449.00),
(121, 59, 3, 2, 1599.00),
(122, 60, 3, 3, 1599.00),
(123, 60, 8, 2, 199.00),
(124, 60, 12, 4, 189.00);

-- ---------------------------------------------------------------------
-- Table: projects
-- One project (Employee Onboarding Portal) has no end_date, i.e. it
-- is still ongoing - useful for practicing NULL / IS NULL queries.
-- ---------------------------------------------------------------------
CREATE TABLE projects (
    project_id    INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    department_id INT,
    budget        DECIMAL(12,2),
    start_date    DATE,
    end_date      DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO projects (project_id, name, department_id, budget, start_date, end_date) VALUES
(1, 'Website Relaunch',              4, 45000.00,  '2023-01-15', '2023-06-30'),
(2, 'Internal CRM Rollout',          2, 120000.00, '2023-02-01', '2023-11-30'),
(3, 'Sales Pipeline Automation',     3, 60000.00,  '2023-03-01', '2023-09-15'),
(4, 'Employee Onboarding Portal',    5, 35000.00,  '2023-04-10', NULL),
(5, 'Cloud Infrastructure Migration',2, 180000.00, '2023-05-01', '2024-02-28'),
(6, 'Brand Refresh Campaign',        4, 55000.00,  '2024-01-08', '2024-05-31');

-- ---------------------------------------------------------------------
-- Table: employee_projects
-- Junction table between employees and projects (many-to-many).
-- Not every employee is assigned to a project - good for LEFT JOIN
-- practice ("find employees currently not on any project").
-- ---------------------------------------------------------------------
CREATE TABLE employee_projects (
    employee_id INT NOT NULL,
    project_id  INT NOT NULL,
    role        VARCHAR(50),
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO employee_projects (employee_id, project_id, role) VALUES
(2,  2, 'Lead'),
(6,  2, 'Developer'),
(7,  2, 'Developer'),
(9,  2, 'QA'),
(2,  5, 'Lead'),
(8,  5, 'Developer'),
(10, 5, 'Developer'),
(23, 5, 'Developer'),
(4,  1, 'Lead'),
(18, 1, 'Designer'),
(19, 1, 'Copywriter'),
(4,  6, 'Lead'),
(19, 6, 'Copywriter'),
(20, 6, 'Designer'),
(3,  3, 'Lead'),
(12, 3, 'Analyst'),
(13, 3, 'Analyst'),
(5,  4, 'Lead'),
(21, 4, 'Coordinator');

-- =====================================================================
-- Done. A few example queries to get your interns started:
--
-- 1) Who reports to whom? (self-join)
--    SELECT e.first_name AS employee, m.first_name AS manager
--    FROM employees e
--    LEFT JOIN employees m ON e.manager_id = m.employee_id;
--
-- 2) Total revenue per customer:
--    SELECT c.company_name, SUM(oi.quantity * oi.unit_price) AS total
--    FROM customers c
--    JOIN orders o ON o.customer_id = c.customer_id
--    JOIN order_items oi ON oi.order_id = o.order_id
--    GROUP BY c.company_name
--    ORDER BY total DESC;
--
-- 3) Customers who never ordered anything (LEFT JOIN / NULL check):
--    SELECT c.company_name
--    FROM customers c
--    LEFT JOIN orders o ON o.customer_id = c.customer_id
--    WHERE o.order_id IS NULL;
--
-- 4) Average salary per department:
--    SELECT d.name, AVG(e.salary) AS avg_salary
--    FROM departments d
--    JOIN employees e ON e.department_id = d.department_id
--    GROUP BY d.name;
--
-- 5) Employees not currently assigned to any project:
--    SELECT e.first_name, e.last_name
--    FROM employees e
--    LEFT JOIN employee_projects ep ON ep.employee_id = e.employee_id
--    WHERE ep.project_id IS NULL;
-- =====================================================================
