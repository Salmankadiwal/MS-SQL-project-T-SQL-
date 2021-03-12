
--Find the employee attendance details for all employees whose lastname starts with 'Y'

select * from EmpAttendance
where Emp_Id = any (select Emp_Id from employee where  EmpLastName   like 'y%')


--Find the employee attendance details for all employees whose lastname not starts with 'Y'

select * from EmpAttendance
where Emp_Id <> all (select Emp_Id from employee where  EmpLastName   like 'y%')


--Find the employee who had done the second highest transaction


select * from Employee
where Emp_id IN(
select Emp_id from EmpTransaction
where Amount =(
select Max(Amount) from EmpTransaction
where Amount < (select MAX(Amount) from  EmpTransaction)
)
)

--Find the employee who had done total transaction greater than 2500

select * from Employee as e
where  exists(
select Emp_id,sum(Amount) from EmpTransaction as t where e.Emp_id  =t.Emp_id group by Emp_id having sum(Amount)>2500)


--Find the 2nd,3rd,4th...Nth highest Amount  of transaction done by employees
---in where clause we can find Nth highest Amount transaction by replacing it like 
--to find 3rd highest amount then put 2,to find 4th highest then put 3

select * from Employee as e
where exists
(
select Emp_id,Amount from EmpTransaction as t1
where 1 =  ( select count(distinct(Amount)) from EmpTransaction as t2 where t1.Amount< t2.Amount ) and e.Emp_id=t1.Emp_id
)


---Find out how many transaction done by each Employee and their totalAmount Of Transaction

 select *,(select count(Emp_Id) from EmpTransaction as t where e.Emp_id = t.Emp_id) as NumberOfTransaction,
          (select sum(Amount) from EmpTransaction as t where e.Emp_id = t.Emp_id) as TotalAmount
 from Employee as e
 where (select count(Emp_Id) from EmpTransaction as t where e.Emp_id = t.Emp_id) > 5
 

 ---Find out which employee has done more than 5 transactions
 select * from Employee as e
 where exists(
 select Emp_id,COUNT(Emp_Id) from EmpTransaction as t where e.Emp_id = t.Emp_id group by Emp_Id having COUNT(Emp_Id) > 5
 )
 order by e.Emp_id
