use CS345;
DROP DATABASE CS345;
SET GLOBAL event_scheduler = ON;
SET SQL_SAFE_UPDATES =0;

DROP TABLE Customer;
CREATE TABLE Customer(
	id INT NOT NULL AUTO_INCREMENT,
    lname VARCHAR(15) NOT NULL ,
    fname VARCHAR(15) NOT NULL ,
    street VARCHAR(30) NOT NULL ,
    city VARCHAR(15) NOT NULL ,
    zip VARCHAR(5) NOT NULL ,
    phone VARCHAR(10) NOT NULL,
    PRIMARY KEY(id)
    );
INSERT INTO Customer VALUES (1, 'Smith', 'Mike', '123 S Pine Ave', 'Flagstaff', '86001', '1234567892');
INSERT INTO Customer VALUES (2,'Simmons', 'Jane', '3432 S Knoles St', 'Flagstaff', '86001', '6548793125');
INSERT INTO Customer VALUES (3,'Fang', 'Harrold', '489 W Valveta Blvd.', 'San Francisco', '90210', '6548793125');
INSERT INTO Customer VALUES (4,'Johnson', 'Randy', '123 S Pine Ave', 'Flagstaff', '86001', '3215647985');
INSERT INTO Customer VALUES (5,'Verlander', 'Justin', '144 E Panda St.', 'Chicago', '58749', '1597355468');
INSERT INTO Customer VALUES(6,'Pedroia', 'Dustin', '343 S University Ave.', 'Flagstaff', '86001', '3751594568');

DROP TABLE Package;
CREATE TABLE Package(
	id INT NOT NULL AUTO_INCREMENT,
    isLive TINYINT(1) DEFAULT 1, 
    dateDelivered DATE DEFAULT 0,
    sendDate DATE NOT NULL, 
    sender_id INT NOT NULL,
    rec_fname VARCHAR(15) NOT NULL,
    rec_lname VARCHAR(15) NOT NULL,
    rec_street VARCHAR(30) NOT NULL,
    rec_city VARCHAR(15) NOT NULL,
    rec_zip VARCHAR(5) NOT NULL,
    weight FLOAT(6,1) NOT NULL,
    height FLOAT(3,1),
    length FLOAT(3,1),
    PRIMARY KEY (id),
    FOREIGN KEY (sender_id) REFERENCES Customer(id)
    );

DROP TABLE Container;
CREATE TABLE Container(
	id INT NOT NULL AUTO_INCREMENT,
    weight INT(5) NOT NULL,
    hazards VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
    );
INSERT INTO Container VALUES (1, 0, '');
INSERT INTO Container VALUES(2,0,'');    

DROP TABLE StatusLookup;
CREATE TABLE StatusLookup(
	id INT NOT NULL AUTO_INCREMENT,
    _name VARCHAR(30) NOT NULL,
    _time VARCHAR(3),
    PRIMARY KEY (id)
	);
INSERT INTO StatusLookup VALUES(1,'Operational', 0);
INSERT INTO StatusLookup VALUES(2, 'Oil Change', 1);

