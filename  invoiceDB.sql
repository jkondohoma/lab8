-- Jaelle Kondohoma

drop table if exists InvoiceProducts;
drop table if exists Invoices;
drop table if exists Products;
drop table if exists Customers;
drop table if exists Emails;
drop table if exists Persons;
drop table if exists Addresses;
drop table if exists  States;
drop table if exists  Countries;



-- Countries
CREATE TABLE Countries(
	countryId int not null primary key auto_increment,
    name varchar(50) not null
) engine=InnoDB;


-- States
CREATE TABLE States (
	stateId int not null primary key auto_increment,
    name varchar(15) not null,
    abbreviation varchar(3) not null,
    countryId int not null,
    foreign key (countryId) references Countries(countryId)
) engine=InnoDB;

-- Addresses
CREATE TABLE Addresses(
	addressId int not null primary key auto_increment,
    streetAddress VARCHAR(100) not null,
    city VARCHAR(20),
    stateId int,
    countryId int not null,
    zipCode int,
    foreign key (stateId) references States(stateId),
    foreign key (countryId) references Countries(countryId)
) engine=InnoDB;


-- Persons
CREATE TABLE Persons(
	personId int not null primary key auto_increment,
    personCode VARCHAR(10) not null unique,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    addressId int,
    foreign key (addressId) references Addresses(addressId)
) engine=InnoDB;

-- Emails
CREATE TABLE Emails(
	emailId int not null primary key auto_increment,
    personId int,
    email varchar(150) not null,
    foreign key (personId) references Persons(personId)
) engine=InnoDB;

-- Customers
CREATE TABLE Customers(
	customerId int not null primary key auto_increment,
    customerCode varchar(10) unique not null, # C or G
    type char not null,
    primaryContactId int,
    name VARCHAR(100),
    addressId int,
    foreign key (primaryContactId) references Persons(personId),
    foreign key (addressId) references Addresses(addressId)
) engine=InnoDB;

-- Products

/*
For Rentals        -productCode;productType;productLabel;dailyCost;deposit;cleaningFee (R)
For Repair          -productCode;productType;productLabel;partsCost;hourlyLaborCost (F)
For Concession  -productCode;productType;productLabel;unitCost (C)
For Towing          -productCode;productType;productLabel;costPerMile (T)
*/

CREATE TABLE Products(
	productId int not null primary key auto_increment,
    productCode VARCHAR(10) unique not null,
    productType char not null, # R, F, C, T
    productLabel  VARCHAR(100),
    -- Rental Data
    dailyCost double,
    deposit double,
    cleaningFee double,
    -- Repair Data
    partsCost double,
    hourlyLaborCost double,
   	-- Concession data
   	unitCost double,
    -- Towing data
    costPerMile double
) engine=InnoDB;

-- Invoices

-- invoiceCode;ownerCode;customerCode;listOfProducts
CREATE TABLE Invoices(
	invoiceId int not null primary key auto_increment,
    invoiceCode VARCHAR(10) unique not null,
    ownerId int not null,
    customerId int not null,
    foreign key (customerId) references Customers(customerId),
    foreign key (ownerId) references Persons(personId)
) engine=InnoDB;

-- InvoiceProducts

-- productCode:daysRented (R)
-- productCode:hoursWorked (F)
-- productCode:quantity:associatedRepair (C)
-- productCode:milesTowed (T)
CREATE TABLE InvoiceProducts(
	invoiceProductId int not null primary key auto_increment,
    invoiceId int not null,
    productId int not null,
    quantity double,
    associatedRepair int,
    foreign key (invoiceId) references Invoices(invoiceId),
    foreign key (productId) references Products(productId),
     foreign key (associatedRepair) references Products(productId)
) engine=InnoDB;


-- inserting data --------------------------------------------------------------------
INSERT INTO Countries (name) VALUES 
	("Malaysia"),
    ("Portugal"),
    ("China"),
    ("Russia"),
    ("Philippines"),
    ("Serbia");
    
    INSERT INTO States (name, abbreviation, countryId) VALUES
	("Sabah", "SBH", 1),
    ("Sarawak", "SWK", 1),
    ("Alentejo", "ATJ", 2),
    ("Estremadura", "ESM", 2),
    ("Shanghai", "SH", 3),
    ("Guizhou", "GZ", 3),
    ("Kalmykia", "", 4),
    ("Cordillera", "COD", 5),
    ("Bicol", "", 5),
	("Vojvodina", "", 3);

