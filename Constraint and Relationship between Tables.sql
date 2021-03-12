--Adding unique key to EmpGovernmentID column

Alter table Employee
Add constraint Unique_Government_ID unique (EmpGovernmentID)

--Adding unique key to (Amount,DateOfTransaction,Emp_id) columns

Alter table EmpTransaction
Add constraint Unique_Transactions unique(Amount,DateOfTransaction,Emp_id)


--Adding check constraint to the amount

Alter table EmpTransaction with nocheck
Add constraint Check_Amount check(Amount <> 0)

--Adding primary constraint to the amount

Alter table Employee
Add constraint Primary_EmpId primary key(Emp_id) 
--select @@identity

--Adding foreign constraint to the Emptransaction Table

Alter table EmpTransaction with nocheck
Add constraint Foreignkey_EmpId_Transaction foreign key (Emp_id) 
references Employee(Emp_id)


--This command is used to drop Constraint
Alter table Employee
drop constraint Unique_Government_ID