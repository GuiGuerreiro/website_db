--------------------
--Database Loading--
--------------------


--PEOPLE
--(name , address , phone , taxid)
INSERT INTO person VALUES ('Liam Neeson', 'Main street Avenue,n12,Afghanistan', '911111111', '123456789');
INSERT INTO person VALUES ('Oliver Torres', 'Road Copa Cabana,n4,2Dto,Bangladesh', '920420420', '345678912');
INSERT INTO person VALUES ('William Shakespear', 'Mozambique', '245789456', '456789123');
INSERT INTO person VALUES ('Elijah Ahmed', 'Primary Road, Mozambique', '963852741', '567891234');
INSERT INTO person VALUES ('James Arthur', 'Road Vanuaeu,n68,Vanuatu', '985632147', '678912345');
INSERT INTO person VALUES ('Benjamin Franklin', 'Lagos, Portugal', '974562318', '789123456');
INSERT INTO person VALUES ('Lucas Neto', 'Road Baku Name,n44,Uganda', '951357468', '891235678');
INSERT INTO person VALUES ('Mason Mars', 'Huelva', '978546213', '912345678');
INSERT INTO person VALUES ('Olivia Palito', 'Plaza de la Villa, Spain', '999888777', '263692884');
INSERT INTO person VALUES ('Emma Stone', 'La rue Soufflot, Bordeaux', '960698785', '141715341');
INSERT INTO person VALUES ('Ava Marilia', 'Botique quarter, Huelva', '984123658', '252525245');
INSERT INTO person VALUES ('Sophia Breyner', 'First Avenue, Dublin', '245784512', '554554785');
INSERT INTO person VALUES ('Isabella Sanchez', 'Second Avenue,Dublin', '978202020', '420420694');
INSERT INTO person VALUES ('Elijah Ahmed', 'Avenida Alinssa, Puerto Rico', '963833341', '567891238');

--SUPERVISORS
--(name , address)
INSERT INTO supervisor VALUES ('Isabella Sanchez', 'Second Avenue,Dublin');
INSERT INTO supervisor VALUES ('Sophia Breyner', 'First Avenue, Dublin');
INSERT INTO supervisor VALUES ('Ava Marilia', 'Botique quarter, Huelva');
INSERT INTO supervisor VALUES ('Emma Stone', 'La rue Soufflot, Bordeaux');
INSERT INTO supervisor VALUES ('Olivia Palito', 'Plaza de la Villa, Spain');

--ANALYSTS
--(name , address)
INSERT INTO analyst VALUES ('Lucas Neto', 'Road Baku Name,n44,Uganda');
INSERT INTO analyst VALUES ('Benjamin Franklin', 'Lagos, Portugal');
INSERT INTO analyst VALUES ('James Arthur', 'Road Vanuaeu,n68,Vanuatu');
INSERT INTO analyst VALUES ('William Shakespear', 'Mozambique');
INSERT INTO analyst VALUES ('Oliver Torres', 'Road Copa Cabana,n4,2Dto,Bangladesh');
INSERT INTO analyst VALUES ('Elijah Ahmed', 'Avenida Alinssa, Puerto Rico');

--BOTH ANALYSTS AND SUPERVISORS
--(name , address)
INSERT INTO analyst VALUES ('Liam Neeson', 'Main street Avenue,n12,Afghanistan');
INSERT INTO supervisor VALUES ('Liam Neeson', 'Main street Avenue,n12,Afghanistan');
INSERT INTO analyst VALUES ('Mason Mars', 'Huelva');
INSERT INTO supervisor VALUES ('Mason Mars', 'Huelva');
INSERT INTO analyst VALUES ('Elijah Ahmed', 'Primary Road, Mozambique');
INSERT INTO supervisor VALUES ('Elijah Ahmed', 'Primary Road, Mozambique');


/*--------------------------------------------------------------------------------------------------------------------*/