INSERT INTO Addresses (streetAddress, city, stateId, countryId,zipCode) VALUES
	("9 Jenifer Circle", "Terengganu", 1, 1,21109),
    ("10 Anderson Point", "Muxagata", 3, 2,5150-304),
    ("11 Golden Leaf Crossing,", "Xiaoduchuan", 4, 3,76824),
    ("12 Declaration Crossing", "San Ramon", 4, 4,6710),
    ("13 Piermont Dr. NE", "Albuquerque", 2, 5,68508),
    ("14 FourTwenty Ave", "Mexico City", NULL, 6,68508),
    ("2 Troy Alley", "Bend", 5, 6,68508);


INSERT INTO Persons (personCode, firstName, lastName, addressId) VALUES
	("doh1", "Christopher", "Eccleston", 1),
    ("sax1", "David", "Tennant", 2),
    ("blu1", "Matthew", "Smith", 3),
    ("zero", "Peter", "Capaldi", 4),
    ("sami", "Jodi", "Whittaker", 5),
    ("blom", "Tom", "Baker", 6),
    ("oops", "Buster", "Salez", 7);

INSERT INTO Emails (personId, email) VALUES 
	(1, "lsaphir0@independent.co.uk"),
    (1, "lasaphir0@google.com"),
    (1, "csaphir0@nytimes.com"),
    (1, "bsaphir0@va.gov"),
    (3, "kcamerana2@cisco.com"),
    (4, "tscrogges3@disqus.com"),
    (4, "djenman4@dyndns.org"),
    (6, "rabela7@parallels.com");


INSERT INTO Customers (customerCode, type, primaryContactId, name, addressId) VALUES
	("pplnt", 'B', 1, "Springfield Nuclear Power Plant", 5),
    ("lab3", 'P', 4, "Walt White's Meth Lab", 4),
    ("sad6", 'B', 7, "Blockbuster Video", 7);
    
    
/*
For Rentals        -productCode;productType;productLabel;dailyCost;deposit;cleaningFee (R)
For Repair          -productCode;productType;productLabel;partsCost;hourlyLaborCost (F)
For Concession  -productCode;productType;productLabel;unitCost (C)
For Towing          -productCode;productType;productLabel;costPerMile (T)
*/

INSERT INTO Products (productCode, productType, productLabel, dailyCost,  deposit, cleaningFee, partsCost, hourlyLaborCost, unitCost, costPerMile) VALUES
    ("3xHG", "C", "Sour cream and Onion Chips", null,  null, null, null, null, 3.11, null),
    ("6eSI", "R", "Chevrolet 2500",  81.36,  4782.42, 22.2, null, null, null, null),
    ("4lJw", "C", "Bai Anioxident Infusion", null,  null, null, null, null, 12.99, null),
    ("3iDu", "F", "Porsche 911", null,  null, null, 1083.62, 3300.20, null, null),
    ("6cHW", "R", "Chevrolet Express 1500",  48.67,  2911.20, 17.6, null, null, null, null),
    ("3pI9", "T", "Mitsubishi Chariot",  null,  null, null, null, null, null, 17.65),
    ("4eXh", "F", "Porsche 911", null,  null, null, 7099.38, 6885.80, null, null),
    ("5aPl", "C", "Nature valley - honey and oats", null,  null, null, null, null, 6.59, null),
    ("5qCj", "T", "Lotus Exige",  null,  null, null, null, null, null, 13.42),
    ("7kP7", "T", "Pontiac LeMans",  null,  null, null, null, null, null, 19.90);
  
 
  
INSERT INTO Invoices(invoiceCode, ownerId, customerId) VALUES
	("INV001", 1, 1),
    ("INV002", 2, 2),
    ("INV003", 3, 3),
    ("INV004", 4, 1),
    ("INV005", 5, 2),
    ("INV006", 6, 3),
	("INV007", 5, 1),
	("INV008", 5, 2);

-- productCode:daysRented (R)
-- productCode:hoursWorked (F) repair
-- productCode:quantity:associatedRepair (C)
-- productCode:milesTowed (T)

INSERT INTO InvoiceProducts(invoiceId, productId, quantity,associatedRepair) VALUES
	(1, 1, 4,null),   # C
    (1, 2, 2.5,null),   # R
	(2, 4, 10.5,null), # F
    (2, 3, 2,4),      # C
    (3, 5, 14.34,null), # R
    (3, 6, 20.7,null), # R
    (4, 7, 22.33,null), # F
    (4, 8, 5,7) ,    # C
	(5, 9, 55.5,null) , # T
	(6, 10, 12.23, null), # T
	(7, 9, 55.5,null) , # T
    (8, 3, 2,null);  # C
    


