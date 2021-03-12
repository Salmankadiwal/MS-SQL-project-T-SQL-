---Find out which employee has done either positive,negative or no transaction with equality expression

select *,TrackOftransaction = case when SumOfAmount  >0 then 'Postive Transaction'
                     when SumOfAmount  <0 then 'Negative Transaction' 
				     when SumOfAmount  is null or SumOfAmount  = 0 then 'No transaction' end
from
(

select e.Emp_id,EmpFirstName,e.EmpLastName ,sum(t.Amount) as SumOfAmount 

from employee as e
left join EmpTransaction as t
on e.Emp_id = t.Emp_id
group by e.Emp_id,EmpFirstName,e.EmpLastName

) as newtable



