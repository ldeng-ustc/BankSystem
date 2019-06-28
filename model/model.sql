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
   branch_name          varchar(50) not null comment '֧������',
   city                 varchar(50) comment '����',
   property             double comment '�ʲ�',
   primary key (branch_name)
);

alter table Branch comment '֧��';

/*==============================================================*/
/* Table: CheckingAccount                                       */
/*==============================================================*/
create table CheckingAccount
(
   account_id           varchar(20) not null comment '�����˻���',
   staff_id             varchar(20) comment '����Ա�����֤��',
   balance              double comment '�����˻����',
   open_date            date comment '�����˺ſ�������',
   last_visit           date comment '�����˺������������',
   overdraft_limit      double,
   primary key (account_id)
);

/*==============================================================*/
/* Table: CheckingAccountInfo                                   */
/*==============================================================*/
create table CheckingAccountInfo
(
   account_id           varchar(20) not null comment '�����˻���',
   branch_name          varchar(50) not null comment '֧������',
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
   client_name          varchar(50) comment 'Ա������',
   client_telephone     varchar(20) comment 'Ա���绰����',
   client_address       varchar(100) comment 'Ա����ͥ��ַ',
   contact_name         varchar(50) comment '��ϵ������',
   contact_telephone    varchar(20) comment '��ϵ�˵绰����',
   contact_email        varchar(50) comment '��ϵ��email',
   relationship         varchar(20) comment '��ϵ����ͻ���ϵ',
   primary key (client_id)
);

/*==============================================================*/
/* Table: Department                                            */
/*==============================================================*/
create table Department
(
   department_id        varchar(20) not null comment '���ź�',
   department_type      int comment '��������',
   department_name      varchar(50) comment '������',
   primary key (department_id)
);

/*==============================================================*/
/* Table: Loan                                                  */
/*==============================================================*/
create table Loan
(
   loan_id              varchar(50) not null comment '�����',
   total_amount         double comment '�����ܽ��',
   times                smallint not null comment '�������',
   staff_id             varchar(20) comment '����Ա�����֤��',
   client_id            varchar(20),
   branch_name          varchar(50) comment '֧������',
   amount               double comment '�˴θ�����',
   issue_date           date,
   primary key (loan_id, times)
);

alter table Loan comment '����';

/*==============================================================*/
/* Table: SavingAccount                                         */
/*==============================================================*/
create table SavingAccount
(
   account_id           varchar(20) not null comment '�����˻���',
   staff_id             varchar(20) comment '����Ա�����֤��',
   balance              double comment '�����˻����',
   open_date            date comment '�����˺ſ�������',
   last_visit           date comment '�����˺������������',
   interest_rate        real comment '����',
   currency             varchar(10),
   primary key (account_id)
);

/*==============================================================*/
/* Table: SavingAccountInfo                                     */
/*==============================================================*/
create table SavingAccountInfo
(
   account_id           varchar(20) not null comment '�����˻���',
   client_id            varchar(20) not null,
   branch_name          varchar(50) not null comment '֧������',
   primary key (account_id, client_id, branch_name),
   constraint uni_checking_account unique (branch_name, client_id)
);

/*==============================================================*/
/* Table: Staff                                                 */
/*==============================================================*/
create table Staff
(
   staff_id             varchar(20) not null comment '����Ա�����֤��',
   manage_department_id varchar(20) comment '���ź�',
   department_id        varchar(20) not null comment '���ź�',
   staff_name           varchar(50) comment 'Ա������',
   staff_telephone      varchar(20) comment 'Ա���绰����',
   staff_address        varchar(100) comment 'Ա����ͥ��ַ',
   employment_time      date,
   primary key (staff_id),
   constraint chk_staff_manage check(manage_department_id is null or manage_department_id = department_id),
   constraint uni_staff_manage unique(manage_department_id)
);

alter table Staff comment '����Ա��';

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

