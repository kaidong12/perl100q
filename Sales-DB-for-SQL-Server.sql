USE Master
GO

/******  CREATE SALES DATABASE ******/
if exists (select * from dbo.sysdatabases where name='Sales')
  drop database Sales
GO

CREATE DATABASE Sales
GO

USE Sales
GO


/******  CREATE CUSTOMERS TABLE ******/
if exists (select * from dbo.sysobjects where id = object_id('dbo.Customers'))
  drop table dbo.Customers
GO

CREATE TABLE dbo.Customers (
	CID bigint NOT NULL ,
	FirstName varchar (64) NOT NULL ,
	LastName  varchar (64) NOT NULL ,
	CreditLimit money NOT NULL ,
	AcctBalance money NOT NULL ,
	DateOfEntry datetime NOT NULL ,
	Notes text ,
	CONSTRAINT CustomersPK PRIMARY KEY CLUSTERED (CID)
)
GO

GRANT  REFERENCES ,  SELECT ,  INSERT ,  DELETE ,  UPDATE  ON Customers  TO public
GO


/******  CREATE PRODUCTS TABLE  ******/
if exists (select * from dbo.sysobjects where id = object_id('dbo.Products'))
  drop table dbo.Products
GO

CREATE TABLE dbo.Products (
	PID bigint NOT NULL ,
	ProductName varchar (64) NOT NULL ,
	QuantityInStock int NOT NULL ,
	PricePerItem money NOT NULL ,
	Description text ,
	CONSTRAINT ProductsPK PRIMARY KEY CLUSTERED (PID)
)
GO

GRANT  REFERENCES ,  SELECT ,  INSERT ,  DELETE ,  UPDATE  ON Products  TO public
GO


/******  CREATE ORDERS TABLE ******/
if exists (select * from dbo.sysobjects where id = object_id('dbo.Orders'))
  drop table dbo.Orders
GO

CREATE TABLE dbo.Orders (
	OID bigint NOT NULL ,
	CID bigint NOT NULL ,
	DateOfOrder datetime NOT NULL ,
	CONSTRAINT OrdersPK PRIMARY KEY CLUSTERED (OID)
)
GO

GRANT  REFERENCES ,  SELECT ,  INSERT ,  DELETE ,  UPDATE  ON Orders  TO public
GO


/******  CREATE ORDERITEMS TABLE ******/
if exists (select * from dbo.sysobjects where id = object_id('dbo.OrderItems'))
  drop table dbo.OrderItems
GO

CREATE TABLE dbo.OrderItems (
	OID bigint NOT NULL ,
	PID bigint NOT NULL ,
	QuantityOrdered int NOT NULL ,
	HasShipped tinyint NOT NULL ,
	CONSTRAINT OrderItemsPK PRIMARY KEY CLUSTERED (OID,PID)
)
GO

GRANT  REFERENCES ,  SELECT ,  INSERT ,  DELETE ,  UPDATE  ON OrderItems  TO public
GO


/******  INSERT STARTER DATA INTO TABLES ******/
INSERT INTO Customers(CID, FirstName, LastName, CreditLimit, AcctBalance, DateOfEntry, Notes) 
            VALUES(1, 'Jim', 'Bag', 1000, 0, '01-Jan-1998', 'works at the gym');
INSERT INTO Customers(CID, FirstName, LastName, CreditLimit, AcctBalance, DateOfEntry, Notes) 
            VALUES(3, 'Kathie', 'O''Dahl', 9999.99, 0, '02-Jan-1999', 'a friend with a special name!');
INSERT INTO Customers(CID, FirstName, LastName, CreditLimit, AcctBalance, DateOfEntry, Notes) 
            VALUES(5, 'Bryan', 'Lore', 1000, 900, '24-Dec-2001', 'a brother-in-law');
INSERT INTO Customers(CID, FirstName, LastName, CreditLimit, AcctBalance, DateOfEntry, Notes) 
            VALUES(6, 'Amy', 'Lore', 1000, 100, '24-Dec-2001', 'a sister-in-law');
INSERT INTO Customers(CID, FirstName, LastName, CreditLimit, AcctBalance, DateOfEntry) 
            VALUES(14, 'Bill', 'Gates', 2000000000, 89992, '01-Jun-2002');
INSERT INTO Customers(CID, FirstName, LastName, CreditLimit, AcctBalance, DateOfEntry) 
            VALUES(116, 'Jane', 'Doe', 1000, 420, '01-Jan-2004');
