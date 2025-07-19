# Hospital-Database-Management-System-MySQL-Queries-Project
Hospital Database Management System MySQL queries Project

The final project topic is hospital management system, which is being created
by myself. The schema and the data were inserted into the database with many
tables of data. The database to be developed will consist of the following tables:
Nurse, Department, Physician, Patient, Room, Prescription, Appointment, Procedure, Trained-in, affiliated with, Medication, Stay, on-call, Undergoes. The
goal is to get real-time experience dealing with the kinds of challenges healthcare
workers can find in a real hospital, like keeping track of patients and appointments.

The system is used strictly by employees of hospital only. There are several locations of hospital and many relational tables of data. It creates a systematic and standardized record of Patients, Doctors, and Rooms, which can
be controlled only by the administrator. The system should be able to query
information about room and patient assignments for each employee of a department. 

The database should be able to store patient information for use by
employees such as Patient ID, Name, Location, Room number, Assigned staff,
Prescriptions, and Invoices to generate reports. etc. All patients and doctors
will have a unique and will be related in the database depending on the ongoing
treatments. Also, There are separate modules for hospital admission, patients’
discharge summary, duties of nurses and ward boys, medical stores, etc.

ER Diagram
Relational schema:
Block ( blockcode, blockfloor)
Nurse (employeeid, name, position, registered, ssn)
Physician (employeeid, name, position, ssn)
Department (departmentid, name, head)
Appointment (appointmentid, patient, prepnurse, Physician, start-dt, enddt, examinationroom)
Room (roomnumber, roomtype, blockfloor, blockcode, unavailable)
Procedures (code, name, cost)

Traine-in (physician, treatment, certificationdate, certificationexpires)
Affiliated-with (physician, department, primaryaffiliation)
Patient(ssn,name,address,phone,insuranceid,pcp)
Prescribes (physician, patient, medication, date, appointment, dose)
MEDICATION (code, name, brand, description)
STAY(stayid,patient-room,start-time,end-time)
On-callnurse,blockkfloor,blockcode,oncall,ONCALLEND)
Undergoes(patient, procedures, stay, date, physicianassit, ingnurse)

Data Analysis
For our hospital database, the staff are the users and below are some of the
tasks that will be performed by the staff of the hospital:

Patient/Nurse registration Patient/Nurse check out Generation of patient/Nurse information Availability of beds Storage of mandatory patient
information U pdating patient information N ame of the physicians/Nurses
with department/ patients to be affiliated, etc

SQL queries:


(−) Write a query in SQL to find a nurse who is yet to be registered
select *from nurse where registered =’f ’;

(−) Write a query in SQL to find the name of the nurse who are
the head of their department:
select *from nurse where position=’Head Nurse’;

(−) Write a query in SQL to find the name of the physicians who
are the head of each department
select p.name,d.name from physician p inner join department d on
p.employeeid = d.head;

(−) Write a query in SQL to count the number of patients who
taken appointment with at least one physician
select count(distinct(patient)) from appointment;

(−) Write a query in SQL to find the floor and block where the
room number 212 belongs to
select blockfloor,blockcode,roomnumber from room where roomnumber=212;

(−) Write a query in SQL to count the number available rooms
select count(unavailable) from room where unavailable=’f ’;

(−) Write a query in SQL to count the number of unavailable rooms
with avlbl as (select count(unavailable) from room where unavailable=’t’) select *from avlbl;

(−) Write a query in SQL to obtain the name of the physician and
the departments they are affiliated with
select employeeid,department,p.name as physician name,d.name
as department name from physician p inner join affiliated with aw on
p.employeeid = aw.physician inner join department d on aw.department
= d.department id where primaryaffiliation=’t’;

(−) Write a query in SQL to obtain the name of the physicians
who are trained for a special treatment
select employeeid,name from physician where employeeid in (select
distinct physician from trained in);

(−) Write a query in SQL to obtain the name of the physicians
who are trained for a special treatment using
select p.employeeid,p.name,pr.code,pr.name as name of procedure
from physician p inner join trained in ti on p.employeeid=ti.physician
inner join procedures pr on ti.treatment=pr.code;

(−) Write a query in SQL to obtain the name of the physicians
with department who are yet to be affiliated
select p.name,d.name from physician p inner join affiliated with aw
on p.employeeid = aw.physician inner join department d on aw.department
= d.department id where primaryaffiliation=’f ’;

(−) Write a query in SQL to obtain the name of the physicians
who are not a specialized physician
select name as not specialized physicians from physician where
employeeid not in(select distinct physician from trained in);

(−) Write a query in SQL to obtain the name of the patients with
their physicians by whom they got their preliminary treatement
select p.name as patient name,ph.name as phy who did pri treatment
from patient p inner join physician ph on p.pcp = ph.employeeid;

(−) Write a query in SQL to find the name of the patients and the
number of physicians they have taken appointment
select p.name as patient name,count(distinct physician) as no of phy tkn apmnt frm
from patient p inner join appointment a on p.ssn = a.patient group
by p.name;

(−) Write a query in SQL to count number of unique patients who
got an appointment for examination room C.
select examinationroom,count(distinct patient) from appointment
group by examinationroom having examinationroom=’C’;

(−) Write a query in SQL to find the name of the patients who
taken the appointment on the 25th of April at 10 am, and also display
their physician, assisting nurses and room no
select p.name as patient name, ph.name as physician name, n.name
as nurse name, a.examinationroom from patient p left outer join appointment a on p.ssn = a.patient left outer join physician ph on
a.physician = ph.employeeid left outer join nurse n on a.prepnurse =
n.employeeid where start dt = ’25 04 08’;


(−) Write a query in SQL to find the name of the patients, their
treating physicians and medication
select p.ssn,p.name as patient name,ph.name as treating phy name,m.name
as medicine name from patient p inner join undergoes u on p.ssn =
u.patient inner join prescribes pr on u.patient = pr.patient inner join
medication m on pr.medication = m.code inner join physician ph on
pr.physician = ph.employeeid;

(−) Write a query in SQL to find the name of the patients who
taken an advanced appointment, and also display their physicians and
medication 
select p.ssn, p.name as patient name, ph.name as physician name,
m.name as medicine name from patient p left outer join appointment
a on p.ssn = a.patient left outer join prescribes pr on a.patient =
pr.patient left outer join physician ph on pr.physician = ph.employeeid
left outer join medication m on pr.medication = m.code ;