--SUBSTATIONS
--(gpslat , gpslong , locality , sname , saddress)
INSERT INTO substation VALUES ('24.07196', '-16.39896', 'Creek', 'Isabella Sanchez', 'Second Avenue,Dublin');
INSERT INTO substation VALUES ('27.07196', '-50.39896', 'West Side', 'Isabella Sanchez', 'Second Avenue,Dublin');
INSERT INTO substation VALUES ('10.07196', '-78.39896', 'Uptown', 'Isabella Sanchez', 'Second Avenue,Dublin');
INSERT INTO substation VALUES ('22.02345', '14.02365', 'Downtown', 'Ava Marilia', 'Botique quarter, Huelva');
INSERT INTO substation VALUES ('89.02345', '51.02365', 'Eastside', 'Emma Stone', 'La rue Soufflot, Bordeaux');
INSERT INTO substation VALUES ('09.02345', '01.02365', 'Rural', 'Emma Stone', 'La rue Soufflot, Bordeaux');
INSERT INTO substation VALUES ('29.02345', '5.02365', 'City', 'Ava Marilia', 'Botique quarter, Huelva');
INSERT INTO substation VALUES ('39.02345', '6.02365', 'City', 'Ava Marilia', 'Botique quarter, Huelva'); /*<- Repeated locality name, supervised by the same person*/
INSERT INTO substation VALUES ('21.02345', '2.02365', 'City', 'Emma Stone', 'La rue Soufflot, Bordeaux'); /*<- Repeated locality name, supervised by diferent person*/
INSERT INTO substation VALUES ('24.07196', '-12.39896', 'River', 'Sophia Breyner', 'First Avenue, Dublin');
INSERT INTO substation VALUES ('14.07196', '62.39896', 'Hospital', 'Liam Neeson', 'Main street Avenue,n12,Afghanistan');
INSERT INTO substation VALUES ('74.1234', '-89.8989', 'School', 'Liam Neeson', 'Main street Avenue,n12,Afghanistan');
INSERT INTO substation VALUES ('88.2323', '77.2020', 'Neighbourhood', 'Mason Mars', 'Huelva');
INSERT INTO substation VALUES ('85.2323', '77.2020', 'Suburbs', 'Mason Mars', 'Huelva');
INSERT INTO substation VALUES ('8.2323', '7.2020', 'Slums', 'Elijah Ahmed', 'Primary Road, Mozambique');

/*---------------------------------------*/
-----------------
--GRID ELEMENTS--
-----------------

--LINES--
--(id)
INSERT INTO element VALUES ('L-101');
INSERT INTO element VALUES ('L-102');
INSERT INTO element VALUES ('L-103');
INSERT INTO element VALUES ('L-104');

--BUS-BARS--
--(id)
INSERT INTO element VALUES ('B-789');
INSERT INTO element VALUES ('B-888');
INSERT INTO element VALUES ('B-901');
INSERT INTO element VALUES ('B-333');
INSERT INTO element VALUES ('B-334');
INSERT INTO element VALUES ('B-335');
INSERT INTO element VALUES ('B-336');
INSERT INTO element VALUES ('B-337');

--TRANSFORMERS--
--(id)
INSERT INTO element VALUES ('T-1001');
INSERT INTO element VALUES ('T-1011');
INSERT INTO element VALUES ('T-1500');
INSERT INTO element VALUES ('T-3000');
INSERT INTO element VALUES ('T-750');
INSERT INTO element VALUES ('T-2000');
INSERT INTO element VALUES ('T-5000');
INSERT INTO element VALUES ('T-8000');
INSERT INTO element VALUES ('T-5001');
INSERT INTO element VALUES ('T-5002');
INSERT INTO element VALUES ('T-5003');
INSERT INTO element VALUES ('T-5004');
INSERT INTO element VALUES ('T-5005');
INSERT INTO element VALUES ('T-5006');


