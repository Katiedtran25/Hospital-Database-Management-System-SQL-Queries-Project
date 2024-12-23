#22 Write a query in SQL to count the number of available rooms in each block

select blockcode as block_no,count(*) as no_of_available_rooms
from room
where unavailable='f'
group by blockcode;


#23 Write a query in SQL to count the number of available rooms in each floor

select blockfloor as floor_no,count(*) as no_of_available_rooms
from room
where unavailable='f'
group by blockfloor;




#24 Write a query in SQL to count the number of available rooms for each block in each floor

select blockcode,blockfloor,count(*) as no_of_available_rooms_ineachblockineachfloor
from room
where unavailable='f'
group by blockcode,blockfloor
order by 1,2;

#25 Write a query in SQL to count the number of unavailable rooms for each block in each floor

select blockcode,blockfloor,count(*) no_of_available_rooms_ineachblockineachfloor
from room
where unavailable='t'
group by blockcode,blockfloor
order by 1,2;

#26 Write a query in SQL to find out the floor where the maximum no of rooms are available

select blockfloor,count(unavailable) as available_room
from room
where unavailable='f'
group by blockfloor
order by count(unavailable) desc;
#fetch first row only;

#27 Write a query in SQL to find out the floor where the minimum no of rooms are available

select blockfloor,count(unavailable)
from room
where unavailable = 'f'
group by blockfloor
having count(unavailable)=(select min(count(unavailable))
                           from room
                           where unavailable ='f'
                           group by blockfloor)
                           order by blockfloor;
                           

#28 Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted

select ssn as patient_id,
       p.name as patient_name,
       blockfloor,
       blockfloor,
       roomnumber
from patient p
inner join stay s
on p.ssn = s.patient
inner join room r
on s.room = r.roomnumber;


#29 Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.

select employeeid as nurse_id,
       name as nurse_name,
       blockcode
from nurse n
left outer join on_call oc
on n.employeeid = oc.nurse;


#31 Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform.

select ph.name as physician_name,u.procedure
from physician ph
inner join undergoes u
on ph.employeeid = u.physician
left outer join trained_in ti
on u.physician = ti.physician
and u.procedure = ti.treatment
where treatment is null;


#32 Write a query in SQL to obtain the names of all the physicians,  their procedure, date when the procedure was carried out and name of the patient on which procedure have been carried out but those physicians are not cetified for that procedure


select p.name as patient_name,ph.name as physician_name,date_ as date_of_procedure,
       pr.name as procedure_name,code as procedure_code
from physician ph
inner join undergoes u
on ph.employeeid = u.physician
left outer join trained_in ti
on u.physician = ti.physician
and u.procedure = ti.treatment
left outer join patient p
on u.patient = p.ssn
left outer join procedures pr
on u.procedure = pr.code
where treatment is null;


#33 Write a query in SQL to obtain the name and position of all physicians who completed a medical procedure with certification after the date of expiration of their certificate.

select employeeid,name as physician_name,position
from physician
where employeeid in(select u.physician
                    from undergoes u
                    inner join trained_in ti
                    on u.physician = ti.physician
                    where date_ > certificationexpires);
     

#34 Write a query in SQL to obtain the name of all those physicians who completed a medical procedure 
#with certification after the date of expiration of their certificate, their position, procedure they 
#have done, date of procedure, name of the patient on which the procedure had been applied and the date
#when the certification expired        

select employeeid,
       ph.name as physician_name,
       ph.position,
       pr.name as procedure_name,
       u.date_ as date_of_procedure,
       p.name as patient_name,
       ti.certificationexpires
from physician ph
left outer join undergoes u
on ph.employeeid = u.physician
left outer join patient p
on u.patient = p.ssn
left outer join trained_in ti
on u.procedure = ti.treatment
left outer join procedures pr
on ti.treatment = pr.code
where date_ > certificationexpires;


#35 Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122

select employeeid,name as nurse_name
from nurse
where employeeid in(select oc.nurse from on_call oc
                                    left outer join room r
                                    on oc.blockkfloor = r.blockfloor
                                    and oc.blockcode = r.blockcode
                                    where roomnumber = 122);

#36 Write a query in SQL to Obtain the names of all patients who has been prescribed some medication by his/her physician who has carried
#out primary care and the name of that physician

select p.name as patient_name,
       ph.name as physician_name
from patient p
left outer join prescribes pr
on p.ssn = pr.patient
left outer join physician ph
on pr.physician = ph.employeeid
where pcp = pr.physician;




#37 Write a query in SQL to obtain the names of all patients who has been undergone a procedure 
#costing more than $5,000 and the name of that physician who has carried out primary care

select p.ssn,ph.employeeid as physician_id,
       p.name as patient_name,
       ph.name as primary_care_physician      
from patient p
inner join undergoes u
on p.ssn = u.patient
inner join procedures pr
on u.procedure = pr.code
inner join physician ph
on p.pcp = ph.employeeid
where cost > 5000;




#38 Write a query in SQL to Obtain the names of all patients who had at least two appointment where 
#the nurse who prepped the appointment was a registered nurse and the physician who has carried out primary care

select a.patient as patient_id,p.name as patient_name,ph.name as physician_name
from patient p
inner join appointment a
on p.ssn = a.patient
inner join nurse n
on a.prepnurse = n.employeeid
inner join physician ph
on p.pcp = ph.employeeid
where registered='t'
group by a.patient,p.name,ph.name
having count(start_dt) >=2;

#39 Write a query in SQL to Obtain the names of all patients whose primary care is taken by a physician
#who is not the head of any department and name of that physician along with their primary care physician

select p.name as patient_name,
       ph.name as primary_care_physician_name
from patient p
inner join physician ph
on p.pcp = ph.employeeid
where p.pcp not in(select head from department);








