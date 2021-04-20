create table "USER"
    (EMAIL varchar(50) NOT NULL,
    "NAME" varchar(100) NOT NULL,
    PASSWORD varchar(20) NOT NULL,
    PHONE varchar(20) NOT NULL,
    GENDER varchar(12) NOT NULL,
    DOB varchar(15) NOT NULL,
    PRIMARY KEY (EMAIL));
    
NSERT INTO ISDUSER."USER" (EMAIL, "NAME", PASSWORD, PHONE, GENDER, DOB) 
	VALUES 
  	('jane.doe@uts.edu.au', 'Jane S. Doe', '12345', '99990000', 'F', '05/05/1995'),
	('john.smith@uts.edu.au', 'John Smith', '111111', '99991111', 'M', '05/06/1990'),
	('jim.carry@uts.edu.au', 'Jim Carry', '12333', '99912000', 'M', '06/05/1999'),
	('julie.l@uts.edu.au', 'Julie Laveaux', '12222', '99991100', 'F', '05/11/2000'), 
	('lucy.lu@uts.edu.au', 'Lucy Lu', '66600', '99990011', 'F', '02/01/1991');

 
