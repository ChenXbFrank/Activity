prompt PL/SQL Developer import file
prompt Created on 2018��5��30�� by Administrator
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

prompt Creating CPK_ORDER_AJ...
create table CPK_ORDER_AJ
(
  orderno  VARCHAR2(60),
  downsign NUMBER(1) default 0,
  datasign NUMBER(1)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CPK_ORDER_AJ
  is '�ӿ����� ';
comment on column CPK_ORDER_AJ.orderno
  is '������';
comment on column CPK_ORDER_AJ.downsign
  is '���ر�־ δ���� 0 ������ 1';
comment on column CPK_ORDER_AJ.datasign
  is '1Ϊ���� 2 Ϊ������';

prompt Creating CPK_ORDER_INFO...
create table CPK_ORDER_INFO
(
  id            VARCHAR2(32) not null,
  create_time   VARCHAR2(20),
  ftype         VARCHAR2(20),
  orderortime   VARCHAR2(64),
  scannum       VARCHAR2(10),
  actualscannum VARCHAR2(10),
  fnumber       VARCHAR2(10),
  record        VARCHAR2(30)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column CPK_ORDER_INFO.create_time
  is '����ʱ��';
comment on column CPK_ORDER_INFO.ftype
  is '�������� ����/������';
comment on column CPK_ORDER_INFO.orderortime
  is '����/ʱ���';
comment on column CPK_ORDER_INFO.scannum
  is '�ӿڷ�������';
comment on column CPK_ORDER_INFO.actualscannum
  is 'ʵ�ʷ�������';
comment on column CPK_ORDER_INFO.fnumber
  is '��������ݿ�����';
comment on column CPK_ORDER_INFO.record
  is '��¼���쳣 /����';

prompt Creating CPK_WLM_AJ...
create table CPK_WLM_AJ
(
  orderno        VARCHAR2(20),
  type           VARCHAR2(20),
  warehousename  VARCHAR2(30),
  serialno       VARCHAR2(24),
  receivercode   VARCHAR2(20),
  receivername   VARCHAR2(50),
  vehicle        VARCHAR2(50),
  receiveaddress VARCHAR2(200),
  shipcode       VARCHAR2(60),
  fromaddress    VARCHAR2(50),
  fromperson     VARCHAR2(12),
  outdate        VARCHAR2(30),
  inputedate     DATE default sysdate,
  upflag         NUMBER(1) default 0,
  datasign       NUMBER(1)
)
tablespace PLSDBFLAT
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column CPK_WLM_AJ.orderno
  is '���ⵥ��';
comment on column CPK_WLM_AJ.type
  is '��ҵ����(OUTBOUND,INBOUND);����ҵ������INBOUNDʱ,���н�����̴���';
comment on column CPK_WLM_AJ.warehousename
  is '�ֿ�����';
comment on column CPK_WLM_AJ.serialno
  is '���';
comment on column CPK_WLM_AJ.receivercode
  is '�����̱���';
comment on column CPK_WLM_AJ.receivername
  is '����������';
comment on column CPK_WLM_AJ.vehicle
  is '������Ϣ';
comment on column CPK_WLM_AJ.receiveaddress
  is '�ջ���ַ';
comment on column CPK_WLM_AJ.shipcode
  is 'װ������';
comment on column CPK_WLM_AJ.fromaddress
  is '������ַ(�ֿ��ַ)';
comment on column CPK_WLM_AJ.fromperson
  is '������ϵ��(�ֿ���ϵ��)';
comment on column CPK_WLM_AJ.outdate
  is '��ҵʱ��(��ʽ yyyy-MM-dd HH:mm:ss)';
comment on column CPK_WLM_AJ.inputedate
  is 'ͬ��ʱ��';
comment on column CPK_WLM_AJ.upflag
  is '������';
comment on column CPK_WLM_AJ.datasign
  is '1Ϊ���� 2 Ϊ������';

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
  spare_two                 VARCHAR2(64),
  need_integral             VARCHAR2(64)
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
comment on column TB_INTEGRAL.need_integral
  is 'һ������Ҫ�Ļ���';
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

prompt Creating TB_INTEGRAL_PRIZE...
create table TB_INTEGRAL_PRIZE
(
  id          VARCHAR2(64) not null,
  integral_id VARCHAR2(64) not null,
  name        VARCHAR2(64),
  type        VARCHAR2(64),
  weight      VARCHAR2(64),
  info        VARCHAR2(64),
  picture     VARCHAR2(1000),
  grade       VARCHAR2(64)
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
comment on column TB_INTEGRAL_PRIZE.integral_id
  is '���ֻID';
comment on column TB_INTEGRAL_PRIZE.name
  is '��Ʒ����';
comment on column TB_INTEGRAL_PRIZE.type
  is '��Ʒ����';
comment on column TB_INTEGRAL_PRIZE.weight
  is 'Ȩ��ֵ';
comment on column TB_INTEGRAL_PRIZE.info
  is '����ֵ  ����ֵ���ߺ��ֵ';
comment on column TB_INTEGRAL_PRIZE.picture
  is '��ƷͼƬ';
comment on column TB_INTEGRAL_PRIZE.grade
  is '��Ʒ�ȼ�';
alter table TB_INTEGRAL_PRIZE
  add constraint TB_INTEGRAL_PRIZE_PK primary key (ID)
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
  groupmoney                VARCHAR2(64) default 1.00,
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
  surplus_probability          VARCHAR2(64) default 0,
  create_time                  VARCHAR2(64) default '',
  surplus_number               VARCHAR2(64) default 0,
  surplus_prize_probability    VARCHAR2(64) default 0,
  surplus_integral_number      VARCHAR2(64) default 0,
  surplus_integral_probability VARCHAR2(64) default 0,
  surplus_integral             VARCHAR2(64) default 0,
  surplus_money                VARCHAR2(64) default 0
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
  company                 VARCHAR2(64),
  scan_img                VARCHAR2(1000),
  logo                    VARCHAR2(1000)
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
comment on column TB_SELLER_PUBLICNUMBER.scan_img
  is 'ɨ��ҳ�汳��ͼ';
comment on column TB_SELLER_PUBLICNUMBER.logo
  is 'LOGO';
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
prompt Disabling triggers for CPK_ORDER_AJ...
alter table CPK_ORDER_AJ disable all triggers;
prompt Disabling triggers for CPK_ORDER_INFO...
alter table CPK_ORDER_INFO disable all triggers;
prompt Disabling triggers for CPK_WLM_AJ...
alter table CPK_WLM_AJ disable all triggers;
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
prompt Disabling triggers for TB_INTEGRAL_PRIZE...
alter table TB_INTEGRAL_PRIZE disable all triggers;
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
insert into ACTIVITY_CODE (id, code, selleroutinfo_recordid, openid, sing_number, spare_one, activity_id, mark, activity_wxid, winingid, wintype, nickname, headimg, sellerpublicid, sellerpublicname)
values ('14e76274984d4708bf817bc7da6917b220180530151222', 'D573500145977515', '3042', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '1', null, '678e9efe168144968180426a604e2e9e', 'robRed', '733610df04b141a9b44444e50545971420180530151222', '777b251eafaf4403a4152891c0aa501d20180530151240', '3', '��', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChyo0ylrfvPmct1gwa43MSBI69Y461yDia1oW6qCwJEsdZ4sqcZ6zCibdF5Duo89ib0KAFdWwicrVg9Lxeqibn0g3JEy7/132', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', '���ڿƼ�');
commit;
prompt 1 records loaded
prompt Loading ACTIVITY_WXUSER...
insert into ACTIVITY_WXUSER (openid, belong_publicnumber_id, nickname, sex, country, province, city, headimgurl, id, total_integral, total_money, surplus_total_money, surplus_total_integral, sian_time)
values ('oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', '��', '1', '�й�', '�Ĵ�', '��Ԫ', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChyo0ylrfvPmct1gwa43MSBI69Y461yDia1oW6qCwJEsdZ4sqcZ6zCibdF5Duo89ib0KAFdWwicrVg9Lxeqibn0g3JEy7/132', '8196ee7a87b04ce5994ef3d97b4d622c20180530151222', '0', '1.00', '0', '0', null);
commit;
prompt 1 records loaded
prompt Loading CPK_ORDER_AJ...
prompt Table is empty
prompt Loading CPK_ORDER_INFO...
prompt Table is empty
prompt Loading CPK_WLM_AJ...
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
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('2062e7f96544460eb3c56ed2c113e78120180530152817', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 15:28:17', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('f6eb661d24c74b48a92e74a9b242ea1f20180530153013', '100651', '�༭-������', '2018-05-30 15:30:13', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('d07cb0d1a6874a488c3d53c24850ae4220180530154309', '100651', '�༭-������', '2018-05-30 15:43:09', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('7e482a5812ff4891912b2b1fea381a3220180530154609', '100651', '�༭-������', '2018-05-30 15:46:09', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('d1a247da66bf4877bbf375e8c5c2d82320180530155106', '100651', '��½', '2018-05-30 15:51:06', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('01569686d940466bb3c24e3b1f30562020180530155131', '100651', '�༭-������', '2018-05-30 15:51:31', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('2663ebc0f877417cbba15fa2b40472eb20180530160222', 'admin', '��½', '2018-05-30 16:02:22', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('841b53daa4134993a1627e3ac0e1497120180530160340', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:03:40', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('64a44c0160214581addc604d873c90f120180530160438', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:04:38', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('27220ab8e2ac440588b4473e2bcf141a20180530161752', '100651', '�༭-�ҽ𵰻', '2018-05-30 16:17:52', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('80c4ab02984f45eaaaa5456c720c3a5320180530163108', '100651', '��½', '2018-05-30 16:31:08', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('01ebf373804c4196a1e25f788f308cd320180530164305', '1001', '��½', '2018-05-30 16:43:05', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('1778688ce3624b52a53ddd1bebe9c35120180530171330', '100651', '�����˳�', '2018-05-30 17:13:30', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('a61d6cb4322743bc968875536917346320180530171712', 'admin', '�����˳�', '2018-05-30 17:17:12', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('9f8eb9bf32404e058ed71a90017bc0b320180530151804', '100651', '��½', '2018-05-30 15:18:04', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('3ea3516677804bada416f4f57dc414e720180530151912', '100651', '�鿴-�ι��ֳ齱�����', '2018-05-30 15:19:12', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('575646f0f9114e7a8f5d5478c7b1cb9920180530152103', '100651', '�༭-������', '2018-05-30 15:21:03', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('8806567779d348ae98fd472e8e5f458220180530152250', '100651', '�༭-������', '2018-05-30 15:22:50', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('d4c3eb3431504b15af6853b50302c82820180530152522', '100651', '�༭-������', '2018-05-30 15:25:22', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('d6782c041d5c4bd590ca7e1b57730c6020180530152833', '100651', '�༭-������', '2018-05-30 15:28:33', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('df7b559a0a7a4b4aa79e5dced3dc51e020180530153236', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 15:32:36', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('aa0d53cb050442a48a16e349d21ab9a020180530153319', '100651', '��½', '2018-05-30 15:33:19', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('7d34efaa4bee4a4ca5ea86aba4b4645b20180530153322', '100651', '�༭-������', '2018-05-30 15:33:22', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('216c8039056c487aa6e2fa0bf99abaf720180530154934', '100651', '�༭-������', '2018-05-30 15:49:34', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('da651ccd4ef542b6a3de279f2b54631c20180530155109', '100651', '�༭-������', '2018-05-30 15:51:09', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('b6224850c50540a9afcdae5433335c0120180530155632', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 15:56:32', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('811940e3bfbd46008cc889f9ecd1e16320180530160351', '100651', '��½', '2018-05-30 16:03:51', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('1442ff8549e440138672d892195ed28820180530160559', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:05:59', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('3db0d5ecd9754bfcb4965df77305bee020180530160614', 'admin', '�ҵĻ', '2018-05-30 16:06:14', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('0e88852cd84249e8aa766a1dea182b5920180530160624', 'admin', '��ѯ-�ҵĻ-ת�̳齱�', '2018-05-30 16:06:24', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('09407e79fabd47539671b25e02fc119420180530160637', 'admin', '��½', '2018-05-30 16:06:37', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('f78bfab93a4f4423af0cbcf2a5a9581320180530160637', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:06:37', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('158c9d4d61c24e62ab8291906a49f2a220180530161636', '100651', '�༭-�ҽ𵰻', '2018-05-30 16:16:36', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('188643528e5e4fa98e3adb6a5e7c2cce20180530161940', '100651', '�༭-һԪ���', '2018-05-30 16:19:40', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('907a999bcc304ca699221947a4e8048f20180530162028', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 16:20:28', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('d9ef7278ba9f4d3cb9bc5c2a9032ddb920180530171121', '100651', '��½', '2018-05-30 17:11:21', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('0bd84da9806a4369bc566f3063ce6d3e20180530171745', '100651', '��½', '2018-05-30 17:17:45', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('c08ec595497d44a88585e612fbd1550420180530151131', '100651', '����-������', '2018-05-30 15:11:31', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('422e9ff937c94dc6bf79e1731131d07320180530151133', '100651', '�����˳�', '2018-05-30 15:11:33', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('434838fd685a4c1abda9d3eb82dbf94b20180530151736', '100651', '�༭-������', '2018-05-30 15:17:36', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('e235f788be4842189385254913a2bc5220180530151928', '100651', '�༭-������', '2018-05-30 15:19:28', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('41df1f4f4c9e45aab3dc97cd28ffb7aa20180530152531', '100651', '�༭-������', '2018-05-30 15:25:31', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('12a86bfea14745519e1711c2549e178a20180530152601', '100651', '�༭-������', '2018-05-30 15:26:01', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('ae7928b944254eeaad2cc504136b404f20180530152651', '100651', '��½', '2018-05-30 15:26:51', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('34de8a25bff24a959dc43da1c40d8cea20180530152657', '100651', '�༭-������', '2018-05-30 15:26:57', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('e359910b92e340e097375d2ff005495520180530153337', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 15:33:37', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('1b356b511f854117aba79c9a2cf4aeb620180530155419', '100651', '�༭-������', '2018-05-30 15:54:19', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('aecec333df7d4afdb1c171e58391edfa20180530155526', '100651', '�༭-������', '2018-05-30 15:55:26', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('e1ece291fb9d4a1292b44ce6111c1c5e20180530155639', '100651', '����-�ι��ֳ齱�����', '2018-05-30 15:56:39', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('fc2903856fa04b02a0811535cb03d51e20180530155834', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 15:58:34', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('fd8cddebc771427abc782590c11db1f320180530155936', '100651', '����-�ι��ֳ齱�����', '2018-05-30 15:59:36', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('1da8d1817207429c8b2e8d2133486d2c20180530160022', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 16:00:22', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('ec47a5c86b1549f9a48059ef7faead0720180530160233', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 16:02:33', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('73d1ed8236074580953107308fbf378220180530160628', 'admin', '�����˳�', '2018-05-30 16:06:28', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('d27cab9373474cc48c2441fc23649b9e20180530160640', 'admin', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 16:06:40', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('9911ce9b823143e88247c8b80a782ecf20180530162058', '100651', '�༭-ƴͼ�', '2018-05-30 16:20:58', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('68ec08b2ea55479db4e12c747bf7f04520180530162556', '100651', '���ں�����', '2018-05-30 16:25:56', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('abe362981c9a47079ac43281b46119f420180530171203', '100651', '��ѯ-�����ۻ-����', '2018-05-30 17:12:03', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('8bb855d135d143bd9450a3e655ada8a620180530171552', '100651', '��½', '2018-05-30 17:15:52', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('71e4b0b2bd174c029ce9ab6bd298326b20180530171651', '100651', '��½', '2018-05-30 17:16:51', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('08fc3dac98084b19bf35955a38b8282720180530171717', '100651', '��½', '2018-05-30 17:17:17', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('72b7def5011545699d2c6b2c541caaa420180530153010', '100651', '��½', '2018-05-30 15:30:10', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('f0c928c0ff0f4729bb31d614b017052320180530161031', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 16:10:31', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('3f5c287ce2bb4e47889ed971db2781fa20180530161416', '100651', '�༭-���޻', '2018-05-30 16:14:16', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('d970fa800a0445dd82a3d282dbb6111b20180530170900', 'admin', '�����˳�', '2018-05-30 17:09:00', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('fe10ef31dcb24cc09c5c0849c7a6cc7120180530171335', 'admin', '��½', '2018-05-30 17:13:35', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('e17d9e2ce3eb4646a87c57a29ff3a99c20180530171452', 'admin', '��½', '2018-05-30 17:14:52', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('f5a2bff8abf143058859e9139714c12020180530151136', 'admin', '��½', '2018-05-30 15:11:36', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('b5e58145dcff46329aef72d1787f129d20180530151139', 'admin', '��������ҳ��', '2018-05-30 15:11:39', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('a5361191e870493e88540ba16f3aa10920180530151140', 'admin', '��ѯ-������-�������', '2018-05-30 15:11:40', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('49f8a4c41b464d0bb413096d7cfd68f920180530151142', 'admin', '��ѯ-������-������ϸ', '2018-05-30 15:11:42', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('8ea87307b7db4e3b8b4fba5daebf3dfb20180530151145', 'admin', '�༭-������-�������', '2018-05-30 15:11:45', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('350e9de428ad42e38c8a8fd35d6e40da20180530151147', 'admin', '��ѯ-������-�������', '2018-05-30 15:11:47', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('5bcff19c22664a3b8008c2c6e83dca1820180530151253', '100651', '�༭-������', '2018-05-30 15:12:53', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('ace65a16195549d28f64bdc162a4f4b720180530154533', '100651', '�༭-������', '2018-05-30 15:45:33', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('07cebc0eb7e940be9a1a95f113f9c46b20180530154738', '100651', '�༭-������', '2018-05-30 15:47:38', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('60ba3c21db4f4dfb95c0dfd0fce9f53420180530154826', '100651', '�༭-������', '2018-05-30 15:48:26', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('9c11edbe25f14584a168fab03035dd3920180530155327', '100651', '�༭-������', '2018-05-30 15:53:27', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('502d8f240280452b99442dc474b2faeb20180530155333', '100651', '�༭-������', '2018-05-30 15:53:33', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('56c0bc16d1bc421184d5a68ede22c9c020180530160102', '100651', '��½', '2018-05-30 16:01:02', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('e636401c2e9b43dc85de529468bfcdfd20180530160109', '100651', '�༭-ǰ��ת�̻�༭ҳ��', '2018-05-30 16:01:09', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('427746da20b74f089aacd831695ec61b20180530160138', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:01:38', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('42d7353f23b143aba4e0f05b31a9a0d020180530160355', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:03:55', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('f0a100e0d96e4bfdb4e1b933102a35ab20180530160513', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:05:13', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('eebaa80d2ec842939e33f57eba09257220180530160705', '100651', '����-�ι��ֳ齱�����', '2018-05-30 16:07:05', null);
insert into LOG_INFO (id, use_usercode, use_function, use_time, spare_one)
values ('1010e714e2b14b528895cad5324b940e20180530170908', '100651', '��½', '2018-05-30 17:09:08', null);
commit;
prompt 86 records loaded
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
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('lkh6e99766b74001b0154b9d378eplk9', '�������', '/advert/approve', '2018-03-29 15:16:56', '2018-03-29 15:16:56', '�������', null, '/img/index/ad-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('95r6e99766b74001b0154b9d3795pli9', '����', '/cancel', '2018-04-29 15:16:56', '2018-04-29 15:16:56', '����', null, '/img/index/can-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('sder485po98b74001b0154b9de4t6y7u8', '������', '/black', '2018-05-29 15:16:56', '2018-05-29 15:16:56', '������', null, '/img/index/black-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('lkh6e99766b74001b0154b9a8rty541o', '���', '/advert', '2018-05-30 15:16:56', '2018-05-30 15:16:56', '���', null, '/img/index/ad-ICON.png', '0');
commit;
prompt 11 records loaded
prompt Loading SYS_MENU_ROLE...
insert into SYS_MENU_ROLE (menu, role, id)
values ('lkh6e99766b74001b0154b9a8rty541o', '1', '999');
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
insert into SYS_MENU_ROLE (menu, role, id)
values ('lkh6e99766b74001b0154b9d378eplk9', '0', '112');
insert into SYS_MENU_ROLE (menu, role, id)
values ('95r6e99766b74001b0154b9d3795pli9', '1', '696');
insert into SYS_MENU_ROLE (menu, role, id)
values ('sder485po98b74001b0154b9de4t6y7u8', '0', '558');
commit;
prompt 16 records loaded
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
insert into TB_ACTIVITY_SELLEROUTINFO (id, activity_id, selleroutinfo_recordid, outno, seller_usercode, state, belong_activity, outsellername, productname, deep, volume, spec, boxsize, bandname, outdate, sendorrec)
values ('63a076bc9181476b8ccda824826b9888', '678e9efe168144968180426a604e2e9e', '3042', 'CK-00000001-20170811-0002', '0', '2', 'robRed', 'Ʒ����һ', '����������', 45, 100, '24', '1', '����Һϵ��', '2017-08-11 09:43:09', null);
commit;
prompt 1 records loaded
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
prompt Loading TB_INTEGRAL_PRIZE...
prompt Table is empty
prompt Loading TB_INTEGRAL_PRODUCT...
prompt Table is empty
prompt Loading TB_INTEGRAL_WINNING_INFO...
prompt Table is empty
prompt Loading TB_MASTERDATA_LOG...
insert into TB_MASTERDATA_LOG (id, account_num, account_group, account_group_type, dealer_type, simple_name, full_name, sales_area, business_number, tax_num, bank_account, bank_name, organization_num, upper_organization_code, is_subbranch, top_branch, transport_type, is_special, title, address, postcode, country, cityid, areaid, quxianid, city, area, quxian, phone, email, headquarters, supplier_account, business_contacts, business_contacts_phone, receiving_contact, receiving_contact_phone, old_num, old_desc, create_by, create_date, update_by, update_date, operation_num, attribute1, status, mdm_sys, processed_status, create_time, update_time)
values ('C724945CC6B142E29CB8A1546DDADF9A', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', 'zz', 0, to_date('08-05-2018 16:20:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('08-05-2018 16:20:53', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 1 records loaded
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
insert into TB_RED_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_red_total, create_time, state, starttime, endtime, withdrawals, activity_wxuser_id, openid, belong_publicnumber_id)
values ('56923a8461fc49818d7304808c0526f820180530151240', '678e9efe168144968180426a604e2e9e', '����', 'robRed', '1', '2018-05-30 15:12:40', '1', '2018-05-30', '2018-06-14', '1', '733610df04b141a9b44444e50545971420180530151222', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 1 records loaded
prompt Loading TB_ROB_RED...
insert into TB_ROB_RED (red_id, activity_name, background_img, belong_activity_id, moblec_background_img, acitivity_launch_userid, acitivity_launch_usercode, join_prople_number, winning_prople_number, state, starttime, endtime, create_time, comfirmuserid, comfirmtime, comfirmadvise, comfirmusername, applyphone, applyusername, scan_red_number, pattern, spare_one, spare_two, sendername, wish, remarks, total, joined)
values ('678e9efe168144968180426a604e2e9e', '����', '/image/hongbao-img.png', '2b39e87d086b4086bf84220f04083683', '/upload/qianghongbao-bg.png', '701', '100651', '1', '1', '1', '2018-05-30', '2018-06-14', '2018-05-30 15:11:31', '-1', '2018-05-30 15:11:45', 'OK', 'ϵͳ����Ա', '13888888888', 'Ʒ����һ', '1', '1', null, null, '0', '0', '0', '23', '0');
commit;
prompt 1 records loaded
prompt Loading TB_ROB_RED_PRIZE...
insert into TB_ROB_RED_PRIZE (red_prize_id, red_id, prize_project, prize_project_money, get_prize_number, subtotal, red_winning_probability, winning_integral, winning_integral_number, red_probability_total, prize_project_total_money, scanrodrednum, integral_winning_probability, integral_probability_total, surplus_probability, create_time, surplus_number, surplus_prize_probability, surplus_integral_number, surplus_integral_probability, surplus_integral, surplus_money)
values ('924a6d54344d47749b9a0c6fee2766bd', '678e9efe168144968180426a604e2e9e', 'һ�Ƚ�', '1', '24', '24.00', '100.00', null, null, '100.00', '24.00', null, null, null, '0.00', '2018-05-30 15:11:31', '23', '100.00', '0', '0', '0', '0');
commit;
prompt 1 records loaded
prompt Loading TB_ROB_RED_WXUSER...
insert into TB_ROB_RED_WXUSER (red_wxuser_id, red_id, openid, nickname, headimgurl, belong_publicnumber_id, create_time, state, scan_code, scan_red_number, total_money, activity_name, starttime, endtime, joinmode)
values ('733610df04b141a9b44444e50545971420180530151222', '678e9efe168144968180426a604e2e9e', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '��', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChyo0ylrfvPmct1gwa43MSBI69Y461yDia1oW6qCwJEsdZ4sqcZ6zCibdF5Duo89ib0KAFdWwicrVg9Lxeqibn0g3JEy7/132', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', '2018-05-30 15:12:22', '0', 'D573500145977515', '0', '1.00', '����', '2018-05-30', '2018-06-14', '1');
commit;
prompt 1 records loaded
prompt Loading TB_ROB_RED_WXUSER_WINNING...
insert into TB_ROB_RED_WXUSER_WINNING (red_wxuser_winning_id, red_wxuser_id, belong_rob_red_prize_id, winning_money, prize_project, create_time, openid)
values ('777b251eafaf4403a4152891c0aa501d20180530151240', '733610df04b141a9b44444e50545971420180530151222', '924a6d54344d47749b9a0c6fee2766bd', '1', 'һ�Ƚ�', '2018-05-30 15:12:40', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ');
commit;
prompt 1 records loaded
prompt Loading TB_SCRATCHCARD...
prompt Table is empty
prompt Loading TB_SCRATCHCARD_PRIZE...
prompt Table is empty
prompt Loading TB_SCRATCHCARD_WXUSER...
prompt Table is empty
prompt Loading TB_SCRATCHCARD_WXUSER_WINNING...
prompt Table is empty
prompt Loading TB_SELLER_PUBLICNUMBER...
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company, scan_img, logo)
values ('7f04f5b8af8248b9b83a74aff6c607d620170915141439', '���ڿƼ�', 'wx3db6ea684d097397', 'cefef93ff906edaecb135e17dab1d878', '/upload/qrcode1.jpg', '1445165502', 'BD5795D634ED6738117018F949C8B46B', null, null, '100651', 'JFfwsy', 'aAmrKzgYCDBsYTgwGJn_a04O8l_2OgcZ94_CnvHN8MY', '���ڿƼ�', '���ڿƼ���ϲ��', '���ڿƼ�ף����', '701', 'BteyqG-wKKhjVt5REqiTHDQKCHg0t0kRoPDsFOBccP0', 'BOykU2jxeeUGvDe6_Yoeq9eA0wtQx9a_0ZHmoVmEdkc', '����˹', '/upload/bg.png', '/upload/logo(2).png');
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company, scan_img, logo)
values ('ec91f66c6fed42d487cb13551caa502220171120152026', '��ʲ3D', 'wx92eab958dc8a82d1', 'b023def5423db45378c2def96437cb3b', '/upload/b3.png', '1284056801', null, null, null, '100666', 'push3dweixin', 'YTbbDHJub8JkuWY4gi2PhMd15B0G_W2nb49z5vzgZoU', '��ʲ3D', '�����ף����', '��ʲ3D���', '708', null, null, null, null, null);
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company, scan_img, logo)
values ('c9902c6bac3c40c2a741418943055a5920170919142510', null, null, null, null, null, null, null, null, 'admin', null, null, null, null, null, '-1', null, null, null, null, null);
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company, scan_img, logo)
values ('1453caacfc284359a91abe6187f99e1c20171102102924', null, 'wx3db6ea684d097397', 'cefef93ff906edaecb135e17dab1d878', null, '1445165502', 'BD5795D634ED6738117018F949C8B46B', null, null, '1001', 'qbtest', 'aAmrKzgYCDBsYTgwGJn_a04O8l_2OgcZ94_CnvHN8MY', null, null, null, '668', null, null, null, null, null);
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
values ('71fc9644f3e34e44ba46638cd2ebe1d220180514154840', '/upload/chaxianban-01.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('8eb43c5c1a2142b9a5a4470a8de478cc20180521104522', '/upload/logo(1).png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('cf6221b2b1e84cad8cf420dee327c15720180521102227', '/upload/qrcode1.jpg', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('9e07cb91a7a04b849430e450fe62df0d20180528144631', '/upload/wuliangye.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('634bc6b3855a48d2a72f0ec2d7d177ba20180511151139', '/upload/3Dhua-0.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('1edd1bac3a504ecd832bf21f40f4046a20180511151205', '/upload/hongjiu-0.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('d5b73eb7405c4140b9206f917a9b274320180516142148', '/upload/u=2024874167,1012015013&fm=27&gp=0.jpg', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('e2eaa07237384b2e94a0550bb432381d20180521103258', '/upload/rrrrr.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('b0e28d205a67499e90c4c67190e15e1d20180518155051', '/upload/logo(2).png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('5f51cf8a451d43d1a695c488e55d4c6820180523151442', '/upload/timg.jpg', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('8539d82fa15a4aa3973921576555038720180514154555', '/upload/3Dhua-01.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('ecc6f6d4c06049b2a84bbb388e2fe8ca20180514154559', '/upload/1218-02.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('54c27485360e4d31bed25f8b153fa0e720180514154619', '/upload/jiuzhenbaoxiaojiu-0.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('6de62379dea34f63a2cf7f61a94a809b20180514132911', '/upload/bj.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('02de20d2895e466b83540edb7246bea320180514154604', '/upload/chaxianban-0.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('68a5a0411bd54a31a69bf9dd7e4e025420180514154609', '/upload/hongjiu-01.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('a665d33d8f20466a98134111f099204720180515103004', '/upload/5liangchun.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('e874eb56f43344a2beee3331ff923fdf20180515103053', '/upload/dadanya.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('f448a2598f174920b5607140d53adc8f20180518155204', '/upload/logo(2)1.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('415a7bebd8d349ac8adb8e468ebf3d5e20180511151201', '/upload/1218-01.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('72647e679ac34d2ca59fb1de4881d26920180523104355', '/upload/wwwww.png', '100651', '701', null);
commit;
prompt 21 records loaded
prompt Enabling triggers for ACTIVITY_CODE...
alter table ACTIVITY_CODE enable all triggers;
prompt Enabling triggers for ACTIVITY_WXUSER...
alter table ACTIVITY_WXUSER enable all triggers;
prompt Enabling triggers for CPK_ORDER_AJ...
alter table CPK_ORDER_AJ enable all triggers;
prompt Enabling triggers for CPK_ORDER_INFO...
alter table CPK_ORDER_INFO enable all triggers;
prompt Enabling triggers for CPK_WLM_AJ...
alter table CPK_WLM_AJ enable all triggers;
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
prompt Enabling triggers for TB_INTEGRAL_PRIZE...
alter table TB_INTEGRAL_PRIZE enable all triggers;
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