DROP TABLE Vehicle;
CREATE TABLE Vehicle(
	id INT NOT NULL AUTO_INCREMENT,
    makeANDmodel VARCHAR(20) NOT NULL,
    zip VARCHAR(5),
    identifyingMark VARCHAR(20), 
    _status INT NOT NULL, 
    cargoCap INT(9) NOT NULL,
    prsnCap INT(2) NOT NULL,
    buyDate DATE NOT NULL,
    fuelCon VARCHAR(4),
    fuelType VARCHAR(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN kEY (_status) REFERENCES StatusLookup(id)
    );    
INSERT INTO Vehicle VALUES (1, 'Ford Transport', 'QPD-456','11111', 1, 2500, 3, CURRENT_DATE(), 14.9, 'Regular');
INSERT INTO Vehicle VALUES (2, 'Ford Transport', 'APL-483', '22222', 1, 2500, 3, CURRENT_DATE(), 14.9, 'Regular');
INSERT INTO Vehicle VALUES (5, 'Boeing 747-700', 'HER-474','44444', 1, 128000, 12, CURRENT_DATE(), 1.2, 'Jet'); 

DROP TABLE Tracking;
CREATE TABLE Tracking(
	pack_id INT NOT NULL,
	cont_id INT DEFAULT NULL,
    vehicle_id INT DEFAULT NULL,
    checkin_zip VARCHAR(5),
    checkin_date DATE,
    checkin_time TIME,
    PRIMARY KEY(pack_id, checkin_date, checkin_time),
    FOREIGN KEY(pack_id) REFERENCES Package(id),
    FOREIGN KEY(cont_id) REFERENCES Container(id),
    FOREIGN KEY(vehicle_id) REFERENCES Vehicle(id)
    );
INSERT INTO Tracking VALUES(1, 1, 1, '45799', CURRENT_DATE, '12:45:24');
INSERT INTO Tracking VALUES(1, 1, 1, '45988', '2014-05-01', '12:45:24');
INSERT INTO Tracking VALUES(1, 1, 1, '45799', '2016-04-30', '19:31:51');
INSERT INTO Tracking VALUES(2, 1, 1, '45799', '2016-05-01', '02:51:46');
INSERT INTO Tracking VALUES(3, 1, 1, '45799', CURRENT_DATE,CURRENT_TIME);
INSERT INTO Tracking VALUES(2, 2, 1, '55849', CURRENT_DATE, CURRENT_TIME);
    
DROP TABLE Employee;
CREATE TABLE Employee(
	id INT NOT NULL AUTO_INCREMENT,
    fname VARCHAR(15) NOT NULL,
    lname VARCHAR(15) NOT NULL,
    ssn VARCHAR(9) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    street VARCHAR(30),
    city VARCHAR(15),
    zip VARCHAR(5),
    dob DATE NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE, 
    PRIMARY KEY(id)
    );
INSERT INTO Employee VALUES (1, 'Johnny', 'Appleseed', '548795235', '9587946515', '458 Main','Anchorage', '58965','1990-06-13', '2011-02-09', 0);
INSERT INTO Employee VALUES (2, 'Jane', 'Appleseed', '451849686', '8457962548', '458 Main','Anchorage', '58965','1992-11-13', '2011-02-12', 0);
INSERT INTO Employee VALUES (3, 'Mark', 'Ruffalo', '215874699', '5184965819', '239 Weshchester Way','Portlans', '58495','1975-01-01', '1998-12-08', 0);
INSERT INTO Employee VALUES (4, 'Mark', 'Ruffalo', '215874699', '5184965819', '239 Weshchester Way','Portlans', '58495','1975-01-01', '1998-12-08', '2014-05-05');

DROP TABLE Crew;
CREATE TABLE Crew(
	crew_id INT NOT NULL,
    empl_num INT NOT NULL,
	PRIMARY KEY (crew_id, empl_num),
    FOREIGN KEY (empl_num) REFERENCES Employee(id)
    );
INSERT INTO Crew VALUES(1, 1);
INSERT INTO Crew VALUES(1, 2);
INSERT INTO Crew VALUES(2,3);

DROP TABLE TransportInstance;
CREATE TABLE TransportInstance(
	id INT NOT NULL AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    dep_location VARCHAR(5) NOT NULL,
    arr_location VARCHAR(5) NOT NULL,
    estDep DATETIME NOT NULL,
    estArr DATETIME NOT NULL,
    actDep DATETIME,
    actArr DATETIME,
    weight INT(9),
    crew_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(vehicle_id) REFERENCES Vehicle(id),
    FOREIGN KEY(crew_id) REFERENCES Crew(crew_id)
    );
INSERT INTO TransportInstance VALUES(1,5,'44539', '99224',null, null, null, null, 90685, 1);
INSERT INTO TransportInstance VALUES(2,2,'45879', '45879',null, null, null, null, 2400, 2);

DROP TABLE Role;
CREATE TABLE Role(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    pay FLOAT(9,2),
    PRIMARY KEY(id)
    );
INSERT INTO Role VALUES (1, 'Driver', 45945);
INSERT INTO Role VALUES (2, 'Pilot', 149836);
  
DROP TABLE EmployeeRole;
CREATE TABLE EmployeeRole(
	id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (id, role_id),
    FOREIGN KEY(id) REFERENCES Employee(id),
    FOREIGN KEY(role_id) REFERENCES Role(id)
    );
INSERT INTO EmployeeRole VALUES	(1,1);
INSERT INTO EmployeeRole VALUES	(1,2);
INSERT INTO EmployeeRole VALUES	(2,1);
INSERT INTO EmployeeRole VALUES	(3,1);


-- View containing all undelievered packages
-- could be used further to narrow down this list to specific zip codes
DROP VIEW undeliveredPackages;
CREATE VIEW undeliveredPackages AS
	SELECT *
    FROM Package
    WHERE isLive = 1;

-- View containing all vehicles that are listed as operational
-- Could be narrowed down to only vehicles of a certain make adn model or even by location
DROP VIEW OperationalFleet;
CREATE VIEW OperationalFleet AS
	SELECT makeANDmodel,identifyingMark
    FROM Vehicle
    WHERE _status = 1;

DROP VIEW ActiveEmployees;
CREATE VIEW ActiveEmployees AS
	SELECT id, fname,  lname
    FROM Employee
    WHERE endDate = 0;
	

DROP TRIGGER after_Tracking_Insert;
-- Trigger: Every time the tracking table is updates with a new entry check to see if the packages current
-- zip code matched the destination and if so change the package.isLive to 0 to signify the package has been delivered
DELIMITER //
CREATE TRIGGER after_Tracking_Insert
	AFTER INSERT ON Tracking
    FOR EACH ROW
BEGIN
	DECLARE toZip VARCHAR(5) DEFAULT 0;
    SELECT rec_zip INTO toZip FROM Package WHERE id = NEW.pack_id;
    
    UPDATE Package 
    SET isLive = IF(rec_zip=NEW.checkin_zip, 0,1)
    WHERE id=NEW.pack_id;
    
    UPDATE Package 
    SET dateDelivered = IF(rec_zip = NEW.checkin_zip, CURRENT_DATE, 0)
    WHERE id = NEW.pack_id;
    
END //
DELIMITER ;


DROP EVENT deleteOLD;
-- Event: Every so often check to see what packages are a certain age and delete the old ones.  
DELIMITER //
CREATE EVENT deleteOld
	ON SCHEDULE EVERY 1 YEAR
    DO
    BEGIN
		DELETE FROM Tracking WHERE Tracking.checkin_date <= DATE_SUB(NOW(), INTERVAL 1 YEAR);
        DELETE FROM Package WHERE dateDelivered <= DATE_SUB(NOW(), INTERVAL 1 YEAR) AND dateDelivered != '0000-00-00';
	END//
DELIMITER ;


-- Takes in a customer id and returns all thir packages
CREATE PROCEDURE getAllCustomerPackages( IN CustomerID INT )
	SELECT * FROM Package WHERE sender_id = CustomerID;


-- Customer enters a package in to be shipped
-- Takes in the shipping customer ID, the recipients first name, last name, street address, city, and zip code, and 
-- package weight, height and length and creates a new package in the database
CREATE PROCEDURE createPackage (IN id INT, IN fname VARCHAR(15), IN lname VARCHAR(15), 
								IN street VARCHAR(30), IN city VARCHAR(15), IN zip VARCHAR(5), 
								IN _weight FLOAT(4,1), IN _height FLOAT(3,1), IN _length FLOAT(3,1))
	INSERT INTO Package (sendDate, sender_id, rec_fname, rec_lname, rec_street, rec_city, rec_zip, weight, height, length)
						VALUES (CURRENT_DATE, id, fname, lname, street, city, zip, _weight, _height, _length);
          
          
-- Package is scanned for the first time without container and vehicle information
-- Also used to log if a package is just scanned into a location ie. postoffice
-- Takes in the package ID, and current zip code and creates a new entry in the Tracking Table
DROP PROCEDURE locationScan;
CREATE PROCEDURE locationScan ( IN packID INT, IN zip VARCHAR(5) )
	INSERT INTO Tracking (pack_id, checkin_date, checkin_time, checkin_zip) VALUES (packID, CURRENT_DATE, CURRENT_TIME, zip);

-- Package is scanned into a container getting ready for transport
-- Takes in a container ID and the current Zip code and creates a new entry in the Tracking table
CREATE PROCEDURE containerScan (IN contID INT, IN zip VARCHAR(5) )
	INSERT INTO Tracking (cont_id, checkin_zip, chekin_date, checkin_time)
						VALUES (contID, zip, CURRENT_DATE, CURRENT_TIME);

-- Container full with packages is scanned onto some form of transportation
-- Takes in the container ID, vehicle ID, and current zip code and creates a new entry in Tracking
CREATE PROCEDURE vehicleScan (IN contID INT, IN vehicleID INT, IN zip VARCHAR(5))
INSERT INTO Tracking (cont_id, vehicle_id, checkin_zip, checkin_date, checkin_time)
						VALUES(contID, vehicleID, zip, CURRENT_DATE, CURRENT_TIME);


drop procedure anticipatedTravelInfo;
-- Way before the transportation leaves some infomration about projected times are entered
-- We are also assuming a crew has already been created for this trip
-- Takes in the vehicle ID, departure location, arrival location, extimated departure time, estimated arrival time, and the crew id
-- This inserts an entry in transportInstance with preliminary information
CREATE PROCEDURE anticipatedTravelInfo ( 	IN id INT, IN dep_loc VARCHAR(5), arr_loc VARCHAR(5), 
											IN _estDep DATETIME, IN _estArr DATETIME, IN crewID INT)
	INSERT INTO TransportInstance (vehicle_id, dep_location, arr_location, estDep, estArr, crew_id) 
								   VALUES(id, dep_loc, arr_loc, _estDep, _estArr, crewID);

-- When the vehicle is ready to leave more information is added
-- Since all the packages are assigned a container and each container is not assigned a vehicle at this point
-- this procedure also gathers up the weight of the vehicle and fills in that value in transportInstance
-- Takes in the transportID, and actual departure date and time.  
DELIMITER //
CREATE PROCEDURE predepartureVehicle ( IN transportID INT, IN actDEP DATETIME)
BEGIN
	DECLARE grossWeight int(9);
    
    SELECT SUM(weight) 
    FROM (	SELECT *
			FROM Package 
			LEFT OUTER JOIN Tracking 
			ON Package.id = Tracking.pack_id
			UNION
			SELECT *
			FROM Package
			RIGHT OUTER JOIN Tracking
			ON Package.id=Tracking.pack_id) t 
    WHERE id=transportID
    INTO grossWeight;
    
    UPDATE TransportInstance
    SET actDep=actDEP, weight = grossWeight
    WHERE id=transportID;
END//
DELIMITER ;
DROP PROCEDURE predepartureVehicle;

-- Once the vehicle reached it's destination
-- Takes in the transport Id, actual arrival date and time as well as the arrival zipcode
-- It updates the transportInstance table as well as sets teh Vehicle location to the new zip code
DELIMITER //
CREATE PROCEDURE arrivalVehicle (IN transportID INT, IN actARR DATETIME, IN arrZip VARCHAR(5))
BEGIN	
    UPDATE transportInstance SET actArr=actARR WHERE id=transportID;
    UPDATE Vehicle SET zip = arrZip WHERE id = (SELECT vehicle_id FROM transportInstance WHERE id = transportID);
END//
DELIMITER ;

CALL createPackage(1, 'Charles', 'Barkley', '494 S Peoria. Ave.', 'Miama', '12345', 43.2,12,9);
CALL locationScan(1, '32165');
CALL containerScan(1, '12345');
CALL anticipatedTravelInfo (1,'45799', '12345', '2016-11-11 12:12:12.', '2016-11-11 12:12:12.', 1);
CALL predepartureVehicle (1, '2016-11-11 12:12:12.', '45799');
CALL arrivalVehicle (1, '2016-11-11 12:12:12.', '33456');

-- Inserting into tables that are less frequently inserted into such as
-- Customer, Container, Vehicle, StatusLookup, Role, Employee, Employee Role, Crew all have to be done manually.
-- Inserting a package has it's own function and various functions take care of each step of a packages life cycle.  

