CREATE TABLE Physician (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  SSN INTEGER NOT NULL
); 

CREATE TABLE Department (
  DepartmentID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Head INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeID REFERENCES Physician(EmployeeID)
);

CREATE TABLE Affiliated_With (
  Physician INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeID_c REFERENCES Physician(EmployeeID),
  Department INTEGER NOT NULL
    CONSTRAINT fk_Department_DepartmentID REFERENCES Department(DepartmentID),
  PrimaryAffiliation varchar(1) NOT NULL,
  PRIMARY KEY(Physician, Department)
);


CREATE TABLE Proceduree (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Cost REAL NOT NULL
);

CREATE TABLE Trained_In (
  Physician INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeID_column REFERENCES Physician(EmployeeID),
  Treatment INTEGER NOT NULL
    CONSTRAINT fk_Procedure_Code REFERENCES Proceduree(Code),
  CertificationDate DATETIME NOT NULL,
  CertificationExpires DATETIME NOT NULL,
  PRIMARY KEY(Physician, Treatment)
);

CREATE TABLE Patient (
  SSN INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Address TEXT NOT NULL,
  Phone TEXT NOT NULL,
  InsuranceID INTEGER NOT NULL,
  PCP INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeID_columnn REFERENCES Physician(EmployeeID)
);

CREATE TABLE Nurse (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  Registered varchar(3) NOT NULL,
  SSN INTEGER NOT NULL
);

CREATE TABLE Appointment (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL
    CONSTRAINT fk_Patient_SSN REFERENCES Patient(SSN),
  PrepNurse INTEGER
    CONSTRAINT fk_Nurse_EmployeeID REFERENCES Nurse(EmployeeID),
  Physician INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeID_col REFERENCES Physician(EmployeeID),
  Start DATETIME NOT NULL,
  Endx DATETIME NOT NULL,
  ExaminationRoom TEXT NOT NULL
);

CREATE TABLE Medication (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Brand TEXT NOT NULL,
  Description TEXT NOT NULL
);

CREATE TABLE Prescribes (
  Physician INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeID_co REFERENCES Physician(EmployeeID),
  Patient INTEGER NOT NULL
    CONSTRAINT fk_Patient_SSNN REFERENCES Patient(SSN),
  Medication INTEGER NOT NULL
    CONSTRAINT fk_Medication_Code REFERENCES Medication(Code),
  Date DATETIME NOT NULL,
  Appointment INTEGER
    CONSTRAINT fk_Appointment_AppointmentID REFERENCES Appointment(AppointmentID),
  Dose TEXT NOT NULL,
  PRIMARY KEY(Physician, Patient, Medication, Date)
);

CREATE TABLE Block (
  Floor INTEGER NOT NULL,
  Code INTEGER NOT NULL,
  PRIMARY KEY(Floor, Code)
); 

CREATE TABLE Room (
  Number INTEGER PRIMARY KEY NOT NULL,
  Type TEXT NOT NULL,
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  Unavailable varchar(3) NOT NULL,
  FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block
);

CREATE TABLE On_Call (
  Nurse INTEGER NOT NULL
    CONSTRAINT fk_Nurse_EmployeeID_col REFERENCES Nurse(EmployeeID),
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  Start DATETIME NOT NULL,
  Endx DATETIME NOT NULL,
  PRIMARY KEY(Nurse, BlockFloor, BlockCode, Start, Endx),
  FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block
);

CREATE TABLE Stay (
  StayID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL
    CONSTRAINT fk_Patient_SSN_col REFERENCES Patient(SSN),
  Room INTEGER NOT NULL
    CONSTRAINT fk_Room_Number REFERENCES Room(Number),
  Start DATETIME NOT NULL,
  Endx DATETIME NOT NULL
);

CREATE TABLE Undergoes (
  Patient INTEGER NOT NULL
    CONSTRAINT fk_Patient_SSN_column REFERENCES Patient(SSN),
  Proceduree INTEGER NOT NULL
    CONSTRAINT fk_Procedure_Code_col REFERENCES Proceduree(Code),
  Stay INTEGER NOT NULL
    CONSTRAINT fk_Stay_StayID REFERENCES Stay(StayID),
  Date DATETIME NOT NULL,
  Physician INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeIDx REFERENCES Physician(EmployeeID),
  AssistingNurse INTEGER
    CONSTRAINT fk_Nurse_EmployeeID_xx REFERENCES Nurse(EmployeeID),
  PRIMARY KEY(Patient, Proceduree, Stay, Date)
);


INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Proceduree VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Proceduree VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Proceduree VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Proceduree VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Proceduree VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Proceduree VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Proceduree VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse',0,333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');


-------------------------------------------------------------------------------
-- write a SQL query to find those nurses who are yet to be registered.
-- Return all the fields of nurse table
select * from Nurse where Registered = 0 

-- write a SQL query to find the nurse who is the head of their department.
-- Return Nurse Name as "name", Position as "Position".
select Name,Position from Nurse where Position LIKE '%head%'

