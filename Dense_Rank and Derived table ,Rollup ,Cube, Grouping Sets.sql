--DENSE_RANK AND DERIVED TABLE
--Find out the total Transaction for all the employees and dense rank the transaction from the highest

select *,DENSE_RANK() over(order by TotalAmount desc) as Ranking    ----row_Number()/Rank()
from
(
select  e.Emp_id,t.Amount,sum(t.Amount) over( partition by e.Emp_id  ) as TotalAmount

from Employee as e
 join EmpTransaction as t
on e.Emp_id = t.Emp_Id
) as new


--ROLLUP
----Create a report for all employees subtotal and grandtotal transaction detail from all the department 

select coalesce(e.Department,'All Departments') as Department,Coalesce(convert(varchar(10),t.Emp_id),'All Employee') as Employee_Id,Coalesce(convert(varchar(10),t.DateOfTransaction,113),'Total Transaction') as DateOfTransaction,sum(t.Amount) as TotalTran
from 
Employee AS e
inner join EmpTransaction as t
on e.Emp_id  =t.Emp_Id
group by rollup ( e.Department,t.Emp_id,t.DateOfTransaction) --(grouping dept,emp,date),(grouping dept,emp) and (grouping dept)
order by  e.Department,t.Emp_id,t.DateOfTransaction

--CUBE
----Create a detail report for all employees Attendance detail with belonging department

select coalesce(e.Department,'All Departments') as Department,Coalesce(convert(varchar(10),e.Emp_id),'All Employee') as Employee_Id,sum(a.NumberOfAttendance) as NoOfAttends
from 
Employee AS e
inner join EmpAttendance as a
on e.Emp_id  =a.Emp_Id
group by cube ( e.Department,e.Emp_id)
order by   e.Department,e.Emp_id


--GROUPING SETS
--Make a report of total transaction done by individual employees,department and grand total

select coalesce(e.Department,'All Departments') as Department,Coalesce(convert(varchar(10),t.Emp_id),'All Employee') as Employee_Id,format(sum(t.Amount),'C') as TotalTran
from 
Employee AS e
inner join EmpTransaction as t
on e.Emp_id  = t.Emp_Id
group by grouping sets ( t.Emp_id
                         ,e.Department,
						  ())
order by grouping(t.Emp_id),grouping(e.Department)

