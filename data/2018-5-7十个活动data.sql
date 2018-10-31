prompt PL/SQL Developer import file
prompt Created on 2018��5��7�� by Administrator
set feedback off
set define off
prompt Creating ACTIVITY_CODE...
create table ACTIVITY_CODE
(
  id                     VARCHAR2(64) not null,
  code                   VARCHAR2(64),
  selleroutinfo_recordid VARCHAR2(64),
  openid                 VARCHAR2(64),
  sing_number            VARCHAR2(1000),
  spare_one              VARCHAR2(64),
  activity_id            VARCHAR2(64),
  mark                   VARCHAR2(64),
  activity_wxid          VARCHAR2(64),
  winingid               VARCHAR2(64),
  wintype                VARCHAR2(64),
  nickname               VARCHAR2(255),
  headimg                VARCHAR2(1000),
  sellerpublicid         VARCHAR2(64),
  sellerpublicname       VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ACTIVITY_CODE.code
  is '��ɨ���CODE';
comment on column ACTIVITY_CODE.selleroutinfo_recordid
  is '������Ϣ�еļ�¼ID';
comment on column ACTIVITY_CODE.openid
  is '�û�OPENID';
comment on column ACTIVITY_CODE.sing_number
  is 'ɨ�����';
comment on column ACTIVITY_CODE.spare_one
  is '�����ֶ�';
comment on column ACTIVITY_CODE.activity_id
  is '�id';
comment on column ACTIVITY_CODE.mark
  is '���ʶ';
comment on column ACTIVITY_CODE.activity_wxid
  is '�μӵ�΢�ŻID';
comment on column ACTIVITY_CODE.winingid
  is '�н�id';
comment on column ACTIVITY_CODE.wintype
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�
';
comment on column ACTIVITY_CODE.nickname
  is 'ɨ���û��ǳ�';
comment on column ACTIVITY_CODE.headimg
  is 'ͷ��';
comment on column ACTIVITY_CODE.sellerpublicid
  is '���ں�id';
comment on column ACTIVITY_CODE.sellerpublicname
  is '���ں�����';
alter table ACTIVITY_CODE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ACTIVITY_WXUSER...
create table ACTIVITY_WXUSER
(
  openid                 VARCHAR2(64),
  belong_publicnumber_id VARCHAR2(64),
  nickname               VARCHAR2(1000),
  sex                    VARCHAR2(64),
  country                VARCHAR2(64),
  province               VARCHAR2(64),
  city                   VARCHAR2(64),
  headimgurl             VARCHAR2(1000),
  id                     VARCHAR2(64) not null,
  total_integral         VARCHAR2(64) default 0,
  total_money            VARCHAR2(64) default 0,
  surplus_total_money    VARCHAR2(64) default 0,
  surplus_total_integral VARCHAR2(64) default 0,
  sian_time              VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ACTIVITY_WXUSER
  is 'ACTIVITY_WXUSER ��û�';
comment on column ACTIVITY_WXUSER.openid
  is '΢��ָ��openidid/����';
comment on column ACTIVITY_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column ACTIVITY_WXUSER.nickname
  is '΢���ǳ�';
comment on column ACTIVITY_WXUSER.sex
  is '1 = ��  2 = Ů';
comment on column ACTIVITY_WXUSER.country
  is '����';
comment on column ACTIVITY_WXUSER.province
  is 'ʡ��';
comment on column ACTIVITY_WXUSER.city
  is '����';
comment on column ACTIVITY_WXUSER.headimgurl
  is 'ͷ���ַ';
comment on column ACTIVITY_WXUSER.total_integral
  is '�ܻ���';
comment on column ACTIVITY_WXUSER.total_money
  is '�ܽ��';
comment on column ACTIVITY_WXUSER.surplus_total_money
  is 'ʣ����';
comment on column ACTIVITY_WXUSER.surplus_total_integral
  is 'ʣ�����';
comment on column ACTIVITY_WXUSER.sian_time
  is 'ǩ��ʱ��';
alter table ACTIVITY_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DEMO_T...
create table DEMO_T
(
  id   VARCHAR2(64) not null,
  name VARCHAR2(64),
  age  VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating JOINACTIVITY...
create table JOINACTIVITY
(
  id                   VARCHAR2(64) not null,
  integralid           VARCHAR2(64),
  join_integral        VARCHAR2(64),
  activitymark         VARCHAR2(64),
  activityname         VARCHAR2(64),
  jointime             VARCHAR2(64),
  openid               VARCHAR2(64),
  sellerpublicnumberid VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column JOINACTIVITY.integralid
  is '���ֻid';
comment on column JOINACTIVITY.join_integral
  is '���ѵĻ���';
comment on column JOINACTIVITY.activitymark
  is '���ʶ';
comment on column JOINACTIVITY.activityname
  is '�����';
comment on column JOINACTIVITY.jointime
  is '����ʱ��';
alter table JOINACTIVITY
  add constraint JOINACTIVITY_PK primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating LOG_INFO...
create table LOG_INFO
(
  id           VARCHAR2(64) not null,
  use_usercode VARCHAR2(64),
  use_function VARCHAR2(64),
  use_time     VARCHAR2(64),
  spare_one    VARCHAR2(255)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column LOG_INFO.use_usercode
  is '������';
comment on column LOG_INFO.use_function
  is '��������';
comment on column LOG_INFO.use_time
  is '����ʱ��';
comment on column LOG_INFO.spare_one
  is '�����ֶ�һ';
alter table LOG_INFO
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_CONFIG...
create table SYS_CONFIG
(
  id      VARCHAR2(64) not null,
  name    VARCHAR2(64),
  value   VARCHAR2(64),
  remarks VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255;

prompt Creating SYS_MENU...
create table SYS_MENU
(
  id          VARCHAR2(64) not null,
  name        VARCHAR2(64),
  href        VARCHAR2(1000),
  create_date VARCHAR2(64),
  update_date VARCHAR2(64),
  remarks     VARCHAR2(1000),
  parent_id   VARCHAR2(64),
  img         VARCHAR2(1000),
  delflag     VARCHAR2(10) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column SYS_MENU.name
  is '�˵�����';
comment on column SYS_MENU.href
  is '·��';
comment on column SYS_MENU.create_date
  is '����ʱ��';
comment on column SYS_MENU.update_date
  is '�޸�ʱ��';
comment on column SYS_MENU.remarks
  is '��ע';
comment on column SYS_MENU.parent_id
  is '����/δ�����ֶ�';
comment on column SYS_MENU.img
  is 'ͼ���ַ';
comment on column SYS_MENU.delflag
  is 'ɾ����ʾ    0 δɾ��   1��ɾ��';
alter table SYS_MENU
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_MENU_ROLE...
create table SYS_MENU_ROLE
(
  menu VARCHAR2(64),
  role VARCHAR2(64),
  id   VARCHAR2(64) not null
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column SYS_MENU_ROLE.menu
  is '�˵�';
comment on column SYS_MENU_ROLE.role
  is '��ɫ';
alter table SYS_MENU_ROLE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ACCUMULATEFABULOUS...
create table TB_ACCUMULATEFABULOUS
(
  id                        VARCHAR2(64) not null,
  activityname              VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moble_background_img      VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64) default 0,
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  productimg                VARCHAR2(64),
  productintroduction       VARCHAR2(1000),
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  applyuserid               VARCHAR2(64),
  handle                    VARCHAR2(64) default 0,
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ACCUMULATEFABULOUS.activityname
  is '�����';
comment on column TB_ACCUMULATEFABULOUS.background_img
  is '����ͼ';
comment on column TB_ACCUMULATEFABULOUS.belong_activity_id
  is '�����ID';
comment on column TB_ACCUMULATEFABULOUS.moble_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_ACCUMULATEFABULOUS.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_ACCUMULATEFABULOUS.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_ACCUMULATEFABULOUS.join_prople_number
  is '�μ�����';
comment on column TB_ACCUMULATEFABULOUS.winning_prople_number
  is '������';
comment on column TB_ACCUMULATEFABULOUS.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_ACCUMULATEFABULOUS.create_time
  is '��ʼʱ��';
comment on column TB_ACCUMULATEFABULOUS.comfirmuserid
  is '����˵�ID';
comment on column TB_ACCUMULATEFABULOUS.comfirmtime
  is '���ʱ��';
comment on column TB_ACCUMULATEFABULOUS.comfirmadvise
  is '��˽���';
comment on column TB_ACCUMULATEFABULOUS.comfirmusername
  is '���������';
comment on column TB_ACCUMULATEFABULOUS.applyphone
  is '�����˵绰';
comment on column TB_ACCUMULATEFABULOUS.applyusername
  is '����������';
comment on column TB_ACCUMULATEFABULOUS.productimg
  is '��ƷͼƬ';
comment on column TB_ACCUMULATEFABULOUS.productintroduction
  is '���޲�Ʒ����';
comment on column TB_ACCUMULATEFABULOUS.spare_one
  is '�����ֶ�һ';
comment on column TB_ACCUMULATEFABULOUS.spare_two
  is '�����ֶζ�';
comment on column TB_ACCUMULATEFABULOUS.starttime
  is '��ʼʱ��';
comment on column TB_ACCUMULATEFABULOUS.endtime
  is '����ʱ��';
comment on column TB_ACCUMULATEFABULOUS.applyuserid
  is '������ID';
comment on column TB_ACCUMULATEFABULOUS.handle
  is '0δ����1�Ѵ���';
alter table TB_ACCUMULATEFABULOUS
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ACCUMULATEFABULOUS_PRIZE...
create table TB_ACCUMULATEFABULOUS_PRIZE
(
  id               VARCHAR2(64) not null,
  accumulate_id    VARCHAR2(64),
  prizegrade       VARCHAR2(64),
  threshold        VARCHAR2(64),
  prizename        VARCHAR2(64),
  prizeimg         VARCHAR2(1000),
  prizetype        VARCHAR2(64),
  redmoney         VARCHAR2(64) default 0,
  accumulatenumber VARCHAR2(64),
  spare_one        VARCHAR2(64),
  spare_two        VARCHAR2(64),
  integral         VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ACCUMULATEFABULOUS_PRIZE.accumulate_id
  is '�������޻ID';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizegrade
  is '��Ʒ�ȼ�';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.threshold
  is '��ֵ';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizename
  is '��Ʒ����(������ʵ�����������)';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizeimg
  is '��ƷͼƬ';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizetype
  is '��Ʒ���� 1ʵ�� 2���� 3���';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.redmoney
  is '���ֵ';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.accumulatenumber
  is '��������';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.integral
  is '����ֵ';
alter table TB_ACCUMULATEFABULOUS_PRIZE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ACCUMULATE_COMMENT_WXUSER...
create table TB_ACCUMULATE_COMMENT_WXUSER
(
  id                     VARCHAR2(64) not null,
  accumulate_id          VARCHAR2(64),
  openid                 VARCHAR2(64),
  nickname               VARCHAR2(1000),
  headimgurl             VARCHAR2(1000),
  belong_publicnumber_id VARCHAR2(64),
  create_time            VARCHAR2(64),
  comments               VARCHAR2(1000),
  help_number            INTEGER default 0,
  state                  VARCHAR2(64),
  scan_code              VARCHAR2(64),
  activity_name          VARCHAR2(64),
  accumulate_przie_id    VARCHAR2(64),
  commentimg             VARCHAR2(1000),
  winstate               VARCHAR2(64) default 3,
  spareone               VARCHAR2(64),
  noticed                VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_ACCUMULATE_COMMENT_WXUSER
  is 'TB_ACCUMUL_COMMENT_WXUSER   ���޻�����û�';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.accumulate_id
  is '�ID';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.create_time
  is '����ʱ��';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.comments
  is '��������';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.help_number
  is '����������';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.state
  is '1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ���� 6��֧��';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.activity_name
  is '�����';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.accumulate_przie_id
  is '���޽�ƷID';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.commentimg
  is '����ͼƬ';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.winstate
  is '�н���� 1һ�Ƚ� 2��ֵ�� 3δ�н�';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.spareone
  is '�����ֶ�1�洢�н����';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.noticed
  is 'Ĭ��Ϊ0δ֪ͨ��1��֪ͨ';
alter table TB_ACCUMULATE_COMMENT_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ACCUMULATE_HELP_WXUSER...
create table TB_ACCUMULATE_HELP_WXUSER
(
  id                     VARCHAR2(64) not null,
  accumulate_id          VARCHAR2(64),
  comment_wxuser_id      VARCHAR2(64),
  openid                 VARCHAR2(64),
  nickname               VARCHAR2(255),
  headimgurl             VARCHAR2(1000),
  belong_publicnumber_id VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_ACCUMULATE_HELP_WXUSER
  is 'TB_ACCUMUL_HELP_WXUSER   ���޻�����û�';
comment on column TB_ACCUMULATE_HELP_WXUSER.id
  is 'Ψһ����';
comment on column TB_ACCUMULATE_HELP_WXUSER.comment_wxuser_id
  is '���޻ID';
comment on column TB_ACCUMULATE_HELP_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_ACCUMULATE_HELP_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_ACCUMULATE_HELP_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_ACCUMULATE_HELP_WXUSER.belong_publicnumber_id
  is '�������ں�';
alter table TB_ACCUMULATE_HELP_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ACCUMULATE_WXUSER_WINNING...
create table TB_ACCUMULATE_WXUSER_WINNING
(
  id                      VARCHAR2(64) not null,
  accumulate_wxuser_id    VARCHAR2(64),
  prize_type              VARCHAR2(64),
  belong_winning_prize_id VARCHAR2(64),
  winning_money           VARCHAR2(64) default 0,
  prize_project           VARCHAR2(64),
  create_time             VARCHAR2(64),
  prize_project_img       VARCHAR2(1000),
  openid                  VARCHAR2(64),
  state                   VARCHAR2(64) default 1,
  addressee_name          VARCHAR2(64),
  addressee_address       VARCHAR2(255),
  addressee_phone         VARCHAR2(64),
  lssue_user_name         VARCHAR2(64),
  lssue_user_userid       VARCHAR2(64),
  lssue_user_usercode     VARCHAR2(64),
  deliver_number          VARCHAR2(64),
  deliver_company         VARCHAR2(64),
  deliver_time            VARCHAR2(64),
  product_winning_info_id VARCHAR2(64),
  spare_one               VARCHAR2(64),
  spare_two               VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ACCUMULATE_WXUSER_WINNING.accumulate_wxuser_id
  is '���޲����¼ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_ACCUMULATE_WXUSER_WINNING.belong_winning_prize_id
  is '�����н�ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.winning_money
  is '�н����/����';
comment on column TB_ACCUMULATE_WXUSER_WINNING.prize_project
  is '��Ʒ����';
comment on column TB_ACCUMULATE_WXUSER_WINNING.create_time
  is '����ʱ��';
comment on column TB_ACCUMULATE_WXUSER_WINNING.prize_project_img
  is '��ƷͼƬ';
comment on column TB_ACCUMULATE_WXUSER_WINNING.openid
  is '΢��ָ��ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_ACCUMULATE_WXUSER_WINNING.addressee_name
  is '�ռ�������';
comment on column TB_ACCUMULATE_WXUSER_WINNING.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_ACCUMULATE_WXUSER_WINNING.addressee_phone
  is '�ռ��˵绰';
comment on column TB_ACCUMULATE_WXUSER_WINNING.lssue_user_name
  is '����������';
comment on column TB_ACCUMULATE_WXUSER_WINNING.lssue_user_userid
  is '������USERID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.lssue_user_usercode
  is '������USERCODE';
comment on column TB_ACCUMULATE_WXUSER_WINNING.deliver_number
  is '��ݵ���';
comment on column TB_ACCUMULATE_WXUSER_WINNING.deliver_company
  is '��ݹ�˾';
comment on column TB_ACCUMULATE_WXUSER_WINNING.deliver_time
  is '����ʱ��';
comment on column TB_ACCUMULATE_WXUSER_WINNING.product_winning_info_id
  is 'ʵ���н���¼ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.spare_one
  is '�洢��Ʒ����';
comment on column TB_ACCUMULATE_WXUSER_WINNING.spare_two
  is '�洢״̬';
alter table TB_ACCUMULATE_WXUSER_WINNING
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ACTIVITY...
create table TB_ACTIVITY
(
  id                   VARCHAR2(64) not null,
  activity_name        VARCHAR2(16),
  img                  VARCHAR2(1000),
  href                 VARCHAR2(255),
  remarks              VARCHAR2(1000),
  update_date          VARCHAR2(64),
  approvehref          VARCHAR2(64),
  reporthref           VARCHAR2(64),
  activityhref         VARCHAR2(64),
  integral_choice_href VARCHAR2(1000)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ACTIVITY.id
  is 'Ψһ����';
comment on column TB_ACTIVITY.activity_name
  is '�����';
comment on column TB_ACTIVITY.img
  is 'ͼƬ';
comment on column TB_ACTIVITY.href
  is '��ת·��';
comment on column TB_ACTIVITY.remarks
  is '��ע';
comment on column TB_ACTIVITY.update_date
  is '�޸�ʱ��';
comment on column TB_ACTIVITY.approvehref
  is '��˵�����';
comment on column TB_ACTIVITY.reporthref
  is '����������';
comment on column TB_ACTIVITY.activityhref
  is '��Ӧ���¼��ѯ������';
comment on column TB_ACTIVITY.integral_choice_href
  is '��ѯ��ǰ������Ļ   ·��������json';
alter table TB_ACTIVITY
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ACTIVITY_SELLEROUTINFO...
create table TB_ACTIVITY_SELLEROUTINFO
(
  id                     VARCHAR2(64) not null,
  activity_id            VARCHAR2(64),
  selleroutinfo_recordid VARCHAR2(64),
  outno                  VARCHAR2(64),
  seller_usercode        VARCHAR2(64),
  state                  VARCHAR2(64),
  belong_activity        VARCHAR2(64),
  outsellername          VARCHAR2(64),
  productname            VARCHAR2(64),
  deep                   NUMBER(10),
  volume                 NUMBER(10),
  spec                   VARCHAR2(64),
  boxsize                VARCHAR2(64),
  bandname               VARCHAR2(64),
  outdate                VARCHAR2(64 CHAR),
  sendorrec              VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_ACTIVITY_SELLEROUTINFO
  is '����˵��� TB_ACTIVITY_SELLEROUTINFO';
comment on column TB_ACTIVITY_SELLEROUTINFO.activity_id
  is '�ID';
comment on column TB_ACTIVITY_SELLEROUTINFO.selleroutinfo_recordid
  is '������Ϣ�м�¼ID';
comment on column TB_ACTIVITY_SELLEROUTINFO.outno
  is '���ⵥ��';
comment on column TB_ACTIVITY_SELLEROUTINFO.seller_usercode
  is '������userCode';
comment on column TB_ACTIVITY_SELLEROUTINFO.state
  is '״̬ 1������ 2������';
comment on column TB_ACTIVITY_SELLEROUTINFO.belong_activity
  is '�����';
comment on column TB_ACTIVITY_SELLEROUTINFO.outsellername
  is '���˵���������';
comment on column TB_ACTIVITY_SELLEROUTINFO.productname
  is '��Ʒ����';
comment on column TB_ACTIVITY_SELLEROUTINFO.deep
  is '����';
comment on column TB_ACTIVITY_SELLEROUTINFO.volume
  is '����';
comment on column TB_ACTIVITY_SELLEROUTINFO.spec
  is '���';
comment on column TB_ACTIVITY_SELLEROUTINFO.boxsize
  is '����';
comment on column TB_ACTIVITY_SELLEROUTINFO.bandname
  is 'Ʒ������';
comment on column TB_ACTIVITY_SELLEROUTINFO.outdate
  is '����ʱ��';
comment on column TB_ACTIVITY_SELLEROUTINFO.sendorrec
  is '1���յĻ�  2�����Ļ�';
alter table TB_ACTIVITY_SELLEROUTINFO
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_BREAKEGG_WXUSER...
create table TB_BREAKEGG_WXUSER
(
  id                     VARCHAR2(64) not null,
  breakegg_id            VARCHAR2(64),
  openid                 VARCHAR2(64),
  nickname               VARCHAR2(1000),
  headimgurl             VARCHAR2(1000),
  belong_publicnumber_id VARCHAR2(64),
  create_time            VARCHAR2(64),
  state                  VARCHAR2(64),
  scan_code              VARCHAR2(64),
  activity_name          VARCHAR2(64),
  breakegg_przie_id      VARCHAR2(64),
  spare_one              VARCHAR2(64),
  spare_two              VARCHAR2(64),
  total_money            VARCHAR2(64) default 0,
  total_integral         VARCHAR2(64) default 0,
  thanknumber            VARCHAR2(64) default 0,
  goodsnumber            VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_BREAKEGG_WXUSER
  is 'TB_BREAKEGG_WXUSER   �ҵ���û�';
comment on column TB_BREAKEGG_WXUSER.breakegg_id
  is '�ID';
comment on column TB_BREAKEGG_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_BREAKEGG_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_BREAKEGG_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_BREAKEGG_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_BREAKEGG_WXUSER.create_time
  is '����ʱ��';
comment on column TB_BREAKEGG_WXUSER.state
  is '1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ���� 6��֧��';
comment on column TB_BREAKEGG_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_BREAKEGG_WXUSER.activity_name
  is '�����';
comment on column TB_BREAKEGG_WXUSER.breakegg_przie_id
  is '�ҵ���ƷID';
comment on column TB_BREAKEGG_WXUSER.total_money
  is '���β�����';
comment on column TB_BREAKEGG_WXUSER.total_integral
  is '���β����н�����';
comment on column TB_BREAKEGG_WXUSER.thanknumber
  is '��л����';
comment on column TB_BREAKEGG_WXUSER.goodsnumber
  is 'ʵ�����';
alter table TB_BREAKEGG_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_BREAKEGG_WXUSER_WINNING...
create table TB_BREAKEGG_WXUSER_WINNING
(
  id                      VARCHAR2(64) not null,
  breakegg_wxuser_id      VARCHAR2(64),
  prize_type              VARCHAR2(64),
  belong_winning_prize_id VARCHAR2(64),
  winning_money           VARCHAR2(64) default 0,
  prize_project           VARCHAR2(64),
  create_time             VARCHAR2(64),
  prize_project_img       VARCHAR2(1000),
  openid                  VARCHAR2(64),
  state                   VARCHAR2(64),
  addressee_name          VARCHAR2(64),
  addressee_address       VARCHAR2(255),
  addressee_phone         VARCHAR2(64),
  lssue_user_name         VARCHAR2(64),
  lssue_user_userid       VARCHAR2(64),
  lssue_user_usercode     VARCHAR2(64),
  deliver_number          VARCHAR2(64),
  deliver_company         VARCHAR2(64),
  deliver_time            VARCHAR2(64),
  product_winning_info_id VARCHAR2(64),
  spare_one               VARCHAR2(64),
  spare_two               VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_BREAKEGG_WXUSER_WINNING.breakegg_wxuser_id
  is '�ҵ������¼ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_BREAKEGG_WXUSER_WINNING.belong_winning_prize_id
  is '�����н�ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.winning_money
  is '�н����/����';
comment on column TB_BREAKEGG_WXUSER_WINNING.prize_project
  is '��Ʒ����';
comment on column TB_BREAKEGG_WXUSER_WINNING.create_time
  is '����ʱ��';
comment on column TB_BREAKEGG_WXUSER_WINNING.prize_project_img
  is '��ƷͼƬ';
comment on column TB_BREAKEGG_WXUSER_WINNING.openid
  is '΢��ָ��ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_BREAKEGG_WXUSER_WINNING.addressee_name
  is '�ռ�������';
comment on column TB_BREAKEGG_WXUSER_WINNING.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_BREAKEGG_WXUSER_WINNING.addressee_phone
  is '�ռ��˵绰';
comment on column TB_BREAKEGG_WXUSER_WINNING.lssue_user_name
  is '����������';
comment on column TB_BREAKEGG_WXUSER_WINNING.lssue_user_userid
  is '������USERID';
comment on column TB_BREAKEGG_WXUSER_WINNING.lssue_user_usercode
  is '������USERCODE';
comment on column TB_BREAKEGG_WXUSER_WINNING.deliver_number
  is '��ݵ���';
comment on column TB_BREAKEGG_WXUSER_WINNING.deliver_company
  is '��ݹ�˾';
comment on column TB_BREAKEGG_WXUSER_WINNING.deliver_time
  is '����ʱ��';
comment on column TB_BREAKEGG_WXUSER_WINNING.product_winning_info_id
  is 'ʵ���н���¼ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.spare_one
  is '�洢��Ʒ����';
comment on column TB_BREAKEGG_WXUSER_WINNING.spare_two
  is '�洢״̬';
alter table TB_BREAKEGG_WXUSER_WINNING
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_BREAK_EGG...
create table TB_BREAK_EGG
(
  id                        VARCHAR2(64) not null,
  activityname              VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moble_background_img      VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64) default 0,
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  breaknumber               VARCHAR2(64),
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  applyuserid               VARCHAR2(64),
  total                     VARCHAR2(64),
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_BREAK_EGG.activityname
  is '�����';
comment on column TB_BREAK_EGG.background_img
  is '����ͼ';
comment on column TB_BREAK_EGG.belong_activity_id
  is '�����ID';
comment on column TB_BREAK_EGG.moble_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_BREAK_EGG.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_BREAK_EGG.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_BREAK_EGG.join_prople_number
  is '�μ�����';
comment on column TB_BREAK_EGG.winning_prople_number
  is '������';
comment on column TB_BREAK_EGG.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_BREAK_EGG.create_time
  is '��ʼʱ��';
comment on column TB_BREAK_EGG.comfirmuserid
  is '����˵�ID';
comment on column TB_BREAK_EGG.comfirmtime
  is '���ʱ��';
comment on column TB_BREAK_EGG.comfirmadvise
  is '��˽���';
comment on column TB_BREAK_EGG.comfirmusername
  is '���������';
comment on column TB_BREAK_EGG.applyphone
  is '�����˵绰';
comment on column TB_BREAK_EGG.applyusername
  is '����������';
comment on column TB_BREAK_EGG.breaknumber
  is '�ҵ�����';
comment on column TB_BREAK_EGG.spare_one
  is '�����ֶ�һ';
comment on column TB_BREAK_EGG.spare_two
  is '�����ֶζ�';
comment on column TB_BREAK_EGG.starttime
  is '��ʼʱ��';
comment on column TB_BREAK_EGG.endtime
  is '����ʱ��';
comment on column TB_BREAK_EGG.applyuserid
  is '������ID';
comment on column TB_BREAK_EGG.total
  is '��Ʒ����';
alter table TB_BREAK_EGG
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_BREAK_EGG_PRIZE...
create table TB_BREAK_EGG_PRIZE
(
  id                        VARCHAR2(64) not null,
  egg_id                    VARCHAR2(64),
  prizename                 VARCHAR2(64),
  prizeimg                  VARCHAR2(64),
  prizetype                 VARCHAR2(64),
  prizenumber               VARCHAR2(64) default 0,
  prizeprobability          VARCHAR2(64) default 0,
  integral                  VARCHAR2(64) default 0,
  redmoney                  VARCHAR2(64) default 0,
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64),
  surplus_prize_number      VARCHAR2(64) default 0,
  surplus_prize_probability VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_BREAK_EGG_PRIZE.egg_id
  is '�����ҵ��ID';
comment on column TB_BREAK_EGG_PRIZE.prizename
  is '��Ʒ����(������ʵ�����������)';
comment on column TB_BREAK_EGG_PRIZE.prizeimg
  is '��ƷͼƬ';
comment on column TB_BREAK_EGG_PRIZE.prizetype
  is '��Ʒ���� 1ʵ�� 2���� 3���';
comment on column TB_BREAK_EGG_PRIZE.prizenumber
  is '��Ʒ����';
comment on column TB_BREAK_EGG_PRIZE.prizeprobability
  is '�н�����';
comment on column TB_BREAK_EGG_PRIZE.integral
  is '����ֵ';
comment on column TB_BREAK_EGG_PRIZE.redmoney
  is '���ֵ';
comment on column TB_BREAK_EGG_PRIZE.surplus_prize_number
  is 'ʣ������';
comment on column TB_BREAK_EGG_PRIZE.surplus_prize_probability
  is 'ʣ�ཱƷ����';
alter table TB_BREAK_EGG_PRIZE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_EXPRESS...
create table TB_EXPRESS
(
  id     VARCHAR2(64) not null,
  name   VARCHAR2(255) not null,
  remark VARCHAR2(255)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_GROUP_PURCHASE...
create table TB_GROUP_PURCHASE
(
  id                        VARCHAR2(64) not null,
  activityname              VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moble_background_img      VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64) default 0,
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  openprizenumber           VARCHAR2(64),
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  applyuserid               VARCHAR2(64),
  total                     VARCHAR2(64),
  groupprice                VARCHAR2(64),
  outtotal                  VARCHAR2(64),
  handle                    VARCHAR2(64) default 0,
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_GROUP_PURCHASE.activityname
  is '�����';
comment on column TB_GROUP_PURCHASE.background_img
  is '����ͼ';
comment on column TB_GROUP_PURCHASE.belong_activity_id
  is '�����ID';
comment on column TB_GROUP_PURCHASE.moble_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_GROUP_PURCHASE.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_GROUP_PURCHASE.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_GROUP_PURCHASE.join_prople_number
  is '�μ�����';
comment on column TB_GROUP_PURCHASE.winning_prople_number
  is '������';
comment on column TB_GROUP_PURCHASE.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_GROUP_PURCHASE.create_time
  is '��ʼʱ��';
comment on column TB_GROUP_PURCHASE.comfirmuserid
  is '����˵�ID';
comment on column TB_GROUP_PURCHASE.comfirmtime
  is '���ʱ��';
comment on column TB_GROUP_PURCHASE.comfirmadvise
  is '��˽���';
comment on column TB_GROUP_PURCHASE.comfirmusername
  is '���������';
comment on column TB_GROUP_PURCHASE.applyphone
  is '�����˵绰';
comment on column TB_GROUP_PURCHASE.applyusername
  is '����������';
comment on column TB_GROUP_PURCHASE.openprizenumber
  is '��������';
comment on column TB_GROUP_PURCHASE.spare_one
  is '�����ֶ�һ';
comment on column TB_GROUP_PURCHASE.spare_two
  is '�����ֶζ�';
comment on column TB_GROUP_PURCHASE.starttime
  is '��ʼʱ��';
comment on column TB_GROUP_PURCHASE.endtime
  is '����ʱ��';
comment on column TB_GROUP_PURCHASE.applyuserid
  is '������ID';
comment on column TB_GROUP_PURCHASE.total
  is '��Ʒ����';
comment on column TB_GROUP_PURCHASE.groupprice
  is 'ƴ�ż�';
comment on column TB_GROUP_PURCHASE.outtotal
  is '�˵���ƿ��';
comment on column TB_GROUP_PURCHASE.handle
  is '�������0δ����1�Ѵ���';
alter table TB_GROUP_PURCHASE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_GROUP_PURCHASE_GROUP_WXUSER...
create table TB_GROUP_PURCHASE_GROUP_WXUSER
(
  id                       VARCHAR2(64) not null,
  group_purchase_wxuser_id VARCHAR2(64),
  openid                   VARCHAR2(64),
  nickname                 VARCHAR2(1000),
  headimgurl               VARCHAR2(1000),
  create_time              VARCHAR2(64),
  state                    VARCHAR2(64),
  activity_name            VARCHAR2(64),
  creater                  VARCHAR2(64),
  paymoney                 VARCHAR2(64),
  paystate                 VARCHAR2(64) default 0,
  mchid                    VARCHAR2(64),
  payoutno                 VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.group_purchase_wxuser_id
  is 'ƴ��΢���û�����ID';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.create_time
  is '����ʱ��';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.state
  is '״̬';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.activity_name
  is '�����';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.creater
  is '������1 ������0
';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.paymoney
  is '֧�����
';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.paystate
  is '֧��״̬ 0δ֧�� 1֧��
';
alter table TB_GROUP_PURCHASE_GROUP_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_GROUP_PURCHASE_PRIZE...
create table TB_GROUP_PURCHASE_PRIZE
(
  id                VARCHAR2(64) not null,
  group_purchase_id VARCHAR2(64),
  prizename         VARCHAR2(64),
  prizeimg          VARCHAR2(64),
  prizenumber       VARCHAR2(64),
  spec              VARCHAR2(64),
  deep              VARCHAR2(64),
  volume            VARCHAR2(64),
  spare_one         VARCHAR2(64),
  spare_two         VARCHAR2(64),
  boxcount          VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_GROUP_PURCHASE_PRIZE.prizename
  is '��Ʒ����(����ֻ�Ǿ�)';
comment on column TB_GROUP_PURCHASE_PRIZE.prizeimg
  is '��ƷͼƬ';
comment on column TB_GROUP_PURCHASE_PRIZE.prizenumber
  is '��Ʒ����';
comment on column TB_GROUP_PURCHASE_PRIZE.spec
  is '���';
comment on column TB_GROUP_PURCHASE_PRIZE.deep
  is '����';
comment on column TB_GROUP_PURCHASE_PRIZE.volume
  is '����';
comment on column TB_GROUP_PURCHASE_PRIZE.boxcount
  is '����';
alter table TB_GROUP_PURCHASE_PRIZE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_GROUP_PURCHASE_WXUSER...
create table TB_GROUP_PURCHASE_WXUSER
(
  id                     VARCHAR2(64) not null,
  group_purchase_id      VARCHAR2(64),
  openid                 VARCHAR2(64),
  nickname               VARCHAR2(1000),
  headimgurl             VARCHAR2(1000),
  belong_publicnumber_id VARCHAR2(64),
  create_time            VARCHAR2(64),
  state                  VARCHAR2(64),
  scan_code              VARCHAR2(64),
  activity_name          VARCHAR2(64),
  paystate               VARCHAR2(64) default 0,
  paymoney               VARCHAR2(64) default 0.01,
  payoutno               VARCHAR2(64),
  mchid                  VARCHAR2(64),
  handle                 VARCHAR2(64) default 0,
  fulled                 VARCHAR2(64) default 0,
  goodstate              VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_GROUP_PURCHASE_WXUSER.group_purchase_id
  is 'ƴ�ŻID';
comment on column TB_GROUP_PURCHASE_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_GROUP_PURCHASE_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_GROUP_PURCHASE_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_GROUP_PURCHASE_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_GROUP_PURCHASE_WXUSER.create_time
  is '����ʱ��';
comment on column TB_GROUP_PURCHASE_WXUSER.state
  is '״̬';
comment on column TB_GROUP_PURCHASE_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_GROUP_PURCHASE_WXUSER.activity_name
  is '�����';
comment on column TB_GROUP_PURCHASE_WXUSER.paystate
  is '0δ֧�� 1֧��';
comment on column TB_GROUP_PURCHASE_WXUSER.paymoney
  is 'ƴ�� Ĭ��һԪ';
comment on column TB_GROUP_PURCHASE_WXUSER.payoutno
  is '֧��������';
comment on column TB_GROUP_PURCHASE_WXUSER.mchid
  is '�̻���';
comment on column TB_GROUP_PURCHASE_WXUSER.handle
  is '����״̬ 0δ���� 1�Ѵ���';
comment on column TB_GROUP_PURCHASE_WXUSER.fulled
  is '��Ա��� 0δ��Ա 1����Ա';
comment on column TB_GROUP_PURCHASE_WXUSER.goodstate
  is '����״̬ 0 δ����  1�ѷ���';
alter table TB_GROUP_PURCHASE_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_INTEGRAL...
create table TB_INTEGRAL
(
  integral_id               VARCHAR2(64) not null,
  sign_integral             VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moblec_background_img     VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64),
  winning_prople_number     VARCHAR2(64),
  state                     VARCHAR2(64),
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  total                     VARCHAR2(64),
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_INTEGRAL.sign_integral
  is 'ǩ����ȡ����';
comment on column TB_INTEGRAL.background_img
  is '����ͼ';
comment on column TB_INTEGRAL.belong_activity_id
  is '�����ID';
comment on column TB_INTEGRAL.moblec_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_INTEGRAL.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_INTEGRAL.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_INTEGRAL.join_prople_number
  is '�μ�����';
comment on column TB_INTEGRAL.winning_prople_number
  is '������';
comment on column TB_INTEGRAL.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_INTEGRAL.create_time
  is '����ʱ��';
comment on column TB_INTEGRAL.comfirmuserid
  is '����˵�ID';
comment on column TB_INTEGRAL.comfirmtime
  is '���ʱ��';
comment on column TB_INTEGRAL.comfirmadvise
  is '��˽���';
comment on column TB_INTEGRAL.comfirmusername
  is '���������';
comment on column TB_INTEGRAL.applyphone
  is '�����˵绰';
comment on column TB_INTEGRAL.applyusername
  is '����������';
comment on column TB_INTEGRAL.total
  is '��ƿ��';
comment on column TB_INTEGRAL.spare_one
  is '�����ֶ�һ';
comment on column TB_INTEGRAL.spare_two
  is '�����ֶζ�';
alter table TB_INTEGRAL
  add primary key (INTEGRAL_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_INTEGRAL_ACTIVITY...
create table TB_INTEGRAL_ACTIVITY
(
  id                VARCHAR2(64) not null,
  integral_id       VARCHAR2(64),
  order_number      VARCHAR2(64),
  activity_number   VARCHAR2(64),
  activity_name     VARCHAR2(64),
  activity_id       VARCHAR2(64),
  need_integral     VARCHAR2(64),
  ten_activity_id   VARCHAR2(64),
  ten_activity_name VARCHAR2(64),
  background_img    VARCHAR2(1000)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_INTEGRAL_ACTIVITY.integral_id
  is '����ID';
comment on column TB_INTEGRAL_ACTIVITY.order_number
  is '���';
comment on column TB_INTEGRAL_ACTIVITY.activity_number
  is '�����';
comment on column TB_INTEGRAL_ACTIVITY.activity_name
  is '�����';
comment on column TB_INTEGRAL_ACTIVITY.activity_id
  is '�ID';
comment on column TB_INTEGRAL_ACTIVITY.need_integral
  is '�������';
comment on column TB_INTEGRAL_ACTIVITY.ten_activity_id
  is 'ʮ���ID';
comment on column TB_INTEGRAL_ACTIVITY.ten_activity_name
  is 'ʮ�������';
comment on column TB_INTEGRAL_ACTIVITY.background_img
  is '�û���������ͼ';
alter table TB_INTEGRAL_ACTIVITY
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_INTEGRAL_EXCHANGE...
create table TB_INTEGRAL_EXCHANGE
(
  integral_exchange_id    VARCHAR2(64) not null,
  integral_id             VARCHAR2(64),
  exchange_type           VARCHAR2(64),
  exchange_prize_id       VARCHAR2(64),
  exchange_use_integral   VARCHAR2(64),
  exchange_prize_name     VARCHAR2(64),
  exchange_prize_img      VARCHAR2(1000),
  exchange_prize_number   VARCHAR2(64),
  ten_activity_id         VARCHAR2(64),
  ten_activity_name       VARCHAR2(64),
  openid                  VARCHAR2(64),
  addressee_name          VARCHAR2(64),
  addressee_address       VARCHAR2(255),
  addressee_phone         VARCHAR2(64),
  state                   VARCHAR2(64),
  lssue_user_name         VARCHAR2(64),
  lssue_user_userid       VARCHAR2(64),
  lssue_user_usercode     VARCHAR2(64),
  deliver_number          VARCHAR2(100),
  deliver_company         VARCHAR2(100),
  qrcode                  VARCHAR2(64),
  nickname                VARCHAR2(225),
  headimgurl              VARCHAR2(1000),
  create_time             VARCHAR2(64),
  deliver_time            VARCHAR2(64),
  product_winning_info_id VARCHAR2(64),
  belong_publicnumber_id  VARCHAR2(64),
  spareone                VARCHAR2(64),
  sparetwo                VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_INTEGRAL_EXCHANGE.integral_id
  is '���ֻID';
comment on column TB_INTEGRAL_EXCHANGE.exchange_type
  is '1=�һ������¼   2=�һ���Ʒ';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_id
  is '�һ���Ʒ��һ�������ID';
comment on column TB_INTEGRAL_EXCHANGE.exchange_use_integral
  is '�һ�ʹ�û���';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_name
  is '�һ���Ʒ��һ�����������';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_img
  is '�һ���Ʒ��һ�������ͼƬ';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_number
  is '�һ���Ʒ��һ�����������';
comment on column TB_INTEGRAL_EXCHANGE.ten_activity_id
  is 'ʮ���ID';
comment on column TB_INTEGRAL_EXCHANGE.ten_activity_name
  is 'ʮ�������';
comment on column TB_INTEGRAL_EXCHANGE.openid
  is '΢���û�ΨһID';
comment on column TB_INTEGRAL_EXCHANGE.addressee_name
  is '�ռ�������';
comment on column TB_INTEGRAL_EXCHANGE.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_INTEGRAL_EXCHANGE.addressee_phone
  is '�ռ��˵绰';
comment on column TB_INTEGRAL_EXCHANGE.state
  is '����״̬  1=�һ��ɹ�  2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_INTEGRAL_EXCHANGE.lssue_user_name
  is '����������';
comment on column TB_INTEGRAL_EXCHANGE.lssue_user_userid
  is '������USERID';
comment on column TB_INTEGRAL_EXCHANGE.lssue_user_usercode
  is '������USERCODE';
comment on column TB_INTEGRAL_EXCHANGE.deliver_number
  is '��ݵ���';
comment on column TB_INTEGRAL_EXCHANGE.deliver_company
  is '��ݹ�˾';
comment on column TB_INTEGRAL_EXCHANGE.qrcode
  is '�һ�����ʱ�����QRCODE����ѯ�һ����н�Ʒ';
comment on column TB_INTEGRAL_EXCHANGE.nickname
  is '�ǳ�';
comment on column TB_INTEGRAL_EXCHANGE.headimgurl
  is 'ͷ��';
comment on column TB_INTEGRAL_EXCHANGE.create_time
  is '����ʱ��';
comment on column TB_INTEGRAL_EXCHANGE.deliver_time
  is '����ʱ��';
comment on column TB_INTEGRAL_EXCHANGE.product_winning_info_id
  is 'ʵ���н���¼ID';
comment on column TB_INTEGRAL_EXCHANGE.belong_publicnumber_id
  is '�������ں�ID';
comment on column TB_INTEGRAL_EXCHANGE.spareone
  is '�洢״̬';
comment on column TB_INTEGRAL_EXCHANGE.sparetwo
  is '��������';
alter table TB_INTEGRAL_EXCHANGE
  add primary key (INTEGRAL_EXCHANGE_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_INTEGRAL_PRODUCT...
create table TB_INTEGRAL_PRODUCT
(
  id                     VARCHAR2(64) not null,
  integral_id            VARCHAR2(64),
  order_number           VARCHAR2(64),
  agent                  VARCHAR2(64),
  product_id             VARCHAR2(64),
  product_img            VARCHAR2(1000),
  product_name           VARCHAR2(64),
  product_number         VARCHAR2(64),
  product_introduce      VARCHAR2(512),
  need_integral          VARCHAR2(64),
  spec                   VARCHAR2(64),
  degree                 VARCHAR2(64),
  volume                 VARCHAR2(64),
  surplus_product_number VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_INTEGRAL_PRODUCT.integral_id
  is '����ID';
comment on column TB_INTEGRAL_PRODUCT.order_number
  is '���';
comment on column TB_INTEGRAL_PRODUCT.agent
  is '�Ƿ����ڴ����Ʒ 1=���� 2=����';
comment on column TB_INTEGRAL_PRODUCT.product_id
  is '��ƷID��������Ʒ��дID�������ڲ���д';
comment on column TB_INTEGRAL_PRODUCT.product_img
  is '��ƷͼƬ';
comment on column TB_INTEGRAL_PRODUCT.product_name
  is '��Ʒ����';
comment on column TB_INTEGRAL_PRODUCT.product_number
  is '��Ʒ����';
comment on column TB_INTEGRAL_PRODUCT.product_introduce
  is '��Ʒ����';
comment on column TB_INTEGRAL_PRODUCT.need_integral
  is '�������';
comment on column TB_INTEGRAL_PRODUCT.spec
  is '���';
comment on column TB_INTEGRAL_PRODUCT.degree
  is '����';
comment on column TB_INTEGRAL_PRODUCT.volume
  is '����';
comment on column TB_INTEGRAL_PRODUCT.surplus_product_number
  is 'ʣ���Ʒ����';
alter table TB_INTEGRAL_PRODUCT
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_INTEGRAL_WINNING_INFO...
create table TB_INTEGRAL_WINNING_INFO
(
  id                     VARCHAR2(64) not null,
  belong_activity_id     VARCHAR2(64),
  activity_name          VARCHAR2(64),
  activity_name_type     VARCHAR2(64),
  winning_integral       VARCHAR2(64) default 0,
  create_time            VARCHAR2(64),
  starttime              VARCHAR2(64),
  endtime                VARCHAR2(64),
  openid                 VARCHAR2(64),
  activity_wxuser_id     VARCHAR2(64),
  belong_publicnumber_id VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_INTEGRAL_WINNING_INFO
  is '�����н���Ϣ��';
comment on column TB_INTEGRAL_WINNING_INFO.id
  is 'Ψһ����';
comment on column TB_INTEGRAL_WINNING_INFO.belong_activity_id
  is '�����';
comment on column TB_INTEGRAL_WINNING_INFO.activity_name
  is '�����';
comment on column TB_INTEGRAL_WINNING_INFO.activity_name_type
  is '����ͣ���񿳼ۣ������...��';
comment on column TB_INTEGRAL_WINNING_INFO.winning_integral
  is '�н�����';
comment on column TB_INTEGRAL_WINNING_INFO.create_time
  is '����ʱ��';
comment on column TB_INTEGRAL_WINNING_INFO.starttime
  is '��ʼʱ��';
comment on column TB_INTEGRAL_WINNING_INFO.endtime
  is '����ʱ��';
comment on column TB_INTEGRAL_WINNING_INFO.openid
  is '΢���û�ID';
comment on column TB_INTEGRAL_WINNING_INFO.activity_wxuser_id
  is '�΢�Ų����¼ID';
comment on column TB_INTEGRAL_WINNING_INFO.belong_publicnumber_id
  is '���ں�I';
alter table TB_INTEGRAL_WINNING_INFO
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_MASTERDATA_LOG...
create table TB_MASTERDATA_LOG
(
  id                      VARCHAR2(64) default SYS_GUID(),
  account_num             VARCHAR2(64),
  account_group           VARCHAR2(255),
  account_group_type      VARCHAR2(255),
  dealer_type             VARCHAR2(255),
  simple_name             VARCHAR2(255),
  full_name               VARCHAR2(255),
  sales_area              VARCHAR2(255),
  business_number         VARCHAR2(255),
  tax_num                 VARCHAR2(255),
  bank_account            VARCHAR2(255),
  bank_name               VARCHAR2(255),
  organization_num        VARCHAR2(255),
  upper_organization_code VARCHAR2(255),
  is_subbranch            VARCHAR2(255),
  top_branch              VARCHAR2(255),
  transport_type          VARCHAR2(255),
  is_special              VARCHAR2(255),
  title                   VARCHAR2(255),
  address                 VARCHAR2(255),
  postcode                VARCHAR2(255),
  country                 VARCHAR2(255),
  cityid                  VARCHAR2(255),
  areaid                  VARCHAR2(255),
  quxianid                VARCHAR2(255),
  city                    VARCHAR2(255),
  area                    VARCHAR2(255),
  quxian                  VARCHAR2(255),
  phone                   VARCHAR2(255),
  email                   VARCHAR2(255),
  headquarters            VARCHAR2(255),
  supplier_account        VARCHAR2(255),
  business_contacts       VARCHAR2(255),
  business_contacts_phone VARCHAR2(255),
  receiving_contact       VARCHAR2(255),
  receiving_contact_phone VARCHAR2(255),
  old_num                 VARCHAR2(255),
  old_desc                VARCHAR2(255),
  create_by               VARCHAR2(255),
  create_date             VARCHAR2(255),
  update_by               VARCHAR2(255),
  update_date             VARCHAR2(255),
  operation_num           VARCHAR2(255),
  attribute1              VARCHAR2(255),
  status                  VARCHAR2(255),
  mdm_sys                 VARCHAR2(255),
  processed_status        NUMBER(38),
  create_time             DATE,
  update_time             DATE
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_MASTERDATA_LOG
  is '���յ��Ŀͻ������ݼ�¼��';
comment on column TB_MASTERDATA_LOG.id
  is '�������ݿ��Զ�����ΨһID';
comment on column TB_MASTERDATA_LOG.account_num
  is '�˻�����';
comment on column TB_MASTERDATA_LOG.account_group
  is '�˻���';
comment on column TB_MASTERDATA_LOG.account_group_type
  is '�˻������';
comment on column TB_MASTERDATA_LOG.dealer_type
  is '�����̷���';
comment on column TB_MASTERDATA_LOG.simple_name
  is '���';
comment on column TB_MASTERDATA_LOG.full_name
  is 'ȫ��';
comment on column TB_MASTERDATA_LOG.sales_area
  is '��������';
comment on column TB_MASTERDATA_LOG.business_number
  is '���̵ǼǺ�';
comment on column TB_MASTERDATA_LOG.tax_num
  is '˰�����';
comment on column TB_MASTERDATA_LOG.bank_account
  is '�����˺�';
comment on column TB_MASTERDATA_LOG.bank_name
  is '����������';
comment on column TB_MASTERDATA_LOG.organization_num
  is '��֯�ṹ����';
comment on column TB_MASTERDATA_LOG.upper_organization_code
  is '�ϲ���֯����';
comment on column TB_MASTERDATA_LOG.is_subbranch
  is '�Ƿ��֧����';
comment on column TB_MASTERDATA_LOG.top_branch
  is '��֧�����˻�����';
comment on column TB_MASTERDATA_LOG.transport_type
  is '���䷽ʽ';
comment on column TB_MASTERDATA_LOG.is_special
  is '�Ƿ�רƱ';
comment on column TB_MASTERDATA_LOG.title
  is '����';
comment on column TB_MASTERDATA_LOG.address
  is '��ַ';
comment on column TB_MASTERDATA_LOG.postcode
  is '��������';
comment on column TB_MASTERDATA_LOG.country
  is '����';
comment on column TB_MASTERDATA_LOG.cityid
  is '��id';
comment on column TB_MASTERDATA_LOG.areaid
  is 'ʡid';
comment on column TB_MASTERDATA_LOG.quxianid
  is '��';
comment on column TB_MASTERDATA_LOG.city
  is '����id';
comment on column TB_MASTERDATA_LOG.area
  is 'ʡ';
comment on column TB_MASTERDATA_LOG.quxian
  is '����';
comment on column TB_MASTERDATA_LOG.phone
  is '����id';
comment on column TB_MASTERDATA_LOG.email
  is 'email';
comment on column TB_MASTERDATA_LOG.headquarters
  is '�ܲ�';
comment on column TB_MASTERDATA_LOG.supplier_account
  is '��Ӧ���˺�';
comment on column TB_MASTERDATA_LOG.business_contacts
  is '��ҵ��ϵ��1  ';
comment on column TB_MASTERDATA_LOG.business_contacts_phone
  is '��ҵ��ϵ��1�绰';
comment on column TB_MASTERDATA_LOG.receiving_contact
  is '��ҵ��ϵ��2';
comment on column TB_MASTERDATA_LOG.receiving_contact_phone
  is '��ҵ��ϵ��2�绰  ';
comment on column TB_MASTERDATA_LOG.old_num
  is '�ɿͻ���';
comment on column TB_MASTERDATA_LOG.old_desc
  is '�ɿͻ�����';
comment on column TB_MASTERDATA_LOG.create_by
  is '������';
comment on column TB_MASTERDATA_LOG.create_date
  is '����ʱ��';
comment on column TB_MASTERDATA_LOG.update_by
  is '�޸���';
comment on column TB_MASTERDATA_LOG.update_date
  is '�޸�ʱ��';
comment on column TB_MASTERDATA_LOG.operation_num
  is '��������';
comment on column TB_MASTERDATA_LOG.attribute1
  is '�����ֶ�';
comment on column TB_MASTERDATA_LOG.status
  is '�Ƿ�ɾ��';
comment on column TB_MASTERDATA_LOG.mdm_sys
  is '��������������';
comment on column TB_MASTERDATA_LOG.processed_status
  is '����״̬:0-��������δ����';
comment on column TB_MASTERDATA_LOG.create_time
  is '�ӿڽ�����������';
comment on column TB_MASTERDATA_LOG.update_time
  is '�ӿڴ�����������';

prompt Creating TB_ONEMONEY_WXUSER_WINNING...
create table TB_ONEMONEY_WXUSER_WINNING
(
  id                      VARCHAR2(64) not null,
  onemoney_wxuser_id      VARCHAR2(64),
  prize_type              VARCHAR2(64) default 1,
  belong_winning_prize_id VARCHAR2(64),
  prize_project           VARCHAR2(64),
  create_time             VARCHAR2(64),
  prize_project_img       VARCHAR2(1000),
  openid                  VARCHAR2(64),
  state                   VARCHAR2(64),
  addressee_name          VARCHAR2(64),
  addressee_address       VARCHAR2(255),
  addressee_phone         VARCHAR2(64),
  lssue_user_name         VARCHAR2(64),
  lssue_user_userid       VARCHAR2(64),
  lssue_user_usercode     VARCHAR2(64),
  deliver_number          VARCHAR2(64),
  deliver_company         VARCHAR2(64),
  deliver_time            VARCHAR2(64),
  product_winning_info_id VARCHAR2(64),
  spareone                VARCHAR2(64),
  sparetwo                VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ONEMONEY_WXUSER_WINNING.onemoney_wxuser_id
  is 'һԪ�������¼ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_ONEMONEY_WXUSER_WINNING.belong_winning_prize_id
  is '�����н�ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.prize_project
  is '��Ʒ����';
comment on column TB_ONEMONEY_WXUSER_WINNING.create_time
  is '����ʱ��';
comment on column TB_ONEMONEY_WXUSER_WINNING.prize_project_img
  is '��ƷͼƬ';
comment on column TB_ONEMONEY_WXUSER_WINNING.openid
  is '΢��ָ��ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_ONEMONEY_WXUSER_WINNING.addressee_name
  is '�ռ�������';
comment on column TB_ONEMONEY_WXUSER_WINNING.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_ONEMONEY_WXUSER_WINNING.addressee_phone
  is '�ռ��˵绰';
comment on column TB_ONEMONEY_WXUSER_WINNING.lssue_user_name
  is '����������';
comment on column TB_ONEMONEY_WXUSER_WINNING.lssue_user_userid
  is '������USERID';
comment on column TB_ONEMONEY_WXUSER_WINNING.lssue_user_usercode
  is '������USERCODE';
comment on column TB_ONEMONEY_WXUSER_WINNING.deliver_number
  is '��ݵ���';
comment on column TB_ONEMONEY_WXUSER_WINNING.deliver_company
  is '��ݹ�˾';
comment on column TB_ONEMONEY_WXUSER_WINNING.deliver_time
  is '����ʱ��';
comment on column TB_ONEMONEY_WXUSER_WINNING.product_winning_info_id
  is 'ʵ���н���¼ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.spareone
  is '�洢��Ʒ����';
comment on column TB_ONEMONEY_WXUSER_WINNING.sparetwo
  is '�洢״̬';
alter table TB_ONEMONEY_WXUSER_WINNING
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ONE_MONEY_GROUP_WXUSER...
create table TB_ONE_MONEY_GROUP_WXUSER
(
  id                 VARCHAR2(64) not null,
  onemoney_wxuser_id VARCHAR2(64),
  openid             VARCHAR2(64),
  nickname           VARCHAR2(1000),
  headimgurl         VARCHAR2(1000),
  create_time        VARCHAR2(64),
  state              VARCHAR2(64),
  activity_name      VARCHAR2(64),
  creater            VARCHAR2(64),
  paymoney           VARCHAR2(64),
  paystate           VARCHAR2(64) default 0,
  mchid              VARCHAR2(64),
  payoutno           VARCHAR2(64),
  returnstate        VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ONE_MONEY_GROUP_WXUSER.onemoney_wxuser_id
  is 'һԪ��΢���û�����ID';
comment on column TB_ONE_MONEY_GROUP_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_ONE_MONEY_GROUP_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_ONE_MONEY_GROUP_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_ONE_MONEY_GROUP_WXUSER.create_time
  is '����ʱ��';
comment on column TB_ONE_MONEY_GROUP_WXUSER.state
  is '״̬';
comment on column TB_ONE_MONEY_GROUP_WXUSER.activity_name
  is '�����';
comment on column TB_ONE_MONEY_GROUP_WXUSER.creater
  is '������1 ������0
';
comment on column TB_ONE_MONEY_GROUP_WXUSER.paymoney
  is '֧�����
';
comment on column TB_ONE_MONEY_GROUP_WXUSER.paystate
  is '֧��״̬ 0δ֧�� 1֧��
';
comment on column TB_ONE_MONEY_GROUP_WXUSER.returnstate
  is '�˿�״̬0û���˿� 1�Ѿ��˿�
';
alter table TB_ONE_MONEY_GROUP_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ONE_MONEY_PRIZE...
create table TB_ONE_MONEY_PRIZE
(
  id           VARCHAR2(64) not null,
  one_money_id VARCHAR2(64),
  prizename    VARCHAR2(64),
  prizeimg     VARCHAR2(64),
  prizenumber  VARCHAR2(64),
  spec         VARCHAR2(64),
  deep         VARCHAR2(64),
  volume       VARCHAR2(64),
  spare_one    VARCHAR2(64),
  spare_two    VARCHAR2(64),
  boxcount     VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ONE_MONEY_PRIZE.prizename
  is '��Ʒ����(����ֻ�Ǿ�)';
comment on column TB_ONE_MONEY_PRIZE.prizeimg
  is '��ƷͼƬ';
comment on column TB_ONE_MONEY_PRIZE.prizenumber
  is '��Ʒ����';
comment on column TB_ONE_MONEY_PRIZE.spec
  is '���';
comment on column TB_ONE_MONEY_PRIZE.deep
  is '����';
comment on column TB_ONE_MONEY_PRIZE.volume
  is '����';
comment on column TB_ONE_MONEY_PRIZE.boxcount
  is '����';
alter table TB_ONE_MONEY_PRIZE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ONE_MONEY_SHOP...
create table TB_ONE_MONEY_SHOP
(
  id                        VARCHAR2(64) not null,
  activityname              VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moble_background_img      VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64) default 0,
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  openprizenumber           VARCHAR2(64),
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  applyuserid               VARCHAR2(64),
  total                     VARCHAR2(64),
  groupmoney                VARCHAR2(64) default 1,
  handle                    VARCHAR2(64) default 0,
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ONE_MONEY_SHOP.activityname
  is '�����';
comment on column TB_ONE_MONEY_SHOP.background_img
  is '����ͼ';
comment on column TB_ONE_MONEY_SHOP.belong_activity_id
  is '�����ID';
comment on column TB_ONE_MONEY_SHOP.moble_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_ONE_MONEY_SHOP.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_ONE_MONEY_SHOP.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_ONE_MONEY_SHOP.join_prople_number
  is '�μ�����';
comment on column TB_ONE_MONEY_SHOP.winning_prople_number
  is '������';
comment on column TB_ONE_MONEY_SHOP.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_ONE_MONEY_SHOP.create_time
  is '��ʼʱ��';
comment on column TB_ONE_MONEY_SHOP.comfirmuserid
  is '����˵�ID';
comment on column TB_ONE_MONEY_SHOP.comfirmtime
  is '���ʱ��';
comment on column TB_ONE_MONEY_SHOP.comfirmadvise
  is '��˽���';
comment on column TB_ONE_MONEY_SHOP.comfirmusername
  is '���������';
comment on column TB_ONE_MONEY_SHOP.applyphone
  is '�����˵绰';
comment on column TB_ONE_MONEY_SHOP.applyusername
  is '����������';
comment on column TB_ONE_MONEY_SHOP.openprizenumber
  is '��������';
comment on column TB_ONE_MONEY_SHOP.spare_one
  is '�����ֶ�һ';
comment on column TB_ONE_MONEY_SHOP.spare_two
  is '�����ֶζ�';
comment on column TB_ONE_MONEY_SHOP.starttime
  is '��ʼʱ��';
comment on column TB_ONE_MONEY_SHOP.endtime
  is '����ʱ��';
comment on column TB_ONE_MONEY_SHOP.applyuserid
  is '������ID';
comment on column TB_ONE_MONEY_SHOP.total
  is '��Ʒ����';
comment on column TB_ONE_MONEY_SHOP.groupmoney
  is '���ż� ֧�����һԪ�� Ĭ��һԪ';
comment on column TB_ONE_MONEY_SHOP.handle
  is '�������0δ����1�Ѵ���';
alter table TB_ONE_MONEY_SHOP
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ONE_MONEY_WXUSER...
create table TB_ONE_MONEY_WXUSER
(
  id                     VARCHAR2(64) not null,
  one_money_id           VARCHAR2(64),
  openid                 VARCHAR2(64),
  nickname               VARCHAR2(1000),
  headimgurl             VARCHAR2(1000),
  belong_publicnumber_id VARCHAR2(64),
  create_time            VARCHAR2(64),
  state                  VARCHAR2(64),
  scan_code              VARCHAR2(64),
  activity_name          VARCHAR2(64),
  paystate               VARCHAR2(64) default 0,
  paymoney               VARCHAR2(64) default 1,
  payoutno               VARCHAR2(64),
  mchid                  VARCHAR2(64),
  handle                 VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ONE_MONEY_WXUSER.one_money_id
  is 'һԪ���ID';
comment on column TB_ONE_MONEY_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_ONE_MONEY_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_ONE_MONEY_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_ONE_MONEY_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_ONE_MONEY_WXUSER.create_time
  is '����ʱ��';
comment on column TB_ONE_MONEY_WXUSER.state
  is '״̬';
comment on column TB_ONE_MONEY_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_ONE_MONEY_WXUSER.activity_name
  is '�����';
comment on column TB_ONE_MONEY_WXUSER.paystate
  is '0δ֧�� 1֧��';
comment on column TB_ONE_MONEY_WXUSER.paymoney
  is 'һԪ�� Ĭ��һԪ';
comment on column TB_ONE_MONEY_WXUSER.payoutno
  is '֧��������';
comment on column TB_ONE_MONEY_WXUSER.mchid
  is '�̻���';
comment on column TB_ONE_MONEY_WXUSER.handle
  is '����״̬ 0δ���� 1�Ѵ���';
alter table TB_ONE_MONEY_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_PRODUCT_WINNING_INFO...
create table TB_PRODUCT_WINNING_INFO
(
  id                     VARCHAR2(64) not null,
  belong_activity_id     VARCHAR2(64),
  activity_name          VARCHAR2(64),
  activity_name_type     VARCHAR2(64),
  product_id             VARCHAR2(64),
  product_name           VARCHAR2(64),
  product_img            VARCHAR2(1000),
  activity_prize_id      VARCHAR2(64),
  create_time            VARCHAR2(64),
  starttime              VARCHAR2(64),
  endtime                VARCHAR2(64),
  openid                 VARCHAR2(64),
  activity_wxuser_id     VARCHAR2(64),
  belong_publicnumber_id VARCHAR2(64),
  state                  VARCHAR2(64),
  winning_info_id        VARCHAR2(64),
  deliver_number         VARCHAR2(64),
  deliver_company        VARCHAR2(64),
  deliver_time           VARCHAR2(64),
  addressee_name         VARCHAR2(64),
  addressee_address      VARCHAR2(255),
  addressee_phone        VARCHAR2(64),
  pay_money              VARCHAR2(64) default 0,
  price                  VARCHAR2(64) default 0,
  low_price              VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_PRODUCT_WINNING_INFO.belong_activity_id
  is '�����ID';
comment on column TB_PRODUCT_WINNING_INFO.activity_name
  is '�����';
comment on column TB_PRODUCT_WINNING_INFO.activity_name_type
  is '����ͣ���񿳼ۣ������...��';
comment on column TB_PRODUCT_WINNING_INFO.product_id
  is 'ʵ���ƷID';
comment on column TB_PRODUCT_WINNING_INFO.product_name
  is 'ʵ���Ʒ����';
comment on column TB_PRODUCT_WINNING_INFO.product_img
  is 'ʵ���ƷͼƬ';
comment on column TB_PRODUCT_WINNING_INFO.activity_prize_id
  is '���Ʒ����ID';
comment on column TB_PRODUCT_WINNING_INFO.create_time
  is '����ʱ��';
comment on column TB_PRODUCT_WINNING_INFO.starttime
  is '��ʼʱ��';
comment on column TB_PRODUCT_WINNING_INFO.endtime
  is '����ʱ��';
comment on column TB_PRODUCT_WINNING_INFO.openid
  is '΢���û�ID';
comment on column TB_PRODUCT_WINNING_INFO.activity_wxuser_id
  is '�΢�Ų����¼ID';
comment on column TB_PRODUCT_WINNING_INFO.belong_publicnumber_id
  is '�������ں�';
comment on column TB_PRODUCT_WINNING_INFO.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_PRODUCT_WINNING_INFO.winning_info_id
  is '�н���¼ID';
comment on column TB_PRODUCT_WINNING_INFO.deliver_number
  is '��ݵ��� ';
comment on column TB_PRODUCT_WINNING_INFO.deliver_company
  is '��ݹ�˾';
comment on column TB_PRODUCT_WINNING_INFO.deliver_time
  is '����ʱ��';
comment on column TB_PRODUCT_WINNING_INFO.addressee_name
  is '�ռ�������';
comment on column TB_PRODUCT_WINNING_INFO.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_PRODUCT_WINNING_INFO.addressee_phone
  is '�ռ��˵绰';
comment on column TB_PRODUCT_WINNING_INFO.pay_money
  is '֧�����';
comment on column TB_PRODUCT_WINNING_INFO.price
  is 'ԭ��';
comment on column TB_PRODUCT_WINNING_INFO.low_price
  is '��ͼ۸�';
alter table TB_PRODUCT_WINNING_INFO
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_PURCHASE_WXUSER_WINNING...
create table TB_PURCHASE_WXUSER_WINNING
(
  id                      VARCHAR2(64) not null,
  purchase_wxuser_id      VARCHAR2(64),
  prize_type              VARCHAR2(64) default 1,
  belong_winning_prize_id VARCHAR2(64),
  prize_project           VARCHAR2(64),
  create_time             VARCHAR2(64),
  prize_project_img       VARCHAR2(1000),
  openid                  VARCHAR2(64),
  state                   VARCHAR2(64),
  addressee_name          VARCHAR2(64),
  addressee_address       VARCHAR2(255),
  addressee_phone         VARCHAR2(64),
  lssue_user_name         VARCHAR2(64),
  lssue_user_userid       VARCHAR2(64),
  lssue_user_usercode     VARCHAR2(64),
  deliver_number          VARCHAR2(64),
  deliver_company         VARCHAR2(64),
  deliver_time            VARCHAR2(64),
  product_winning_info_id VARCHAR2(64),
  spareone                VARCHAR2(64),
  sparetwo                VARCHAR2(64),
  nickname                VARCHAR2(1000),
  headimgurl              VARCHAR2(1000)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_PURCHASE_WXUSER_WINNING.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����''';
alter table TB_PURCHASE_WXUSER_WINNING
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_PUZZLE...
create table TB_PUZZLE
(
  id                        VARCHAR2(64) not null,
  activityname              VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moble_background_img      VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64) default 0,
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  applyuserid               VARCHAR2(64),
  total                     VARCHAR2(64),
  looktime                  VARCHAR2(64),
  palytime                  VARCHAR2(64),
  puzzleimg                 VARCHAR2(1000),
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_PUZZLE.activityname
  is '�����';
comment on column TB_PUZZLE.background_img
  is '����ͼ';
comment on column TB_PUZZLE.belong_activity_id
  is '�����ID';
comment on column TB_PUZZLE.moble_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_PUZZLE.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_PUZZLE.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_PUZZLE.join_prople_number
  is '�μ�����';
comment on column TB_PUZZLE.winning_prople_number
  is '������';
comment on column TB_PUZZLE.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_PUZZLE.create_time
  is '��ʼʱ��';
comment on column TB_PUZZLE.comfirmuserid
  is '����˵�ID';
comment on column TB_PUZZLE.comfirmtime
  is '���ʱ��';
comment on column TB_PUZZLE.comfirmadvise
  is '��˽���';
comment on column TB_PUZZLE.comfirmusername
  is '���������';
comment on column TB_PUZZLE.applyphone
  is '�����˵绰';
comment on column TB_PUZZLE.applyusername
  is '����������';
comment on column TB_PUZZLE.spare_one
  is '�����ֶ�һ';
comment on column TB_PUZZLE.spare_two
  is '�����ֶζ�';
comment on column TB_PUZZLE.starttime
  is '��ʼʱ��';
comment on column TB_PUZZLE.endtime
  is '����ʱ��';
comment on column TB_PUZZLE.applyuserid
  is '������ID';
comment on column TB_PUZZLE.total
  is '��Ʒ����';
comment on column TB_PUZZLE.looktime
  is '��ͼʱ��';
comment on column TB_PUZZLE.palytime
  is 'ƴͼ��ʱ';
comment on column TB_PUZZLE.puzzleimg
  is 'ƴͼͼƬ';
alter table TB_PUZZLE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_PUZZLE_PRIZE...
create table TB_PUZZLE_PRIZE
(
  id          VARCHAR2(64) not null,
  puzzle_id   VARCHAR2(64),
  prizename   VARCHAR2(64),
  prizenumber VARCHAR2(64),
  spec        VARCHAR2(64),
  deep        VARCHAR2(64),
  volume      VARCHAR2(64),
  spare_one   VARCHAR2(64),
  spare_two   VARCHAR2(64),
  boxcount    VARCHAR2(64),
  productimg  VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_PUZZLE_PRIZE.prizename
  is '��Ʒ����(����ֻ�Ǿ�)';
comment on column TB_PUZZLE_PRIZE.prizenumber
  is '��Ʒ����';
comment on column TB_PUZZLE_PRIZE.spec
  is '���';
comment on column TB_PUZZLE_PRIZE.deep
  is '����';
comment on column TB_PUZZLE_PRIZE.volume
  is '����';
comment on column TB_PUZZLE_PRIZE.boxcount
  is '����';
comment on column TB_PUZZLE_PRIZE.productimg
  is 'ͼƬ';
alter table TB_PUZZLE_PRIZE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_PUZZLE_WXUSER...
create table TB_PUZZLE_WXUSER
(
  id                     VARCHAR2(64) not null,
  puzzle_id              VARCHAR2(64),
  openid                 VARCHAR2(64),
  nickname               VARCHAR2(1000),
  headimgurl             VARCHAR2(1000),
  belong_publicnumber_id VARCHAR2(64),
  create_time            VARCHAR2(64),
  state                  VARCHAR2(64),
  scan_code              VARCHAR2(64),
  activity_name          VARCHAR2(64),
  goodstate              VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_PUZZLE_WXUSER
  is 'TB_ACCUMUL_COMMENT_WXUSER   ƴͼ΢�Ų����û���¼';
comment on column TB_PUZZLE_WXUSER.puzzle_id
  is '�ID';
comment on column TB_PUZZLE_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_PUZZLE_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_PUZZLE_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_PUZZLE_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_PUZZLE_WXUSER.create_time
  is '����ʱ��';
comment on column TB_PUZZLE_WXUSER.state
  is '״̬0��ʼƴͼ 1�ɹ� 2δ�ɹ� 3δ��ʼƴͼ';
comment on column TB_PUZZLE_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_PUZZLE_WXUSER.activity_name
  is '�����';
comment on column TB_PUZZLE_WXUSER.goodstate
  is '����״̬ 0 δ����  1�ѷ���';
alter table TB_PUZZLE_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_PUZZLE_WXUSER_WINNING...
create table TB_PUZZLE_WXUSER_WINNING
(
  id                      VARCHAR2(64) not null,
  puzzle_wxuser_id        VARCHAR2(64),
  prize_type              VARCHAR2(64),
  belong_winning_prize_id VARCHAR2(64),
  winning_money           VARCHAR2(64) default 0,
  prize_project           VARCHAR2(64),
  create_time             VARCHAR2(64),
  prize_project_img       VARCHAR2(1000),
  openid                  VARCHAR2(64),
  state                   VARCHAR2(64) default 1,
  addressee_name          VARCHAR2(64),
  addressee_address       VARCHAR2(255),
  addressee_phone         VARCHAR2(64),
  lssue_user_name         VARCHAR2(64),
  lssue_user_userid       VARCHAR2(64),
  lssue_user_usercode     VARCHAR2(64),
  deliver_number          VARCHAR2(64),
  deliver_company         VARCHAR2(64),
  deliver_time            VARCHAR2(64),
  product_winning_info_id VARCHAR2(64),
  spare_one               VARCHAR2(64),
  spare_two               VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_PUZZLE_WXUSER_WINNING.puzzle_wxuser_id
  is 'ƴͼ�����¼ID';
comment on column TB_PUZZLE_WXUSER_WINNING.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_PUZZLE_WXUSER_WINNING.belong_winning_prize_id
  is '�����н�ID';
comment on column TB_PUZZLE_WXUSER_WINNING.winning_money
  is '�н����/����';
comment on column TB_PUZZLE_WXUSER_WINNING.prize_project
  is '��Ʒ����';
comment on column TB_PUZZLE_WXUSER_WINNING.create_time
  is '����ʱ��';
comment on column TB_PUZZLE_WXUSER_WINNING.prize_project_img
  is '��ƷͼƬ';
comment on column TB_PUZZLE_WXUSER_WINNING.openid
  is '΢��ָ��ID';
comment on column TB_PUZZLE_WXUSER_WINNING.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_PUZZLE_WXUSER_WINNING.addressee_name
  is '�ռ�������';
comment on column TB_PUZZLE_WXUSER_WINNING.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_PUZZLE_WXUSER_WINNING.addressee_phone
  is '�ռ��˵绰';
comment on column TB_PUZZLE_WXUSER_WINNING.lssue_user_name
  is '����������';
comment on column TB_PUZZLE_WXUSER_WINNING.lssue_user_userid
  is '������USERID';
comment on column TB_PUZZLE_WXUSER_WINNING.lssue_user_usercode
  is '������USERCODE';
comment on column TB_PUZZLE_WXUSER_WINNING.deliver_number
  is '��ݵ���';
comment on column TB_PUZZLE_WXUSER_WINNING.deliver_company
  is '��ݹ�˾';
comment on column TB_PUZZLE_WXUSER_WINNING.deliver_time
  is '����ʱ��';
comment on column TB_PUZZLE_WXUSER_WINNING.product_winning_info_id
  is 'ʵ���н���¼ID';
comment on column TB_PUZZLE_WXUSER_WINNING.spare_one
  is '�洢��Ʒ����';
comment on column TB_PUZZLE_WXUSER_WINNING.spare_two
  is '�洢״̬';
alter table TB_PUZZLE_WXUSER_WINNING
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_RED_WINNING_INFO...
create table TB_RED_WINNING_INFO
(
  id                     VARCHAR2(64) not null,
  belong_activity_id     VARCHAR2(64),
  activity_name          VARCHAR2(64),
  activity_name_type     VARCHAR2(64),
  winning_red_total      VARCHAR2(64) default 0,
  create_time            VARCHAR2(64),
  state                  VARCHAR2(64) default 0,
  starttime              VARCHAR2(64),
  endtime                VARCHAR2(64),
  withdrawals            VARCHAR2(64) default 0,
  activity_wxuser_id     VARCHAR2(64),
  openid                 VARCHAR2(64),
  belong_publicnumber_id VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_RED_WINNING_INFO.belong_activity_id
  is '�����ID';
comment on column TB_RED_WINNING_INFO.activity_name
  is '�����';
comment on column TB_RED_WINNING_INFO.activity_name_type
  is '����ͣ���񿳼ۣ������...��';
comment on column TB_RED_WINNING_INFO.winning_red_total
  is '�н�����ϼ�';
comment on column TB_RED_WINNING_INFO.create_time
  is '����ʱ��';
comment on column TB_RED_WINNING_INFO.state
  is '״̬ 0=δ��� 1=���    ';
comment on column TB_RED_WINNING_INFO.starttime
  is '��ʼʱ��';
comment on column TB_RED_WINNING_INFO.endtime
  is '����ʱ��';
comment on column TB_RED_WINNING_INFO.withdrawals
  is '�Ƿ�����0=δ����  1=������';
comment on column TB_RED_WINNING_INFO.activity_wxuser_id
  is '΢�Ų����¼ID';
comment on column TB_RED_WINNING_INFO.openid
  is '�û�΢��ID';
comment on column TB_RED_WINNING_INFO.belong_publicnumber_id
  is '���ں�ID';

prompt Creating TB_ROB_RED...
create table TB_ROB_RED
(
  red_id                    VARCHAR2(64) not null,
  activity_name             VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moblec_background_img     VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  scan_red_number           VARCHAR2(64),
  pattern                   VARCHAR2(64),
  spare_one                 VARCHAR2(255),
  spare_two                 VARCHAR2(255),
  sendername                VARCHAR2(100),
  wish                      VARCHAR2(64),
  remarks                   VARCHAR2(64),
  total                     VARCHAR2(64),
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ROB_RED.activity_name
  is '�����';
comment on column TB_ROB_RED.background_img
  is '����ͼ';
comment on column TB_ROB_RED.belong_activity_id
  is '�����ID';
comment on column TB_ROB_RED.moblec_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_ROB_RED.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_ROB_RED.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_ROB_RED.join_prople_number
  is '��������';
comment on column TB_ROB_RED.winning_prople_number
  is '������';
comment on column TB_ROB_RED.state
  is '�״̬��0������ ? 1����ͨ�� ?2 �Ѳ���';
comment on column TB_ROB_RED.starttime
  is '���ʼʱ��';
comment on column TB_ROB_RED.endtime
  is '�����ʱ��';
comment on column TB_ROB_RED.create_time
  is '����ʱ��';
comment on column TB_ROB_RED.comfirmuserid
  is '����˵�ID';
comment on column TB_ROB_RED.comfirmtime
  is '���ʱ��';
comment on column TB_ROB_RED.comfirmadvise
  is '��˽���';
comment on column TB_ROB_RED.comfirmusername
  is '���������';
comment on column TB_ROB_RED.applyphone
  is '�����˵绰';
comment on column TB_ROB_RED.applyusername
  is '����������';
comment on column TB_ROB_RED.scan_red_number
  is 'ɨ��������';
comment on column TB_ROB_RED.pattern
  is 'ģʽ 1=ģʽһ   2=ģʽ��';
comment on column TB_ROB_RED.spare_one
  is '�����ֶ�һ';
comment on column TB_ROB_RED.spare_two
  is '�����ֶζ�';
comment on column TB_ROB_RED.sendername
  is '�������������';
comment on column TB_ROB_RED.wish
  is 'ף����';
comment on column TB_ROB_RED.remarks
  is '�����ע';
comment on column TB_ROB_RED.total
  is '�ƿ����';
alter table TB_ROB_RED
  add primary key (RED_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ROB_RED_PRIZE...
create table TB_ROB_RED_PRIZE
(
  red_prize_id                 VARCHAR2(64) not null,
  red_id                       VARCHAR2(64),
  prize_project                VARCHAR2(64),
  prize_project_money          VARCHAR2(64),
  get_prize_number             VARCHAR2(64),
  subtotal                     VARCHAR2(64),
  red_winning_probability      VARCHAR2(64),
  winning_integral             VARCHAR2(64),
  winning_integral_number      VARCHAR2(64),
  red_probability_total        VARCHAR2(64),
  prize_project_total_money    VARCHAR2(64),
  scanrodrednum                VARCHAR2(64),
  integral_winning_probability VARCHAR2(64),
  integral_probability_total   VARCHAR2(64),
  surplus_probability          VARCHAR2(64),
  create_time                  VARCHAR2(64) default '',
  surplus_number               VARCHAR2(64),
  surplus_prize_probability    VARCHAR2(64),
  surplus_integral_number      VARCHAR2(64),
  surplus_integral_probability VARCHAR2(64),
  surplus_integral             VARCHAR2(64),
  surplus_money                VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ROB_RED_PRIZE.red_id
  is '������ID';
comment on column TB_ROB_RED_PRIZE.prize_project
  is '����';
comment on column TB_ROB_RED_PRIZE.prize_project_money
  is 'ģʽһ:������  ģʽ��:������';
comment on column TB_ROB_RED_PRIZE.get_prize_number
  is 'ģʽһ:��Ʒ����  ģʽ��:�н�����';
comment on column TB_ROB_RED_PRIZE.subtotal
  is 'С��';
comment on column TB_ROB_RED_PRIZE.red_winning_probability
  is '����н�����';
comment on column TB_ROB_RED_PRIZE.winning_integral
  is '�н�����';
comment on column TB_ROB_RED_PRIZE.winning_integral_number
  is '�����н�����';
comment on column TB_ROB_RED_PRIZE.red_probability_total
  is '������ʺϼ�';
comment on column TB_ROB_RED_PRIZE.prize_project_total_money
  is '������ϼ�';
comment on column TB_ROB_RED_PRIZE.scanrodrednum
  is 'ɨ���н�����';
comment on column TB_ROB_RED_PRIZE.integral_winning_probability
  is '�����н�����';
comment on column TB_ROB_RED_PRIZE.integral_probability_total
  is '���ָ��ʺϼ�';
comment on column TB_ROB_RED_PRIZE.surplus_probability
  is 'ʣ�����';
comment on column TB_ROB_RED_PRIZE.create_time
  is '����ʱ��';
comment on column TB_ROB_RED_PRIZE.surplus_number
  is 'ʣ������';
comment on column TB_ROB_RED_PRIZE.surplus_prize_probability
  is 'ʣ�ཱƷ�н�����';
comment on column TB_ROB_RED_PRIZE.surplus_integral_number
  is 'ʣ���������';
comment on column TB_ROB_RED_PRIZE.surplus_integral_probability
  is 'ʣ����ֽ�Ʒ�н�����';
comment on column TB_ROB_RED_PRIZE.surplus_integral
  is 'ʣ�����';
comment on column TB_ROB_RED_PRIZE.surplus_money
  is 'ʣ����';
alter table TB_ROB_RED_PRIZE
  add primary key (RED_PRIZE_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ROB_RED_WXUSER...
create table TB_ROB_RED_WXUSER
(
  red_wxuser_id          VARCHAR2(64) not null,
  red_id                 VARCHAR2(64),
  openid                 VARCHAR2(64),
  nickname               VARCHAR2(1000),
  headimgurl             VARCHAR2(1000),
  belong_publicnumber_id VARCHAR2(64),
  create_time            VARCHAR2(64),
  state                  VARCHAR2(64) default 0,
  scan_code              VARCHAR2(64),
  scan_red_number        VARCHAR2(64),
  total_money            VARCHAR2(64) default 0,
  activity_name          VARCHAR2(64),
  starttime              VARCHAR2(64),
  endtime                VARCHAR2(64),
  joinmode               VARCHAR2(64) default 1
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ROB_RED_WXUSER.red_id
  is '����ID';
comment on column TB_ROB_RED_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_ROB_RED_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_ROB_RED_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_ROB_RED_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_ROB_RED_WXUSER.create_time
  is '����ʱ��';
comment on column TB_ROB_RED_WXUSER.state
  is '״̬   0δ����  1������';
comment on column TB_ROB_RED_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_ROB_RED_WXUSER.scan_red_number
  is 'ɨ��������';
comment on column TB_ROB_RED_WXUSER.total_money
  is '�ۼƽ��';
comment on column TB_ROB_RED_WXUSER.activity_name
  is '�����';
comment on column TB_ROB_RED_WXUSER.starttime
  is '��ʼʱ��';
comment on column TB_ROB_RED_WXUSER.endtime
  is '����ʱ��';
comment on column TB_ROB_RED_WXUSER.joinmode
  is '���뷽ʽ  1=ɨ�����  2=���ֶһ�';
alter table TB_ROB_RED_WXUSER
  add primary key (RED_WXUSER_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_ROB_RED_WXUSER_WINNING...
create table TB_ROB_RED_WXUSER_WINNING
(
  red_wxuser_winning_id   VARCHAR2(64) not null,
  red_wxuser_id           VARCHAR2(64),
  belong_rob_red_prize_id VARCHAR2(64),
  winning_money           VARCHAR2(64),
  prize_project           VARCHAR2(64),
  create_time             VARCHAR2(64),
  openid                  VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_ROB_RED_WXUSER_WINNING.red_wxuser_id
  is '����������¼ID';
comment on column TB_ROB_RED_WXUSER_WINNING.belong_rob_red_prize_id
  is '�����н�ID';
comment on column TB_ROB_RED_WXUSER_WINNING.winning_money
  is '�н����/����';
comment on column TB_ROB_RED_WXUSER_WINNING.prize_project
  is '����';
comment on column TB_ROB_RED_WXUSER_WINNING.create_time
  is '����ʱ��';
comment on column TB_ROB_RED_WXUSER_WINNING.openid
  is '΢��ָ��ID';
alter table TB_ROB_RED_WXUSER_WINNING
  add primary key (RED_WXUSER_WINNING_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SCRATCHCARD...
create table TB_SCRATCHCARD
(
  scratchcard_id            VARCHAR2(64) not null,
  activity_name             VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moblec_background_img     VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  spare_one                 VARCHAR2(255),
  spare_two                 VARCHAR2(255),
  total                     VARCHAR2(64),
  scan_number               VARCHAR2(64),
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_SCRATCHCARD.activity_name
  is '�����';
comment on column TB_SCRATCHCARD.background_img
  is '����ͼ';
comment on column TB_SCRATCHCARD.belong_activity_id
  is '�����ID';
comment on column TB_SCRATCHCARD.moblec_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_SCRATCHCARD.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_SCRATCHCARD.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_SCRATCHCARD.join_prople_number
  is '��������';
comment on column TB_SCRATCHCARD.winning_prople_number
  is '������';
comment on column TB_SCRATCHCARD.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_SCRATCHCARD.starttime
  is '���ʼʱ��';
comment on column TB_SCRATCHCARD.endtime
  is '�����ʱ��';
comment on column TB_SCRATCHCARD.create_time
  is '����ʱ��';
comment on column TB_SCRATCHCARD.comfirmuserid
  is '����˵�ID';
comment on column TB_SCRATCHCARD.comfirmtime
  is '���ʱ��';
comment on column TB_SCRATCHCARD.comfirmadvise
  is '��˽���';
comment on column TB_SCRATCHCARD.comfirmusername
  is '���������';
comment on column TB_SCRATCHCARD.applyphone
  is '�����˵绰';
comment on column TB_SCRATCHCARD.applyusername
  is '����������';
comment on column TB_SCRATCHCARD.spare_one
  is '�����ֶ�һ';
comment on column TB_SCRATCHCARD.spare_two
  is '�����ֶζ�';
comment on column TB_SCRATCHCARD.total
  is '��ƿ��';
comment on column TB_SCRATCHCARD.scan_number
  is 'ɨ��齱����';
alter table TB_SCRATCHCARD
  add primary key (SCRATCHCARD_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SCRATCHCARD_PRIZE...
create table TB_SCRATCHCARD_PRIZE
(
  scratchcard_prize_id      VARCHAR2(64) not null,
  scratchcard_id            VARCHAR2(64),
  prize_type                VARCHAR2(64),
  order_number              VARCHAR2(64),
  prize_img                 VARCHAR2(64),
  prize_name                VARCHAR2(64),
  prize_number              VARCHAR2(64),
  surplus_prize_number      VARCHAR2(64),
  prize_probability         VARCHAR2(64),
  surplus_prize_probability VARCHAR2(64),
  integral_numebr           VARCHAR2(64),
  red_number                VARCHAR2(64),
  create_time               VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_SCRATCHCARD_PRIZE.scratchcard_id
  is 'ת�̻ID';
comment on column TB_SCRATCHCARD_PRIZE.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_SCRATCHCARD_PRIZE.order_number
  is '���';
comment on column TB_SCRATCHCARD_PRIZE.prize_img
  is '��ƷͼƬ';
comment on column TB_SCRATCHCARD_PRIZE.prize_name
  is '��Ʒ����';
comment on column TB_SCRATCHCARD_PRIZE.prize_number
  is '��Ʒ����';
comment on column TB_SCRATCHCARD_PRIZE.surplus_prize_number
  is 'ʣ�ཱƷ����';
comment on column TB_SCRATCHCARD_PRIZE.prize_probability
  is '��Ʒ���ʣ�ԭʼ��';
comment on column TB_SCRATCHCARD_PRIZE.surplus_prize_probability
  is 'ʣ�ཱƷ����';
comment on column TB_SCRATCHCARD_PRIZE.integral_numebr
  is '������ֵ';
comment on column TB_SCRATCHCARD_PRIZE.red_number
  is '�����ֵ';
comment on column TB_SCRATCHCARD_PRIZE.create_time
  is '����ʱ��';
alter table TB_SCRATCHCARD_PRIZE
  add primary key (SCRATCHCARD_PRIZE_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SCRATCHCARD_WXUSER...
create table TB_SCRATCHCARD_WXUSER
(
  scratchcard_wxuser_id   VARCHAR2(64) not null,
  scratchcard_id          VARCHAR2(64),
  openid                  VARCHAR2(64),
  nickname                VARCHAR2(1000),
  headimgurl              VARCHAR2(1000),
  belong_publicnumber_id  VARCHAR2(64),
  create_time             VARCHAR2(64),
  state                   VARCHAR2(64),
  scan_code               VARCHAR2(64),
  scan_winning_number     VARCHAR2(64),
  activity_name           VARCHAR2(64),
  total_money             VARCHAR2(64) default 0,
  total_integral          VARCHAR2(64) default 0,
  integral_winning_number VARCHAR2(64) default 0,
  red_winning_number      VARCHAR2(64) default 0,
  goods_winning_number    VARCHAR2(64) default 0,
  think_winning_number    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_SCRATCHCARD_WXUSER.scratchcard_id
  is 'ת�̻ID';
comment on column TB_SCRATCHCARD_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_SCRATCHCARD_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_SCRATCHCARD_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_SCRATCHCARD_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_SCRATCHCARD_WXUSER.create_time
  is '����ʱ��';
comment on column TB_SCRATCHCARD_WXUSER.state
  is '״̬';
comment on column TB_SCRATCHCARD_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_SCRATCHCARD_WXUSER.scan_winning_number
  is 'ɨ���н�����';
comment on column TB_SCRATCHCARD_WXUSER.activity_name
  is '�����';
comment on column TB_SCRATCHCARD_WXUSER.total_money
  is '���β�����';
comment on column TB_SCRATCHCARD_WXUSER.total_integral
  is '���β����н�����';
comment on column TB_SCRATCHCARD_WXUSER.integral_winning_number
  is '�����н�����';
comment on column TB_SCRATCHCARD_WXUSER.red_winning_number
  is '����н�����';
comment on column TB_SCRATCHCARD_WXUSER.goods_winning_number
  is 'ʵ���н�����';
comment on column TB_SCRATCHCARD_WXUSER.think_winning_number
  is 'лл�ݹ��н�����';
alter table TB_SCRATCHCARD_WXUSER
  add primary key (SCRATCHCARD_WXUSER_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SCRATCHCARD_WXUSER_WINNING...
create table TB_SCRATCHCARD_WXUSER_WINNING
(
  scratchcard_wxuser_winning_id VARCHAR2(64) not null,
  scratchcard_wxuser_id         VARCHAR2(64),
  prize_type                    VARCHAR2(64),
  belong_winning_prize_id       VARCHAR2(64),
  winning_money                 VARCHAR2(64),
  prize_project                 VARCHAR2(64),
  create_time                   VARCHAR2(64),
  prize_project_img             VARCHAR2(1000),
  openid                        VARCHAR2(64),
  state                         VARCHAR2(64),
  addressee_name                VARCHAR2(64),
  addressee_address             VARCHAR2(255),
  addressee_phone               VARCHAR2(64),
  lssue_user_name               VARCHAR2(64),
  lssue_user_userid             VARCHAR2(64),
  lssue_user_usercode           VARCHAR2(64),
  deliver_number                VARCHAR2(64),
  deliver_company               VARCHAR2(64),
  deliver_time                  VARCHAR2(64),
  product_winning_info_id       VARCHAR2(64),
  spareone                      VARCHAR2(64),
  sparetwo                      VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_SCRATCHCARD_WXUSER_WINNING.scratchcard_wxuser_id
  is 'ת�̲����¼ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.belong_winning_prize_id
  is '�����н�ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.winning_money
  is '�н����/����';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.prize_project
  is '��Ʒ����';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.create_time
  is '����ʱ��';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.prize_project_img
  is '��ƷͼƬ';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.openid
  is '΢��ָ��ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.addressee_name
  is '�ռ�������';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.addressee_phone
  is '�ռ��˵绰';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.lssue_user_name
  is '����������';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.lssue_user_userid
  is '������USERID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.lssue_user_usercode
  is '������USERCODE';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.deliver_number
  is '��ݵ���';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.deliver_company
  is '��ݹ�˾';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.deliver_time
  is '����ʱ��';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.product_winning_info_id
  is 'ʵ���н���¼ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.spareone
  is '�洢��Ʒ����';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.sparetwo
  is '�洢״̬';
alter table TB_SCRATCHCARD_WXUSER_WINNING
  add primary key (SCRATCHCARD_WXUSER_WINNING_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SELLER_PUBLICNUMBER...
create table TB_SELLER_PUBLICNUMBER
(
  id                      VARCHAR2(64) not null,
  publicnumber_name       VARCHAR2(64),
  appid                   VARCHAR2(32),
  appsecret               VARCHAR2(255),
  publicnumber_qrcode_img VARCHAR2(1000),
  shop_number             VARCHAR2(64),
  pay_key                 VARCHAR2(255),
  spare_one               VARCHAR2(255),
  spare_two               VARCHAR2(255),
  seller_usercode         VARCHAR2(64),
  token                   VARCHAR2(255),
  winning_news_id         VARCHAR2(255),
  sendername              VARCHAR2(64),
  wish                    VARCHAR2(64),
  remarks                 VARCHAR2(255),
  seller_userid           VARCHAR2(64),
  sendid                  VARCHAR2(64),
  successid               VARCHAR2(64),
  company                 VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_SELLER_PUBLICNUMBER
  is '�����̹��ںű�    TB_SELLER_PUBLICNUMBER';
comment on column TB_SELLER_PUBLICNUMBER.publicnumber_name
  is '���ں�����';
comment on column TB_SELLER_PUBLICNUMBER.appid
  is '������ID';
comment on column TB_SELLER_PUBLICNUMBER.appsecret
  is '����������';
comment on column TB_SELLER_PUBLICNUMBER.publicnumber_qrcode_img
  is '���ںŶ�ά��ͼƬ';
comment on column TB_SELLER_PUBLICNUMBER.shop_number
  is '�̻���';
comment on column TB_SELLER_PUBLICNUMBER.pay_key
  is '֧����Կ';
comment on column TB_SELLER_PUBLICNUMBER.spare_one
  is '�����ֶ�һ';
comment on column TB_SELLER_PUBLICNUMBER.spare_two
  is '�����ֶζ�';
comment on column TB_SELLER_PUBLICNUMBER.seller_usercode
  is '������userCode';
comment on column TB_SELLER_PUBLICNUMBER.token
  is 'token��';
comment on column TB_SELLER_PUBLICNUMBER.winning_news_id
  is '�н�ģ��ID';
comment on column TB_SELLER_PUBLICNUMBER.sendername
  is '�������������';
comment on column TB_SELLER_PUBLICNUMBER.wish
  is 'ף����';
comment on column TB_SELLER_PUBLICNUMBER.remarks
  is '�����ע';
comment on column TB_SELLER_PUBLICNUMBER.seller_userid
  is '������userId';
comment on column TB_SELLER_PUBLICNUMBER.sendid
  is '����֪ͨid';
comment on column TB_SELLER_PUBLICNUMBER.successid
  is '����ɹ�֪ͨ';
comment on column TB_SELLER_PUBLICNUMBER.company
  is '��˾����';
alter table TB_SELLER_PUBLICNUMBER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SHARE_BARGAIN...
create table TB_SHARE_BARGAIN
(
  id                        VARCHAR2(64) not null,
  activity_name             VARCHAR2(64),
  belong_activity_id        VARCHAR2(64),
  background_img            VARCHAR2(1000),
  acitivity_launch_usercode VARCHAR2(64),
  acitivity_launch_userid   NUMBER,
  introduce                 VARCHAR2(250),
  join_prople_number        NUMBER default 0,
  winning_prople_number     NUMBER default 0,
  state                     NUMBER,
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  spare_one                 VARCHAR2(255),
  spare_two                 VARCHAR2(255),
  moblec_background_img     VARCHAR2(1000),
  create_time               VARCHAR2(64) default '',
  comfirmusername           VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  applyusername             VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyuserid               VARCHAR2(64),
  sharetitle                VARCHAR2(64),
  sharedetail               VARCHAR2(255),
  shareimg                  VARCHAR2(1000),
  comfirmuserid             VARCHAR2(64),
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_SHARE_BARGAIN
  is '�����ۻ��   TB_SHARE_BARGAIN';
comment on column TB_SHARE_BARGAIN.activity_name
  is '�����';
comment on column TB_SHARE_BARGAIN.belong_activity_id
  is '�����ID';
comment on column TB_SHARE_BARGAIN.background_img
  is '����ͼ';
comment on column TB_SHARE_BARGAIN.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_SHARE_BARGAIN.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_SHARE_BARGAIN.introduce
  is '����';
comment on column TB_SHARE_BARGAIN.join_prople_number
  is '��������';
comment on column TB_SHARE_BARGAIN.winning_prople_number
  is '������';
comment on column TB_SHARE_BARGAIN.state
  is '�״̬��0������   1����ͨ��  2 �Ѳ���  3��һ����ʱ��״̬';
comment on column TB_SHARE_BARGAIN.starttime
  is '���ʼʱ��';
comment on column TB_SHARE_BARGAIN.endtime
  is '�����ʱ��';
comment on column TB_SHARE_BARGAIN.moblec_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_SHARE_BARGAIN.comfirmusername
  is '����˵�����';
comment on column TB_SHARE_BARGAIN.comfirmtime
  is '���ʱ��';
comment on column TB_SHARE_BARGAIN.comfirmadvise
  is '��˽���';
comment on column TB_SHARE_BARGAIN.applyusername
  is '����������';
comment on column TB_SHARE_BARGAIN.applyphone
  is '�������ֻ�';
comment on column TB_SHARE_BARGAIN.applyuserid
  is '�����û�ID';
comment on column TB_SHARE_BARGAIN.sharetitle
  is '����ı���';
comment on column TB_SHARE_BARGAIN.sharedetail
  is '��������';
comment on column TB_SHARE_BARGAIN.shareimg
  is '����ʱ��ͼƬ';
comment on column TB_SHARE_BARGAIN.comfirmuserid
  is '�����ID';
comment on column TB_SHARE_BARGAIN.joined
  is 'Ĭ��Ϊ0û�вμ�  �μ�';
alter table TB_SHARE_BARGAIN
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SHARE_BARGAIN_HELP...
create table TB_SHARE_BARGAIN_HELP
(
  id                 VARCHAR2(64) not null,
  openid             VARCHAR2(64),
  nickname           VARCHAR2(1000),
  headimgurl         VARCHAR2(1000),
  friend_activity_id VARCHAR2(64),
  bargain_money      VARCHAR2(64),
  spare_one          VARCHAR2(255),
  spare_two          VARCHAR2(255)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_SHARE_BARGAIN_HELP.openid
  is '�û�OPENID';
comment on column TB_SHARE_BARGAIN_HELP.nickname
  is '�ǳ�';
comment on column TB_SHARE_BARGAIN_HELP.headimgurl
  is 'ͷ��';
comment on column TB_SHARE_BARGAIN_HELP.friend_activity_id
  is '��������ID';
comment on column TB_SHARE_BARGAIN_HELP.bargain_money
  is '�������۽��';
comment on column TB_SHARE_BARGAIN_HELP.spare_one
  is '�����ֶ�һ';
comment on column TB_SHARE_BARGAIN_HELP.spare_two
  is '�����ֶζ�';
alter table TB_SHARE_BARGAIN_HELP
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SHARE_BARGAIN_PRIZE...
create table TB_SHARE_BARGAIN_PRIZE
(
  id                   VARCHAR2(64) not null,
  share_bargain_id     VARCHAR2(64),
  productid            VARCHAR2(255),
  przie_number         NUMBER,
  przie_surplus_number NUMBER,
  original_price       VARCHAR2(64),
  low_price            VARCHAR2(64),
  bargain_section      VARCHAR2(64),
  bargain_number       NUMBER,
  spare_one            VARCHAR2(255),
  spare_two            VARCHAR2(255),
  productimg           VARCHAR2(64),
  prizename            VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_SHARE_BARGAIN_PRIZE
  is '�����۽�Ʒ���ñ�   TB_SHARE_BARGAIN_PRIZE';
comment on column TB_SHARE_BARGAIN_PRIZE.share_bargain_id
  is '�����ۻID';
comment on column TB_SHARE_BARGAIN_PRIZE.productid
  is '��ƷID';
comment on column TB_SHARE_BARGAIN_PRIZE.przie_number
  is '��Ʒ����';
comment on column TB_SHARE_BARGAIN_PRIZE.przie_surplus_number
  is 'ʣ������';
comment on column TB_SHARE_BARGAIN_PRIZE.original_price
  is 'ԭ�۸�';
comment on column TB_SHARE_BARGAIN_PRIZE.low_price
  is '��ͼ�';
comment on column TB_SHARE_BARGAIN_PRIZE.bargain_section
  is '��������';
comment on column TB_SHARE_BARGAIN_PRIZE.bargain_number
  is '���۴���';
comment on column TB_SHARE_BARGAIN_PRIZE.spare_one
  is '�����ֶ�һ  ';
comment on column TB_SHARE_BARGAIN_PRIZE.spare_two
  is '�����ֶζ�';
comment on column TB_SHARE_BARGAIN_PRIZE.prizename
  is '��Ʒ����';
alter table TB_SHARE_BARGAIN_PRIZE
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_SHARE_BARGAIN_WXUSER...
create table TB_SHARE_BARGAIN_WXUSER
(
  openid                  VARCHAR2(64) not null,
  nickname                VARCHAR2(1000),
  headimgurl              VARCHAR2(1000),
  join_activity_id        VARCHAR2(64),
  belong_publicnumber_id  VARCHAR2(64),
  price                   VARCHAR2(64),
  now_price               VARCHAR2(64),
  low_price               VARCHAR2(64),
  bargain_section         VARCHAR2(64),
  bargain_number          VARCHAR2(64),
  create_time             VARCHAR2(64),
  consignee_name          VARCHAR2(64),
  consignee_address       VARCHAR2(1000),
  consignee_phone         VARCHAR2(64),
  pay_money               VARCHAR2(64) default 0,
  goods_state             VARCHAR2(64) default 2,
  goods_odd_number        VARCHAR2(64),
  goods_company           VARCHAR2(1000),
  goods_time              VARCHAR2(64),
  id                      VARCHAR2(64) not null,
  sharebargain_prize_id   VARCHAR2(64),
  state                   VARCHAR2(64),
  pay_order               VARCHAR2(64),
  mch_id                  VARCHAR2(64),
  product_winning_info_id VARCHAR2(64),
  spareone                VARCHAR2(64),
  sparetwo                VARCHAR2(64),
  sparethree              VARCHAR2(64),
  scan_code               VARCHAR2(64),
  sendname                VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table TB_SHARE_BARGAIN_WXUSER
  is 'TB_SHARE_BARGAIN_WXUSER   �μӷ����ۻ���û�';
comment on column TB_SHARE_BARGAIN_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_SHARE_BARGAIN_WXUSER.headimgurl
  is 'ͷ���ַ';
comment on column TB_SHARE_BARGAIN_WXUSER.join_activity_id
  is '�μӻID';
comment on column TB_SHARE_BARGAIN_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_SHARE_BARGAIN_WXUSER.price
  is '�۸�';
comment on column TB_SHARE_BARGAIN_WXUSER.now_price
  is '���ڼ۸�';
comment on column TB_SHARE_BARGAIN_WXUSER.low_price
  is '��ͼ۸�';
comment on column TB_SHARE_BARGAIN_WXUSER.bargain_section
  is '��������';
comment on column TB_SHARE_BARGAIN_WXUSER.bargain_number
  is '���۴���';
comment on column TB_SHARE_BARGAIN_WXUSER.create_time
  is '����ʱ��';
comment on column TB_SHARE_BARGAIN_WXUSER.consignee_name
  is '�ջ�������';
comment on column TB_SHARE_BARGAIN_WXUSER.consignee_address
  is '�ջ��˵�ַ';
comment on column TB_SHARE_BARGAIN_WXUSER.consignee_phone
  is '�ջ��˵绰';
comment on column TB_SHARE_BARGAIN_WXUSER.pay_money
  is '֧�����';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_state
  is '����״̬ 1�ѷ��� 2δ����';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_odd_number
  is '��������';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_company
  is '������˾';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_time
  is '����ʱ��';
comment on column TB_SHARE_BARGAIN_WXUSER.sharebargain_prize_id
  is '���Ʒ����ID';
comment on column TB_SHARE_BARGAIN_WXUSER.state
  is '״̬  1 ������ 2 �������  3 ��֧��';
comment on column TB_SHARE_BARGAIN_WXUSER.pay_order
  is '֧������';
comment on column TB_SHARE_BARGAIN_WXUSER.mch_id
  is '�̻�ID';
comment on column TB_SHARE_BARGAIN_WXUSER.spareone
  is '�����洢����״̬';
comment on column TB_SHARE_BARGAIN_WXUSER.sparetwo
  is '�����洢����״̬   ';
comment on column TB_SHARE_BARGAIN_WXUSER.sparethree
  is '�����洢״̬   ״̬ ״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ���� 6��֧��';
comment on column TB_SHARE_BARGAIN_WXUSER.scan_code
  is '���û���ɨ����';
comment on column TB_SHARE_BARGAIN_WXUSER.sendname
  is '����������';
alter table TB_SHARE_BARGAIN_WXUSER
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_TURNTABLE...
create table TB_TURNTABLE
(
  turntable_id              VARCHAR2(64) not null,
  activity_name             VARCHAR2(64),
  background_img            VARCHAR2(1000),
  belong_activity_id        VARCHAR2(64),
  moblec_background_img     VARCHAR2(1000),
  acitivity_launch_userid   VARCHAR2(64),
  acitivity_launch_usercode VARCHAR2(64),
  turntable_number          VARCHAR2(64),
  speed                     VARCHAR2(64),
  join_prople_number        VARCHAR2(64) default 0,
  winning_prople_number     VARCHAR2(64) default 0,
  state                     VARCHAR2(64),
  starttime                 VARCHAR2(64),
  endtime                   VARCHAR2(64),
  create_time               VARCHAR2(64),
  comfirmuserid             VARCHAR2(64),
  comfirmtime               VARCHAR2(64),
  comfirmadvise             VARCHAR2(1000),
  comfirmusername           VARCHAR2(64),
  applyphone                VARCHAR2(64),
  applyusername             VARCHAR2(64),
  spare_one                 VARCHAR2(64),
  spare_two                 VARCHAR2(64),
  total                     VARCHAR2(64),
  scan_turntable_number     VARCHAR2(64),
  joined                    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_TURNTABLE.activity_name
  is '����� ';
comment on column TB_TURNTABLE.background_img
  is '����ͼ';
comment on column TB_TURNTABLE.belong_activity_id
  is '�����ID';
comment on column TB_TURNTABLE.moblec_background_img
  is '�ֻ�ҳ�汳��ͼ';
comment on column TB_TURNTABLE.acitivity_launch_userid
  is '������˵�USERID';
comment on column TB_TURNTABLE.acitivity_launch_usercode
  is '������˵�USERCODE';
comment on column TB_TURNTABLE.turntable_number
  is 'ת������';
comment on column TB_TURNTABLE.speed
  is 'ת���ٶ�0=����  1=����';
comment on column TB_TURNTABLE.join_prople_number
  is '��������';
comment on column TB_TURNTABLE.winning_prople_number
  is '������';
comment on column TB_TURNTABLE.state
  is '�״̬��0������ �� 1����ͨ�� ��2 �Ѳ���';
comment on column TB_TURNTABLE.starttime
  is '���ʼʱ��';
comment on column TB_TURNTABLE.endtime
  is '�����ʱ��';
comment on column TB_TURNTABLE.create_time
  is '����ʱ��';
comment on column TB_TURNTABLE.comfirmuserid
  is '����˵�ID';
comment on column TB_TURNTABLE.comfirmtime
  is '���ʱ��';
comment on column TB_TURNTABLE.comfirmadvise
  is '��˽���';
comment on column TB_TURNTABLE.comfirmusername
  is '���������';
comment on column TB_TURNTABLE.applyphone
  is '�����˵绰';
comment on column TB_TURNTABLE.applyusername
  is '����������';
comment on column TB_TURNTABLE.spare_one
  is '�����ֶ�һ';
comment on column TB_TURNTABLE.spare_two
  is '�����ֶζ�';
comment on column TB_TURNTABLE.total
  is '��ƿ��';
comment on column TB_TURNTABLE.scan_turntable_number
  is 'ɨ��ת�̴���';
alter table TB_TURNTABLE
  add primary key (TURNTABLE_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_TURNTABLE_PRIZE...
create table TB_TURNTABLE_PRIZE
(
  turntable_prize_id        VARCHAR2(64) not null,
  turntable_id              VARCHAR2(64),
  prize_type                VARCHAR2(64),
  order_number              VARCHAR2(64),
  prize_img                 VARCHAR2(64),
  prize_name                VARCHAR2(64),
  prize_number              VARCHAR2(64),
  surplus_prize_number      VARCHAR2(64),
  prize_probability         VARCHAR2(64),
  surplus_prize_probability VARCHAR2(64),
  integral_numebr           VARCHAR2(64),
  red_number                VARCHAR2(64),
  create_time               VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_TURNTABLE_PRIZE.turntable_id
  is 'ת�̻ID';
comment on column TB_TURNTABLE_PRIZE.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_TURNTABLE_PRIZE.order_number
  is '���';
comment on column TB_TURNTABLE_PRIZE.prize_img
  is '��ƷͼƬ';
comment on column TB_TURNTABLE_PRIZE.prize_name
  is '��Ʒ����';
comment on column TB_TURNTABLE_PRIZE.prize_number
  is '��Ʒ����';
comment on column TB_TURNTABLE_PRIZE.surplus_prize_number
  is 'ʣ�ཱƷ����';
comment on column TB_TURNTABLE_PRIZE.prize_probability
  is '��Ʒ���ʣ�ԭʼ��';
comment on column TB_TURNTABLE_PRIZE.surplus_prize_probability
  is 'ʣ�ཱƷ����';
comment on column TB_TURNTABLE_PRIZE.integral_numebr
  is '������ֵ';
comment on column TB_TURNTABLE_PRIZE.red_number
  is '�����ֵ';
comment on column TB_TURNTABLE_PRIZE.create_time
  is '����ʱ��';
alter table TB_TURNTABLE_PRIZE
  add primary key (TURNTABLE_PRIZE_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_TURNTABLE_WXUSER...
create table TB_TURNTABLE_WXUSER
(
  turntable_wxuser_id     VARCHAR2(64) not null,
  turntable_id            VARCHAR2(64),
  openid                  VARCHAR2(64),
  nickname                VARCHAR2(1000),
  headimgurl              VARCHAR2(1000),
  belong_publicnumber_id  VARCHAR2(64),
  create_time             VARCHAR2(64),
  state                   VARCHAR2(64),
  scan_code               VARCHAR2(64),
  scan_winning_number     VARCHAR2(64),
  activity_name           VARCHAR2(64),
  total_money             VARCHAR2(64) default 0,
  total_integral          VARCHAR2(64) default 0,
  integral_winning_number VARCHAR2(64) default 0,
  red_winning_number      VARCHAR2(64) default 0,
  goods_winning_number    VARCHAR2(64) default 0,
  think_winning_number    VARCHAR2(64) default 0
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_TURNTABLE_WXUSER.turntable_id
  is 'ת�̻ID';
comment on column TB_TURNTABLE_WXUSER.openid
  is '΢��ָ��ID';
comment on column TB_TURNTABLE_WXUSER.nickname
  is '΢���ǳ�';
comment on column TB_TURNTABLE_WXUSER.headimgurl
  is '΢��ͷ��';
comment on column TB_TURNTABLE_WXUSER.belong_publicnumber_id
  is '�������ں�';
comment on column TB_TURNTABLE_WXUSER.create_time
  is '����ʱ��';
comment on column TB_TURNTABLE_WXUSER.state
  is '״̬';
comment on column TB_TURNTABLE_WXUSER.scan_code
  is 'ɨ��CODE';
comment on column TB_TURNTABLE_WXUSER.scan_winning_number
  is 'ɨ���н�����';
comment on column TB_TURNTABLE_WXUSER.activity_name
  is '�����';
comment on column TB_TURNTABLE_WXUSER.total_money
  is '���β�����';
comment on column TB_TURNTABLE_WXUSER.total_integral
  is '���β����н�����';
comment on column TB_TURNTABLE_WXUSER.integral_winning_number
  is '�����н�����';
comment on column TB_TURNTABLE_WXUSER.red_winning_number
  is '����н�����';
comment on column TB_TURNTABLE_WXUSER.goods_winning_number
  is 'ʵ���н�����';
comment on column TB_TURNTABLE_WXUSER.think_winning_number
  is 'лл�ݹ��н�����';
alter table TB_TURNTABLE_WXUSER
  add primary key (TURNTABLE_WXUSER_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TB_TURNTABLE_WXUSER_WINNING...
create table TB_TURNTABLE_WXUSER_WINNING
(
  turntable_wxuser_winning_id VARCHAR2(64) not null,
  turntable_wxuser_id         VARCHAR2(64),
  prize_type                  VARCHAR2(64),
  belong_winning_prize_id     VARCHAR2(64),
  winning_money               VARCHAR2(64),
  prize_project               VARCHAR2(64),
  create_time                 VARCHAR2(64),
  openid                      VARCHAR2(64),
  state                       VARCHAR2(64),
  prize_project_img           VARCHAR2(1000),
  addressee_name              VARCHAR2(64),
  addressee_address           VARCHAR2(255),
  addressee_phone             VARCHAR2(64),
  lssue_user_name             VARCHAR2(64),
  lssue_user_userid           VARCHAR2(64),
  lssue_user_usercode         VARCHAR2(64),
  deliver_number              VARCHAR2(100),
  deliver_company             VARCHAR2(100),
  deliver_time                VARCHAR2(64),
  product_winning_info_id     VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column TB_TURNTABLE_WXUSER_WINNING.turntable_wxuser_id
  is 'ת�̲����¼ID';
comment on column TB_TURNTABLE_WXUSER_WINNING.prize_type
  is '��Ʒ����1=ʵ�� 2=����  3=���   4=лл�ݹ�';
comment on column TB_TURNTABLE_WXUSER_WINNING.belong_winning_prize_id
  is '�����н�ID';
comment on column TB_TURNTABLE_WXUSER_WINNING.winning_money
  is '�н����/����';
comment on column TB_TURNTABLE_WXUSER_WINNING.prize_project
  is '��Ʒ����';
comment on column TB_TURNTABLE_WXUSER_WINNING.create_time
  is '����ʱ��';
comment on column TB_TURNTABLE_WXUSER_WINNING.openid
  is '΢��ָ��ID';
comment on column TB_TURNTABLE_WXUSER_WINNING.state
  is '״̬ 1=�Ѿ���ȡ 2δ��д��ַ 3��ַ����д  4�ѷ���  5δ����';
comment on column TB_TURNTABLE_WXUSER_WINNING.prize_project_img
  is '��ƷͼƬ';
comment on column TB_TURNTABLE_WXUSER_WINNING.addressee_name
  is '�ռ�������';
comment on column TB_TURNTABLE_WXUSER_WINNING.addressee_address
  is '�ռ��˵�ַ';
comment on column TB_TURNTABLE_WXUSER_WINNING.addressee_phone
  is '�ռ��˵绰';
comment on column TB_TURNTABLE_WXUSER_WINNING.lssue_user_name
  is '����������';
comment on column TB_TURNTABLE_WXUSER_WINNING.lssue_user_userid
  is '������USERID';
comment on column TB_TURNTABLE_WXUSER_WINNING.lssue_user_usercode
  is '������USERCODE';
comment on column TB_TURNTABLE_WXUSER_WINNING.deliver_number
  is '��ݵ���';
comment on column TB_TURNTABLE_WXUSER_WINNING.deliver_company
  is '��ݹ�˾';
comment on column TB_TURNTABLE_WXUSER_WINNING.deliver_time
  is '����ʱ��';
comment on column TB_TURNTABLE_WXUSER_WINNING.product_winning_info_id
  is 'ʵ���н���¼ID';
alter table TB_TURNTABLE_WXUSER_WINNING
  add primary key (TURNTABLE_WXUSER_WINNING_ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating UPLOAD_IMG...
create table UPLOAD_IMG
(
  id        VARCHAR2(64) not null,
  img_url   VARCHAR2(64),
  usercode  VARCHAR2(64),
  userid    VARCHAR2(64),
  spare_one VARCHAR2(64)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column UPLOAD_IMG.img_url
  is 'ͼƬ��ַ';
comment on column UPLOAD_IMG.usercode
  is '�û�COED';
comment on column UPLOAD_IMG.userid
  is '�û�ID';
alter table UPLOAD_IMG
  add primary key (ID)
  using index 
  tablespace PLSDBFLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for ACTIVITY_CODE...
alter table ACTIVITY_CODE disable all triggers;
prompt Disabling triggers for ACTIVITY_WXUSER...
alter table ACTIVITY_WXUSER disable all triggers;
prompt Disabling triggers for DEMO_T...
alter table DEMO_T disable all triggers;
prompt Disabling triggers for JOINACTIVITY...
alter table JOINACTIVITY disable all triggers;
prompt Disabling triggers for LOG_INFO...
alter table LOG_INFO disable all triggers;
prompt Disabling triggers for SYS_CONFIG...
alter table SYS_CONFIG disable all triggers;
prompt Disabling triggers for SYS_MENU...
alter table SYS_MENU disable all triggers;
prompt Disabling triggers for SYS_MENU_ROLE...
alter table SYS_MENU_ROLE disable all triggers;
prompt Disabling triggers for TB_ACCUMULATEFABULOUS...
alter table TB_ACCUMULATEFABULOUS disable all triggers;
prompt Disabling triggers for TB_ACCUMULATEFABULOUS_PRIZE...
alter table TB_ACCUMULATEFABULOUS_PRIZE disable all triggers;
prompt Disabling triggers for TB_ACCUMULATE_COMMENT_WXUSER...
alter table TB_ACCUMULATE_COMMENT_WXUSER disable all triggers;
prompt Disabling triggers for TB_ACCUMULATE_HELP_WXUSER...
alter table TB_ACCUMULATE_HELP_WXUSER disable all triggers;
prompt Disabling triggers for TB_ACCUMULATE_WXUSER_WINNING...
alter table TB_ACCUMULATE_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for TB_ACTIVITY...
alter table TB_ACTIVITY disable all triggers;
prompt Disabling triggers for TB_ACTIVITY_SELLEROUTINFO...
alter table TB_ACTIVITY_SELLEROUTINFO disable all triggers;
prompt Disabling triggers for TB_BREAKEGG_WXUSER...
alter table TB_BREAKEGG_WXUSER disable all triggers;
prompt Disabling triggers for TB_BREAKEGG_WXUSER_WINNING...
alter table TB_BREAKEGG_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for TB_BREAK_EGG...
alter table TB_BREAK_EGG disable all triggers;
prompt Disabling triggers for TB_BREAK_EGG_PRIZE...
alter table TB_BREAK_EGG_PRIZE disable all triggers;
prompt Disabling triggers for TB_EXPRESS...
alter table TB_EXPRESS disable all triggers;
prompt Disabling triggers for TB_GROUP_PURCHASE...
alter table TB_GROUP_PURCHASE disable all triggers;
prompt Disabling triggers for TB_GROUP_PURCHASE_GROUP_WXUSER...
alter table TB_GROUP_PURCHASE_GROUP_WXUSER disable all triggers;
prompt Disabling triggers for TB_GROUP_PURCHASE_PRIZE...
alter table TB_GROUP_PURCHASE_PRIZE disable all triggers;
prompt Disabling triggers for TB_GROUP_PURCHASE_WXUSER...
alter table TB_GROUP_PURCHASE_WXUSER disable all triggers;
prompt Disabling triggers for TB_INTEGRAL...
alter table TB_INTEGRAL disable all triggers;
prompt Disabling triggers for TB_INTEGRAL_ACTIVITY...
alter table TB_INTEGRAL_ACTIVITY disable all triggers;
prompt Disabling triggers for TB_INTEGRAL_EXCHANGE...
alter table TB_INTEGRAL_EXCHANGE disable all triggers;
prompt Disabling triggers for TB_INTEGRAL_PRODUCT...
alter table TB_INTEGRAL_PRODUCT disable all triggers;
prompt Disabling triggers for TB_INTEGRAL_WINNING_INFO...
alter table TB_INTEGRAL_WINNING_INFO disable all triggers;
prompt Disabling triggers for TB_MASTERDATA_LOG...
alter table TB_MASTERDATA_LOG disable all triggers;
prompt Disabling triggers for TB_ONEMONEY_WXUSER_WINNING...
alter table TB_ONEMONEY_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for TB_ONE_MONEY_GROUP_WXUSER...
alter table TB_ONE_MONEY_GROUP_WXUSER disable all triggers;
prompt Disabling triggers for TB_ONE_MONEY_PRIZE...
alter table TB_ONE_MONEY_PRIZE disable all triggers;
prompt Disabling triggers for TB_ONE_MONEY_SHOP...
alter table TB_ONE_MONEY_SHOP disable all triggers;
prompt Disabling triggers for TB_ONE_MONEY_WXUSER...
alter table TB_ONE_MONEY_WXUSER disable all triggers;
prompt Disabling triggers for TB_PRODUCT_WINNING_INFO...
alter table TB_PRODUCT_WINNING_INFO disable all triggers;
prompt Disabling triggers for TB_PURCHASE_WXUSER_WINNING...
alter table TB_PURCHASE_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for TB_PUZZLE...
alter table TB_PUZZLE disable all triggers;
prompt Disabling triggers for TB_PUZZLE_PRIZE...
alter table TB_PUZZLE_PRIZE disable all triggers;
prompt Disabling triggers for TB_PUZZLE_WXUSER...
alter table TB_PUZZLE_WXUSER disable all triggers;
prompt Disabling triggers for TB_PUZZLE_WXUSER_WINNING...
alter table TB_PUZZLE_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for TB_RED_WINNING_INFO...
alter table TB_RED_WINNING_INFO disable all triggers;
prompt Disabling triggers for TB_ROB_RED...
alter table TB_ROB_RED disable all triggers;
prompt Disabling triggers for TB_ROB_RED_PRIZE...
alter table TB_ROB_RED_PRIZE disable all triggers;
prompt Disabling triggers for TB_ROB_RED_WXUSER...
alter table TB_ROB_RED_WXUSER disable all triggers;
prompt Disabling triggers for TB_ROB_RED_WXUSER_WINNING...
alter table TB_ROB_RED_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for TB_SCRATCHCARD...
alter table TB_SCRATCHCARD disable all triggers;
prompt Disabling triggers for TB_SCRATCHCARD_PRIZE...
alter table TB_SCRATCHCARD_PRIZE disable all triggers;
prompt Disabling triggers for TB_SCRATCHCARD_WXUSER...
alter table TB_SCRATCHCARD_WXUSER disable all triggers;
prompt Disabling triggers for TB_SCRATCHCARD_WXUSER_WINNING...
alter table TB_SCRATCHCARD_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for TB_SELLER_PUBLICNUMBER...
alter table TB_SELLER_PUBLICNUMBER disable all triggers;
prompt Disabling triggers for TB_SHARE_BARGAIN...
alter table TB_SHARE_BARGAIN disable all triggers;
prompt Disabling triggers for TB_SHARE_BARGAIN_HELP...
alter table TB_SHARE_BARGAIN_HELP disable all triggers;
prompt Disabling triggers for TB_SHARE_BARGAIN_PRIZE...
alter table TB_SHARE_BARGAIN_PRIZE disable all triggers;
prompt Disabling triggers for TB_SHARE_BARGAIN_WXUSER...
alter table TB_SHARE_BARGAIN_WXUSER disable all triggers;
prompt Disabling triggers for TB_TURNTABLE...
alter table TB_TURNTABLE disable all triggers;
prompt Disabling triggers for TB_TURNTABLE_PRIZE...
alter table TB_TURNTABLE_PRIZE disable all triggers;
prompt Disabling triggers for TB_TURNTABLE_WXUSER...
alter table TB_TURNTABLE_WXUSER disable all triggers;
prompt Disabling triggers for TB_TURNTABLE_WXUSER_WINNING...
alter table TB_TURNTABLE_WXUSER_WINNING disable all triggers;
prompt Disabling triggers for UPLOAD_IMG...
alter table UPLOAD_IMG disable all triggers;
prompt Loading ACTIVITY_CODE...
prompt Table is empty
prompt Loading ACTIVITY_WXUSER...
prompt Table is empty
prompt Loading DEMO_T...
insert into DEMO_T (id, name, age)
values ('1', '1', '1');
insert into DEMO_T (id, name, age)
values ('2', '2', '2');
insert into DEMO_T (id, name, age)
values ('3', '3', '3');
insert into DEMO_T (id, name, age)
values ('3', '4', '4');
commit;
prompt 4 records loaded
prompt Loading JOINACTIVITY...
prompt Table is empty
prompt Loading LOG_INFO...
prompt Table is empty
prompt Loading SYS_CONFIG...
prompt Table is empty
prompt Loading SYS_MENU...
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b76', '�����', '/approve', '2017-08-09 15:15:53', '2017-08-09 15:15:53', '�������Ϣ', null, '/img/index/shengpi-icon.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b75', 'ϵͳ����', '/system', '2017-08-09 15:15:54', '2017-08-09 15:15:54', 'ϵͳ������Ϣ', null, '/img/index/shezhi-icon.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b74', '�ҵĻ', '/activity', '2017-08-09 15:15:50', '2017-08-09 15:15:50', '�ҵĻ��Ϣ', null, '/img/index/my-activities-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('2ec1354c3c794b6ab3dad2d3e0189b1b', '�����', '/activityApply', '2017-08-09 15:15:51', '2017-08-09 15:15:51', '�������Ϣ', null, '/img/index/apply-for-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('a076e99766b74001b0154b9d378e0065', '�����', '/activityForm', '2017-08-09 15:15:52', '2017-08-09 15:15:52', '�������Ϣ', null, '/img/index/statement-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('b354e99766b74001b0154b9d378e0890', '���ں�����', '/publicNumber/index', '2017-08-19 15:15:52', '2017-08-19 25:15:52', '���ں�����', null, '/img/index/weixinshezhi.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('q2e4e99766b74001b0154b9d378ef925', '�������', '/scanCount', '2017-08-29 15:15:56', '2017-08-29 15:15:52', '�������', null, '/img/index/statement-ICON.png', '0');
commit;
prompt 7 records loaded
prompt Loading SYS_MENU_ROLE...
insert into SYS_MENU_ROLE (menu, role, id)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b74', '1', '123');
insert into SYS_MENU_ROLE (menu, role, id)
values ('2ec1354c3c794b6ab3dad2d3e0189b1b', '1', '234');
insert into SYS_MENU_ROLE (menu, role, id)
values ('a076e99766b74001b0154b9d378e0065', '1', '345');
insert into SYS_MENU_ROLE (menu, role, id)
values ('b354e99766b74001b0154b9d378e0890', '1', '456');
insert into SYS_MENU_ROLE (menu, role, id)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b76', '0', '567');
insert into SYS_MENU_ROLE (menu, role, id)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b75', '0', '678');
insert into SYS_MENU_ROLE (menu, role, id)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b74', '0', '891');
insert into SYS_MENU_ROLE (menu, role, id)
values ('2ec1354c3c794b6ab3dad2d3e0189b1b', '0', '910');
insert into SYS_MENU_ROLE (menu, role, id)
values ('a076e99766b74001b0154b9d378e0065', '0', '101');
insert into SYS_MENU_ROLE (menu, role, id)
values ('b354e99766b74001b0154b9d378e0890', '0', '111');
insert into SYS_MENU_ROLE (menu, role, id)
values ('q2e4e99766b74001b0154b9d378ef925', '1', '878');
insert into SYS_MENU_ROLE (menu, role, id)
values ('q2e4e99766b74001b0154b9d378ef925', '0', '859');
commit;
prompt 12 records loaded
prompt Loading TB_ACCUMULATEFABULOUS...
prompt Table is empty
prompt Loading TB_ACCUMULATEFABULOUS_PRIZE...
prompt Table is empty
prompt Loading TB_ACCUMULATE_COMMENT_WXUSER...
prompt Table is empty
prompt Loading TB_ACCUMULATE_HELP_WXUSER...
prompt Table is empty
prompt Loading TB_ACCUMULATE_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_ACTIVITY...
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f05583683', '�ҽ�', '/image/zadan-img.png', '/breakEggConfig/goToBreakEgg', 'breakEgg', '2017-11-1 13:38:07', '/breakEggConfig/goApproveList', '/breakEggConfig/berakEggReport', '/breakEggConfig/myAllEggActivity', '/breakEggConfig/breakEggActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84227875772154', 'һԪ��', '/image/yiyuangou-img.png', '/oneMoneyShopConfig/oneMoneyShopEidt', 'oneMoneyShop', '2017-11-1 13:38:08', '/oneMoneyShopConfig/goApproveList', '/oneMoneyShopConfig/oneMoneyReport', '/oneMoneyShopConfig/myAllOneMoneyActivity', '/oneMoneyShopConfig/oneShopActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f04083684', 'ƴͼС��Ϸ', '/image/pingtu-img.png', '/puzzleConfig/puzzleEdit', 'puzzle', '2017-11-1 13:38:09', '/puzzleConfig/goApproveList', '/puzzleConfig/puzzleReport', '/puzzleConfig/myAllPuzzleActivity' || chr(10) || '', '/puzzleConfig/puzzleActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f05083555', 'ƴ��', '/image/pingtuan-img.png', '/groupPurchaseConfig/groupPurchaseEdit', 'groupPurchase', '2017-11-1 13:38:10', '/groupPurchaseConfig/goApproveList', '/groupPurchaseConfig/purchaseReport', '/groupPurchaseConfig/myAllGroupPurchaseActivity', '/groupPurchaseConfig/purchaseActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('58a8781c51154c899023734cccf9c608', '������', '/image/kanjia-img.png', '/shareBargainConfig/shareBargainConfigUpdate', 'shareBargain', '2017-11-1 13:38:01', '/shareBargainConfig/approveShareBargain', '/shareBargainConfig/shareBargainReport', '/shareBargainConfig/shareBargainActivityByUserId', '/shareBargainConfig/shareBargainActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f04083683', '�����', '/image/hongbao-img.png', '/robRedConfig/robRedConfigUpdate', 'robRed', '2017-11-1 13:38:02', '/robRedConfig/redRobApprove', '/robRedConfig/redRobReport', '/robRedConfig/allMyActvity', '/robRedConfig/redActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('ba13fff2da9f4fdd8bf7e3c8d2b63da7', 'ת�̳齱', '/image/zhuanpan-img.png', '/turntableConfig/activityEdit', 'turntable', '2017-11-1 13:38:03', '/turntableConfig/turntableApproval', '/turntableConfig/turntableReportAll', '/turntableConfig/turntableMyAllActivity', '/turntableConfig/turntableMyAllActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f88899984', '�ι���', '/image/guaguale-img.png', '/scratchCardConfig/scratchCardUpdate', 'scratchCard', '2017-11-1 13:38:04', '/scratchCardConfig/scratchCardApproval', '/scratchCardConfig/scratchCardReportAll', '/scratchCardConfig/scratchCardMyAllActivity', '/scratchCardConfig/cardActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('5489e12d896b9654bf8a360f0ae8d514', '����', '/image/jizan-img.png', '/accumulateFabulousConfig/accumulateEdit', 'accumulateFabulous', '2017-11-1 13:38:06', '/accumulateFabulousConfig/accumulateApprove', '/accumulateFabulousConfig/accumulateReport', '/accumulateFabulousConfig/myAccumulate' || chr(10) || '', '/accumulateFabulousConfig/accumulateActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f04083682', '���ֶһ�', '/image/jifenduihuan-img.png', '/integralConfig/integralConfigUpdate', 'integral', '2017-11-1 13:38:05', '/integralConfig/approveIntegral', '/integralConfig/integralReportAll', '/integralConfig/MyIntegralActivity', null);
commit;
prompt 10 records loaded
prompt Loading TB_ACTIVITY_SELLEROUTINFO...
prompt Table is empty
prompt Loading TB_BREAKEGG_WXUSER...
prompt Table is empty
prompt Loading TB_BREAKEGG_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_BREAK_EGG...
prompt Table is empty
prompt Loading TB_BREAK_EGG_PRIZE...
prompt Table is empty
prompt Loading TB_EXPRESS...
insert into TB_EXPRESS (id, name, remark)
values ('4352e9f212544ea1ae14adb69718da9a20180126153838', 'Բͨ���', 'yt');
insert into TB_EXPRESS (id, name, remark)
values ('3baee1a220bf4c75b7529e6d6c73f88d20180126162054', '��ͨ���', 'zt');
insert into TB_EXPRESS (id, name, remark)
values ('3599601dd701466db11b85fefa069f2220180126163052', '˳������', 'sf');
insert into TB_EXPRESS (id, name, remark)
values ('eb2264d51ab943dca2c974f1cf3938c020180202114230', '�ֳ��콱', null);
insert into TB_EXPRESS (id, name, remark)
values ('ad78e196650d4fe6bea52c604683b0e820180330152649', '������վ', 'cn');
insert into TB_EXPRESS (id, name, remark)
values ('b043effd72fa4df0843e266aec80369820180330152740', '�ϴ���', 'yd');
insert into TB_EXPRESS (id, name, remark)
values ('535a73b220844c5cb26edf2b861a34a720180205163306', '�°�����', null);
insert into TB_EXPRESS (id, name, remark)
values ('d49e7c76ad984100b55137c16600538620180330152728', '������', 'tt');
commit;
prompt 8 records loaded
prompt Loading TB_GROUP_PURCHASE...
prompt Table is empty
prompt Loading TB_GROUP_PURCHASE_GROUP_WXUSER...
prompt Table is empty
prompt Loading TB_GROUP_PURCHASE_PRIZE...
prompt Table is empty
prompt Loading TB_GROUP_PURCHASE_WXUSER...
prompt Table is empty
prompt Loading TB_INTEGRAL...
prompt Table is empty
prompt Loading TB_INTEGRAL_ACTIVITY...
prompt Table is empty
prompt Loading TB_INTEGRAL_EXCHANGE...
prompt Table is empty
prompt Loading TB_INTEGRAL_PRODUCT...
prompt Table is empty
prompt Loading TB_INTEGRAL_WINNING_INFO...
prompt Table is empty
prompt Loading TB_MASTERDATA_LOG...
prompt Table is empty
prompt Loading TB_ONEMONEY_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_ONE_MONEY_GROUP_WXUSER...
prompt Table is empty
prompt Loading TB_ONE_MONEY_PRIZE...
prompt Table is empty
prompt Loading TB_ONE_MONEY_SHOP...
prompt Table is empty
prompt Loading TB_ONE_MONEY_WXUSER...
prompt Table is empty
prompt Loading TB_PRODUCT_WINNING_INFO...
prompt Table is empty
prompt Loading TB_PURCHASE_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_PUZZLE...
prompt Table is empty
prompt Loading TB_PUZZLE_PRIZE...
prompt Table is empty
prompt Loading TB_PUZZLE_WXUSER...
prompt Table is empty
prompt Loading TB_PUZZLE_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_RED_WINNING_INFO...
prompt Table is empty
prompt Loading TB_ROB_RED...
prompt Table is empty
prompt Loading TB_ROB_RED_PRIZE...
prompt Table is empty
prompt Loading TB_ROB_RED_WXUSER...
prompt Table is empty
prompt Loading TB_ROB_RED_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_SCRATCHCARD...
prompt Table is empty
prompt Loading TB_SCRATCHCARD_PRIZE...
prompt Table is empty
prompt Loading TB_SCRATCHCARD_WXUSER...
prompt Table is empty
prompt Loading TB_SCRATCHCARD_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_SELLER_PUBLICNUMBER...
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company)
values ('7f04f5b8af8248b9b83a74aff6c607d620170915141439', '���ڿƼ�', 'wx3db6ea684d097397', 'cefef93ff906edaecb135e17dab1d878', '/upload/qrcode.png', '1445165502', 'BD5795D634ED6738117018F949C8B46B', null, null, '100651', 'JFfwsy', 'aAmrKzgYCDBsYTgwGJn_a04O8l_2OgcZ94_CnvHN8MY', '���ڿƼ�', '���ڿƼ���ϲ��', '���ڿƼ�ף����', '701', 'BteyqG-wKKhjVt5REqiTHDQKCHg0t0kRoPDsFOBccP0', 'BOykU2jxeeUGvDe6_Yoeq9eA0wtQx9a_0ZHmoVmEdkc', '����˹');
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company)
values ('ec91f66c6fed42d487cb13551caa502220171120152026', '��ʲ3D', 'wx92eab958dc8a82d1', 'b023def5423db45378c2def96437cb3b', '/upload/b3.png', '1284056801', null, null, null, '100666', 'push3dweixin', 'YTbbDHJub8JkuWY4gi2PhMd15B0G_W2nb49z5vzgZoU', '��ʲ3D', '�����ף����', '��ʲ3D���', '708', null, null, null);
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company)
values ('c9902c6bac3c40c2a741418943055a5920170919142510', null, null, null, null, null, null, null, null, 'admin', null, null, null, null, null, '-1', null, null, null);
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company)
values ('1453caacfc284359a91abe6187f99e1c20171102102924', null, 'wx3db6ea684d097397', 'cefef93ff906edaecb135e17dab1d878', null, '1445165502', 'BD5795D634ED6738117018F949C8B46B', null, null, '1001', 'qbtest', 'aAmrKzgYCDBsYTgwGJn_a04O8l_2OgcZ94_CnvHN8MY', null, null, null, '668', null, null, null);
commit;
prompt 4 records loaded
prompt Loading TB_SHARE_BARGAIN...
prompt Table is empty
prompt Loading TB_SHARE_BARGAIN_HELP...
prompt Table is empty
prompt Loading TB_SHARE_BARGAIN_PRIZE...
prompt Table is empty
prompt Loading TB_SHARE_BARGAIN_WXUSER...
prompt Table is empty
prompt Loading TB_TURNTABLE...
prompt Table is empty
prompt Loading TB_TURNTABLE_PRIZE...
prompt Table is empty
prompt Loading TB_TURNTABLE_WXUSER...
prompt Table is empty
prompt Loading TB_TURNTABLE_WXUSER_WINNING...
prompt Table is empty
prompt Loading UPLOAD_IMG...
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('ce977415884645a783ed75ad66af342120180423180043', '/upload/111111111.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('73b2cb0865264c87b70a3b0ada37c9ba20180420113436', '/upload/qrcode.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('5e9710740ec447a0a08cbb568f5224ce20180420160436', '/upload/dsa.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('4283e0da5d0342a184e6259322d98dbb20180424004051', '/upload/2222.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('cdb2f1d2a12949259ff5a9316dd11c6420180424161956', '/upload/dsd.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('fac2d82493194fbca7bff2f95c1d031120180422093137', '/upload/wdsdad.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('63bcf8009fa94f00adb48e08333714c320180424152951', '/upload/cccccc.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('157badaf9b7e453eb74f1af2b9d6657d20180420111655', '/upload/mr.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('2829f8d003a04beb88e992011b4435d620180422093112', '/upload/bg (2).png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('eafb1d2041414f5aa1a2e1c26a54edf820180422093123', '/upload/bg (2)1.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('ee09b6f553ca40e5af24baa4c5330b4b20180423175530', '/upload/11111111.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('41ba63a3fa904dad9d90e7d9b88da6d720180424162006', '/upload/dsd1.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('b6a1706b1c5140a78f14fe4e7a2b166320180425133441', '/upload/dggkmv-min.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('73c5bc1003b54434a9e6d906b7c1f3b520180420111521', '/upload/ptsy1.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('93d3164763ac4eef84df39f179f63eee20180420133214', '/upload/dsdsd.png', '100651', '701', null);
commit;
prompt 15 records loaded
prompt Enabling triggers for ACTIVITY_CODE...
alter table ACTIVITY_CODE enable all triggers;
prompt Enabling triggers for ACTIVITY_WXUSER...
alter table ACTIVITY_WXUSER enable all triggers;
prompt Enabling triggers for DEMO_T...
alter table DEMO_T enable all triggers;
prompt Enabling triggers for JOINACTIVITY...
alter table JOINACTIVITY enable all triggers;
prompt Enabling triggers for LOG_INFO...
alter table LOG_INFO enable all triggers;
prompt Enabling triggers for SYS_CONFIG...
alter table SYS_CONFIG enable all triggers;
prompt Enabling triggers for SYS_MENU...
alter table SYS_MENU enable all triggers;
prompt Enabling triggers for SYS_MENU_ROLE...
alter table SYS_MENU_ROLE enable all triggers;
prompt Enabling triggers for TB_ACCUMULATEFABULOUS...
alter table TB_ACCUMULATEFABULOUS enable all triggers;
prompt Enabling triggers for TB_ACCUMULATEFABULOUS_PRIZE...
alter table TB_ACCUMULATEFABULOUS_PRIZE enable all triggers;
prompt Enabling triggers for TB_ACCUMULATE_COMMENT_WXUSER...
alter table TB_ACCUMULATE_COMMENT_WXUSER enable all triggers;
prompt Enabling triggers for TB_ACCUMULATE_HELP_WXUSER...
alter table TB_ACCUMULATE_HELP_WXUSER enable all triggers;
prompt Enabling triggers for TB_ACCUMULATE_WXUSER_WINNING...
alter table TB_ACCUMULATE_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for TB_ACTIVITY...
alter table TB_ACTIVITY enable all triggers;
prompt Enabling triggers for TB_ACTIVITY_SELLEROUTINFO...
alter table TB_ACTIVITY_SELLEROUTINFO enable all triggers;
prompt Enabling triggers for TB_BREAKEGG_WXUSER...
alter table TB_BREAKEGG_WXUSER enable all triggers;
prompt Enabling triggers for TB_BREAKEGG_WXUSER_WINNING...
alter table TB_BREAKEGG_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for TB_BREAK_EGG...
alter table TB_BREAK_EGG enable all triggers;
prompt Enabling triggers for TB_BREAK_EGG_PRIZE...
alter table TB_BREAK_EGG_PRIZE enable all triggers;
prompt Enabling triggers for TB_EXPRESS...
alter table TB_EXPRESS enable all triggers;
prompt Enabling triggers for TB_GROUP_PURCHASE...
alter table TB_GROUP_PURCHASE enable all triggers;
prompt Enabling triggers for TB_GROUP_PURCHASE_GROUP_WXUSER...
alter table TB_GROUP_PURCHASE_GROUP_WXUSER enable all triggers;
prompt Enabling triggers for TB_GROUP_PURCHASE_PRIZE...
alter table TB_GROUP_PURCHASE_PRIZE enable all triggers;
prompt Enabling triggers for TB_GROUP_PURCHASE_WXUSER...
alter table TB_GROUP_PURCHASE_WXUSER enable all triggers;
prompt Enabling triggers for TB_INTEGRAL...
alter table TB_INTEGRAL enable all triggers;
prompt Enabling triggers for TB_INTEGRAL_ACTIVITY...
alter table TB_INTEGRAL_ACTIVITY enable all triggers;
prompt Enabling triggers for TB_INTEGRAL_EXCHANGE...
alter table TB_INTEGRAL_EXCHANGE enable all triggers;
prompt Enabling triggers for TB_INTEGRAL_PRODUCT...
alter table TB_INTEGRAL_PRODUCT enable all triggers;
prompt Enabling triggers for TB_INTEGRAL_WINNING_INFO...
alter table TB_INTEGRAL_WINNING_INFO enable all triggers;
prompt Enabling triggers for TB_MASTERDATA_LOG...
alter table TB_MASTERDATA_LOG enable all triggers;
prompt Enabling triggers for TB_ONEMONEY_WXUSER_WINNING...
alter table TB_ONEMONEY_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for TB_ONE_MONEY_GROUP_WXUSER...
alter table TB_ONE_MONEY_GROUP_WXUSER enable all triggers;
prompt Enabling triggers for TB_ONE_MONEY_PRIZE...
alter table TB_ONE_MONEY_PRIZE enable all triggers;
prompt Enabling triggers for TB_ONE_MONEY_SHOP...
alter table TB_ONE_MONEY_SHOP enable all triggers;
prompt Enabling triggers for TB_ONE_MONEY_WXUSER...
alter table TB_ONE_MONEY_WXUSER enable all triggers;
prompt Enabling triggers for TB_PRODUCT_WINNING_INFO...
alter table TB_PRODUCT_WINNING_INFO enable all triggers;
prompt Enabling triggers for TB_PURCHASE_WXUSER_WINNING...
alter table TB_PURCHASE_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for TB_PUZZLE...
alter table TB_PUZZLE enable all triggers;
prompt Enabling triggers for TB_PUZZLE_PRIZE...
alter table TB_PUZZLE_PRIZE enable all triggers;
prompt Enabling triggers for TB_PUZZLE_WXUSER...
alter table TB_PUZZLE_WXUSER enable all triggers;
prompt Enabling triggers for TB_PUZZLE_WXUSER_WINNING...
alter table TB_PUZZLE_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for TB_RED_WINNING_INFO...
alter table TB_RED_WINNING_INFO enable all triggers;
prompt Enabling triggers for TB_ROB_RED...
alter table TB_ROB_RED enable all triggers;
prompt Enabling triggers for TB_ROB_RED_PRIZE...
alter table TB_ROB_RED_PRIZE enable all triggers;
prompt Enabling triggers for TB_ROB_RED_WXUSER...
alter table TB_ROB_RED_WXUSER enable all triggers;
prompt Enabling triggers for TB_ROB_RED_WXUSER_WINNING...
alter table TB_ROB_RED_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for TB_SCRATCHCARD...
alter table TB_SCRATCHCARD enable all triggers;
prompt Enabling triggers for TB_SCRATCHCARD_PRIZE...
alter table TB_SCRATCHCARD_PRIZE enable all triggers;
prompt Enabling triggers for TB_SCRATCHCARD_WXUSER...
alter table TB_SCRATCHCARD_WXUSER enable all triggers;
prompt Enabling triggers for TB_SCRATCHCARD_WXUSER_WINNING...
alter table TB_SCRATCHCARD_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for TB_SELLER_PUBLICNUMBER...
alter table TB_SELLER_PUBLICNUMBER enable all triggers;
prompt Enabling triggers for TB_SHARE_BARGAIN...
alter table TB_SHARE_BARGAIN enable all triggers;
prompt Enabling triggers for TB_SHARE_BARGAIN_HELP...
alter table TB_SHARE_BARGAIN_HELP enable all triggers;
prompt Enabling triggers for TB_SHARE_BARGAIN_PRIZE...
alter table TB_SHARE_BARGAIN_PRIZE enable all triggers;
prompt Enabling triggers for TB_SHARE_BARGAIN_WXUSER...
alter table TB_SHARE_BARGAIN_WXUSER enable all triggers;
prompt Enabling triggers for TB_TURNTABLE...
alter table TB_TURNTABLE enable all triggers;
prompt Enabling triggers for TB_TURNTABLE_PRIZE...
alter table TB_TURNTABLE_PRIZE enable all triggers;
prompt Enabling triggers for TB_TURNTABLE_WXUSER...
alter table TB_TURNTABLE_WXUSER enable all triggers;
prompt Enabling triggers for TB_TURNTABLE_WXUSER_WINNING...
alter table TB_TURNTABLE_WXUSER_WINNING enable all triggers;
prompt Enabling triggers for UPLOAD_IMG...
alter table UPLOAD_IMG enable all triggers;
set feedback on
set define on
prompt Done.
