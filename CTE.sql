-- CTE

---Make a report of employees Total transaction for the year 2014 and 2015 side by side for comparison



 with Transaction2014 as
 (
 select Emp_id,DateOfTransaction, sum(Amount)  over(partition by Emp_Id ) as TotalTransaction2014
 from EmpTransaction 
 where DateOfTransaction <'2015-01-01'),
 Transaction2015 as
 (select Emp_id, DateOfTransaction,sum(Amount)  over(partition by Emp_Id ) as TotalTransaction2015
 from EmpTransaction 
 where DateOfTransaction between '2015-01-01'and '2015-12-31'
 )
 
 
 select * from Transaction2014 left join Transaction2015 on Transaction2014.Emp_id = Transaction2015.Emp_id


---Find out which emp_id are not used for Transaction

 with rownum as
 (
 select top(1125) ROW_NUMBER() over(order by (select null)) as Rowss from EmpTransaction
 )

 select * from rownum as r
 left join EmpTransaction as t
 on r.Rowss = t.Emp_id
 where t.Emp_id is null
 order by r.Rowss
 



