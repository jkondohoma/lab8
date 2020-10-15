
-- Jaelle Kondohoma

-- 1. A query to retrieve the major fields for every person
	select p.personCode, p.firstName, p.lastName , a.streetAddress, a.city, s.name, s.abbreviation, c.name, a.zipCode from   Persons      as  p
				 join    Addresses   as  a on p.addressId = a.addressId
                 join    Countries     as  c  on a.countryId = c.countryId
                 join    States          as  s on a.stateId = s.stateId;
                 
-- 2. A query to retrieve the email(s) of a given person
		select p.personId , p.personCode, p.firstName, p.lastName,e.email  from Emails   as e
					  join  Persons as p on e.personId = p.personId where p.personCode = "zero";

-- 3. A query to add an email to a specific person
		INSERT INTO Emails (personId, email) VALUES 
	(4, "doitforher@sprngfldpowerplant.net");
    
    select p.personId , p.personCode, p.firstName, p.lastName,e.emailId,e.email  from Emails   as e
					  join  Persons as p on e.personId = p.personId where p.personId = 4;
    
-- 4. A query to change the email address of a given email record
		update Emails as e SET email = "clara derseved better :( danny should be alive" WHERE e.emailId = 6;
        
        select p.personId , p.personCode, p.firstName, p.lastName,e.emailId,e.email  from Emails   as e
					  join  Persons as p on e.personId = p.personId where e.emailId = 6;
        
-- 5. A query (or series of queries) to remove a given person record
		select * from Persons;
        select * from Invoices;
        select * from Customers;
        
        delete from Emails where personId = 6;
        delete from InvoiceProducts where invoiceId = 6;
        delete from Invoices where InvoiceId = 6;
        delete from Customers where primaryContactId = 6;
		
-- 6. A query to create a person record
		insert into Persons (personCode, firstName, lastName, addressId) VALUES
	   ("TIRED", "Jaelle", "Kondohoma", 7);
       
       select * from Persons;
       
-- 7. A query to get all the products in a particular invoice
	SELECT * FROM Products p 
	JOIN InvoiceProducts ip ON ip.productId = p.productId
    WHERE ip.invoiceId = 3;
    
-- 8. A query to get all the products of a particular person

    
-- 9. A query to get all the Invoices of a particular owner
		
       
-- 10. A query that “adds” a particular product to a particular invoice
-- 11. A query to find the total of all unitCostof all Concessionproducts
-- 12. A query to find thecustomerswith more than 2 invoices
-- 13. A query to find the number of invoices that include Repair as one of the product in the invoice
-- 14. A  query  to  find  the  total  revenue  generated  (excluding  fees  and  taxes) bytowingfrom all invoices
-- 15. Write a query to find any invoice that includes multiple products of the same type

    
-- 6.	A query to get all the invoices of a particular customer.
SELECT * FROM Invoices i
	JOIN Customers c ON c.customerId = i.customerId
    WHERE c.customerId = 1;
    
-- 7.	A query that “adds” a particular product to a particular invoice.
INSERT INTO InvoiceProducts (invoiceId, productId, quantity) VALUES
	(2, 3, 8);
    
-- 8.	A query to find the total of all per-unit costs of all lease-agreements.
SELECT SUM(cost) FROM Products
	WHERE type = 'L';

-- 9. A query to find the total of all per-unit costs of all sales-agreements.
SELECT SUM(cost) FROM Products
	WHERE type = 'S';
    
-- 10. A query to find the total number of agreements sold on a particular date. 
SELECT COUNT(productId) FROM Products
	WHERE startDate LIKE "2015-06-06" OR dateTime LIKE "%2016-04-01%";
    
-- 11. A query to find the total number of invoices for every realtor
SELECT p.personId, COUNT(i.invoiceId) FROM Invoices i
	JOIN Persons p on p.personId = i.realtorId
    GROUP BY p.personId;
    
-- 12. A query to find the total number of invoices for a particular agreement.
SELECT COUNT(i.invoiceId) FROM Invoices i
	JOIN InvoiceProducts ip ON ip.invoiceId = i.invoiceId
    WHERE ip.productId = 2;

-- 13. A query to find the total revenue generated (excluding fees and taxes) on a particular date from all agreements
SELECT ip.invoiceId, SUM(p.cost * ip.quantity) AS totalCost FROM Products p 
	JOIN InvoiceProducts ip ON ip.productId = p.productId
    WHERE p.type = 'S' OR p.type = 'L';
    
-- 14. A query to find the total quantities sold (excluding fees and taxes) of each category of services (parking-passes and amenities) in all the existing invoices
SELECT p.type, SUM(ip.quantity) AS totalQuantity FROM Products p
	JOIN InvoiceProducts ip ON ip.productId = p.productId
    WHERE p.type = 'P' or p.type = 'A'
    GROUP BY p.type;
    
-- 15. A query to detect invalid data in invoices as follows.  In a single invoice, a particular agreement should only appear once (since any number of units can 
--  	 be consolidated to a single record).  Write a query to find any invoice that includes multiple instances of the same agreement
SELECT ip.invoiceId FROM InvoiceProducts ip
	JOIN Products p ON ip.productId = p.productId
    WHERE p.type = 'S' OR p.type = 'L'
    GROUP BY ip.invoiceId
    HAVING COUNT(DISTINCT p.productId) < COUNT(p.productId);
    
-- 17. detect  a  possible  conflict  of  interest  as  follows.   No  distinction is made in this system between a person who is the primary
--       contact of a client and aperson who is also a sales person.  Write a query to find any and all invoices where the salesperson is 
--       the same as the primary contact of the invoice’s customer.
SELECT i.invoiceId FROM Invoices i
	JOIN Customers c ON c.customerId = i.customerId
    WHERE c.primaryContactId = i.realtorId;


