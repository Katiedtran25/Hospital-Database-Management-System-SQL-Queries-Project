#1 Find a nurse who is yet to be registered
select *from nurse
where registered ='f';

#2 Find the name of the nurse who are the head of their department.
select *from nurse
where position='Head Nurse';

#3Find the name of the physicians who are the head of each department
select p.name,d.name from physician p
inner join department d
on p.employeeid = d.head;

#4 Count the number of patients who taken appointment with at least one physician
select count(distinct(patient)) from appointment;

#5 Find the floor and block where the room number 212 belongs to
select blockfloor,blockcode,roomnumber
from room
where roomnumber=212;

#6 Count the number available rooms
select count(unavailable)
from room
where unavailable='f';

#7 Count the number of unavailable rooms
with avlbl as
(select count(unavailable)
from room
where unavailable='t')select *from avlbl;

#8 Obtain the name of the physician and the departments they are affiliated with
select employeeid,department,p.name as physician_name,d.name as department_name
from physician p
inner join affiliated_with aw
on p.employeeid = aw.physician
inner join department d
on aw.department = d.department_id
where primaryaffiliation='t';

#9 Obtain the name of the physicians who are trained for a special treatement

select employeeid,name
from physician
where employeeid in (select distinct physician
                     from trained_in);
                     
#using join

select p.employeeid,p.name,pr.code,pr.name as name_of_procedure
from physician p
inner join trained_in ti
on p.employeeid=ti.physician
inner join procedures pr
on ti.treatment=pr.code;

#10 Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated

select p.name,d.name from physician p
inner join affiliated_with aw
on p.employeeid = aw.physician
inner join department d
on aw.department = d.department_id
where primaryaffiliation='f';



#11 Write a query in SQL to obtain the name of the physicians who are not a specialized physician


select name as not_specialized_physicians
from physician
where employeeid not in(select distinct physician
                        from trained_in);



#12 Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement

select p.name as patient_name,ph.name as phy_who_did_pri_treatment
from patient p
inner join physician ph
on p.pcp = ph.employeeid;

#13 Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment

select p.name as patient_name,count(distinct physician) as no_of_phy_tkn_apmnt_frm
from patient p
inner join appointment a
on p.ssn = a.patient
group by p.name;
                    
#14 Write a query in SQL to count number of unique patients who got an appointment for examination room C.    

select examinationroom,count(distinct patient)
from appointment
group by examinationroom
having examinationroom='C';

#15 Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment

#select p.name as patient_name,s.room as roomnumber
#from patient p
#inner join stay s
#on p.ssn = s.patient
#inner join room r
#on s.room = r.roomnumber;


#16 Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.

#select n.employeeid as nurse_id,n.name as nurse_name,room as room_no
#from nurse n
#inner join undergoes u
#on n.employeeid = u.assistingnurse
#inner join stay s
#on u.stay = s.stayid;

#17 Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no

select p.name as patient_name,
       ph.name as physician_name,
       n.name as nurse_name,
       a.examinationroom
from patient p
left outer join appointment a
on p.ssn = a.patient
left outer join physician ph
on a.physician = ph.employeeid
left outer join nurse n
on a.prepnurse = n.employeeid
where start_dt = '25-04-08';


#18 Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse

#select p.name as patient_name,ph.name as physician_name
#from patient p
#inner join undergoes u
#on p.ssn = u.patient
#inner join physician ph
#on u.physician = ph.employeeid
#where assistingnurse is null;



#19 Write a query in SQL to find the name of the patients, their treating physicians and medication

select p.ssn,p.name as patient_name,ph.name as treating_phy_name,m.name as medicine_name
from patient p
inner join undergoes u
on p.ssn = u.patient
inner join prescribes pr
on u.patient = pr.patient
inner join medication m
on pr.medication = m.code
inner join physician ph
on pr.physician = ph.employeeid;


#20 Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication

select p.ssn,
       p.name as patient_name,
       ph.name as physician_name,
       m.name as medicine_name
from patient p
left outer join appointment a
on p.ssn = a.patient
left outer join prescribes pr
on a.patient = pr.patient
left outer join physician ph
on pr.physician = ph.employeeid
left outer join medication m
on pr.medication = m.code
;



