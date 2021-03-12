---Store Procedure
---Creating Store proceduce to find when each employees had done max transation with name and Department


Alter procedure Employee_Details(@EmpId as int) as

begin 
    declare @MaxTransaction as int 
	select @MaxTransaction = max(Amount) from EmpTransaction
	where Emp_Id = @EmpId

	if exists(select * from EmpTransaction where Emp_id = @EmpId)
	begin
	select e.EmpFirstName,e.EmpLastName,e.Department,FORMAT(t.DateOfTransaction,'dd-MM-yyyy'),concat('$ ',t.Amount)
	from employee as e
	inner join EmpTransaction as t
	on e.Emp_id = t.Emp_id
	where t.Amount = @MaxTransaction and e.Emp_id = @EmpId
	end
	else

	 select 'Not A single Transaction done yet'
end


execute Employee_details @EmpId = 132
go




---Creating Store proceduce to find Average transaction done by each employee.


Alter procedure Avg_Emp_Tran(@EmpId  int,@Average_Transaction int output) 
as
begin
       begin try
	     Print ' The Employee Id '+convert(varchar(10),@EmpId)
             declare @Total as money
	         declare @NoOfEmployee as int
	         select @Total = sum(Amount) from EmpTransaction where Emp_id=@EmpId
	         select @NoOfEmployee = count(Emp_Id) from EmpTransaction where Emp_id=@EmpId
	         set @Average_Transaction = isnull(@Total,0)/@NoOfEmployee
	   end try
	   begin catch
	         print ' There is no valid record for that employee_Id'
	         select ERROR_MESSAGE() as ErrorMessage,ERROR_LINE() as ErrorLine,ERROR_NUMBER() as ErrorNumber,
			 ERROR_PROCEDURE() as ErrorProcedure,ERROR_SEVERITY() as ErrorSeverity,ERROR_STATE() as ErrorState
	         set @Average_Transaction = 0
	   end catch

	   --if @Total = 0 or @Total is null                                                        .
	   --   begin
	   --   set @Average_Transaction = 0
	   --   select 'Not a single Transaction done yet.'
	   --   end
	   --else
	   -- set @Average_Transaction = @Total/@NoOfEmployee


end

declare @Average as int 
execute Avg_Emp_Tran 9999,@Average_Transaction = @Average  output
select @Average as 'Average'