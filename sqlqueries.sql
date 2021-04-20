CREATE TABLE "USER" (
ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1), 
"NAME" VARCHAR(255) NOT NULL, 
EMAIL VARCHAR(255) NOT NULL, 
PASSWORD VARCHAR(255) NOT NULL, 
PHONE VARCHAR(255) NOT NULL, 
GENDER VARCHAR(255) NOT NULL, 
DOB VARCHAR(255) NOT NULL, 
PRIMARY KEY (ID));
    
INSERT INTO SUPERUSER."USER" ("NAME",EMAIL, PASSWORD, PHONE, GENDER, DOB) 
	VALUES 
  	('Jane S. Doe','jane.doe@uts.edu.au',  '12345', '99990000', 'F', '05/05/1995'),
	('John Smith','john.smith@uts.edu.au',  '111111', '99991111', 'M', '05/06/1990'),
	('Jim Carry','jim.carry@uts.edu.au',  '12333', '99912000', 'M', '06/05/1999'),
	('Julie Laveaux','julie.l@uts.edu.au',  '12222', '99991100', 'F', '05/11/2000'), 
	('Lucy Lu','lucy.lu@uts.edu.au',  '66600', '99990011', 'F', '02/01/1991');

 