-- write a SQL query to find those physicians who are the head of the department.
-- Return Department name as "Department" and Physician name as "Physician"

select * from Department
select * from Physician

select Name as PhysicianName from Physician
where EmployeeID in (select Head from Department)

select Physician.Name as PhysicianName , Department.Name as DepartmentName
from Physician inner join Department
on Physician.EmployeeID = Department.Head


-- write a SQL query to count the number of patients who booked an appointment with 
-- at least one Physician.
-- Return count as "Number of patients taken at least one appointment"

select * from Patient
select * from Appointment


select count(distinct patient) as Number_of_patients from Appointment
select count(distinct patient) as Number_of_patients from Appointment
where Physician >= 1 

-- write a SQL query to find the floor and block where the room number 212 belongs.
-- Return block floor as "Floor" and block code as "Block". 

select BlockFloor as Floor , BlockCode as Block from Room
where Number = 212

-- write a SQL query to count the number available rooms.
-- Return count as "Number of available rooms"

select count(*) from Room where Unavailable = 0

-- write a SQL query to count the number of unavailable rooms.
-- Return count as "Number of unavailable rooms".


select count(*) from Room where Unavailable = 1

-- write a SQL query to find the physician and the departments they are affiliated with.
--Return Physician name as "Physician", and department name as "Department".

select * from Physician
select * from Department
select * from Affiliated_With

select Physician.Name as P_NAME, Department.Name as DepName
from Affiliated_With
inner Join Physician   on Physician.EmployeeID    = Affiliated_With.Physician
inner Join Department  on Department.DepartmentID = Affiliated_With.Department
where PrimaryAffiliation = 1


-------------------------------------------------------------------------------------
-- write a SQL query to find those physicians who have trained for special treatment.
-- Return Physician name as "Physician", treatment procedure name as "Treatment".

select * from Trained_In
select * from Physician

select Physician.Name as P_Name , Proceduree.Name as Treatment
from Trained_In
inner Join Physician
on Physician.EmployeeID  = Trained_In.Physician
inner join Proceduree
on Proceduree.Code = Trained_In.Treatment 

-- write a SQL query to find those physicians who are yet to be affiliated.
-- Return Physician name as "Physician", Position, and department as "Department".

SELECT p.name AS "Physician",
       p.position,
       d.name AS "Department"
FROM physician p
JOIN affiliated_with a ON a.physician=p.employeeid
JOIN department d ON a.department=d.departmentid
WHERE primaryaffiliation=0;


-- write a SQL query to find those physicians who are not a specialized physician.
-- Return Physician name as "Physician", position as "Designation"

SELECT p.name AS "Physician",
       p.position "Designation"
FROM physician p
LEFT JOIN trained_in t ON p.employeeid=t.physician
WHERE t.treatment IS NULL
ORDER BY employeeid;


select Name,position from Physician
where EmployeeID not in (select Trained_In.Physician from Trained_In)


--write a SQL query to find the patients with their physicians by whom they got 
--their preliminary treatment.
--Return Patient name as "Patient", address as "Address" and 
--Physician name as "Physician".

select * from Patient
select * from Physician

select patient.Name as Patient , Physician.Name from Patient
inner join Physician
on Patient.PCP = Physician.EmployeeID


-- write a SQL query to find the patients and the number of physicians they have taken appointment.
-- Return Patient name as "Patient", 
-- number of Physicians as "Appointment for No. of Physicians"


SELECT p.name ,
       count(t.patient) 
FROM appointment t
JOIN patient p ON t.patient=p.ssn
GROUP BY p.name
HAVING count(t.patient)>=1;

----------------------------------------------------------------
--write a SQL query to count number 
--of unique patients who got an appointment for examination room ‘C’.
--Return unique patients as “No. of patients got appointment for room C”


select * from Appointment

SELECT count(DISTINCT patient)
FROM appointment
WHERE convert(varchar(1) , examinationroom )='C';

--write a SQL query to find the name of the patients and the number of the room where 
--they have to go for their treatment.
--Return patient name as “Patient”, examination room as "Room No.”, 
--and starting date time as Date "Date and Time of appointment"

select Patient.Name as PatientName , 
       --count(convert(varchar(1) , isnull(ExaminationRoom,0))) as RoomNo,
	   Start as DateAndTimeAppointment,
	   ExaminationRoom as RoomNo
from Appointment inner join Patient
on Patient.SSN = Appointment.Patient
group by Patient.Name,Start


--write a SQL query to find the name of the nurses and the room scheduled,
--where they will assist the physicians.
--Return Nurse Name as “Name of the Nurse” and examination room as “Room No.”

select * from Nurse
select * from Appointment

select Nurse.Name as Name , Appointment.ExaminationRoom
from Nurse inner Join Appointment
on Appointment.PrepNurse = Nurse.EmployeeID

SELECT t.name AS "Name of the patient",
       n.name AS "Name of the Nurse assisting the physician",
       p.name AS "Name of the physician",
       a.examinationroom AS "Room No.",
       a.start