INSERT INTO Customers(CID, FirstName, LastName, CreditLimit, AcctBalance, DateOfEntry, Notes) 
            VALUES(666, 'Bad', 'Guy', 1000000, 235000, '01-Apr-2004', 'not a nice person...');

INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem, Description)
            VALUES(1, 'Flying Squirrels', 3, 899.99, 'yes, they really do fly!');
INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem)
            VALUES(2, 'Cats', 100, 19.99);
INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem, Description)
            VALUES(3, 'Dogs', 20, 79.03, 'we carry dalmations only');
INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem)
            VALUES(4, 'Ants', 10000, 0.09);
INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem)
            VALUES(5, 'Birds', 1000, 4.95);
INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem)
            VALUES(6, 'Elephants', 10, 389.95);
INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem)
            VALUES(7, 'Racoons', 25, 2.25);
INSERT INTO Products(PID, ProductName, QuantityInStock, PricePerItem, Description)
            VALUES(8, 'Cobras', 25, 105.00, 'beth''s favorite');

INSERT INTO ORDERS(OID, CID, DateOfOrder)
            VALUES(9906, 3, '02-Jan-1999');
INSERT INTO ORDERS(OID, CID, DateOfOrder)
            VALUES(12351, 116, '01-Jan-2004');
INSERT INTO ORDERS(OID, CID, DateOfOrder)
            VALUES(22209, 1, '15-Jan-2004');
INSERT INTO ORDERS(OID, CID, DateOfOrder)
            VALUES(22210, 1, '15-Jan-2004');
INSERT INTO ORDERS(OID, CID, DateOfOrder)
            VALUES(33410, 1, '28-Jun-2004');

INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(9906, 4, 10, 1);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(12351, 4, 100, 1);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(12351, 6, 1, 1);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(12351, 8, 1, 1);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(22209, 2, 1, 1);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(22210, 2, 1, 1);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(33410, 3, 1, 0);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(33410, 4, 100, 1);
INSERT INTO ORDERITEMS(OID, PID, QuantityOrdered, HasShipped)
            VALUES(33410, 8, 2, 0);


/***** STORED PROCEDURES *****/

/***** given order id, return customer who placed this order *****/
if exists (select * from dbo.sysobjects where id = object_id('dbo.sprocOrdersOIDToCustomer'))
  drop procedure dbo.sprocOrdersOIDToCustomer
GO

CREATE PROCEDURE sprocOrdersOIDToCustomer @OID bigint 
AS
SELECT *
   FROM Customers 
   INNER JOIN Orders ON Customers.CID = Orders.CID 
   WHERE Orders.OID = @OID
GO
/***** execute sprocOrdersOIDToCustomer 12351; *****/


/***** top 10 customers with the highest account balance *****/
if exists (select * from dbo.sysobjects where id = object_id('dbo.sprocCustomersTopTen'))
  drop procedure dbo.sprocCustomersTopTen
GO

CREATE PROCEDURE sprocCustomersTopTen
AS
SET ROWCOUNT 10
SELECT *
   FROM Customers 
   ORDER BY AcctBalance DESC
GO
/***** execute sprocCustomersTopTen; *****/


/***** deletes a customer by firstname, lastname *****/
if exists (select * from dbo.sysobjects where id = object_id('dbo.sprocCustomersDelete'))
  drop procedure dbo.sprocCustomersDelete
GO

CREATE PROCEDURE sprocCustomersDelete
(
  @FN varchar(64),
  @LN varchar(64)
)
AS
DELETE FROM Customers
       WHERE FirstName=@FN AND LastName=@LN
RETURN(@@ROWCOUNT)
GO
/***** execute sprocCustomersDelete 'Jim', 'Bag'; *****/


/***** given customer's ID, returns FN and LN *****/
if exists (select * from dbo.sysobjects where id = object_id('dbo.sprocCustomersCIDToName'))
  drop procedure dbo.sprocCustomersCIDToName
GO

CREATE PROCEDURE sprocCustomersCIDToName
(
  @CID bigint,
  @FN varchar(64) OUTPUT,
  @LN varchar(64) OUTPUT
)
AS
SELECT @FN=FirstName, @LN=LastName
       FROM Customers
       WHERE CID=@CID
RETURN(@@ROWCOUNT)
GO

/***** DONE! *****/
