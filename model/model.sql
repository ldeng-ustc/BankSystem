/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2019/6/28 19:46:17                           */
/*==============================================================*/


drop table if exists Branch;

drop table if exists CheckingAccount;

drop table if exists CheckingAccountInfo;

drop table if exists Client;

drop table if exists Department;

drop table if exists Loan;

drop table if exists SavingAccount;

drop table if exists SavingAccountInfo;

drop table if exists Staff;

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
/* Table: CheckingAccount                                       */
/*==============================================================*/
create table CheckingAccount
(
   account_id           varchar(20) not null comment '储蓄账户号',
   staff_id             varchar(20) comment '银行员工身份证号',
   balance              double comment '储蓄账户余额',
   open_date            date comment '储蓄账号开户日期',
   last_visit           date comment '储蓄账号最近访问日期',
   overdraft_limit      double,
   primary key (account_id)
);

/*==============================================================*/
/* Table: CheckingAccountInfo                                   */
/*==============================================================*/
create table CheckingAccountInfo
(
   account_id           varchar(20) not null comment '储蓄账户号',
   branch_name          varchar(50) not null comment '支行名字',
   client_id            varchar(20) not null,
   primary key (account_id, branch_name, client_id),
   constraint uni_checking_account unique (branch_name, client_id)
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
   primary key (loan_id, times)
);

alter table Loan comment '贷款';

/*==============================================================*/
/* Table: SavingAccount                                         */
/*==============================================================*/
create table SavingAccount
(
   account_id           varchar(20) not null comment '储蓄账户号',
   staff_id             varchar(20) comment '银行员工身份证号',
   balance              double comment '储蓄账户余额',
   open_date            date comment '储蓄账号开户日期',
   last_visit           date comment '储蓄账号最近访问日期',
   interest_rate        real comment '利率',
   currency             varchar(10),
   primary key (account_id)
);

/*==============================================================*/
/* Table: SavingAccountInfo                                     */
/*==============================================================*/
create table SavingAccountInfo
(
   account_id           varchar(20) not null comment '储蓄账户号',
   client_id            varchar(20) not null,
   branch_name          varchar(50) not null comment '支行名字',
   primary key (account_id, client_id, branch_name),
   constraint uni_checking_account unique (branch_name, client_id)
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
   constraint chk_staff_manage check(manage_department_id is null or manage_department_id = department_id),
   constraint uni_staff_manage unique(manage_department_id)
);

alter table Staff comment '银行员工';

alter table CheckingAccount add constraint FK_checking_account_duty foreign key (staff_id)
      references Staff (staff_id) on delete restrict on update restrict;

alter table CheckingAccountInfo add constraint FK_CheckingAccountInfo foreign key (account_id)
      references CheckingAccount (account_id) on delete restrict on update restrict;

alter table CheckingAccountInfo add constraint FK_CheckingAccountInfo2 foreign key (branch_name)
      references Branch (branch_name) on delete restrict on update restrict;

alter table CheckingAccountInfo add constraint FK_CheckingAccountInfo3 foreign key (client_id)
      references Client (client_id) on delete restrict on update restrict;

alter table Loan add constraint FK_get foreign key (client_id)
      references Client (client_id) on delete restrict on update restrict;

alter table Loan add constraint FK_loan_duty foreign key (staff_id)
      references Staff (staff_id) on delete restrict on update restrict;

alter table Loan add constraint FK_offer foreign key (branch_name)
      references Branch (branch_name) on delete restrict on update restrict;

alter table SavingAccount add constraint FK_saving_account_duty foreign key (staff_id)
      references Staff (staff_id) on delete restrict on update restrict;

alter table SavingAccountInfo add constraint FK_SavingAccountInfo foreign key (account_id)
      references SavingAccount (account_id) on delete restrict on update restrict;

alter table SavingAccountInfo add constraint FK_SavingAccountInfo2 foreign key (client_id)
      references Client (client_id) on delete restrict on update restrict;

alter table SavingAccountInfo add constraint FK_SavingAccountInfo3 foreign key (branch_name)
      references Branch (branch_name) on delete restrict on update restrict;

alter table Staff add constraint FK_manage foreign key (manage_department_id)
      references Department (department_id) on delete restrict on update restrict;

alter table Staff add constraint FK_work_in foreign key (department_id)
      references Department (department_id) on delete restrict on update restrict;