------------------------------------
--SPECIALIZATIONS OF GRID ELEMENTS--
------------------------------------
--BUS-BAR
--(id , voltage)
INSERT INTO busbar VALUES ('B-789', '250');
INSERT INTO busbar VALUES ('B-888', '500');
INSERT INTO busbar VALUES ('B-901', '350');
INSERT INTO busbar VALUES ('B-333', '550');
INSERT INTO busbar VALUES ('B-334', '250');
INSERT INTO busbar VALUES ('B-335', '200');
INSERT INTO busbar VALUES ('B-336', '100');
INSERT INTO busbar VALUES ('B-337', '100');

--Lines
--(id , impedance , pbbid , sbbid)
INSERT INTO line VALUES ('L-101', '500', 'B-789', 'B-888');
INSERT INTO line VALUES ('L-102', '500', 'B-901', 'B-333');
INSERT INTO line VALUES ('L-103', '100', 'B-789', 'B-901');
INSERT INTO line VALUES ('L-104', '100', 'B-789', 'B-333');


--NOT USED!!!
--LINE_CONNECTION - Table for the association of 2 bus-bars and a line
--INSERT INTO line_connection VALUES ('B-789', 'B-888', 'L-101');
--INSERT INTO line_connection VALUES ('B-901', 'B-333', 'L-102');
--INSERT INTO line_connection VALUES ('B-789', 'B-901', 'L-103');
--INSERT INTO line_connection VALUES ('B-789', 'B-333', 'L-104');

--TRANSFORMER
--(id , pv , sv , gpslat , gpslong , pbbid , sbbid)
INSERT INTO transformer VALUES ('T-1001', '250', '500', '24.07196', '-16.39896', 'B-789', 'B-888');
INSERT INTO transformer VALUES ('T-1011', '550', '350', '24.07196', '-16.39896', 'B-333', 'B-901');
INSERT INTO transformer VALUES ('T-1500', '550', '500', '27.07196', '-50.39896', 'B-333', 'B-888');
INSERT INTO transformer VALUES ('T-3000', '250', '350', '10.07196', '-78.39896', 'B-789', 'B-901');
INSERT INTO transformer VALUES ('T-750', '250', '550', '22.02345', '14.02365', 'B-789', 'B-333');
INSERT INTO transformer VALUES ('T-2000', '350', '500', '8.2323', '7.2020', 'B-901', 'B-888');
INSERT INTO transformer VALUES ('T-5000', '500', '250', '21.02345', '2.02365', 'B-888', 'B-789');
INSERT INTO transformer VALUES ('T-8000', '350', '250', '8.2323', '7.2020', 'B-901', 'B-789');
INSERT INTO transformer VALUES ('T-5001', '200', '100', '24.07196', '-16.39896', 'B-335', 'B-337');
INSERT INTO transformer VALUES ('T-5002', '250', '250', '10.07196', '-78.39896', 'B-334', 'B-789');
INSERT INTO transformer VALUES ('T-5003', '100', '500', '89.02345', '51.02365', 'B-336', 'B-888');
INSERT INTO transformer VALUES ('T-5004', '500', '100', '89.02345', '51.02365', 'B-888', 'B-336');
INSERT INTO transformer VALUES ('T-5005', '250', '250', '09.02345', '01.02365', 'B-789', 'B-334');
INSERT INTO transformer VALUES ('T-5006', '100', '200', '09.02345', '01.02365', 'B-337','B-335');

------------
--INCIDENT--
------------

--Line incidents
--(instant , id , description , severity)
INSERT INTO incident VALUES ('2008-11-11 13:23:44','L-101','Weather destroyed the line','5');
INSERT INTO incident VALUES ('1977-01-31 22:03:12','L-103','Bird Collision with power line','10');

--Specialization for Line incidents
--(instant , id , point)
INSERT INTO lineincident VALUES ('2008-11-11 13:23:44','L-101','232.25');
INSERT INTO lineincident VALUES ('1977-1-31 22:03:12','L-103','1.92');