FROM patient t
JOIN appointment a ON a.patient=t.ssn
JOIN nurse n ON a.prepnurse=n.employeeid
JOIN physician p ON a.physician=p.employeeid
WHERE start='2008-04-25 10:00:00';

--write a SQL query to find those patients and their physicians who do not require any 
--assistance of a nurse.
--Return Name of the patient as "Name of the patient", 
--Name of the Physician as "Name of the physician" and examination room as "Room No.".

SELECT t.name AS "Name of the patient",
       p.name AS "Name of the physician",
       a.examinationroom AS "Room No."
FROM patient t
JOIN appointment a ON a.patient=t.ssn
JOIN physician p ON a.physician=p.employeeid
WHERE a.prepnurse IS NULL;


--write a SQL query to find the patients and their treating physicians and medication.
--Return Patient name as "Patient", Physician name as "Physician", 
--Medication name as "Medication". 

SELECT t.name AS "Patient",
       p.name AS "Physician",
       m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code;


------------------------------------------------------------------------------
--find those patients who did not take any appointment.
--Return Patient name as "Patient",
--Physician name as "Physician" and Medication name as "Medication".
SELECT t.name AS "Patient",
       p.name AS "Physician",
       m.name AS "Medication"
FROM patient t
JOIN prescribes s ON s.patient=t.ssn
JOIN physician p ON s.physician=p.employeeid
JOIN medication m ON s.medication=m.code
WHERE s.appointment IS NULL;


----------------------------------------------------------------------------------
--count the number of available rooms in each block. Sort the result-set on 
--ID of the block. 
--Return ID of the block as "Block", count number of available rooms 
--as "Number of available rooms"

select count(*) as Number_of_Rooms,
       BlockCode as Block
from Room
where Unavailable = 0
group by BlockCode
order by Block

--write a SQL query to count the number of available rooms for each floor in each block.
--Sort the result-set on floor ID, ID of the block.
--Return the floor ID as "Floor", ID of the block as "Block", 
--and number of available rooms as "Number of available rooms"

select count(*) as Number_of_Rooms,
       BlockCode  as Block,
	   BlockFloor as Floor
from Room
where Unavailable = 0
group by BlockCode,BlockFloor
order by Floor,Block

--find the floor where the maximum numbers of rooms are available.
--Return floor ID as "Floor", count "Number of available rooms"

SELECT blockfloor as "Floor",
count(*) AS  "Number of available rooms"
FROM room
WHERE unavailable=0
GROUP BY blockfloor
HAVING count(*) =
  (SELECT max(zz) AS highest_total
   FROM
( select  
count(*) AS zz
      FROM room
      WHERE unavailable=0
      GROUP BY blockfloor ) AS t );

---------------------------------------------------------------------------------
--write a SQL query to find those patients whose primary care a physician who is not 
--the head of any department takes. Return Patient name as “Patient”, 
--Physician Name as “Primary care Physician”.

select * from Patient
select * from Physician
select * from Department

SELECT pt.name AS "Patient",
       p.name AS "Primary care Physician"
FROM patient pt
JOIN physician p ON pt.pcp=p.employeeid
WHERE p.EmployeeID NOT IN
    (SELECT head
     FROM department);
-------------------------------------------------------------------------------------------
-- find the name of the patients, their block, floor, 
-- and room number where they admitted.
select name as Name_Patient ,
       Stay.Room,
       Room.BlockFloor As Floor , 
	   Room.BlockCode  AS Block
from Patient inner join Stay
on Patient.SSN = Stay.Patient
inner join Room
ON Stay.Room = Room.Number

-----------------------------------------------------------------------------
--write a SQL query to find the nurses and the block 
--where they are booked for attending the patients on call.
--Return Nurse Name as “Nurse”, Block code as "Block".

select Nurse.Name as Name,
       On_Call.BlockCode as Block 
FROM Nurse
inner Join On_Call
on On_Call.Nurse = Nurse.EmployeeID

---------------------------------------------------------------------------
--From the following tables, write a SQL query to get
--a) name of the patient,
--b) name of the physician who is treating him or her,
--c) name of the nurse who is attending him or her,
--d) which treatement is going on to the patient,
--e) the date of release,
--f) in which room the patient has admitted and which floor 
--and block the room belongs to respectively.

select Patient.Name   as PatientName,
       Physician.Name as PhysicianName,
	   Nurse.Name     as NurseName,
	   Proceduree.name as "Treatement going on",
	   Stay.Endx as DateOfRelease,
	   Stay.Room as Number_of_room,
	   Room.BlockFloor AS Floor,
	   Room.BlockCode  AS Block

from Undergoes inner join Patient
on Undergoes.Patient = Patient.SSN
inner Join Physician
on Physician.EmployeeID = Undergoes.Physician
inner join Nurse
on Nurse.EmployeeID = Undergoes.AssistingNurse
inner join Stay
on Stay.Patient = Patient.SSN
inner Join Room
on Room.Number = Stay.Room
inner join Proceduree
on Proceduree.Code = Undergoes.Proceduree
