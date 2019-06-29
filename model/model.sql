/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2019/6/29 10:48:45                           */
/*==============================================================*/

drop database bank;
create database bank;
use bank;

/*==============================================================*/
/* Table: Branch                                                */
/*==============================================================*/
create table Branch
(
   branch_name          varchar(50) not null comment '支行名字',
   city                 varchar(50) comment '城市',
   property             double comment '资产',
   primary key (branch_name)
);

alter table Branch comment '支行';

/*==============================================================*/
/* Table: Department                                            */
/*==============================================================*/
create table Department
(
   department_id        varchar(20) not null comment '部门号',
   department_type      int comment '部门类型',
   department_name      varchar(50) comment '部门名',
   primary key (department_id)
);

/*==============================================================*/
/* Table: Staff                                                 */
/*==============================================================*/
create table Staff
(
   staff_id             varchar(20) not null comment '银行员工身份证号',
   manage_department_id varchar(20) comment '部门号',
   department_id        varchar(20) not null comment '部门号',
   staff_name           varchar(50) comment '员工姓名',
   staff_telephone      varchar(20) comment '员工电话号码',
   staff_address        varchar(100) comment '员工家庭地址',
   employment_time      date,
   primary key (staff_id),
   unique key AK_uni_manage (manage_department_id),
   constraint FK_work_in foreign key (department_id)
      references Department (department_id) on delete restrict on update restrict,
   constraint FK_manage foreign key (manage_department_id)
      references Department (department_id) on delete restrict on update restrict,
   check (manage_department_id is null or manage_department_id = department_id)
);

alter table Staff comment '银行员工';