--Bus-Bar incidents
--(instant , id , description , severity)
INSERT INTO incident VALUES ('2010-10-11 9:13:44','B-789','Broken bus bar','10');
INSERT INTO incident VALUES ('1929-05-05 13:23:44','B-789','maintenance','20');
INSERT INTO incident VALUES ('1955-06-05 15:11:33','B-789','maintenance','25');
INSERT INTO incident VALUES ('1979-07-05 13:23:44','B-888','maintenance','5');
INSERT INTO incident VALUES ('1900-05-05 13:23:44','B-888','Voltage Variations','8');
INSERT INTO incident VALUES ('2020-09-04 13:23:44','B-333','Broken weld','10');

--Transformer incidents
--(instant , id , description , severity)
INSERT INTO incident VALUES ('2017-11-17 13:23:44','T-8000','As a consequence of a Blackout, undefined behaviour of the element','3');
INSERT INTO incident VALUES ('2019-03-21 13:23:44','T-2000','Missing the wel in the bus bar connection number 2','5');
INSERT INTO incident VALUES ('2019-03-21 13:23:44','T-8000','As a consequence of a Blackout, undefined behaviour of the element','3');
INSERT INTO incident VALUES ('1999-01-23 13:23:44','T-1001','A person broke a transformer connection','3');

----------------------Analysis---------------------------------
--Lines Analysis--
--(instant , id , report , name , address)
INSERT INTO analyses VALUES('2008-11-11 13:23:44', 'L-101', 'Due to weather causes, the line blew up, shutting down the' ||
                                'electricity in the city', 'Liam Neeson', 'Main street Avenue,n12,Afghanistan');

INSERT INTO analyses VALUES('1977-1-31 22:03:12', 'L-103', 'A Bird collided with the power line while migrating' ||
                            'for a better place due to the present season.The damages were minimal and the company cost' ||
                            'for the problem solving was 20 dollars', 'Elijah Ahmed', 'Primary Road, Mozambique');

--Bus bars Analysis--
--(instant , id , report , name , address)
INSERT INTO analyses VALUES('1929-05-05 13:23:44', 'B-789', 'There were some errors while reading the voltage values so the' ||
                             'company decided to execute a maintenance of the element. There was a problem in the'  ||
                             'voltage counter, which was repaired immediately.', 'Elijah Ahmed', 'Avenida Alinssa, Puerto Rico');

INSERT INTO analyses VALUES('2010-10-11 9:13:44', 'B-789', 'The bus bar broke because of the physical tension applied' ||
                            'The procedures have been followed and the problem was fixed, costing 100 dollars to the company ',
                            'Elijah Ahmed', 'Avenida Alinssa, Puerto Rico');

INSERT INTO analyses VALUES('1955-06-05 15:11:33', 'B-789', 'The bus bar broke because of the physical tension applied' ||
                            'The procedures have been followed and the problem was fixed, costing 150 dollars to the company ',
                            'Elijah Ahmed', 'Avenida Alinssa, Puerto Rico');

INSERT INTO analyses VALUES('2020-09-04 13:23:44', 'B-333', 'The high voltages registered made the heat released to merge the well.' ||
                            'Fortunately it was fixed on time.', 'Oliver Torres', 'Road Copa Cabana,n4,2Dto,Bangladesh');

--TRANSFORMER ANALYSIS
--(instant , id , report , name , address)
INSERT INTO analyses VALUES('1999-01-23 13:23:44', 'T-1001', 'A masked person entered the substation and sabotaged the transformer,' ||
                            'breaking its bus bar connection related to the secondary voltage. It took a while to solve' ||
                            'and find the person, but justice has been made and now the transformer is fixed. ',
                            'Liam Neeson', 'Main street Avenue,n12,Afghanistan');

INSERT INTO analyses VALUES('2019-03-21 13:23:44', 'T-8000', 'A blackout happened and it was suspected the transformer could be compromised.' ||
                            'It was noticed an undefined behaviour. An electrical engineer quickly solved the problem: it was the conductance!' ||
                            'The transformer was fixed for 300 dollars',
                            'Liam Neeson', 'Main street Avenue,n12,Afghanistan');
