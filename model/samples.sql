delete from owncheckingaccount;
delete from checkingaccount;
delete from ownsavingaccount;
delete from savingaccount;
delete from client;
delete from Branch;
select * from HasAccount;
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

select * from ownsavingaccount;
select * from hasaccount;
select * from temp;
