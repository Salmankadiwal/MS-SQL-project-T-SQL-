-- Merge

select * from Employee

select * from [dbo].[UpdatedEmployee_Data]

go

---Just heads up that if there is instead of trigger on the table that you wanna merge,then it is 
--possible to do that until you disable trigger from that table 

begin tran

Merge Employee as T
using UpdatedEmployee_Data as S
on T.Emp_id = S.Emp_id
when Matched
           then update set T.EmpMiddleName = S.EmpMiddleName,
           T.Department  = S.Department
when Not Matched by Target 
           then insert ([Emp_id],[EmpFirstName],[EmpMiddleName],[EmpLastName],[EmpGovernmentID],[DateOfBirth],[Department])
		        values(S.Emp_id,S.EmpFirstName,S.EmpMiddleName,S.EmpLastName,S.EmpGovernmentID,S.DateOfBirth,S.Department)
when Not Matched by source
           then delete;

Rollback tran
