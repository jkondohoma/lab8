
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
	
		select * from Invoices;
		
		select inv.invoiceCode, p.firstName, p.lastName,pr.productType,pr.productLabel from Persons as p join Invoices as inv on p.personId = inv.ownerId
													join InvoiceProducts as prods on inv.invoiceId = prods.invoiceId 
                                                    join Products as pr on prods.productId = pr.productId
                                                    where p.personId= 2 group by prods.productId;

    
-- 9. A query to get all the Invoices of a particular owner
		select inv.invoiceCode, p.firstName, p.lastName from Invoices as inv
					join Persons as p on inv.ownerId = p.personId where inv.ownerId = 5;
		
       
-- 10. A query that “adds” a particular product to a particular invoice
 INSERT INTO InvoiceProducts(invoiceId, productId, quantity,associatedRepair) VALUES (8, 2, 2.5,null);  #rental 

-- 11. A query to find the total of all unitCostof all Concession products
	select sum(p.unitCost) as concessionUnitCostSum from Products as p where p.productType = "c" ;
    
-- 12. A query to find the customers with more than 2 invoices
	select c.name, count(c.customerId) as InvoiceCount from Invoices as inv 
							join Customers as c on inv.customerId = c.customerId group by c.customerId having InvoiceCount > 2 ;
                            
-- 13. A query to find the number of invoices that include Repair as one of the product in the invoice
	select count(inv.invoiceId) as InvoicesWithRepair from Invoices as inv 
						join InvoiceProducts as prods on inv.invoiceId = prods.invoiceId
                        join Products as pr on prods.productId = pr.productId where pr.productType = "F";
                        
-- 14. A  query  to  find  the  total  revenue  generated  (excluding  fees  and  taxes) by towing from all invoices
	select sum(pr.costPerMile * prods.quantity) as TowingRevenue from Invoices as inv 
						join InvoiceProducts as prods on inv.invoiceId = prods.invoiceId
                        join Products as pr on prods.productId = pr.productId where pr.productType = "T";
                        
-- 15. Write a query to find any invoice that includes multiple products of the same type
		select inv.invoiceCode, pr.productType, count(pr.productType) as count  from Invoices as inv 
						join InvoiceProducts  as prods on inv.invoiceId = prods.invoiceId
                        join Products as pr on prods.productId = pr.productId group by inv.invoiceId having count > 1;