/*==============================================================*/
/* Table: CheckingAccount                                       */
/*==============================================================*/
create table CheckingAccount
(
   account_id           varchar(20) not null comment '储蓄账户号',
   branch_name          varchar(50) not null comment '支行名字',
   staff_id             varchar(20) comment '银行员工身份证号',
   balance              double comment '储蓄账户余额',
   open_date            date comment '储蓄账号开户日期',
   last_visit           date comment '储蓄账号最近访问日期',
   overdraft_limit      double,
   primary key (account_id),
   constraint FK_duty foreign key (staff_id)
      references Staff (staff_id) on delete restrict on update restrict,
   constraint FK_open foreign key (branch_name)
      references Branch (branch_name) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: Client                                                */
/*==============================================================*/
create table Client
(
   client_id            varchar(20) not null,
   client_name          varchar(50) comment '员工姓名',
   client_telephone     varchar(20) comment '员工电话号码',
   client_address       varchar(100) comment '员工家庭地址',
   contact_name         varchar(50) comment '联系人姓名',
   contact_telephone    varchar(20) comment '联系人电话号码',
   contact_email        varchar(50) comment '联系人email',
   relationship         varchar(20) comment '联系人与客户关系',
   primary key (client_id)
);

/*==============================================================*/
/* Table: HasAccount                                            */
/*==============================================================*/
create table HasAccount
(
   client_id            varchar(20) not null,
   branch_name          varchar(50) not null comment '支行名字',
   account_type         varchar(10) not null,
   primary key (client_id, branch_name, account_type),
   constraint FK_HasAccount foreign key (client_id)
      references Client (client_id) on delete restrict on update restrict,
   constraint FK_HasAccount2 foreign key (branch_name)
      references Branch (branch_name) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: Loan                                                  */
/*==============================================================*/
create table Loan
(
   loan_id              varchar(50) not null comment '贷款号',
   total_amount         double comment '所贷总金额',
   times                smallint not null comment '付款次数',
   staff_id             varchar(20) comment '银行员工身份证号',
   client_id            varchar(20),
   branch_name          varchar(50) comment '支行名字',
   amount               double comment '此次付款金额',
   issue_date           date,
   primary key (loan_id, times),
   constraint FK_offer foreign key (branch_name)
      references Branch (branch_name) on delete restrict on update restrict,
   constraint FK_get foreign key (client_id)
      references Client (client_id) on delete restrict on update restrict,
   constraint FK_loan_duty foreign key (staff_id)
      references Staff (staff_id) on delete restrict on update restrict
);

alter table Loan comment '贷款';

/*==============================================================*/
/* Table: OwnCheckingAccount                                    */
/*==============================================================*/
create table OwnCheckingAccount
(
   client_id            varchar(20) not null,
   account_id           varchar(20) not null comment '储蓄账户号',
   primary key (client_id, account_id),
   constraint FK_OwnCheckingAccount foreign key (client_id)
      references Client (client_id) on delete restrict on update restrict,
   constraint FK_OwnCheckingAccount2 foreign key (account_id)
      references CheckingAccount (account_id) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: SavingAccount                                         */
/*==============================================================*/
create table SavingAccount
(
   account_id           varchar(20) not null comment '储蓄账户号',
   branch_name          varchar(50) not null comment '支行名字',
   staff_id             varchar(20) comment '银行员工身份证号',
   balance              double comment '储蓄账户余额',
   open_date            date comment '储蓄账号开户日期',
   last_visit           date comment '储蓄账号最近访问日期',
   interest_rate        real comment '利率',
   currency             varchar(10),
   primary key (account_id),
   constraint FK_duty2 foreign key (staff_id)
      references Staff (staff_id) on delete restrict on update restrict,
   constraint FK_open2 foreign key (branch_name)
      references Branch (branch_name) on delete restrict on update restrict
);

/*==============================================================*/
/* Table: OwnSavingAccount                                      */
/*==============================================================*/
create table OwnSavingAccount
(
   client_id            varchar(20) not null,
   account_id           varchar(20) not null comment '储蓄账户号',
   primary key (client_id, account_id),
   constraint FK_OwnSavingAccount foreign key (client_id)
      references Client (client_id) on delete restrict on update restrict,
   constraint FK_OwnSavingAccount2 foreign key (account_id)
      references SavingAccount (account_id) on delete restrict on update restrict
);


drop trigger if exists Delete_Owner_Saving_Before;
delimiter |
create trigger Delete_Owner_Saving_Before before delete
on OwnSavingAccount for each row
begin
    set @bname = (select branch_name from savingaccount where account_id = old.account_id);
    delete from HasAccount 
        where client_id = old.client_id 
            and branch_name=@bname 
            and account_type='saving';
end; |
delimiter ;


drop trigger if exists Insert_Owner_Saving;
delimiter |
create trigger Insert_Owner_Saving after insert
on OwnSavingAccount for each row
begin
	set @bname = (select branch_name from savingaccount where account_id = new.account_id);
	insert into HasAccount(client_id, branch_name, account_type)
            values(new.client_id, @bname, 'saving');
end; |
delimiter ;


drop trigger if exists Update_Owner_Saving_Before;
delimiter |
create trigger Update_Owner_Saving_Before before update
on OwnSavingAccount for each row
begin
    set @bname = (select branch_name from savingaccount where account_id = old.account_id);
    delete from HasAccount 
        where client_id = old.client_id 
            and branch_name=@bname 
            and account_type='saving';
end; |
delimiter ;


drop trigger if exists Update_Owner_Saving_After;
delimiter |
create trigger Update_Owner_Saving_After before update
on OwnSavingAccount for each row
begin
    set @bname = (select branch_name from savingaccount where account_id = new.account_id);
    insert into HasAccount(client_id, branch_name, account_type) 
        values(new.client_id, @bname, 'saving');
end;
|
delimiter ;

drop trigger if exists Delete_Owner_Checking_Before;
delimiter |
create trigger Delete_Owner_Checking_Before before delete
on OwnCheckingAccount for each row
begin
    set @bname = (select branch_name from Checkingaccount where account_id = old.account_id);
    delete from HasAccount 
        where client_id = old.client_id 
            and branch_name=@bname 
            and account_type='checking';
end; |
delimiter ;


drop trigger if exists Insert_Owner_Checking;
delimiter |
create trigger Insert_Owner_Checking after insert
on OwnCheckingAccount for each row
begin
	set @bname = (select branch_name from Checkingaccount where account_id = new.account_id);
	insert into HasAccount(client_id, branch_name, account_type)
            values(new.client_id, @bname, 'checking');
end; |
delimiter ;


drop trigger if exists Update_Owner_Checking_Before;
delimiter |
create trigger Update_Owner_Checking_Before before update
on OwnCheckingAccount for each row
begin
    set @bname = (select branch_name from Checkingaccount where account_id = old.account_id);
    delete from HasAccount 
        where client_id = old.client_id 
            and branch_name=@bname 
            and account_type='checking';
end; |
delimiter ;


drop trigger if exists Update_Owner_Checking_After;
delimiter |
create trigger Update_Owner_Checking_After before update
on OwnCheckingAccount for each row
begin
    set @bname = (select branch_name from Checkingaccount where account_id = new.account_id);
    insert into HasAccount(client_id, branch_name, account_type) 
        values(new.client_id, @bname, 'checking');
end;
|
delimiter ;
