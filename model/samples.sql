delete from owncheckingaccount;
delete from checkingaccount;
delete from ownsavingaccount;
delete from savingaccount;
delete from client;
delete from Branch;
delete from staff;
delete from department;
insert into Branch value('合肥支行', '合肥', 1000000);
insert into Branch value('北京支行', '北京', 2000000);
insert into client value('U001', '张三', '13312345678', '合肥中科大', '李四', '080123456', 'a@b.c', '朋友');
insert into checkingaccount(account_id, branch_name) value('C001', '合肥支行'); 
insert into checkingaccount(account_id, branch_name) value('C002', '合肥支行');
insert into owncheckingaccount value('U001', 'C001');
insert into owncheckingaccount value('U001', 'C002');
insert into savingaccount(account_id, branch_name) value('S001', '合肥支行'); 
insert into savingaccount(account_id, branch_name) value('S002', '合肥支行');
insert into ownsavingaccount value('U001', 'S001');
insert into ownsavingaccount value('U001', 'S002');

select * from hasaccount;
delete from ownsavingaccount where client_id = 'U001';
select * from hasaccount;

insert into department(department_id) value('D001');
insert into department(department_id) value('D002');

insert into staff(staff_id, manage_department_id, department_id, staff_name)
			value('E001', 'D001', 'D001', '李四');
insert into staff(staff_id, manage_department_id, department_id, staff_name)
			value('E002', 'D002', 'D001', '王五');
insert into staff(staff_id, manage_department_id, department_id, staff_name)
			value('E003', 'D001', 'D001', '赵六');
