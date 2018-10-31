prompt PL/SQL Developer import file
prompt Created on 2018年5月18日 by Administrator
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
  is '所扫码的CODE';
comment on column ACTIVITY_CODE.selleroutinfo_recordid
  is '发货信息中的记录ID';
comment on column ACTIVITY_CODE.openid
  is '用户OPENID';
comment on column ACTIVITY_CODE.sing_number
  is '扫码次数';
comment on column ACTIVITY_CODE.spare_one
  is '备用字段';
comment on column ACTIVITY_CODE.activity_id
  is '活动id';
comment on column ACTIVITY_CODE.mark
  is '活动标识';
comment on column ACTIVITY_CODE.activity_wxid
  is '参加的微信活动ID';
comment on column ACTIVITY_CODE.winingid
  is '中奖id';
comment on column ACTIVITY_CODE.wintype
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
';
comment on column ACTIVITY_CODE.nickname
  is '扫码用户昵称';
comment on column ACTIVITY_CODE.headimg
  is '头像';
comment on column ACTIVITY_CODE.sellerpublicid
  is '公众号id';
comment on column ACTIVITY_CODE.sellerpublicname
  is '公众号名字';
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
  is 'ACTIVITY_WXUSER 活动用户';
comment on column ACTIVITY_WXUSER.openid
  is '微信指定openidid/主键';
comment on column ACTIVITY_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column ACTIVITY_WXUSER.nickname
  is '微信昵称';
comment on column ACTIVITY_WXUSER.sex
  is '1 = 男  2 = 女';
comment on column ACTIVITY_WXUSER.country
  is '国家';
comment on column ACTIVITY_WXUSER.province
  is '省份';
comment on column ACTIVITY_WXUSER.city
  is '城市';
comment on column ACTIVITY_WXUSER.headimgurl
  is '头像地址';
comment on column ACTIVITY_WXUSER.total_integral
  is '总积分';
comment on column ACTIVITY_WXUSER.total_money
  is '总金额';
comment on column ACTIVITY_WXUSER.surplus_total_money
  is '剩余金额';
comment on column ACTIVITY_WXUSER.surplus_total_integral
  is '剩余积分';
comment on column ACTIVITY_WXUSER.sian_time
  is '签到时间';
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
  is '积分活动id';
comment on column JOINACTIVITY.join_integral
  is '消费的积分';
comment on column JOINACTIVITY.activitymark
  is '活动标识';
comment on column JOINACTIVITY.activityname
  is '活动名称';
comment on column JOINACTIVITY.jointime
  is '参与时间';
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
  is '操作人';
comment on column LOG_INFO.use_function
  is '操作功能';
comment on column LOG_INFO.use_time
  is '操作时间';
comment on column LOG_INFO.spare_one
  is '备用字段一';
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
  is '菜单名称';
comment on column SYS_MENU.href
  is '路径';
comment on column SYS_MENU.create_date
  is '创建时间';
comment on column SYS_MENU.update_date
  is '修改时间';
comment on column SYS_MENU.remarks
  is '备注';
comment on column SYS_MENU.parent_id
  is '父级/未启用字段';
comment on column SYS_MENU.img
  is '图标地址';
comment on column SYS_MENU.delflag
  is '删除标示    0 未删除   1已删除';
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
  is '菜单';
comment on column SYS_MENU_ROLE.role
  is '角色';
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
  is '活动名称';
comment on column TB_ACCUMULATEFABULOUS.background_img
  is '背景图';
comment on column TB_ACCUMULATEFABULOUS.belong_activity_id
  is '所属活动ID';
comment on column TB_ACCUMULATEFABULOUS.moble_background_img
  is '手机页面背景图';
comment on column TB_ACCUMULATEFABULOUS.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_ACCUMULATEFABULOUS.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_ACCUMULATEFABULOUS.join_prople_number
  is '参加人数';
comment on column TB_ACCUMULATEFABULOUS.winning_prople_number
  is '获奖人数';
comment on column TB_ACCUMULATEFABULOUS.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_ACCUMULATEFABULOUS.create_time
  is '开始时间';
comment on column TB_ACCUMULATEFABULOUS.comfirmuserid
  is '审核人的ID';
comment on column TB_ACCUMULATEFABULOUS.comfirmtime
  is '审核时间';
comment on column TB_ACCUMULATEFABULOUS.comfirmadvise
  is '审核建议';
comment on column TB_ACCUMULATEFABULOUS.comfirmusername
  is '审核人名称';
comment on column TB_ACCUMULATEFABULOUS.applyphone
  is '申请人电话';
comment on column TB_ACCUMULATEFABULOUS.applyusername
  is '申请人名称';
comment on column TB_ACCUMULATEFABULOUS.productimg
  is '产品图片';
comment on column TB_ACCUMULATEFABULOUS.productintroduction
  is '集赞产品介绍';
comment on column TB_ACCUMULATEFABULOUS.spare_one
  is '备用字段一';
comment on column TB_ACCUMULATEFABULOUS.spare_two
  is '备用字段二';
comment on column TB_ACCUMULATEFABULOUS.starttime
  is '开始时间';
comment on column TB_ACCUMULATEFABULOUS.endtime
  is '结束时间';
comment on column TB_ACCUMULATEFABULOUS.applyuserid
  is '申请人ID';
comment on column TB_ACCUMULATEFABULOUS.handle
  is '0未处理1已处理';
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
  is '所属集赞活动ID';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizegrade
  is '奖品等级';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.threshold
  is '阀值';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizename
  is '奖品名称(可以是实物名、红包名)';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizeimg
  is '奖品图片';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.prizetype
  is '奖品类型 1实物 2积分 3红包';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.redmoney
  is '红包值';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.accumulatenumber
  is '集赞总数';
comment on column TB_ACCUMULATEFABULOUS_PRIZE.integral
  is '积分值';
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
  is 'TB_ACCUMUL_COMMENT_WXUSER   集赞活动评论用户';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.accumulate_id
  is '活动ID';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.openid
  is '微信指定ID';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.nickname
  is '微信昵称';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.headimgurl
  is '微信头像';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.create_time
  is '创建时间';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.comments
  is '评论内容';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.help_number
  is '被点赞数量';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.state
  is '1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货 6已支付';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.activity_name
  is '活动名称';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.accumulate_przie_id
  is '集赞奖品ID';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.commentimg
  is '评论图片';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.winstate
  is '中奖情况 1一等奖 2阀值奖 3未中奖';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.spareone
  is '备用字段1存储中奖情况';
comment on column TB_ACCUMULATE_COMMENT_WXUSER.noticed
  is '默认为0未通知，1已通知';
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
  is 'TB_ACCUMUL_HELP_WXUSER   集赞活动点赞用户';
comment on column TB_ACCUMULATE_HELP_WXUSER.id
  is '唯一主键';
comment on column TB_ACCUMULATE_HELP_WXUSER.comment_wxuser_id
  is '集赞活动ID';
comment on column TB_ACCUMULATE_HELP_WXUSER.openid
  is '微信指定ID';
comment on column TB_ACCUMULATE_HELP_WXUSER.nickname
  is '微信昵称';
comment on column TB_ACCUMULATE_HELP_WXUSER.headimgurl
  is '微信头像';
comment on column TB_ACCUMULATE_HELP_WXUSER.belong_publicnumber_id
  is '所属公众号';
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
  is '集赞参与记录ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_ACCUMULATE_WXUSER_WINNING.belong_winning_prize_id
  is '所属中奖ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.winning_money
  is '中奖金额/积分';
comment on column TB_ACCUMULATE_WXUSER_WINNING.prize_project
  is '奖品名称';
comment on column TB_ACCUMULATE_WXUSER_WINNING.create_time
  is '创建时间';
comment on column TB_ACCUMULATE_WXUSER_WINNING.prize_project_img
  is '奖品图片';
comment on column TB_ACCUMULATE_WXUSER_WINNING.openid
  is '微信指定ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.state
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_ACCUMULATE_WXUSER_WINNING.addressee_name
  is '收件人姓名';
comment on column TB_ACCUMULATE_WXUSER_WINNING.addressee_address
  is '收件人地址';
comment on column TB_ACCUMULATE_WXUSER_WINNING.addressee_phone
  is '收件人电话';
comment on column TB_ACCUMULATE_WXUSER_WINNING.lssue_user_name
  is '发货人名称';
comment on column TB_ACCUMULATE_WXUSER_WINNING.lssue_user_userid
  is '发货人USERID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.lssue_user_usercode
  is '发货人USERCODE';
comment on column TB_ACCUMULATE_WXUSER_WINNING.deliver_number
  is '快递单号';
comment on column TB_ACCUMULATE_WXUSER_WINNING.deliver_company
  is '快递公司';
comment on column TB_ACCUMULATE_WXUSER_WINNING.deliver_time
  is '发货时间';
comment on column TB_ACCUMULATE_WXUSER_WINNING.product_winning_info_id
  is '实物中奖记录ID';
comment on column TB_ACCUMULATE_WXUSER_WINNING.spare_one
  is '存储奖品类型';
comment on column TB_ACCUMULATE_WXUSER_WINNING.spare_two
  is '存储状态';
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
  is '唯一主键';
comment on column TB_ACTIVITY.activity_name
  is '活动名称';
comment on column TB_ACTIVITY.img
  is '图片';
comment on column TB_ACTIVITY.href
  is '跳转路径';
comment on column TB_ACTIVITY.remarks
  is '备注';
comment on column TB_ACTIVITY.update_date
  is '修改时间';
comment on column TB_ACTIVITY.approvehref
  is '审核的链接';
comment on column TB_ACTIVITY.reporthref
  is '活动报表的链接';
comment on column TB_ACTIVITY.activityhref
  is '对应活动记录查询的链接';
comment on column TB_ACTIVITY.integral_choice_href
  is '查询当前人申请的活动   路径，返回json';
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
  is '活动与运单表 TB_ACTIVITY_SELLEROUTINFO';
comment on column TB_ACTIVITY_SELLEROUTINFO.activity_id
  is '活动ID';
comment on column TB_ACTIVITY_SELLEROUTINFO.selleroutinfo_recordid
  is '发货信息中记录ID';
comment on column TB_ACTIVITY_SELLEROUTINFO.outno
  is '出库单号';
comment on column TB_ACTIVITY_SELLEROUTINFO.seller_usercode
  is '经销商userCode';
comment on column TB_ACTIVITY_SELLEROUTINFO.state
  is '状态 1可以用 2不可用';
comment on column TB_ACTIVITY_SELLEROUTINFO.belong_activity
  is '所属活动';
comment on column TB_ACTIVITY_SELLEROUTINFO.outsellername
  is '该运单的渠道商';
comment on column TB_ACTIVITY_SELLEROUTINFO.productname
  is '货品名称';
comment on column TB_ACTIVITY_SELLEROUTINFO.deep
  is '度数';
comment on column TB_ACTIVITY_SELLEROUTINFO.volume
  is '容量';
comment on column TB_ACTIVITY_SELLEROUTINFO.spec
  is '规格';
comment on column TB_ACTIVITY_SELLEROUTINFO.boxsize
  is '箱数';
comment on column TB_ACTIVITY_SELLEROUTINFO.bandname
  is '品牌名称';
comment on column TB_ACTIVITY_SELLEROUTINFO.outdate
  is '发货时间';
comment on column TB_ACTIVITY_SELLEROUTINFO.sendorrec
  is '1接收的货  2发出的货';
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
  is 'TB_BREAKEGG_WXUSER   砸蛋活动用户';
comment on column TB_BREAKEGG_WXUSER.breakegg_id
  is '活动ID';
comment on column TB_BREAKEGG_WXUSER.openid
  is '微信指定ID';
comment on column TB_BREAKEGG_WXUSER.nickname
  is '微信昵称';
comment on column TB_BREAKEGG_WXUSER.headimgurl
  is '微信头像';
comment on column TB_BREAKEGG_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_BREAKEGG_WXUSER.create_time
  is '创建时间';
comment on column TB_BREAKEGG_WXUSER.state
  is '1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货 6已支付';
comment on column TB_BREAKEGG_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_BREAKEGG_WXUSER.activity_name
  is '活动名称';
comment on column TB_BREAKEGG_WXUSER.breakegg_przie_id
  is '砸蛋奖品ID';
comment on column TB_BREAKEGG_WXUSER.total_money
  is '单次参与金额';
comment on column TB_BREAKEGG_WXUSER.total_integral
  is '单次参与中奖积分';
comment on column TB_BREAKEGG_WXUSER.thanknumber
  is '感谢次数';
comment on column TB_BREAKEGG_WXUSER.goodsnumber
  is '实物次数';
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
  is '砸蛋参与记录ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_BREAKEGG_WXUSER_WINNING.belong_winning_prize_id
  is '所属中奖ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.winning_money
  is '中奖金额/积分';
comment on column TB_BREAKEGG_WXUSER_WINNING.prize_project
  is '奖品名称';
comment on column TB_BREAKEGG_WXUSER_WINNING.create_time
  is '创建时间';
comment on column TB_BREAKEGG_WXUSER_WINNING.prize_project_img
  is '奖品图片';
comment on column TB_BREAKEGG_WXUSER_WINNING.openid
  is '微信指定ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.state
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_BREAKEGG_WXUSER_WINNING.addressee_name
  is '收件人姓名';
comment on column TB_BREAKEGG_WXUSER_WINNING.addressee_address
  is '收件人地址';
comment on column TB_BREAKEGG_WXUSER_WINNING.addressee_phone
  is '收件人电话';
comment on column TB_BREAKEGG_WXUSER_WINNING.lssue_user_name
  is '发货人名称';
comment on column TB_BREAKEGG_WXUSER_WINNING.lssue_user_userid
  is '发货人USERID';
comment on column TB_BREAKEGG_WXUSER_WINNING.lssue_user_usercode
  is '发货人USERCODE';
comment on column TB_BREAKEGG_WXUSER_WINNING.deliver_number
  is '快递单号';
comment on column TB_BREAKEGG_WXUSER_WINNING.deliver_company
  is '快递公司';
comment on column TB_BREAKEGG_WXUSER_WINNING.deliver_time
  is '发货时间';
comment on column TB_BREAKEGG_WXUSER_WINNING.product_winning_info_id
  is '实物中奖记录ID';
comment on column TB_BREAKEGG_WXUSER_WINNING.spare_one
  is '存储奖品类型';
comment on column TB_BREAKEGG_WXUSER_WINNING.spare_two
  is '存储状态';
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
  is '活动名称';
comment on column TB_BREAK_EGG.background_img
  is '背景图';
comment on column TB_BREAK_EGG.belong_activity_id
  is '所属活动ID';
comment on column TB_BREAK_EGG.moble_background_img
  is '手机页面背景图';
comment on column TB_BREAK_EGG.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_BREAK_EGG.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_BREAK_EGG.join_prople_number
  is '参加人数';
comment on column TB_BREAK_EGG.winning_prople_number
  is '获奖人数';
comment on column TB_BREAK_EGG.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_BREAK_EGG.create_time
  is '开始时间';
comment on column TB_BREAK_EGG.comfirmuserid
  is '审核人的ID';
comment on column TB_BREAK_EGG.comfirmtime
  is '审核时间';
comment on column TB_BREAK_EGG.comfirmadvise
  is '审核建议';
comment on column TB_BREAK_EGG.comfirmusername
  is '审核人名称';
comment on column TB_BREAK_EGG.applyphone
  is '申请人电话';
comment on column TB_BREAK_EGG.applyusername
  is '申请人名称';
comment on column TB_BREAK_EGG.breaknumber
  is '砸蛋次数';
comment on column TB_BREAK_EGG.spare_one
  is '备用字段一';
comment on column TB_BREAK_EGG.spare_two
  is '备用字段二';
comment on column TB_BREAK_EGG.starttime
  is '开始时间';
comment on column TB_BREAK_EGG.endtime
  is '结束时间';
comment on column TB_BREAK_EGG.applyuserid
  is '申请人ID';
comment on column TB_BREAK_EGG.total
  is '奖品总数';
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
  is '所属砸蛋活动ID';
comment on column TB_BREAK_EGG_PRIZE.prizename
  is '奖品名称(可以是实物名、红包名)';
comment on column TB_BREAK_EGG_PRIZE.prizeimg
  is '奖品图片';
comment on column TB_BREAK_EGG_PRIZE.prizetype
  is '奖品类型 1实物 2积分 3红包';
comment on column TB_BREAK_EGG_PRIZE.prizenumber
  is '奖品数量';
comment on column TB_BREAK_EGG_PRIZE.prizeprobability
  is '中奖概率';
comment on column TB_BREAK_EGG_PRIZE.integral
  is '积分值';
comment on column TB_BREAK_EGG_PRIZE.redmoney
  is '红包值';
comment on column TB_BREAK_EGG_PRIZE.surplus_prize_number
  is '剩余数量';
comment on column TB_BREAK_EGG_PRIZE.surplus_prize_probability
  is '剩余奖品概率';
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
  is '活动名称';
comment on column TB_GROUP_PURCHASE.background_img
  is '背景图';
comment on column TB_GROUP_PURCHASE.belong_activity_id
  is '所属活动ID';
comment on column TB_GROUP_PURCHASE.moble_background_img
  is '手机页面背景图';
comment on column TB_GROUP_PURCHASE.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_GROUP_PURCHASE.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_GROUP_PURCHASE.join_prople_number
  is '参加人数';
comment on column TB_GROUP_PURCHASE.winning_prople_number
  is '获奖人数';
comment on column TB_GROUP_PURCHASE.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_GROUP_PURCHASE.create_time
  is '开始时间';
comment on column TB_GROUP_PURCHASE.comfirmuserid
  is '审核人的ID';
comment on column TB_GROUP_PURCHASE.comfirmtime
  is '审核时间';
comment on column TB_GROUP_PURCHASE.comfirmadvise
  is '审核建议';
comment on column TB_GROUP_PURCHASE.comfirmusername
  is '审核人名称';
comment on column TB_GROUP_PURCHASE.applyphone
  is '申请人电话';
comment on column TB_GROUP_PURCHASE.applyusername
  is '申请人名称';
comment on column TB_GROUP_PURCHASE.openprizenumber
  is '开奖人数';
comment on column TB_GROUP_PURCHASE.spare_one
  is '备用字段一';
comment on column TB_GROUP_PURCHASE.spare_two
  is '备用字段二';
comment on column TB_GROUP_PURCHASE.starttime
  is '开始时间';
comment on column TB_GROUP_PURCHASE.endtime
  is '结束时间';
comment on column TB_GROUP_PURCHASE.applyuserid
  is '申请人ID';
comment on column TB_GROUP_PURCHASE.total
  is '奖品总数';
comment on column TB_GROUP_PURCHASE.groupprice
  is '拼团价';
comment on column TB_GROUP_PURCHASE.outtotal
  is '运单总瓶数';
comment on column TB_GROUP_PURCHASE.handle
  is '处理情况0未处理1已处理';
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
  is '拼团微信用户参与活动ID';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.openid
  is '微信指定ID';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.nickname
  is '微信昵称';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.headimgurl
  is '微信头像';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.create_time
  is '创建时间';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.state
  is '状态';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.activity_name
  is '活动名称';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.creater
  is '创建者1 参与者0
';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.paymoney
  is '支付金额
';
comment on column TB_GROUP_PURCHASE_GROUP_WXUSER.paystate
  is '支付状态 0未支付 1支付
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
  is '奖品名称(这里只是酒)';
comment on column TB_GROUP_PURCHASE_PRIZE.prizeimg
  is '奖品图片';
comment on column TB_GROUP_PURCHASE_PRIZE.prizenumber
  is '奖品数量';
comment on column TB_GROUP_PURCHASE_PRIZE.spec
  is '规格';
comment on column TB_GROUP_PURCHASE_PRIZE.deep
  is '度数';
comment on column TB_GROUP_PURCHASE_PRIZE.volume
  is '容量';
comment on column TB_GROUP_PURCHASE_PRIZE.boxcount
  is '箱数';
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
  is '拼团活动ID';
comment on column TB_GROUP_PURCHASE_WXUSER.openid
  is '微信指定ID';
comment on column TB_GROUP_PURCHASE_WXUSER.nickname
  is '微信昵称';
comment on column TB_GROUP_PURCHASE_WXUSER.headimgurl
  is '微信头像';
comment on column TB_GROUP_PURCHASE_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_GROUP_PURCHASE_WXUSER.create_time
  is '创建时间';
comment on column TB_GROUP_PURCHASE_WXUSER.state
  is '状态';
comment on column TB_GROUP_PURCHASE_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_GROUP_PURCHASE_WXUSER.activity_name
  is '活动名称';
comment on column TB_GROUP_PURCHASE_WXUSER.paystate
  is '0未支付 1支付';
comment on column TB_GROUP_PURCHASE_WXUSER.paymoney
  is '拼团 默认一元';
comment on column TB_GROUP_PURCHASE_WXUSER.payoutno
  is '支付订单号';
comment on column TB_GROUP_PURCHASE_WXUSER.mchid
  is '商户号';
comment on column TB_GROUP_PURCHASE_WXUSER.handle
  is '处理状态 0未处理 1已处理';
comment on column TB_GROUP_PURCHASE_WXUSER.fulled
  is '满员情况 0未满员 1已满员';
comment on column TB_GROUP_PURCHASE_WXUSER.goodstate
  is '发货状态 0 未发货  1已发货';
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
  is '签到获取积分';
comment on column TB_INTEGRAL.background_img
  is '背景图';
comment on column TB_INTEGRAL.belong_activity_id
  is '所属活动ID';
comment on column TB_INTEGRAL.moblec_background_img
  is '手机页面背景图';
comment on column TB_INTEGRAL.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_INTEGRAL.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_INTEGRAL.join_prople_number
  is '参加人数';
comment on column TB_INTEGRAL.winning_prople_number
  is '获奖人数';
comment on column TB_INTEGRAL.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_INTEGRAL.create_time
  is '创建时间';
comment on column TB_INTEGRAL.comfirmuserid
  is '审核人的ID';
comment on column TB_INTEGRAL.comfirmtime
  is '审核时间';
comment on column TB_INTEGRAL.comfirmadvise
  is '审核建议';
comment on column TB_INTEGRAL.comfirmusername
  is '审核人名称';
comment on column TB_INTEGRAL.applyphone
  is '申请人电话';
comment on column TB_INTEGRAL.applyusername
  is '申请人名称';
comment on column TB_INTEGRAL.total
  is '总瓶数';
comment on column TB_INTEGRAL.spare_one
  is '备用字段一';
comment on column TB_INTEGRAL.spare_two
  is '备用字段二';
comment on column TB_INTEGRAL.need_integral
  is '一次所需要的积分';
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
  is '积分ID';
comment on column TB_INTEGRAL_ACTIVITY.order_number
  is '编号';
comment on column TB_INTEGRAL_ACTIVITY.activity_number
  is '活动编码';
comment on column TB_INTEGRAL_ACTIVITY.activity_name
  is '活动名称';
comment on column TB_INTEGRAL_ACTIVITY.activity_id
  is '活动ID';
comment on column TB_INTEGRAL_ACTIVITY.need_integral
  is '所需积分';
comment on column TB_INTEGRAL_ACTIVITY.ten_activity_id
  is '十个活动ID';
comment on column TB_INTEGRAL_ACTIVITY.ten_activity_name
  is '十个活动名称';
comment on column TB_INTEGRAL_ACTIVITY.background_img
  is '用户发起活动背景图';
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
  is '积分活动ID';
comment on column TB_INTEGRAL_EXCHANGE.exchange_type
  is '1=兑换参与记录   2=兑换产品';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_id
  is '兑换产品或兑换参与活动的ID';
comment on column TB_INTEGRAL_EXCHANGE.exchange_use_integral
  is '兑换使用积分';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_name
  is '兑换产品或兑换参与活动的名称';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_img
  is '兑换产品或兑换参与活动的图片';
comment on column TB_INTEGRAL_EXCHANGE.exchange_prize_number
  is '兑换产品或兑换参与活动的数量';
comment on column TB_INTEGRAL_EXCHANGE.ten_activity_id
  is '十个活动ID';
comment on column TB_INTEGRAL_EXCHANGE.ten_activity_name
  is '十个活动名称';
comment on column TB_INTEGRAL_EXCHANGE.openid
  is '微信用户唯一ID';
comment on column TB_INTEGRAL_EXCHANGE.addressee_name
  is '收件人姓名';
comment on column TB_INTEGRAL_EXCHANGE.addressee_address
  is '收件人地址';
comment on column TB_INTEGRAL_EXCHANGE.addressee_phone
  is '收件人电话';
comment on column TB_INTEGRAL_EXCHANGE.state
  is '发货状态  1=兑换成功  2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_INTEGRAL_EXCHANGE.lssue_user_name
  is '发货人名称';
comment on column TB_INTEGRAL_EXCHANGE.lssue_user_userid
  is '发货人USERID';
comment on column TB_INTEGRAL_EXCHANGE.lssue_user_usercode
  is '发货人USERCODE';
comment on column TB_INTEGRAL_EXCHANGE.deliver_number
  is '快递单号';
comment on column TB_INTEGRAL_EXCHANGE.deliver_company
  is '快递公司';
comment on column TB_INTEGRAL_EXCHANGE.qrcode
  is '兑换参与活动时保存的QRCODE，查询兑换所中奖品';
comment on column TB_INTEGRAL_EXCHANGE.nickname
  is '昵称';
comment on column TB_INTEGRAL_EXCHANGE.headimgurl
  is '头像';
comment on column TB_INTEGRAL_EXCHANGE.create_time
  is '创建时间';
comment on column TB_INTEGRAL_EXCHANGE.deliver_time
  is '发货时间';
comment on column TB_INTEGRAL_EXCHANGE.product_winning_info_id
  is '实物中奖记录ID';
comment on column TB_INTEGRAL_EXCHANGE.belong_publicnumber_id
  is '所属公众号ID';
comment on column TB_INTEGRAL_EXCHANGE.spareone
  is '存储状态';
comment on column TB_INTEGRAL_EXCHANGE.sparetwo
  is '积分类型';
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
  is '积分活动ID';
comment on column TB_INTEGRAL_PRIZE.name
  is '奖品名称';
comment on column TB_INTEGRAL_PRIZE.type
  is '奖品类型';
comment on column TB_INTEGRAL_PRIZE.weight
  is '权重值';
comment on column TB_INTEGRAL_PRIZE.info
  is '奖项值  积分值或者红包值';
comment on column TB_INTEGRAL_PRIZE.picture
  is '奖品图片';
comment on column TB_INTEGRAL_PRIZE.grade
  is '奖品等级';
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
  is '积分ID';
comment on column TB_INTEGRAL_PRODUCT.order_number
  is '编号';
comment on column TB_INTEGRAL_PRODUCT.agent
  is '是否属于代理产品 1=代理 2=其他';
comment on column TB_INTEGRAL_PRODUCT.product_id
  is '产品ID输入代理产品填写ID，不属于不填写';
comment on column TB_INTEGRAL_PRODUCT.product_img
  is '产品图片';
comment on column TB_INTEGRAL_PRODUCT.product_name
  is '产品名称';
comment on column TB_INTEGRAL_PRODUCT.product_number
  is '产品数量';
comment on column TB_INTEGRAL_PRODUCT.product_introduce
  is '产品介绍';
comment on column TB_INTEGRAL_PRODUCT.need_integral
  is '所需积分';
comment on column TB_INTEGRAL_PRODUCT.spec
  is '规格';
comment on column TB_INTEGRAL_PRODUCT.degree
  is '度数';
comment on column TB_INTEGRAL_PRODUCT.volume
  is '容量';
comment on column TB_INTEGRAL_PRODUCT.surplus_product_number
  is '剩余产品数量';
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
  is '积分中奖信息表';
comment on column TB_INTEGRAL_WINNING_INFO.id
  is '唯一主键';
comment on column TB_INTEGRAL_WINNING_INFO.belong_activity_id
  is '所属活动';
comment on column TB_INTEGRAL_WINNING_INFO.activity_name
  is '活动名称';
comment on column TB_INTEGRAL_WINNING_INFO.activity_name_type
  is '活动类型（疯狂砍价，抢红包...）';
comment on column TB_INTEGRAL_WINNING_INFO.winning_integral
  is '中奖积分';
comment on column TB_INTEGRAL_WINNING_INFO.create_time
  is '创建时间';
comment on column TB_INTEGRAL_WINNING_INFO.starttime
  is '开始时间';
comment on column TB_INTEGRAL_WINNING_INFO.endtime
  is '结束时间';
comment on column TB_INTEGRAL_WINNING_INFO.openid
  is '微信用户ID';
comment on column TB_INTEGRAL_WINNING_INFO.activity_wxuser_id
  is '活动微信参与记录ID';
comment on column TB_INTEGRAL_WINNING_INFO.belong_publicnumber_id
  is '公众号I';
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
  is '接收到的客户主数据记录表';
comment on column TB_MASTERDATA_LOG.id
  is '主键数据库自动生成唯一ID';
comment on column TB_MASTERDATA_LOG.account_num
  is '账户编码';
comment on column TB_MASTERDATA_LOG.account_group
  is '账户组';
comment on column TB_MASTERDATA_LOG.account_group_type
  is '账户组类别';
comment on column TB_MASTERDATA_LOG.dealer_type
  is '经销商分类';
comment on column TB_MASTERDATA_LOG.simple_name
  is '简称';
comment on column TB_MASTERDATA_LOG.full_name
  is '全称';
comment on column TB_MASTERDATA_LOG.sales_area
  is '销售区域';
comment on column TB_MASTERDATA_LOG.business_number
  is '工商登记号';
comment on column TB_MASTERDATA_LOG.tax_num
  is '税务代码';
comment on column TB_MASTERDATA_LOG.bank_account
  is '银行账号';
comment on column TB_MASTERDATA_LOG.bank_name
  is '开户行名称';
comment on column TB_MASTERDATA_LOG.organization_num
  is '组织结构代码';
comment on column TB_MASTERDATA_LOG.upper_organization_code
  is '上层组织编码';
comment on column TB_MASTERDATA_LOG.is_subbranch
  is '是否分支机构';
comment on column TB_MASTERDATA_LOG.top_branch
  is '分支机构账户编码';
comment on column TB_MASTERDATA_LOG.transport_type
  is '运输方式';
comment on column TB_MASTERDATA_LOG.is_special
  is '是否专票';
comment on column TB_MASTERDATA_LOG.title
  is '标题';
comment on column TB_MASTERDATA_LOG.address
  is '地址';
comment on column TB_MASTERDATA_LOG.postcode
  is '邮政编码';
comment on column TB_MASTERDATA_LOG.country
  is '国家';
comment on column TB_MASTERDATA_LOG.cityid
  is '市id';
comment on column TB_MASTERDATA_LOG.areaid
  is '省id';
comment on column TB_MASTERDATA_LOG.quxianid
  is '市';
comment on column TB_MASTERDATA_LOG.city
  is '区县id';
comment on column TB_MASTERDATA_LOG.area
  is '省';
comment on column TB_MASTERDATA_LOG.quxian
  is '区县';
comment on column TB_MASTERDATA_LOG.phone
  is '区县id';
comment on column TB_MASTERDATA_LOG.email
  is 'email';
comment on column TB_MASTERDATA_LOG.headquarters
  is '总部';
comment on column TB_MASTERDATA_LOG.supplier_account
  is '供应商账号';
comment on column TB_MASTERDATA_LOG.business_contacts
  is '企业联系人1  ';
comment on column TB_MASTERDATA_LOG.business_contacts_phone
  is '企业联系人1电话';
comment on column TB_MASTERDATA_LOG.receiving_contact
  is '企业联系人2';
comment on column TB_MASTERDATA_LOG.receiving_contact_phone
  is '企业联系人2电话  ';
comment on column TB_MASTERDATA_LOG.old_num
  is '旧客户号';
comment on column TB_MASTERDATA_LOG.old_desc
  is '旧客户描述';
comment on column TB_MASTERDATA_LOG.create_by
  is '创建人';
comment on column TB_MASTERDATA_LOG.create_date
  is '创建时间';
comment on column TB_MASTERDATA_LOG.update_by
  is '修改人';
comment on column TB_MASTERDATA_LOG.update_date
  is '修改时间';
comment on column TB_MASTERDATA_LOG.operation_num
  is '操作类型';
comment on column TB_MASTERDATA_LOG.attribute1
  is '备用字段';
comment on column TB_MASTERDATA_LOG.status
  is '是否删除';
comment on column TB_MASTERDATA_LOG.mdm_sys
  is '主数据数据类型';
comment on column TB_MASTERDATA_LOG.processed_status
  is '处理状态:0-接收数据未处理';
comment on column TB_MASTERDATA_LOG.create_time
  is '接口接收数据日期';
comment on column TB_MASTERDATA_LOG.update_time
  is '接口处理数据日期';

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
  is '一元购参与记录ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_ONEMONEY_WXUSER_WINNING.belong_winning_prize_id
  is '所属中奖ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.prize_project
  is '奖品名称';
comment on column TB_ONEMONEY_WXUSER_WINNING.create_time
  is '创建时间';
comment on column TB_ONEMONEY_WXUSER_WINNING.prize_project_img
  is '奖品图片';
comment on column TB_ONEMONEY_WXUSER_WINNING.openid
  is '微信指定ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.state
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_ONEMONEY_WXUSER_WINNING.addressee_name
  is '收件人姓名';
comment on column TB_ONEMONEY_WXUSER_WINNING.addressee_address
  is '收件人地址';
comment on column TB_ONEMONEY_WXUSER_WINNING.addressee_phone
  is '收件人电话';
comment on column TB_ONEMONEY_WXUSER_WINNING.lssue_user_name
  is '发货人名称';
comment on column TB_ONEMONEY_WXUSER_WINNING.lssue_user_userid
  is '发货人USERID';
comment on column TB_ONEMONEY_WXUSER_WINNING.lssue_user_usercode
  is '发货人USERCODE';
comment on column TB_ONEMONEY_WXUSER_WINNING.deliver_number
  is '快递单号';
comment on column TB_ONEMONEY_WXUSER_WINNING.deliver_company
  is '快递公司';
comment on column TB_ONEMONEY_WXUSER_WINNING.deliver_time
  is '发货时间';
comment on column TB_ONEMONEY_WXUSER_WINNING.product_winning_info_id
  is '实物中奖记录ID';
comment on column TB_ONEMONEY_WXUSER_WINNING.spareone
  is '存储奖品类型';
comment on column TB_ONEMONEY_WXUSER_WINNING.sparetwo
  is '存储状态';
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
  is '一元购微信用户参与活动ID';
comment on column TB_ONE_MONEY_GROUP_WXUSER.openid
  is '微信指定ID';
comment on column TB_ONE_MONEY_GROUP_WXUSER.nickname
  is '微信昵称';
comment on column TB_ONE_MONEY_GROUP_WXUSER.headimgurl
  is '微信头像';
comment on column TB_ONE_MONEY_GROUP_WXUSER.create_time
  is '创建时间';
comment on column TB_ONE_MONEY_GROUP_WXUSER.state
  is '状态';
comment on column TB_ONE_MONEY_GROUP_WXUSER.activity_name
  is '活动名称';
comment on column TB_ONE_MONEY_GROUP_WXUSER.creater
  is '创建者1 参与者0
';
comment on column TB_ONE_MONEY_GROUP_WXUSER.paymoney
  is '支付金额
';
comment on column TB_ONE_MONEY_GROUP_WXUSER.paystate
  is '支付状态 0未支付 1支付
';
comment on column TB_ONE_MONEY_GROUP_WXUSER.returnstate
  is '退款状态0没有退款 1已经退款
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
  is '奖品名称(这里只是酒)';
comment on column TB_ONE_MONEY_PRIZE.prizeimg
  is '奖品图片';
comment on column TB_ONE_MONEY_PRIZE.prizenumber
  is '奖品数量';
comment on column TB_ONE_MONEY_PRIZE.spec
  is '规格';
comment on column TB_ONE_MONEY_PRIZE.deep
  is '度数';
comment on column TB_ONE_MONEY_PRIZE.volume
  is '容量';
comment on column TB_ONE_MONEY_PRIZE.boxcount
  is '箱数';
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
  is '活动名称';
comment on column TB_ONE_MONEY_SHOP.background_img
  is '背景图';
comment on column TB_ONE_MONEY_SHOP.belong_activity_id
  is '所属活动ID';
comment on column TB_ONE_MONEY_SHOP.moble_background_img
  is '手机页面背景图';
comment on column TB_ONE_MONEY_SHOP.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_ONE_MONEY_SHOP.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_ONE_MONEY_SHOP.join_prople_number
  is '参加人数';
comment on column TB_ONE_MONEY_SHOP.winning_prople_number
  is '获奖人数';
comment on column TB_ONE_MONEY_SHOP.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_ONE_MONEY_SHOP.create_time
  is '开始时间';
comment on column TB_ONE_MONEY_SHOP.comfirmuserid
  is '审核人的ID';
comment on column TB_ONE_MONEY_SHOP.comfirmtime
  is '审核时间';
comment on column TB_ONE_MONEY_SHOP.comfirmadvise
  is '审核建议';
comment on column TB_ONE_MONEY_SHOP.comfirmusername
  is '审核人名称';
comment on column TB_ONE_MONEY_SHOP.applyphone
  is '申请人电话';
comment on column TB_ONE_MONEY_SHOP.applyusername
  is '申请人名称';
comment on column TB_ONE_MONEY_SHOP.openprizenumber
  is '开奖人数';
comment on column TB_ONE_MONEY_SHOP.spare_one
  is '备用字段一';
comment on column TB_ONE_MONEY_SHOP.spare_two
  is '备用字段二';
comment on column TB_ONE_MONEY_SHOP.starttime
  is '开始时间';
comment on column TB_ONE_MONEY_SHOP.endtime
  is '结束时间';
comment on column TB_ONE_MONEY_SHOP.applyuserid
  is '申请人ID';
comment on column TB_ONE_MONEY_SHOP.total
  is '奖品总数';
comment on column TB_ONE_MONEY_SHOP.groupmoney
  is '组团价 支付金额一元购 默认一元';
comment on column TB_ONE_MONEY_SHOP.handle
  is '处理情况0未处理1已处理';
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
  is '一元购活动ID';
comment on column TB_ONE_MONEY_WXUSER.openid
  is '微信指定ID';
comment on column TB_ONE_MONEY_WXUSER.nickname
  is '微信昵称';
comment on column TB_ONE_MONEY_WXUSER.headimgurl
  is '微信头像';
comment on column TB_ONE_MONEY_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_ONE_MONEY_WXUSER.create_time
  is '创建时间';
comment on column TB_ONE_MONEY_WXUSER.state
  is '状态';
comment on column TB_ONE_MONEY_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_ONE_MONEY_WXUSER.activity_name
  is '活动名称';
comment on column TB_ONE_MONEY_WXUSER.paystate
  is '0未支付 1支付';
comment on column TB_ONE_MONEY_WXUSER.paymoney
  is '一元购 默认一元';
comment on column TB_ONE_MONEY_WXUSER.payoutno
  is '支付订单号';
comment on column TB_ONE_MONEY_WXUSER.mchid
  is '商户号';
comment on column TB_ONE_MONEY_WXUSER.handle
  is '处理状态 0未处理 1已处理';
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
  is '所属活动ID';
comment on column TB_PRODUCT_WINNING_INFO.activity_name
  is '活动名称';
comment on column TB_PRODUCT_WINNING_INFO.activity_name_type
  is '活动类型（疯狂砍价，抢红包...）';
comment on column TB_PRODUCT_WINNING_INFO.product_id
  is '实物产品ID';
comment on column TB_PRODUCT_WINNING_INFO.product_name
  is '实物产品名称';
comment on column TB_PRODUCT_WINNING_INFO.product_img
  is '实物产品图片';
comment on column TB_PRODUCT_WINNING_INFO.activity_prize_id
  is '活动奖品配置ID';
comment on column TB_PRODUCT_WINNING_INFO.create_time
  is '创建时间';
comment on column TB_PRODUCT_WINNING_INFO.starttime
  is '开始时间';
comment on column TB_PRODUCT_WINNING_INFO.endtime
  is '结束时间';
comment on column TB_PRODUCT_WINNING_INFO.openid
  is '微信用户ID';
comment on column TB_PRODUCT_WINNING_INFO.activity_wxuser_id
  is '活动微信参与记录ID';
comment on column TB_PRODUCT_WINNING_INFO.belong_publicnumber_id
  is '所属公众号';
comment on column TB_PRODUCT_WINNING_INFO.state
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_PRODUCT_WINNING_INFO.winning_info_id
  is '中奖记录ID';
comment on column TB_PRODUCT_WINNING_INFO.deliver_number
  is '快递单号 ';
comment on column TB_PRODUCT_WINNING_INFO.deliver_company
  is '快递公司';
comment on column TB_PRODUCT_WINNING_INFO.deliver_time
  is '发货时间';
comment on column TB_PRODUCT_WINNING_INFO.addressee_name
  is '收件人姓名';
comment on column TB_PRODUCT_WINNING_INFO.addressee_address
  is '收件人地址';
comment on column TB_PRODUCT_WINNING_INFO.addressee_phone
  is '收件人电话';
comment on column TB_PRODUCT_WINNING_INFO.pay_money
  is '支付金额';
comment on column TB_PRODUCT_WINNING_INFO.price
  is '原价';
comment on column TB_PRODUCT_WINNING_INFO.low_price
  is '最低价格';
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
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货''';
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
  is '活动名称';
comment on column TB_PUZZLE.background_img
  is '背景图';
comment on column TB_PUZZLE.belong_activity_id
  is '所属活动ID';
comment on column TB_PUZZLE.moble_background_img
  is '手机页面背景图';
comment on column TB_PUZZLE.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_PUZZLE.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_PUZZLE.join_prople_number
  is '参加人数';
comment on column TB_PUZZLE.winning_prople_number
  is '获奖人数';
comment on column TB_PUZZLE.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_PUZZLE.create_time
  is '开始时间';
comment on column TB_PUZZLE.comfirmuserid
  is '审核人的ID';
comment on column TB_PUZZLE.comfirmtime
  is '审核时间';
comment on column TB_PUZZLE.comfirmadvise
  is '审核建议';
comment on column TB_PUZZLE.comfirmusername
  is '审核人名称';
comment on column TB_PUZZLE.applyphone
  is '申请人电话';
comment on column TB_PUZZLE.applyusername
  is '申请人名称';
comment on column TB_PUZZLE.spare_one
  is '备用字段一';
comment on column TB_PUZZLE.spare_two
  is '备用字段二';
comment on column TB_PUZZLE.starttime
  is '开始时间';
comment on column TB_PUZZLE.endtime
  is '结束时间';
comment on column TB_PUZZLE.applyuserid
  is '申请人ID';
comment on column TB_PUZZLE.total
  is '奖品总数';
comment on column TB_PUZZLE.looktime
  is '看图时间';
comment on column TB_PUZZLE.palytime
  is '拼图用时';
comment on column TB_PUZZLE.puzzleimg
  is '拼图图片';
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
  is '奖品名称(这里只是酒)';
comment on column TB_PUZZLE_PRIZE.prizenumber
  is '奖品数量';
comment on column TB_PUZZLE_PRIZE.spec
  is '规格';
comment on column TB_PUZZLE_PRIZE.deep
  is '度数';
comment on column TB_PUZZLE_PRIZE.volume
  is '容量';
comment on column TB_PUZZLE_PRIZE.boxcount
  is '箱数';
comment on column TB_PUZZLE_PRIZE.productimg
  is '图片';
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
  is 'TB_ACCUMUL_COMMENT_WXUSER   拼图微信参与用户记录';
comment on column TB_PUZZLE_WXUSER.puzzle_id
  is '活动ID';
comment on column TB_PUZZLE_WXUSER.openid
  is '微信指定ID';
comment on column TB_PUZZLE_WXUSER.nickname
  is '微信昵称';
comment on column TB_PUZZLE_WXUSER.headimgurl
  is '微信头像';
comment on column TB_PUZZLE_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_PUZZLE_WXUSER.create_time
  is '创建时间';
comment on column TB_PUZZLE_WXUSER.state
  is '状态0开始拼图 1成功 2未成功 3未开始拼图';
comment on column TB_PUZZLE_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_PUZZLE_WXUSER.activity_name
  is '活动名称';
comment on column TB_PUZZLE_WXUSER.goodstate
  is '发货状态 0 未发货  1已发货';
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
  is '拼图参与记录ID';
comment on column TB_PUZZLE_WXUSER_WINNING.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_PUZZLE_WXUSER_WINNING.belong_winning_prize_id
  is '所属中奖ID';
comment on column TB_PUZZLE_WXUSER_WINNING.winning_money
  is '中奖金额/积分';
comment on column TB_PUZZLE_WXUSER_WINNING.prize_project
  is '奖品名称';
comment on column TB_PUZZLE_WXUSER_WINNING.create_time
  is '创建时间';
comment on column TB_PUZZLE_WXUSER_WINNING.prize_project_img
  is '奖品图片';
comment on column TB_PUZZLE_WXUSER_WINNING.openid
  is '微信指定ID';
comment on column TB_PUZZLE_WXUSER_WINNING.state
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_PUZZLE_WXUSER_WINNING.addressee_name
  is '收件人姓名';
comment on column TB_PUZZLE_WXUSER_WINNING.addressee_address
  is '收件人地址';
comment on column TB_PUZZLE_WXUSER_WINNING.addressee_phone
  is '收件人电话';
comment on column TB_PUZZLE_WXUSER_WINNING.lssue_user_name
  is '发货人名称';
comment on column TB_PUZZLE_WXUSER_WINNING.lssue_user_userid
  is '发货人USERID';
comment on column TB_PUZZLE_WXUSER_WINNING.lssue_user_usercode
  is '发货人USERCODE';
comment on column TB_PUZZLE_WXUSER_WINNING.deliver_number
  is '快递单号';
comment on column TB_PUZZLE_WXUSER_WINNING.deliver_company
  is '快递公司';
comment on column TB_PUZZLE_WXUSER_WINNING.deliver_time
  is '发货时间';
comment on column TB_PUZZLE_WXUSER_WINNING.product_winning_info_id
  is '实物中奖记录ID';
comment on column TB_PUZZLE_WXUSER_WINNING.spare_one
  is '存储奖品类型';
comment on column TB_PUZZLE_WXUSER_WINNING.spare_two
  is '存储状态';
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
  is '所属活动ID';
comment on column TB_RED_WINNING_INFO.activity_name
  is '活动名称';
comment on column TB_RED_WINNING_INFO.activity_name_type
  is '活动类型（疯狂砍价，抢红包...）';
comment on column TB_RED_WINNING_INFO.winning_red_total
  is '中奖红包合计';
comment on column TB_RED_WINNING_INFO.create_time
  is '创建时间';
comment on column TB_RED_WINNING_INFO.state
  is '状态 0=未完成 1=完成    ';
comment on column TB_RED_WINNING_INFO.starttime
  is '开始时间';
comment on column TB_RED_WINNING_INFO.endtime
  is '结束时间';
comment on column TB_RED_WINNING_INFO.withdrawals
  is '是否提现0=未提现  1=已提现';
comment on column TB_RED_WINNING_INFO.activity_wxuser_id
  is '微信参与记录ID';
comment on column TB_RED_WINNING_INFO.openid
  is '用户微信ID';
comment on column TB_RED_WINNING_INFO.belong_publicnumber_id
  is '公众号ID';

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
  is '活动名称';
comment on column TB_ROB_RED.background_img
  is '背景图';
comment on column TB_ROB_RED.belong_activity_id
  is '所属活动ID';
comment on column TB_ROB_RED.moblec_background_img
  is '手机页面背景图';
comment on column TB_ROB_RED.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_ROB_RED.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_ROB_RED.join_prople_number
  is '参与人数';
comment on column TB_ROB_RED.winning_prople_number
  is '获奖人数';
comment on column TB_ROB_RED.state
  is '活动状态：0申请中 ? 1审批通过 ?2 已驳回';
comment on column TB_ROB_RED.starttime
  is '活动开始时间';
comment on column TB_ROB_RED.endtime
  is '活动结束时间';
comment on column TB_ROB_RED.create_time
  is '创建时间';
comment on column TB_ROB_RED.comfirmuserid
  is '审核人的ID';
comment on column TB_ROB_RED.comfirmtime
  is '审核时间';
comment on column TB_ROB_RED.comfirmadvise
  is '审核建议';
comment on column TB_ROB_RED.comfirmusername
  is '审核人名称';
comment on column TB_ROB_RED.applyphone
  is '申请人电话';
comment on column TB_ROB_RED.applyusername
  is '申请人名称';
comment on column TB_ROB_RED.scan_red_number
  is '扫码红包次数';
comment on column TB_ROB_RED.pattern
  is '模式 1=模式一   2=模式二';
comment on column TB_ROB_RED.spare_one
  is '备用字段一';
comment on column TB_ROB_RED.spare_two
  is '备用字段二';
comment on column TB_ROB_RED.sendername
  is '红包发送者名称';
comment on column TB_ROB_RED.wish
  is '祝福语';
comment on column TB_ROB_RED.remarks
  is '红包备注';
comment on column TB_ROB_RED.total
  is '活动瓶总数';
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
  is '抢红包活动ID';
comment on column TB_ROB_RED_PRIZE.prize_project
  is '奖项';
comment on column TB_ROB_RED_PRIZE.prize_project_money
  is '模式一:奖项金额  模式二:红包金额';
comment on column TB_ROB_RED_PRIZE.get_prize_number
  is '模式一:奖品人数  模式二:中奖人数';
comment on column TB_ROB_RED_PRIZE.subtotal
  is '小计';
comment on column TB_ROB_RED_PRIZE.red_winning_probability
  is '红包中奖概率';
comment on column TB_ROB_RED_PRIZE.winning_integral
  is '中奖积分';
comment on column TB_ROB_RED_PRIZE.winning_integral_number
  is '积分中奖人数';
comment on column TB_ROB_RED_PRIZE.red_probability_total
  is '红包概率合计';
comment on column TB_ROB_RED_PRIZE.prize_project_total_money
  is '奖项金额合计';
comment on column TB_ROB_RED_PRIZE.scanrodrednum
  is '扫码中奖次数';
comment on column TB_ROB_RED_PRIZE.integral_winning_probability
  is '积分中奖概率';
comment on column TB_ROB_RED_PRIZE.integral_probability_total
  is '积分概率合计';
comment on column TB_ROB_RED_PRIZE.surplus_probability
  is '剩余概率';
comment on column TB_ROB_RED_PRIZE.create_time
  is '创建时间';
comment on column TB_ROB_RED_PRIZE.surplus_number
  is '剩余数量';
comment on column TB_ROB_RED_PRIZE.surplus_prize_probability
  is '剩余奖品中奖概率';
comment on column TB_ROB_RED_PRIZE.surplus_integral_number
  is '剩余积分数量';
comment on column TB_ROB_RED_PRIZE.surplus_integral_probability
  is '剩余积分奖品中奖概率';
comment on column TB_ROB_RED_PRIZE.surplus_integral
  is '剩余积分';
comment on column TB_ROB_RED_PRIZE.surplus_money
  is '剩余金额';
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
  is '红包活动ID';
comment on column TB_ROB_RED_WXUSER.openid
  is '微信指定ID';
comment on column TB_ROB_RED_WXUSER.nickname
  is '微信昵称';
comment on column TB_ROB_RED_WXUSER.headimgurl
  is '微信头像';
comment on column TB_ROB_RED_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_ROB_RED_WXUSER.create_time
  is '创建时间';
comment on column TB_ROB_RED_WXUSER.state
  is '状态   0未提现  1已提现';
comment on column TB_ROB_RED_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_ROB_RED_WXUSER.scan_red_number
  is '扫码参与次数';
comment on column TB_ROB_RED_WXUSER.total_money
  is '累计金额';
comment on column TB_ROB_RED_WXUSER.activity_name
  is '活动名称';
comment on column TB_ROB_RED_WXUSER.starttime
  is '开始时间';
comment on column TB_ROB_RED_WXUSER.endtime
  is '结束时间';
comment on column TB_ROB_RED_WXUSER.joinmode
  is '参与方式  1=扫码进入  2=积分兑换';
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
  is '抢红包参与记录ID';
comment on column TB_ROB_RED_WXUSER_WINNING.belong_rob_red_prize_id
  is '所属中奖ID';
comment on column TB_ROB_RED_WXUSER_WINNING.winning_money
  is '中奖金额/积分';
comment on column TB_ROB_RED_WXUSER_WINNING.prize_project
  is '奖项';
comment on column TB_ROB_RED_WXUSER_WINNING.create_time
  is '创建时间';
comment on column TB_ROB_RED_WXUSER_WINNING.openid
  is '微信指定ID';
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
  is '活动名称';
comment on column TB_SCRATCHCARD.background_img
  is '背景图';
comment on column TB_SCRATCHCARD.belong_activity_id
  is '所属活动ID';
comment on column TB_SCRATCHCARD.moblec_background_img
  is '手机页面背景图';
comment on column TB_SCRATCHCARD.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_SCRATCHCARD.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_SCRATCHCARD.join_prople_number
  is '参与人数';
comment on column TB_SCRATCHCARD.winning_prople_number
  is '获奖人数';
comment on column TB_SCRATCHCARD.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_SCRATCHCARD.starttime
  is '活动开始时间';
comment on column TB_SCRATCHCARD.endtime
  is '活动结束时间';
comment on column TB_SCRATCHCARD.create_time
  is '创建时间';
comment on column TB_SCRATCHCARD.comfirmuserid
  is '审核人的ID';
comment on column TB_SCRATCHCARD.comfirmtime
  is '审核时间';
comment on column TB_SCRATCHCARD.comfirmadvise
  is '审核建议';
comment on column TB_SCRATCHCARD.comfirmusername
  is '审核人名称';
comment on column TB_SCRATCHCARD.applyphone
  is '申请人电话';
comment on column TB_SCRATCHCARD.applyusername
  is '申请人名称';
comment on column TB_SCRATCHCARD.spare_one
  is '备用字段一';
comment on column TB_SCRATCHCARD.spare_two
  is '备用字段二';
comment on column TB_SCRATCHCARD.total
  is '总瓶数';
comment on column TB_SCRATCHCARD.scan_number
  is '扫码抽奖次数';
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
  is '转盘活动ID';
comment on column TB_SCRATCHCARD_PRIZE.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_SCRATCHCARD_PRIZE.order_number
  is '编号';
comment on column TB_SCRATCHCARD_PRIZE.prize_img
  is '奖品图片';
comment on column TB_SCRATCHCARD_PRIZE.prize_name
  is '奖品名称';
comment on column TB_SCRATCHCARD_PRIZE.prize_number
  is '奖品数量';
comment on column TB_SCRATCHCARD_PRIZE.surplus_prize_number
  is '剩余奖品数量';
comment on column TB_SCRATCHCARD_PRIZE.prize_probability
  is '奖品概率（原始）';
comment on column TB_SCRATCHCARD_PRIZE.surplus_prize_probability
  is '剩余奖品概率';
comment on column TB_SCRATCHCARD_PRIZE.integral_numebr
  is '积分面值';
comment on column TB_SCRATCHCARD_PRIZE.red_number
  is '红包面值';
comment on column TB_SCRATCHCARD_PRIZE.create_time
  is '创建时间';
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
  is '转盘活动ID';
comment on column TB_SCRATCHCARD_WXUSER.openid
  is '微信指定ID';
comment on column TB_SCRATCHCARD_WXUSER.nickname
  is '微信昵称';
comment on column TB_SCRATCHCARD_WXUSER.headimgurl
  is '微信头像';
comment on column TB_SCRATCHCARD_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_SCRATCHCARD_WXUSER.create_time
  is '创建时间';
comment on column TB_SCRATCHCARD_WXUSER.state
  is '状态';
comment on column TB_SCRATCHCARD_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_SCRATCHCARD_WXUSER.scan_winning_number
  is '扫码中奖次数';
comment on column TB_SCRATCHCARD_WXUSER.activity_name
  is '活动名称';
comment on column TB_SCRATCHCARD_WXUSER.total_money
  is '单次参与金额';
comment on column TB_SCRATCHCARD_WXUSER.total_integral
  is '单次参与中奖积分';
comment on column TB_SCRATCHCARD_WXUSER.integral_winning_number
  is '积分中奖次数';
comment on column TB_SCRATCHCARD_WXUSER.red_winning_number
  is '红包中奖次数';
comment on column TB_SCRATCHCARD_WXUSER.goods_winning_number
  is '实物中奖次数';
comment on column TB_SCRATCHCARD_WXUSER.think_winning_number
  is '谢谢惠顾中奖次数';
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
  is '转盘参与记录ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.belong_winning_prize_id
  is '所属中奖ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.winning_money
  is '中奖金额/积分';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.prize_project
  is '奖品名称';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.create_time
  is '创建时间';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.prize_project_img
  is '奖品图片';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.openid
  is '微信指定ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.state
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.addressee_name
  is '收件人姓名';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.addressee_address
  is '收件人地址';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.addressee_phone
  is '收件人电话';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.lssue_user_name
  is '发货人名称';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.lssue_user_userid
  is '发货人USERID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.lssue_user_usercode
  is '发货人USERCODE';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.deliver_number
  is '快递单号';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.deliver_company
  is '快递公司';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.deliver_time
  is '发货时间';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.product_winning_info_id
  is '实物中奖记录ID';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.spareone
  is '存储奖品类型';
comment on column TB_SCRATCHCARD_WXUSER_WINNING.sparetwo
  is '存储状态';
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
  is '经销商公众号表    TB_SELLER_PUBLICNUMBER';
comment on column TB_SELLER_PUBLICNUMBER.publicnumber_name
  is '公众号名称';
comment on column TB_SELLER_PUBLICNUMBER.appid
  is '开发者ID';
comment on column TB_SELLER_PUBLICNUMBER.appsecret
  is '开发者密码';
comment on column TB_SELLER_PUBLICNUMBER.publicnumber_qrcode_img
  is '公众号二维码图片';
comment on column TB_SELLER_PUBLICNUMBER.shop_number
  is '商户号';
comment on column TB_SELLER_PUBLICNUMBER.pay_key
  is '支付密钥';
comment on column TB_SELLER_PUBLICNUMBER.spare_one
  is '备用字段一';
comment on column TB_SELLER_PUBLICNUMBER.spare_two
  is '备用字段二';
comment on column TB_SELLER_PUBLICNUMBER.seller_usercode
  is '经销商userCode';
comment on column TB_SELLER_PUBLICNUMBER.token
  is 'token码';
comment on column TB_SELLER_PUBLICNUMBER.winning_news_id
  is '中奖模板ID';
comment on column TB_SELLER_PUBLICNUMBER.sendername
  is '红包发生者名称';
comment on column TB_SELLER_PUBLICNUMBER.wish
  is '祝福语';
comment on column TB_SELLER_PUBLICNUMBER.remarks
  is '红包备注';
comment on column TB_SELLER_PUBLICNUMBER.seller_userid
  is '经销商userId';
comment on column TB_SELLER_PUBLICNUMBER.sendid
  is '发货通知id';
comment on column TB_SELLER_PUBLICNUMBER.successid
  is '参与成功通知';
comment on column TB_SELLER_PUBLICNUMBER.company
  is '公司名称';
comment on column TB_SELLER_PUBLICNUMBER.scan_img
  is '扫码页面背景图';
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
  is '分享砍价活动表   TB_SHARE_BARGAIN';
comment on column TB_SHARE_BARGAIN.activity_name
  is '活动名称';
comment on column TB_SHARE_BARGAIN.belong_activity_id
  is '所属活动ID';
comment on column TB_SHARE_BARGAIN.background_img
  is '背景图';
comment on column TB_SHARE_BARGAIN.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_SHARE_BARGAIN.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_SHARE_BARGAIN.introduce
  is '介绍';
comment on column TB_SHARE_BARGAIN.join_prople_number
  is '参与人数';
comment on column TB_SHARE_BARGAIN.winning_prople_number
  is '获奖人数';
comment on column TB_SHARE_BARGAIN.state
  is '活动状态：0申请中   1审批通过  2 已驳回  3下一步临时的状态';
comment on column TB_SHARE_BARGAIN.starttime
  is '活动开始时间';
comment on column TB_SHARE_BARGAIN.endtime
  is '活动结束时间';
comment on column TB_SHARE_BARGAIN.moblec_background_img
  is '手机页面背景图';
comment on column TB_SHARE_BARGAIN.comfirmusername
  is '审核人的名称';
comment on column TB_SHARE_BARGAIN.comfirmtime
  is '审核时间';
comment on column TB_SHARE_BARGAIN.comfirmadvise
  is '审核建议';
comment on column TB_SHARE_BARGAIN.applyusername
  is '申请人名称';
comment on column TB_SHARE_BARGAIN.applyphone
  is '申请人手机';
comment on column TB_SHARE_BARGAIN.applyuserid
  is '申请用户ID';
comment on column TB_SHARE_BARGAIN.sharetitle
  is '分享的标题';
comment on column TB_SHARE_BARGAIN.sharedetail
  is '分享描述';
comment on column TB_SHARE_BARGAIN.shareimg
  is '分享时的图片';
comment on column TB_SHARE_BARGAIN.comfirmuserid
  is '审核人ID';
comment on column TB_SHARE_BARGAIN.joined
  is '默认为0没有参加  参加';
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
  is '用户OPENID';
comment on column TB_SHARE_BARGAIN_HELP.nickname
  is '昵称';
comment on column TB_SHARE_BARGAIN_HELP.headimgurl
  is '头像';
comment on column TB_SHARE_BARGAIN_HELP.friend_activity_id
  is '朋友申请活动ID';
comment on column TB_SHARE_BARGAIN_HELP.bargain_money
  is '帮助砍价金额';
comment on column TB_SHARE_BARGAIN_HELP.spare_one
  is '备用字段一';
comment on column TB_SHARE_BARGAIN_HELP.spare_two
  is '备用字段二';
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
  is '分享砍价奖品配置表   TB_SHARE_BARGAIN_PRIZE';
comment on column TB_SHARE_BARGAIN_PRIZE.share_bargain_id
  is '分享砍价活动ID';
comment on column TB_SHARE_BARGAIN_PRIZE.productid
  is '产品ID';
comment on column TB_SHARE_BARGAIN_PRIZE.przie_number
  is '奖品数量';
comment on column TB_SHARE_BARGAIN_PRIZE.przie_surplus_number
  is '剩余数量';
comment on column TB_SHARE_BARGAIN_PRIZE.original_price
  is '原价格';
comment on column TB_SHARE_BARGAIN_PRIZE.low_price
  is '最低价';
comment on column TB_SHARE_BARGAIN_PRIZE.bargain_section
  is '砍价区间';
comment on column TB_SHARE_BARGAIN_PRIZE.bargain_number
  is '砍价次数';
comment on column TB_SHARE_BARGAIN_PRIZE.spare_one
  is '备用字段一  ';
comment on column TB_SHARE_BARGAIN_PRIZE.spare_two
  is '备用字段二';
comment on column TB_SHARE_BARGAIN_PRIZE.prizename
  is '奖品名称';
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
  is 'TB_SHARE_BARGAIN_WXUSER   参加分享砍价活动的用户';
comment on column TB_SHARE_BARGAIN_WXUSER.nickname
  is '微信昵称';
comment on column TB_SHARE_BARGAIN_WXUSER.headimgurl
  is '头像地址';
comment on column TB_SHARE_BARGAIN_WXUSER.join_activity_id
  is '参加活动ID';
comment on column TB_SHARE_BARGAIN_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_SHARE_BARGAIN_WXUSER.price
  is '价格';
comment on column TB_SHARE_BARGAIN_WXUSER.now_price
  is '现在价格';
comment on column TB_SHARE_BARGAIN_WXUSER.low_price
  is '最低价格';
comment on column TB_SHARE_BARGAIN_WXUSER.bargain_section
  is '砍价区间';
comment on column TB_SHARE_BARGAIN_WXUSER.bargain_number
  is '砍价次数';
comment on column TB_SHARE_BARGAIN_WXUSER.create_time
  is '创建时间';
comment on column TB_SHARE_BARGAIN_WXUSER.consignee_name
  is '收货人名称';
comment on column TB_SHARE_BARGAIN_WXUSER.consignee_address
  is '收货人地址';
comment on column TB_SHARE_BARGAIN_WXUSER.consignee_phone
  is '收货人电话';
comment on column TB_SHARE_BARGAIN_WXUSER.pay_money
  is '支付金额';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_state
  is '发货状态 1已发货 2未发货';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_odd_number
  is '发货单号';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_company
  is '发货公司';
comment on column TB_SHARE_BARGAIN_WXUSER.goods_time
  is '发货时间';
comment on column TB_SHARE_BARGAIN_WXUSER.sharebargain_prize_id
  is '活动奖品配置ID';
comment on column TB_SHARE_BARGAIN_WXUSER.state
  is '状态  1 进行中 2 砍价完成  3 已支付';
comment on column TB_SHARE_BARGAIN_WXUSER.pay_order
  is '支付订单';
comment on column TB_SHARE_BARGAIN_WXUSER.mch_id
  is '商户ID';
comment on column TB_SHARE_BARGAIN_WXUSER.spareone
  is '用来存储砍价状态';
comment on column TB_SHARE_BARGAIN_WXUSER.sparetwo
  is '用来存储发货状态   ';
comment on column TB_SHARE_BARGAIN_WXUSER.sparethree
  is '用来存储状态   状态 状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货 6已支付';
comment on column TB_SHARE_BARGAIN_WXUSER.scan_code
  is '该用户所扫的码';
comment on column TB_SHARE_BARGAIN_WXUSER.sendname
  is '发货人名字';
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
  is '活动名称 ';
comment on column TB_TURNTABLE.background_img
  is '背景图';
comment on column TB_TURNTABLE.belong_activity_id
  is '所属活动ID';
comment on column TB_TURNTABLE.moblec_background_img
  is '手机页面背景图';
comment on column TB_TURNTABLE.acitivity_launch_userid
  is '活动发起人的USERID';
comment on column TB_TURNTABLE.acitivity_launch_usercode
  is '活动发起人的USERCODE';
comment on column TB_TURNTABLE.turntable_number
  is '转盘数量';
comment on column TB_TURNTABLE.speed
  is '转盘速度0=快速  1=慢速';
comment on column TB_TURNTABLE.join_prople_number
  is '参与人数';
comment on column TB_TURNTABLE.winning_prople_number
  is '获奖人数';
comment on column TB_TURNTABLE.state
  is '活动状态：0申请中 ？ 1审批通过 ？2 已驳回';
comment on column TB_TURNTABLE.starttime
  is '活动开始时间';
comment on column TB_TURNTABLE.endtime
  is '活动结束时间';
comment on column TB_TURNTABLE.create_time
  is '创建时间';
comment on column TB_TURNTABLE.comfirmuserid
  is '审核人的ID';
comment on column TB_TURNTABLE.comfirmtime
  is '审核时间';
comment on column TB_TURNTABLE.comfirmadvise
  is '审核建议';
comment on column TB_TURNTABLE.comfirmusername
  is '审核人名称';
comment on column TB_TURNTABLE.applyphone
  is '申请人电话';
comment on column TB_TURNTABLE.applyusername
  is '申请人名称';
comment on column TB_TURNTABLE.spare_one
  is '备用字段一';
comment on column TB_TURNTABLE.spare_two
  is '备用字段二';
comment on column TB_TURNTABLE.total
  is '总瓶数';
comment on column TB_TURNTABLE.scan_turntable_number
  is '扫码转盘次数';
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
  is '转盘活动ID';
comment on column TB_TURNTABLE_PRIZE.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_TURNTABLE_PRIZE.order_number
  is '编号';
comment on column TB_TURNTABLE_PRIZE.prize_img
  is '奖品图片';
comment on column TB_TURNTABLE_PRIZE.prize_name
  is '奖品名称';
comment on column TB_TURNTABLE_PRIZE.prize_number
  is '奖品数量';
comment on column TB_TURNTABLE_PRIZE.surplus_prize_number
  is '剩余奖品数量';
comment on column TB_TURNTABLE_PRIZE.prize_probability
  is '奖品概率（原始）';
comment on column TB_TURNTABLE_PRIZE.surplus_prize_probability
  is '剩余奖品概率';
comment on column TB_TURNTABLE_PRIZE.integral_numebr
  is '积分面值';
comment on column TB_TURNTABLE_PRIZE.red_number
  is '红包面值';
comment on column TB_TURNTABLE_PRIZE.create_time
  is '创建时间';
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
  is '转盘活动ID';
comment on column TB_TURNTABLE_WXUSER.openid
  is '微信指定ID';
comment on column TB_TURNTABLE_WXUSER.nickname
  is '微信昵称';
comment on column TB_TURNTABLE_WXUSER.headimgurl
  is '微信头像';
comment on column TB_TURNTABLE_WXUSER.belong_publicnumber_id
  is '所属公众号';
comment on column TB_TURNTABLE_WXUSER.create_time
  is '创建时间';
comment on column TB_TURNTABLE_WXUSER.state
  is '状态';
comment on column TB_TURNTABLE_WXUSER.scan_code
  is '扫码CODE';
comment on column TB_TURNTABLE_WXUSER.scan_winning_number
  is '扫码中奖次数';
comment on column TB_TURNTABLE_WXUSER.activity_name
  is '活动名称';
comment on column TB_TURNTABLE_WXUSER.total_money
  is '单次参与金额';
comment on column TB_TURNTABLE_WXUSER.total_integral
  is '单次参与中奖积分';
comment on column TB_TURNTABLE_WXUSER.integral_winning_number
  is '积分中奖次数';
comment on column TB_TURNTABLE_WXUSER.red_winning_number
  is '红包中奖次数';
comment on column TB_TURNTABLE_WXUSER.goods_winning_number
  is '实物中奖次数';
comment on column TB_TURNTABLE_WXUSER.think_winning_number
  is '谢谢惠顾中奖次数';
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
  is '转盘参与记录ID';
comment on column TB_TURNTABLE_WXUSER_WINNING.prize_type
  is '奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾';
comment on column TB_TURNTABLE_WXUSER_WINNING.belong_winning_prize_id
  is '所属中奖ID';
comment on column TB_TURNTABLE_WXUSER_WINNING.winning_money
  is '中奖金额/积分';
comment on column TB_TURNTABLE_WXUSER_WINNING.prize_project
  is '奖品名称';
comment on column TB_TURNTABLE_WXUSER_WINNING.create_time
  is '创建时间';
comment on column TB_TURNTABLE_WXUSER_WINNING.openid
  is '微信指定ID';
comment on column TB_TURNTABLE_WXUSER_WINNING.state
  is '状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货';
comment on column TB_TURNTABLE_WXUSER_WINNING.prize_project_img
  is '奖品图片';
comment on column TB_TURNTABLE_WXUSER_WINNING.addressee_name
  is '收件人姓名';
comment on column TB_TURNTABLE_WXUSER_WINNING.addressee_address
  is '收件人地址';
comment on column TB_TURNTABLE_WXUSER_WINNING.addressee_phone
  is '收件人电话';
comment on column TB_TURNTABLE_WXUSER_WINNING.lssue_user_name
  is '发货人名称';
comment on column TB_TURNTABLE_WXUSER_WINNING.lssue_user_userid
  is '发货人USERID';
comment on column TB_TURNTABLE_WXUSER_WINNING.lssue_user_usercode
  is '发货人USERCODE';
comment on column TB_TURNTABLE_WXUSER_WINNING.deliver_number
  is '快递单号';
comment on column TB_TURNTABLE_WXUSER_WINNING.deliver_company
  is '快递公司';
comment on column TB_TURNTABLE_WXUSER_WINNING.deliver_time
  is '发货时间';
comment on column TB_TURNTABLE_WXUSER_WINNING.product_winning_info_id
  is '实物中奖记录ID';
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
  is '图片地址';
comment on column UPLOAD_IMG.usercode
  is '用户COED';
comment on column UPLOAD_IMG.userid
  is '用户ID';
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
prompt Table is empty
prompt Loading ACTIVITY_WXUSER...
insert into ACTIVITY_WXUSER (openid, belong_publicnumber_id, nickname, sex, country, province, city, headimgurl, id, total_integral, total_money, surplus_total_money, surplus_total_integral, sian_time)
values ('oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null, null, null, null, null, '57c18e8449544b48916ce6d234c96de820180516175538', '10', '0.01', '.01', '10', null);
insert into ACTIVITY_WXUSER (openid, belong_publicnumber_id, nickname, sex, country, province, city, headimgurl, id, total_integral, total_money, surplus_total_money, surplus_total_integral, sian_time)
values ('oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null, null, null, null, null, 'ad4839ac91d2415da779848cb7848a7620180516173429', '70', '0.04', '0.04', '70', null);
insert into ACTIVITY_WXUSER (openid, belong_publicnumber_id, nickname, sex, country, province, city, headimgurl, id, total_integral, total_money, surplus_total_money, surplus_total_integral, sian_time)
values ('oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', '妖妖妖怪君', '2', 'AQ', null, null, 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', 'f3cd41f8c92f462eae34e6c37ba6df0620180516173847', '2298', '0.36', '0.36', '1953', '2018-05-16');
insert into ACTIVITY_WXUSER (openid, belong_publicnumber_id, nickname, sex, country, province, city, headimgurl, id, total_integral, total_money, surplus_total_money, surplus_total_integral, sian_time)
values ('oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', '骚的要有贞操', '0', null, null, null, null, 'a8c7091e790140159589d10c7fb9ff4c20180518015720', '2121', '0', '0', '1731', '2018-05-18');
insert into ACTIVITY_WXUSER (openid, belong_publicnumber_id, nickname, sex, country, province, city, headimgurl, id, total_integral, total_money, surplus_total_money, surplus_total_integral, sian_time)
values ('oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null, null, null, null, null, 'e65ecffd51de48599f4ce3a37422946220180516175033', '10', '0.02', '.02', '10', null);
commit;
prompt 5 records loaded
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
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('150dcb89558a4c30b1c830f195a0241620180512105600', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:56:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f6dabb391a1247259c7a539b0723104220180512105609', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:56:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7f46c05426f14b20881bbdd3e010545d20180512105612', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:56:12', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e795a70f3a144a1ab6b2c2d9452727fd20180512110854', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:08:54', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6c7bceb254e646d08d89b3656aedc67d20180512110922', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:09:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9d4e9d4ecd804b308a4c77f7579b743620180512111038', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:10:38', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b12d80b8799e4aa497914cd34ff3359920180512111116', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:11:16', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('dfecc6a3c4b14437a16bb5c4c2f6c5d520180512111134', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:11:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e6c4e94ef8574d25b16a813bdefbbe8420180512111144', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:11:44', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f08dc90b7d184f03a396d537dfef61fe20180512115709', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:57:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('22b7496f6c254d948ec550234a596c8b20180512132923', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:29:23', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9997353c347944dcb1e7f9777b3711a020180512133729', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:37:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ec77c3a62d25491eb1648f4aba193bbe20180512133742', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:37:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1b6f3c8498324deabff3deee7081a87820180512134114', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:41:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a27cb5d9ffd441a79c7ab176cd33fb0920180512134116', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:41:16', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('30a0e77d14bc4c76b86cb38473441e7f20180512134333', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:43:33', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c3418d46005c40cdbfc0936b6c60b55a20180512134418', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:44:18', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('19b68de6bce248debf59232d8347b97220180512134629', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:46:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3cef434616e34a51b13d4571ada1eecb20180512135002', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:50:02', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ce93b10a932b4e94a435fec996f3e22d20180512135106', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:51:06', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7c150053c9144113a2817c66a38a67c720180512135226', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:52:26', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ebfa98816bb949d39bd07dd72a5f271e20180512135246', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:52:46', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('92f3f54a3df445f5b0b4fae9d566f68720180512135411', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:54:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('95e10b8b8e3d425aabf346e8d70ddfb420180512135429', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:54:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d1559532540f4baebfecaebe2fa3471c20180512135542', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:55:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('19bcdaf2a97d406cb884ab978ab5a64b20180512140510', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:05:10', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('577fd245527f4417a3e9249cc4b331e920180512141213', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:12:13', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e3f6076661b847a49a41e883cf659eb920180512143246', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换', '2018-05-12 14:32:46', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('733f889d06484d0fa94afffcb37972a620180512143731', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:37:31', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fc59865ae2bf42e080e6706617ce206420180512143920', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:39:20', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f2f9ca2babba4dac9a20ace540fa7bc520180512144040', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:40:40', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('717bbce237ee4379828cb8ee31a4e95220180512144543', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:45:43', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5d898d0c3b8f4b178343a0bb9c8b852020180512144622', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:46:22', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f0d97319847d4179abf80f9b306268f520180512110205', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:02:05', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f0a0d4a22cd04ab6b8c03638600d1a6720180512110207', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:02:07', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('135df3872b774cf5a5a62ca72fffc44120180512110653', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:06:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e1a9f6aae6e04017a2715adbe584d1f520180512111331', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:13:31', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('357964658d394e968f5ed2d1a7b9f8a320180512111334', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:13:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d7095a02734a4b0bb90a6797ef1eae9220180512113030', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:30:30', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('eb5bc801f7fb4e8aad36d408a7c5755320180512113034', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:30:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('417d2249fcc043dca8cf13b08e8403fc20180512133042', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:30:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3a3c6b59f3a2427ebc2b2d5560da49ce20180512133147', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:31:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ae4508b6a077471e8eb1c21c2aa0162820180512133206', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:32:06', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a4057afc2bd14d099d63a4c8947ffae920180512133414', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:34:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d1ac8def77a74cc383ccb7c2f6f67dda20180512133705', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:37:05', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('86aa208247604bdc91049821d5b89ffe20180512135332', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:53:32', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('87d15d46efe44cc182429c9f870beb8f20180512140918', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:09:18', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2900a88b9faa4e96884a5f6f8611a03920180512140950', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:09:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('27000b344f9e44f1971e0fafb7e840b420180512143631', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:36:31', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('17f30a1e9f9b47d0a0c558b2ab06a48220180512143928', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:39:28', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('48f239e309564beb985a23f55f54e17520180512143934', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:39:34', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('226a5f30ebea43e69aa2bb66c6d1536720180512143941', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:39:41', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('80fc6f40c044405eb217bd58c779c0a420180512144045', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:40:45', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('79ef38f787b74be4b2910b6aead5ca8420180512144528', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:45:28', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4e836fe1dd2f462e8d716add2542901a20180512144600', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:46:00', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a0e7b67c0b694e90b16134262012345d20180512144613', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:46:13', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d0f408746c614da297a123a038a3c8cb20180512144647', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:46:47', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e6dbcdca3c5946e7ba3c3cbe988192b720180512145611', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:56:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9aa7cdc72fb9458c9204ea7a85af4ef420180512150241', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:02:41', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('892c89862ea34a1e9df90f03833361e220180512150409', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:04:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9d9c1dfd60d24714a35142f95a40173c20180512155018', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:50:18', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('86fc1ca9739f4b1a8104152baa66e63120180512160130', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:01:30', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('145844480a2e4a8e9b3c80a46f615cf320180512160212', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:02:12', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e526fda861c14f16932c79ef657afc4220180512162124', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:21:24', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('62ef81c02d1f4ba6b914c8907697fe0c20180512162235', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:22:35', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fcf31956bbf54a8da55f08a02bda5b6e20180512163130', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:31:30', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c44828cdb39340658351a12a7d9fbd1a20180512105809', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:58:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7d5b2b6c0e8846dea688126393d2766120180512110158', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:01:58', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('930c514af2bc4670a22427a0cc322ec120180512110203', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:02:03', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ae76a2fe1f3946148fb8ff949021a49220180512110358', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:03:58', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('22c98c2fef144b9998c28398ceac65fc20180512111426', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:14:26', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3cf0bcd2f19f4bab8e6db322d20094c920180512111650', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:16:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('56e39b6e26074dd78e6d95b8c553716420180512112425', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:24:25', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f4dd187f12ce43dda6452cf0fb24b69220180512113748', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:37:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6f160cd39ff34afa95d276c605a30abe20180512113800', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:38:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('44a586c1ee424023aa6be65149e6c11d20180512113906', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:39:06', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('09d58c25188c4b82be3ab77475180d3020180512132842', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:28:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e8e5563984464ee49c07a67a84c1316e20180512133745', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:37:45', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ae30442d6b5342eeb04465adf0c45d4220180512133748', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:37:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d1e6f488773542029858d80dc132098120180512134257', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:42:57', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ca4634259ede4462b3941eeacff50c5720180512134322', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:43:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('26b9cd16f40e46cb8adce5c737568e7e20180512134347', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:43:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('106190d198574843a2e20686f65cfdca20180512134400', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:44:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b03e43d9d12742dca7d166a2b0ce235e20180512135051', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:50:51', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('46407068aa46417dafddeeb0349f1a7420180512135215', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:52:15', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f4bc186c543d4092858d34e442b22ea020180512140449', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:04:49', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('408baa78e4f4454791f5214065f6ebfd20180512140755', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:07:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4d4f54d01d994857b98df18c34f028b120180512144953', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:49:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('02551755e2cf4759bbb4d3e991b2cc0b20180512150203', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:02:03', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('48ba0e4e421144c5a9f9a9198c25c30a20180512160248', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:02:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('477815855e804b78a94c847a5d8e157320180512163141', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:31:41', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ae85d88c7e2e46bab8dde4d0cd555a0820180512163322', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:33:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b132376cfb884786945e6bc620c8e1de20180512163441', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:34:41', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7290d62708ec4660aebed76f97cc691e20180512163511', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:35:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('76d879d851484c848413bd18153f6d1420180512164126', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:41:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('14ae9c5f7b56494a978e937fb05557f120180512164453', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:44:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2ed63fea7bfe40ef956a269f07105ad920180512164514', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:45:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f82e4ac0d257419bac411c7aaef32b4220180512164526', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:45:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d48bb4af87e64cdd859d6150824ed30320180512164539', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:45:39', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fb7c5835a91d4a069a703ef88f77e3f020180512105722', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:57:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 100 records committed...
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('653f380cab124ed98ccec3260cd3571220180512105824', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:58:24', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('91507b29bcb64f0d80153ced5c2fec0f20180512105826', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:58:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fdd8129e228f4dfcb9745fe53d10e1ae20180512110128', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:01:28', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a9719247322144a58e46173ae1cf4d4120180512110150', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:01:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e508e7897961485b83b9a6560f6bed6720180512110153', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:01:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('073b1b0cfa9c48769ce1e176bf7e02b520180512110155', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:01:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1282c1170e814d5fb3b4ba0fd09475b120180512110157', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:01:57', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('337c9c5e0f004f248a356b3476aaf93020180512110200', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:02:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0bc9f22db73e42af8fec807df51814da20180512110202', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:02:02', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a57dab6b3f064ec3852bf0c6e265dbe420180512110209', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:02:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2e3f3984f88c476696adba717d612b7d20180512110247', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:02:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('545464559d1944a3a11565747a8bf59220180512111040', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:10:40', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b9c4592a209648338460bf90e1e41e5620180512111042', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:10:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9dce6a7550df4515913e0c42ccd4067320180512111242', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:12:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e236e173667f4f50aeaf94b74ff1bffd20180512112021', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:20:21', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ec3fb568a5d44a24835bb07299d1298420180512112524', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:25:24', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('69caa4e4107a4eb887b4ecfe623e00c620180512113413', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:34:13', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2a2d667b83844d50bb8dec8fb568c1f220180512113835', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:38:35', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b29fe05770da473bb894e85bfb17e1f520180512114002', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:40:02', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('efa7720b79f142449ddd557d9f27404720180512115632', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:56:32', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('46fdbb9e62ff4ae09248af2de60c305420180512115724', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:57:24', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a834a04faeb940908b841f383a94f8d320180512132825', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:28:25', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4e908e2beb844f68ad9fb74a2defdcf820180512141414', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:14:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d1749d806a194a5fa6850e04cb1c18fe20180512143014', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换', '2018-05-12 14:30:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5ff607deb5754b83b86bb0cfcfaaa1ac20180512143956', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:39:56', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a1181a2121c94d4cb16382e2f719344420180512144005', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:40:05', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a365c75080ee41c58080d110656ef63d20180512144738', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:47:38', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('76180a96a56043c383c61c8ace0dd2b620180512150053', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:00:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('44d1f11a429441e98b2a8e4d7fef039420180512154524', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:45:24', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('88fcded928294c90af80e4294c08950020180512154554', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:45:54', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fe8a701f89e7451c8533620bd1ad3f0520180512160232', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:02:32', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c733c074d15f47798a714c1c51c051e520180512160307', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:03:07', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6b5d101a15b34644855fe1d17ea074f820180512105447', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:54:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('13d266ae2efb43418f7911d7dd27df6920180512105459', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:54:59', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('dc50d08540ab40ac9007460dea002c3020180512105505', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 10:55:05', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e3921e4e3a5340a0b32dbd1d5eb0960020180512111131', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:11:31', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5598c82f93ba48b88945d62da677611d20180512114023', '17fdb3268a49419db09f4e7a6a1bdf0a20180512100052', '20', 'integral', '积分兑换', '2018-05-12 11:40:23', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b1b755d6fad24e4da221433febf6dda020180512133750', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:37:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('991d11580f894c85938f6b729908db6520180512134226', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:42:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('efdd2aab873b41dd97c37ef23e1f3dc520180512134600', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:46:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2c3db3453dea4d97affeab188a633ac920180512134617', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:46:17', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1402da2a01ad4302af40c2084bc74f9f20180512135030', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:50:30', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('42006fd0193942c2b4d2741c04fd233a20180512135148', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:51:48', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('437be46bc138427d8e899a9ab436b77420180512135351', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 13:53:51', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fef7a95e1ac742658b09f079088f999f20180512140128', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:01:28', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0a5dee01dbd84deaae5b66fcee5cd6ea20180512140633', '466fc74154b447b490b2e8eae8c8e91e20180512125230', '20', 'integral', '积分兑换', '2018-05-12 14:06:33', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f1754cd157304a128441b05ab96ccab620180512145712', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:57:12', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6add93fa1dc340aeac0bdae88ca6b6a920180512145925', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 14:59:25', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5e5f9d6fc20c47b59890118103491cef20180512150355', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:03:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('acaecffb8f5c40048e82f0a429732e6e20180512154541', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:45:41', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bc06ebc5554041719f394d9bc2ff4fc220180512154842', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 15:48:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3d9045d745964f139cbb19c09f0db12120180512160321', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:03:21', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('863e1e7868c442c08bd73089005d509e20180512160332', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:03:32', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6505628e4a344458854e31b15ffb908320180512161833', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:18:33', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b94982c869454597876e63592c93689420180512161940', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:19:40', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1038b563188543dba8d001e23de261f120180512162006', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:20:06', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('955d6655bf9f4ec3ac10a8c4ea9ae79d20180512162023', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:20:23', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('41b74bc190894a49875dcd5d45a1aa2820180512162100', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:21:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e60ae9ab5a644a30a20510e3344b8bed20180512162138', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:21:38', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('577a24a2ba3245bd930447fdbff8a4cc20180512162208', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:22:08', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fe85938014c644a8b97c3a3a218e7ce520180512162223', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:22:23', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('edeacd9ff4ac46388cbd5cce5d5f6b9620180512162307', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:23:07', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5580e183261043f69fc9055b2d0fffb720180512162325', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:23:25', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('be40eeefacfb4c108de33e92609b1e4720180512163309', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:33:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8de2d18870564bc7b888b93e6961c20120180512163342', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:33:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5665982f459643dea3cdcc4fca58b74920180512165050', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:50:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('590dc6a0a67b44cb98e1aee76924f6a120180512170116', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:01:16', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b4fbab0431034bd8babf40f3178b4c0320180512171341', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:13:41', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('928efb3a85f242c38b905f045c8c76c420180512172207', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:22:07', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('98c02792540a4e6e9339ab67077f250820180512191944', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:19:44', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3a4a5681c9bd4a23bb144ce1a44a9d0f20180512192012', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:20:12', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f6265c330fbb4c0d8f259b0d4bbbc9da20180512192039', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:20:39', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0b8d04d2223943758439ef51f4d2bd6320180512192109', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:21:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b83669e03f4a45e391b1140781e3358620180512194724', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:47:24', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('497ec99b592f4731af7c7b679e098b8520180512194749', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:47:49', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9561194804114756be1713b65f87f53220180512194934', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:49:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('74391818952a42d39785184557dea77720180512195002', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:50:02', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b3bd7a46ce334609bface4ed4da5bf3b20180512195010', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:50:10', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('51a63510d56c4767befd58653357de3420180512214247', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('54d315358c1f4e59a48560cc1ed8379d20180512214247', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a549d604324b4c969058c40899f8d93420180512214249', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:49', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a3af3ca0d814448388ddf9c26667512c20180512214249', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:49', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d8f465c5b75c4d97802a45a2f442085f20180512214249', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:49', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6775ab6f7f764348a1cb900e4e545b0b20180512214250', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3e382b9379714ba3a0f26ed459f24ef220180512214250', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cb221bb563bf434d8465d9ca5e10b02e20180512214250', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('dfef2de235f54b3fb227141b0d66c7fe20180512214250', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('414d9dac70c249f68dae3e1f5e992bf820180512214347', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:43:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bc3c1b897b6243589ba23a399fc8cadb20180512214539', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:45:39', 'oRvVat4hLq-eL59V_MRomtCkzryw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5cba344f53314805876eefbc050d240e20180512224005', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-12 22:40:05', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e27516ed43774020867f442399d751c220180512224509', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-12 22:45:09', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('afb7364f9c52458eb4c83f128aa7b68520180512224520', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-12 22:45:20', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('295f25ed2864404ba8d625d919281f9920180513015017', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:50:17', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('772aac4c95984989ad4f4cd77377771520180513015041', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:50:41', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9b6db90ee1c34ad89f8c74b2d6af8f5620180513020756', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 02:07:56', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4fc6e63c23df45678a2d3c6d2708136920180513025948', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 02:59:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('06a493e567db44cd99b6634d6f652fd120180513144612', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 14:46:12', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6eb9a20eba23422c9f87a23ca8653de320180512165003', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:50:03', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3626f765066f4d10bdebb82db555f0db20180512165023', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:50:23', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('aeb7d98f12aa41839e9d5f2326a562f420180512180022', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 18:00:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 200 records committed...
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c88ff1d3a9d94afc8cd7bb828acd4e1b20180512191404', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:14:04', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c394df8e44614cd9af3b5de646678a1820180512192849', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:28:49', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('373c72b5377e4aefbcceaf74d48e2de420180512194755', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:47:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e178c02c314f47f3b521c114122887ba20180512195031', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:50:31', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0f9881ba8672419597adeef1592fa63e20180512212946', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:29:46', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('70ec85b841a44fd5912493523403717f20180512214249', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:49', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('adfdb311b8214d81a1318999118e740220180512214250', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('71a1f7d31abb4bbdaf4c113165bd844720180512214517', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:45:17', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3ad6a70fc64847a984c8d744d48bdcc720180512214607', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:46:07', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('461a5fb7eb5d402799a13b83a4844b2120180512215034', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:50:34', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9b835ad97e444b8e8b91586a88b4576720180512215050', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:50:50', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2ce8bea29eba4e19a9226bf121ca893620180512224012', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-12 22:40:12', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a9bbde06557e4bfab2d8053557793e0a20180513015055', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:50:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ebb7c4292b5f4c24891970fc7b29202920180513015126', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:51:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2cd616d6c5624e0787b0cc4757be0e3620180513151358', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 15:13:58', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5b4bb48c71a34f7ea5c6232c0c3ab08620180513151512', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 15:15:12', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c457e17b9deb4a0da2e0cb5ec8421a2120180513185000', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 18:50:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('dec0cbea05d84122bf82b487f79b470720180513190652', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:06:52', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('efd36d3024554ee49638a6c67d6aa92c20180513190709', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:07:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3d3462d03a724958a81d8c667e1b54c120180514095153', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:51:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7e2261b5265d40e8a556d7faa38a399820180514095159', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:51:59', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e0c7a2b85ace4b0c9a83b1eece81903a20180514095745', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:57:45', 'oRvVat8GfsCgCmnuZSwp7SyADs80', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9f07ba551d3f4f5d951d05b2dc18a00a20180514100131', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:01:31', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('09983e528b24491caca2a9ca6c36aac920180514102452', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:24:52', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9d95e4c8282548e7bb71b4d097cd213220180514103004', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:30:04', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('852228b46d2c4ae3bb04d43c9fb9fef020180514103115', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:31:15', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('512cc76001b240299c735a27982e138920180514110648', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:06:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1797596e200240c6a2b88b2e60bb95b020180514110730', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:07:30', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d005b34204d7493f9b6317223be395cf20180514110737', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:07:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9faace4214a644c28a820751ecf6b01b20180512170129', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:01:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3898c327a71f48c19e92fde22ecc3f0f20180512173011', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:30:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8aeb796fbd844fe3ba3f60b16e130c4820180512173722', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:37:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a12cc634961c455c981c6da5d29ef13920180512173745', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:37:45', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4ac8a5340dc44975adeed295f14d998620180512173802', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:38:02', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('74966494e49248b7a6427e5ed3c3396520180512191348', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:13:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f8cad27c1aae41c58424aaa3fa54174d20180512192858', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:28:58', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('eea1d0c7bfd948da94d7049ab155bf5720180512213316', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:33:16', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9271c8176b444001b6446497d9a8fbd920180512213827', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:38:27', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ba9f1209e9ab476a81fae7677abeadf520180512214233', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:33', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('84876a456a7e4acda05d3aabc06da2c320180512214233', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:33', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('035e71fd9085423f8e371d2d6fcb8d3420180512214234', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('41028c548ead456f84a0df74657236b820180512214234', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6caab2e5dc6e4ede8534a763b4bb38ef20180512214234', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2d19391d99ba45a388fa2fc9c890f6fd20180512214234', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2e26d8cddd17470abc0bee270cbfa05020180512214234', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6fa2ef7b21394207b9977d16b16e4e8c20180512214237', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b215148f36a5455994c554c4210027c720180512214237', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('babe243f793e4178b6867dac3bd8083620180512214237', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3ced69aecbb54485a194e70039cba80620180512214238', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:38', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6cc3148b9a73453f93c99dfd08988caa20180512214445', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:44:45', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('58a18a460e3f4de28a871c9bbb26528d20180512225839', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-12 22:58:39', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4e10fa235ec842e080cb9d85afcf78c720180513143314', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 14:33:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1eb19c0a4bb54389a5eb469a7ea5b07a20180513190638', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:06:38', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e0e53fda619e445db5de28efdd5a76dd20180514092423', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:24:23', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('078aaf66d08f4054b1ec6ec5ec6617b720180514095134', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:51:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4dd1f943103544139c0a97c943d7005d20180514095440', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:54:40', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3428a0d32f9e45f4bf4130a7c44a7f6f20180514095722', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:57:22', 'oRvVat8GfsCgCmnuZSwp7SyADs80', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e349d7310b4e41f1b4e5837f3621909220180514095807', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:58:07', 'oRvVat8GfsCgCmnuZSwp7SyADs80', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('54d6d59a46004e5ab6cc56f3c7a7a0b820180514103415', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:34:15', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f63d11398b654341ae7f74f57437f8b620180514111105', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:11:05', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('94ccc2193dc24dd6bc243bcd469ef59820180514111131', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:11:31', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('38bd02025c82471eaaa470573589cbce20180512172645', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:26:45', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e12f64adf63f4304a84b2f2eb61af0fe20180512180032', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 18:00:32', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('65954421edf04503b3d4d2310e289d9520180512183956', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 18:39:56', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5e4bd178bed44d6d9c5401cf2bdd96ea20180512184520', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 18:45:20', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('36a4b16fcbcf41428988979b24bef48620180512191953', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:19:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1a992793dfd84eb6ad277c7232d0857420180512192022', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:20:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('756bda08dcd940db836d623c145cefe920180512192049', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:20:49', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cdade73be3cd4fa199ec5faeb4d4313f20180512192319', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:23:19', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5069eac3524b42deb49c9ddf87549edc20180512194258', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:42:58', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c005d68723de42ab9a88f2799546a79920180512213651', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:36:51', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('915c1006269c4882a11ff90f5b98afd520180512213734', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:37:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('89bc0ce2ca2044a29619b9c101dc7dd220180512214234', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a7c6aa12fbe243319bb62784143065e520180512214859', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:48:59', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e7e1035b617347eaa6c6beb3bbd9122c20180513013840', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:38:40', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('47e4a0a4e0914438a8a03e0e8151fb9b20180513190659', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:06:59', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('73317be9bf614d8ebeb2711a01577b6f20180514102433', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:24:33', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('80b9c708dd4048faa820c282ee756f5a20180514103017', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:30:17', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('20f3e302e922408c8df54a4a6f8312e720180514104731', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:47:31', 'oRvVat9U83DCCoLdW-CmAWAkBmAM', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6a61f53cf30542c2b2e1e102049b50ce20180514104731', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:47:31', 'oRvVat9U83DCCoLdW-CmAWAkBmAM', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5baa92e08c4a44b2b72ae9e8482085ff20180514111221', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:12:21', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('73aa50fbbc93482e8d29caca0defe88f20180514111254', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:12:54', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d66b25b04d2d4d958728a7b6d19f4b3920180514111254', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:12:54', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5bbb42d0f15d4166aa067de07358333920180514111254', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:12:54', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fd8a06b0f4744c62b51ba6b6076f81bd20180514111254', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:12:54', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('320e854d6f93497cb2f824604b67e6b620180514111300', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:13:00', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1ed46ed3bdc54708a021021e48309af520180514111316', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:13:16', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d64de772be9e42c6938d4cebcd7c2b4f20180514111522', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:15:22', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('16d57cfd709945b8aae0a03f98c53f7420180514111543', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:15:43', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('05ab0b224df04f23bc5ed871a926b3c820180514111620', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:16:20', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c1b29390ccb6423daf85077033d82a5820180514111627', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:16:27', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('04f40601f5844c1e97ab96cdd83b7d7520180514111657', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:16:57', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('962a03e757624d2e90adbed7cfb69c4a20180514111826', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:18:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bcb8b03c814a49d5b9c9f40b15881f7920180514111834', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:18:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bf20fd8e79bb4b8782045acee06125f020180512165037', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:50:37', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b47e0b6bd6944b84b2cda75d60f3decc20180512165150', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:51:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('456d2ab9f427425fb4e4812b55b36b2f20180512165218', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:52:18', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ee6e26e87b4148be8e583fc5e2a61cb020180512172833', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:28:33', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('db25c9c45baf4cf5bf96a32c1349efb720180512173911', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:39:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cde937d5a27646f187ced77165a0101a20180512184711', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 18:47:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 300 records committed...
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cd3707cef3f1449c8ad2f7627675019e20180512191413', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:14:13', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8e3a86e264df4709b7150faad885915f20180512192030', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:20:30', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ed8a9894b41842cab03f4295849d89d220180512192058', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:20:58', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('18f5d61f70cc455cbf88a89edc7834a020180512192120', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:21:20', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f8aa7b12e7af4d32b2e98ac3e542b61d20180512192301', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:23:01', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a2e64b4de29b48c9867f4260e942b70a20180512192311', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:23:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('90660ae6da21482db04e5187dc0cd02220180512192327', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:23:27', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d9d7584b32a0445abc66c32a4aebbb1a20180512193512', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:35:12', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ff421c1b5fb04d0a858d39d6b40659b520180512194810', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:48:10', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('58c59d1af41e4655b1361362edb96a0920180512194926', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:49:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e3260683a565466d8919998c91c5c69120180512194955', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:49:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('444756de5ddb4a3c8df71d34c5d2798020180512195024', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:50:24', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5570914276894a16938e8c28cfc1b90b20180512213714', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:37:14', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c12e62f406a9419ebe04f05ed606481120180512214235', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:35', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6cb77a67ed0d4cf6ba4f462c7d8a777820180512214235', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:35', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ffc4c7686d984adc992da1a627fbdf4420180512214236', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c90a5a3514e1461d994efd0068f1867220180512214236', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('812b6802999c42eab6b8655a6964347c20180512214236', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a63f3a55909d430a971ccb152697e4bd20180512214237', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cbc70bda6ded48eaa6d9359eabc97a1820180512214302', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:43:02', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cd641eb3890643dcb0c8f674289de95520180513151538', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 15:15:38', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('45d56d08b5a040069637b5e2be94959a20180513192911', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:29:11', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fa362bb95e35449a839807e5dce7e25420180513192937', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:29:37', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5de31e35344a452ca74771250dcf9f8e20180513193430', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:34:30', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8a3fa87e53284f0794ec8548bb39274120180513193527', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:35:27', 'oRvVaty0Nkd_0vmbjnUjM1_oHx_U', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2733612052524c45a3ad5eff1da363bd20180514091404', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:14:04', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fed94ea626f84188a34d5c68a0f87ff920180512173733', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:37:33', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('71869dec8fc443b5a0e79801e0bf1e7e20180512191934', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:19:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('130fafebbeca48c3903d12e762ec14c020180512192003', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:20:03', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6533a739ce254d0eb6608e6b17c0fb5d20180512192253', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:22:53', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9f57a61049b649fcaa404c7ec402ea4d20180512195018', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:50:18', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7a923fa3b2b54fafa5e60d8d1ae2de7420180512213934', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:39:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e9a35a5b1aa6455bb02d377530a2c59c20180512214247', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9e971e1959b147aea10b781fff007d6620180512214247', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f66fef94adc54501a16da197fcbbeacc20180512214247', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('10a625d865044bc9b2d075a2b21310bc20180512214247', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7d29f266d94f47b9ba890aa51186f90020180512214248', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('60a9224a0ab44285b454729902c6b2b820180512214248', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('eb054e02459c4ada823ffaba67a9e78320180512214248', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('88ad8989733545c685530f8f9d1c8c4220180512214248', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7fea6e696d904ba7b447d43dad2c787e20180512214250', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7031c0cdd4df466ea3d2fcf6e780787620180512214251', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:51', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f43e2620d21743619050ccd4f503ec4c20180512215027', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:50:27', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b0e91d7f0ecf44a8a03a9a39cba0cd6120180512215116', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:51:16', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('33cb4524df11446c947d7d2c8a5f623620180513015029', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:50:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0fc4b6b134204008a55c27eb662a344220180513015115', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:51:15', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a94d6139439c429798c710ff149a17b120180513192858', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:28:58', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4f6799554a8f4f0192b5c41c879d9b6b20180513192920', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:29:20', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('99db4bd6c1314d9f8b3cf5b7e8a5071220180514091412', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:14:12', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5e91f9c38cd84932a7eaec526e4710a920180514095116', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:51:16', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('76369e1ac1ca46d9bf186f4e17bb387020180514095206', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:52:06', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f7e80a37cf5e4ea19375e1c2b75a14bd20180514095301', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:53:01', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('917e02546bc7447e820eb6d7292f4fdd20180514095403', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:54:03', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('88c1b18b5c3e4b9491d6c8a21c8b16fa20180514095631', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:56:31', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e5e5945a3a104893b53082f1ad165b3620180514095709', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:57:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ea099aaa7a864fa78910d517165bc5a120180514100302', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:03:02', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('65e5671c15654be48f185af680afe02820180514102441', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:24:41', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('80d7c751495940bcafee2d0ae9f5b87220180514103027', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:30:27', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a43a315e6789461183ea0526c8fe9a4d20180512172950', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:29:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('19a787b425554f0c88686520f34f8f0120180512173002', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:30:02', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('12da8ed11f984079827296efe32238f120180512194941', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:49:41', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3aa282a5e68d41eda1c97894c4e14e0220180512213841', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:38:41', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('02d7f8c817f647499aa50c5eb211835e20180512214318', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:43:18', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6bacaaef38484efd8092bf7e9e03a85320180512214320', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:43:20', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ee0da3fb8b0f4a67bd8923d9dae8f81e20180513184914', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 18:49:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e8ddefe1063a4274968eb6ac08b53ba020180513193054', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:30:54', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('38f3cf5925544f689402115a231de8f520180513193447', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:34:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c13aed8fcf01494ab9ca7bf4832f992620180513193536', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:35:36', 'oRvVaty0Nkd_0vmbjnUjM1_oHx_U', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('11ae7988e3bd471288b22351b4b239f420180514095107', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:51:07', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4fdc26fd06ce4d69b03634cfc04bd23720180514095625', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:56:25', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6d81527366ba4d7a843ce56cd4288b9a20180514095645', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:56:45', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d6cdbb67768a4dbfa1a2ef27c4d8d9bf20180514100134', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:01:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('606b5021414d46b794b4eee617f6746020180514100252', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:02:52', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c2b5a34fdaf04b3b8e646ddc347b563c20180514100253', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:02:53', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7e54ff55f41e43d192d5fa9d4c18d8ec20180514100253', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:02:53', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3ffe41e68d1247d0980e57a97efa85f620180514103034', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:30:34', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6e9416cb9df4498ca354dad0492139d820180514103346', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 10:33:46', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('caa9f36915c54a61ba4730cf5689aafd20180514110722', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:07:22', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a21ed685180e44859c23d33af0aa7f5a20180514110745', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:07:45', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('18e2c8ee4e5441948058a9191d9b4c1520180514110836', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:08:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('776e9ad258624dff87acfabfc36ad8d020180514111050', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:10:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('50384e7f757a46d9959d3e8f2f90fc7c20180514111058', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:10:58', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0a9bf784a63f4b3b93b1a2f0f5eeb73620180514111112', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:11:12', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('78792b6813ea453fb6d84cff10f5557520180514111122', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:11:22', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('034e20d325d24ee8a73ebf091e59218d20180514111145', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:11:45', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('05987f6e7134421a83af9271111e62a820180514111154', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:11:54', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c0a93066956e40fe878960cf6012faf320180514111204', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:12:04', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('43cfc8b22b6d4dba9c1611276da6817620180514111238', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:12:38', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9b07958a01044c86b3a3fa90b117426520180514111509', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:15:09', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2f0a28958c064b6bab0269ae39154ca520180514111554', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:15:54', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ef8fb9f92de94b9f999b69175496994920180514111558', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:15:58', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ae00f6c6fec144e78f13601f7bfb2dd120180512165112', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 16:51:12', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ca8d0db9c37c403ca08dc1fad4d720cb20180512172850', '978d1ab8429248cda9961df9febc482120180512142425', '30', 'integral', '积分兑换-九宫格', '2018-05-12 17:28:50', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3af3ad88770e4f26b41ef8ec60e3be4120180512194734', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:47:34', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ab2ac80d57734e25a04310323b08a64620180512194740', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:47:40', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('31db6259a5214eb09f052b21bbd6800020180512194803', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:48:03', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f7c3ded6a6c24d679eafef136b76b7ba20180512194919', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:49:19', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4115636878c14cddad7ca0fc7565cae620180512194948', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 19:49:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b155f00b46f1419c9f28258b209cd52520180512212735', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:27:35', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('da779963e8ee4fa6af177a5a265e54bc20180512213723', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:37:23', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 400 records committed...
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4ad02077f2c7445c955ae4631aca7a2e20180512214234', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9d515583754f4c12bb642bca076592ae20180512214235', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:35', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('96f079d1b4d24b8992ade13ee910c6ef20180512214235', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:35', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fde737f0ab7147ac9f4d53488a04eba020180512214235', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:35', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ea742ee40bfe4c55b54705f3c1338c5d20180512214235', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:35', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fa6635ca8c8247aeb623319ac18e21a620180512214236', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('89817e54052b47118711e42d67904a6620180512214236', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9cecff714244449d86e7e69ca39312b820180512214237', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6b034a2ce0ae4b7a98317bb2ac9b855d20180512214242', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:42', 'oRvVat4hLq-eL59V_MRomtCkzryw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f2c188d29ab741d880220e1d3d81aa7320180512214248', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b4436a03e40c4707b4d2f8a9d331b60620180512214248', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4405e5c0e0ce4225b67111aec8ecb87f20180512214249', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:49', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e3a4113462944590ac42317200d6138420180512214249', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分兑换-九宫格', '2018-05-12 21:42:49', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f0d5c0816bae47bc8ee02b17ef67896520180513015105', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 01:51:05', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5626c17ff7b946bdbf67cd91a3b72bbb20180513020747', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 02:07:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e57f89aaa8a14b30aa0bde4204952b7920180513150005', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 15:00:05', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0629f8828f8e47dbb73d0738ac52010020180513192840', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:28:40', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0bfee44dac8d4721a72a2cb8cc0e10e720180513192928', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:29:28', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('657b06d7a57b41f7bcc5c13079f982a620180513193714', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-13 19:37:14', 'oRvVaty0Nkd_0vmbjnUjM1_oHx_U', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5188a715947c4309a57bf4a05942df3820180514091429', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:14:29', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('40ff962b6b6b4757a69dc73e1de92a5820180514091733', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:17:33', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('908541b8289d47d4ba013024c2f4f65920180514094227', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:42:27', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9e8c79e748604b23a35dffb6532eacaa20180514095127', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 09:51:27', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('165ba9d518114aac929c698f1d5f1c1e20180514135729', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:57:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a8ead366b1084d719b94a4947586acdf20180514153421', '551cae096f234f6db619cd81b9244c6b20180514152446', '50', 'integral', '积分小游戏', '2018-05-14 15:34:21', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('90a478deb00b4887b27d3d2f39d7493420180514162051', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:20:51', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e6040215fb334e19999790083624f69720180514170039', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:00:39', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('62f14904b2684b398c80ae4f5c80173020180514170103', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:01:03', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ab7f0cf61bf345b78032c99aea03d47a20180514170244', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:02:44', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('61c46d0f0e42470bb99387eddc2d531020180514192956', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:29:56', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('dbe7aaa7c5304b4f918002f8f8cc8ccc20180514203128', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:31:28', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0b7318069ed449f09fe40a5f32990ad120180514203308', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:33:08', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('be7992a1a62c49c3a14e763fdaacc32120180514203322', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:33:22', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('af38bf36ff7043348b0ad9a7afcc002620180514214304', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 21:43:04', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2355dfc0d255445baff195d7652983de20180514223122', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:31:22', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ae9e26fec81849a693d808552a55e59d20180514223151', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:31:51', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cc5d8d020f3d4ecf881e5126a1557e9720180514223152', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:31:52', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('66008c36f20e475b856b89b3747594e520180514223224', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:32:24', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('52cbd1b72c0147aab8441c63ed3c669c20180514224852', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:48:52', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bb5ac2124aa94402a6e0be422c413d3120180514225652', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:56:52', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3daefe4514654d44978295a8c67c860420180514231110', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:11:10', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b1dd37ba8144474c9d6f1cc3deaaec3c20180514231126', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:11:26', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2a3ad979e2f544008ffb74c0e6188a6c20180514231431', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:14:31', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8c02fe4b5a804046a6f4f6f85a7fd52020180515105752', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-15 10:57:52', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('00b0712f243041b0b5f421eb538c4ac520180515115222', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-15 11:52:22', 'oRvVat-1GjA2Tph66j0XHFlAy5Ts', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2df69b658fd14b3c9014fbdc58addd5020180515134653', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-15 13:46:53', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('53aaff6380f246d4bded405deb2b674220180515170129', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:01:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bd8ce3efd395436ba0750910f5c9bd1420180515170215', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:02:15', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('14eaf0d5ce1b4eb48dd6dcbda41fb75320180516093019', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:30:19', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3e08855751a24a4f96ad7e35f8e69cb020180516093028', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:30:28', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('658f06df5118411c9c429c3cce4f13fa20180516093040', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:30:40', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('65abdc53ca36490b8e5e606666bf0f6220180516093106', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:31:06', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('03f0afff81b743219feb94c7dc81e12a20180516093117', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:31:17', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5cda44f250c840a2a96b20d5641c410320180516102728', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 10:27:28', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('85f8560ceb474055b5be875ae7aa932720180516155242', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:52:42', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('57de308807234b438893eca0073f7dea20180516155443', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:54:43', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('df4d923764684792a335adb32b71df3520180514134504', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:45:04', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('72f58fad4bc743d79f3a58b9ff9ffac520180514135351', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:53:51', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('03e0df98964d420fa8854f38a3f9c31320180514135610', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:56:10', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('63c7e3362a9b4049b5182f2f09db205b20180514141423', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:14:23', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f45a4f1a3e2b4c72bc7f1d8612e1ad5e20180514142124', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:21:24', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3ff802b5d90344e1afc258b9f0761c5820180514142304', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:04', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('36a16522edbe41ca95ff464a525a005f20180514142328', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:28', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d3727cb0ff4e442c9d88af35825ac92420180514160314', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:03:14', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6159ad12636946739340d547df941e2520180514170106', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:01:06', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bf70a9d8555d4c9e85ad18e9df9c160120180514193008', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:30:08', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0627c7dcb50d41d19c2ebe9a1bdab73b20180514193016', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:30:16', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e1add9f4dab443a8b076fcc577e6e76620180514195247', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:52:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cf0df887e0f049bba59700f294489dbc20180514230502', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:05:02', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7c930118cf5846c297e7c7e504ae4e0620180514231717', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:17:17', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4e43f69f8bd543738d0add5f429d7ef520180515073857', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-15 07:38:57', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('edb378979e784a3eb90bc43c98b564a320180515170137', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:01:37', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a647faa064ff48668bc3675ff66be6fa20180515170224', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:02:24', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ae052f169a474ad895211f9e4102827820180516155326', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:53:26', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e602be1503fb413885ba23a8bbd38f6b20180516155456', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:54:56', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('55393422d7e246aeb6060aac3dfe24e720180516155610', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:56:10', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a3fe3cc417264622abd0fb34fab2660c20180516155841', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:58:41', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0e7f0ad5e578414bb074bb167be4276820180516173951', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 17:39:51', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a8e74ccfa9684a58adfc7af952fe769720180516174023', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 17:40:23', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('269131b6cb8f43a49e66918549c2ebe820180518015956', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 01:59:56', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bc27a822f2904462a40a5c32aca9013b20180518020019', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:00:19', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6308568facfb42d1986433a07eb65c2120180518020028', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:00:28', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bad4653904a44069b5ad2622a627c21820180518020056', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:00:56', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ed69103e90c84224aef85d965bc220e820180518020119', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:01:19', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a90d9de182344957b2092ee9f5caeac520180518020132', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:01:32', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('16135a52046d4c1aada813f2f9b7b57320180518020145', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:01:45', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0fd8f9698c994daf8dcddbba8f50c15020180518111512', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 11:15:12', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('73a607112a4a4a2793cbfb967ccda7ec20180514112630', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:26:30', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('59daa0aad2d14250a60796da796f871420180514112715', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:27:15', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('24c4a24d79e84c12bcfca2a5a3e0ef0720180514153228', '551cae096f234f6db619cd81b9244c6b20180514152446', '50', 'integral', '积分小游戏', '2018-05-14 15:32:28', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a8902347af824f4ea68407d135bbb44720180514170059', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:00:59', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a205ee8b9a3d4f57bff9303e3c68126820180514171036', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:10:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6bbafec4c86c430aa908a8cb826800e720180514171452', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:14:52', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('63709e237db741c59422a58c25b4154720180514171556', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:15:56', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1ba1a99d752e4f2fb178c9e390190cb620180514171645', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:16:45', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8f2b1a1896884971b3271c2e3fe1bfbd20180514171757', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:17:57', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('783065e5217b4838b53875e09ea0829020180514172000', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:20:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('726d362f0b4f40b89f653be1bee466ae20180514172031', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:20:31', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('52f030b11c404405a50cc8aae0170ddb20180514224613', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:46:13', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ebd1e1a50dd04361b592c1baf53cfd9020180514230028', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:00:28', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 500 records committed...
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c281d693b80841a38e51d8b47eb79f6420180514231147', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:11:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b6dc442baa4945c890fd297ae6204d8020180514231423', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:14:23', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('196bc5dc7c4a4b1bb094f4737a92fc0620180515170121', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:01:21', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6b2bb43ad8744336a0738e7767fb4cc620180515171040', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:10:40', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bd6b34b379be4e0094399934060ab0cf20180515171103', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:11:03', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('37f5451464754b309ea854040e20cc5d20180516155342', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:53:42', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b4f3b2fd183642c5b23c80f071492be220180516155422', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:54:22', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9540dfb683524f8e94cf8f8c5d0c469920180516155516', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:55:16', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0315bd300f764eadbb922b9c2d566ad020180516155534', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:55:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e26b8981e27048c9877ef7860f7426ca20180516155805', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:58:05', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d564467dd49443f7b7279127688c107820180518020204', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:02:04', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fa18093d713648118844015db39d732920180514112254', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:22:54', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('44c4d5ea45a741d0ae4be0f82c59292820180514112304', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:23:04', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('170c28e281b44cefb7d1ec739bcbf5f220180514112617', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:26:17', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6a3f6650106f4d80b0ecf38f08a812bf20180514141516', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:15:16', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6c286d1dd7714c8ba9a1da9ac4963c1520180514141713', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:17:13', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f69450c3723d4daab14195c4f5c16bfa20180514141810', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:18:10', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4bc5542dbb334169aee864a8d7f3e0ee20180514142240', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:22:40', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a75150e161cd400484f9c419ef04503120180514142320', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:20', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4602504852284c18b5076355d82f79c920180514142411', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:24:11', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('464862d5b67f4e56aa54a6d37cf8de5920180514153151', '551cae096f234f6db619cd81b9244c6b20180514152446', '50', 'integral', '积分小游戏', '2018-05-14 15:31:51', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0a48b00d1f804dd0b81f3896e4b5cbb720180514170852', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:08:52', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('420f941d8894486aa9739d36741b508320180514170858', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:08:58', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e616c84abf5143a38223cbb9e30ba67020180514171630', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:16:30', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('58c31f41c9db44ca9c0d062c4631a41c20180514195304', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:53:04', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e5282cc66ae84d34b31bc1e58ce1b48720180514200413', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:04:13', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('dca9d7fd6cd6451a8636ff33b0c3298420180514203209', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:32:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('197ba1ed82454e129c58982864ee6a7520180514224635', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:46:35', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('87dbd91d429444b1801fb3510bc06a2d20180514224836', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:48:36', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('48e661a27f33469bbcc892d75aa4e19720180514225709', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:57:09', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8b7c8767ea174b7e8d8043d37b01f1d120180514230519', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:05:19', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1717f65be0494a0299b68949e18aa1ec20180514231413', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:14:13', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d0194cc69b3c41c8a3b9a0222fa5e23f20180515170941', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:09:41', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4a7615471fac4af280ad15e7115c5c5820180515171031', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:10:31', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fadc5453eed24e64833dcdcfe0d299f520180516155509', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:55:09', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f069f642f9f84db79941a52e6d5c165220180516155600', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:56:00', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('801a2d3cafc047af86bd9d5cc6382a0e20180516155629', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 15:56:29', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('49d7e83cc1fd40b9ad1a2973a458046720180518020041', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:00:41', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('218b3b3fc89142468c59f49e0310d26e20180518111501', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 11:15:01', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b514b087aee5402b94c95e497a40f72d20180514112705', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:27:05', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('01b44c3d711e4a1d875074d47d49458c20180514135346', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:53:46', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('afa493af4e2a45598fc5366628579d2c20180514141001', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:10:01', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c29ce2157f7140bca8625706691542d620180514141345', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:13:45', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9280b386c50a4fff9673a46a7fa39cbb20180514142309', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:09', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('17f85c9e2fab4217b547ccb189941d1a20180514142421', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:24:21', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e10f8248f9474a5498539338067b7e0220180514153233', '551cae096f234f6db619cd81b9244c6b20180514152446', '50', 'integral', '积分小游戏', '2018-05-14 15:32:33', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5a70d570af674bfbaa721b900bbfed7220180514162721', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:27:21', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('617f35284ff14c3ba94e282bfe93695d20180514165931', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:59:31', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('be4d4828d0934c5e9143691f96cb789e20180514165955', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:59:55', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d265bc399c4f4fb49c54fc1e0c0ad4ef20180514170034', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:00:34', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d475e361e91349d0be786388f1f7285120180514170118', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:01:18', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('631be719d01f4b90a4138890c051e42620180514170256', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:02:56', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('4f0bb2f5bddc41f3b19c2e7c78657adb20180514171008', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:10:08', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('87160b4c68854fa09297ceba34d83db720180514171039', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:10:39', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('45c26d17ba5d4a15a0010b8a7001996920180514195406', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:54:06', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0d50d37a6bf54e5abefa6975caab58a220180514195417', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:54:17', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f408a3ebcccf443e969bba052700e9cf20180514201306', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:13:06', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cebb2dab7f494419ae73c35d634422bb20180514225407', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:54:07', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('35374ce7cb3749d1939ffbbcca21ec8d20180514231136', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 23:11:36', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5ae57468d2af45fdb6728e5b338cd48520180515171110', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-15 17:11:10', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('68d2072f622f42139a7389e85c72cdf520180516092942', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:29:42', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('100e16a28ef5499caaeda50aac2be0fb20180516092948', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:29:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a7eb9d69ee524b8ea548ab2228936dcb20180516093000', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:30:00', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('771f0fa47340466f965ad7f462e2096a20180516093057', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 09:30:57', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('27d0f98433da4f90b283dc4f3855752b20180516173923', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-16 17:39:23', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9b97409f59a941cbb94ddaeb3704531020180518020155', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 02:01:55', 'oRvVat9hwiXdq2i_P21feAUH5AHs', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6174130541324dcc91c07255e6ce531420180518111429', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 11:14:29', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b8c0d86d00954757836958488f7a0ae320180518111440', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', 'integral', '积分小游戏', '2018-05-18 11:14:40', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('50fde353d2b4413fb5b17ff3b9cba9db20180514135423', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:54:23', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e6ed823400664890b1d10e836f25662120180514141409', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:14:09', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bd08c1729b58424fbd0d8d113dbb43b020180514141733', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:17:33', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('97c51ad5c9a64bf29be30b403911af1e20180514142150', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:21:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c67eb9005191457f849cdf9b3975048f20180514142224', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:22:24', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('56a1d6ff1f2e45a8949593cc55a0c5c120180514142248', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:22:48', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d15d51d69d1f413eaa2f52b1c35b5ae420180514142312', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:12', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('81b03b3153c24ce583ff86657921bf0220180514142337', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e067ad9f9a9849658db6046728390b7220180514142344', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:44', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d2cef8878abf455a9188705ff1b33adf20180514142402', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:24:02', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('61f1ccba0a10448c9b000fe1558b414f20180514142432', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:24:32', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1ff4208548f14dc6a4bbe89bad948a2820180514142450', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:24:50', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bee79cff725b4ff0a45e2420f9b51d6620180514162755', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:27:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('8bbf75a7b4f14af9a7eae17795a546e220180514170026', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:00:26', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('67da243e000c4e6398adfaf678ca808620180514170051', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:00:51', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('b73ba386bafd4dedb88969cfeed747e020180514170134', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:01:34', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('c6c8328139884412bdc0c01cd58041dd20180514170351', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:03:51', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('49dc322960684d128a6529d5c81a314320180514170620', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:06:20', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('10096565000c45b8b9f330875d91069e20180514170955', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:09:55', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('65895d31d0384fecb836358a9f43b9fa20180514171016', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:10:16', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('84a59c2c102b4d8ca1da83b18116ddd820180514171028', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:10:28', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e9c257b16c4d43cc8966298f7033ecff20180514171510', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:15:10', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5717e1ea43f84447a0a13bbd88ff496820180514171517', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:15:17', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('2668f98242fd41568607ef55ea93984c20180514171524', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:15:24', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e3373a1c70414fd9b2a5790add949bd520180514171547', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:15:47', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('28974164de6d44a1a9f86fe8acfc1c3320180514171616', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:16:16', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('01044e4d294d4e71adeee957280f7a4720180514171623', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:16:23', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('af639afc79ce4ff6b4fa7b9bf995939420180514171637', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:16:37', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('67f3ed85c8554d29a2ae8a83dbf79f1320180514171704', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:17:04', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a68d082c27744a7e94a670ab99105d4b20180514171714', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:17:14', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('383cedd3d9834ef4bedd437d5945513520180514172656', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:26:56', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('a636f9dddccc42829178b4cad89ed2cc20180514192255', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:22:55', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 600 records committed...
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('eac2741082d14824a94daf890495aea920180514214024', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 21:40:24', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('eebd49f8a240477281ee93f793d3373420180514112245', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:22:45', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('e485bc5e4e8a4f2fbcf5eafc16533f7620180514112529', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 11:25:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fc252522165f48e1bfa13f25df53335120180514132348', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:23:48', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('422741d727f44afd954b60f028a0550e20180514134819', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 13:48:19', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5106bb2a1dd74b91b737e3e750bbce9c20180514142208', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:22:08', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('34f8096740834ad8a9b29fd5617c957920180514142353', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:23:53', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ced62b76664d4ae7817ae9fa80b6517320180514142440', 'bc9333ec4cd446fd8b15e850a46a9ccc20180512175948', '30', 'integral', '积分小游戏', '2018-05-14 14:24:40', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6a269cd138ec4199a49e103d2b9139cd20180514153143', '551cae096f234f6db619cd81b9244c6b20180514152446', '50', 'integral', '积分小游戏', '2018-05-14 15:31:43', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('d3613a7eee804dbfaee071ac259d25a420180514161949', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:19:49', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('18a362dceb8741f5b63c8933ea3d56f920180514162501', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:25:01', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('cd45c738aeb74a3990cd2564eb136c4f20180514162826', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 16:28:26', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7fcd31ed5f1d4f628117a51ae86b90c720180514171054', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:10:54', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('db6ea9d8ed934ed49fe9ee2d377fcdba20180514171116', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:11:16', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('3de4033b3bf74f58a96a2223d66baf1b20180514171141', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:11:41', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('31f48f13d4c84d1aa1ee91a1370dce6c20180514171142', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:11:42', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('fcecf6bb72ea42f1b3ab8339c32e080d20180514171452', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:14:52', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('71a07ac5bdea4ef29ea89de3ce5b131c20180514171507', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:15:07', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5341cbeb082144689efdd715f4bea8b120180514171530', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:15:30', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('54303b037c9b40e381047ebab6aeed1e20180514171606', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:16:06', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('9cd844291979450490d2abf8be9427c120180514171657', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:16:57', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('6c83eeacaaee41de8732909080fff52b20180514171735', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:17:35', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('0da747a661e94a2499a1a62163b1008420180514172308', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 17:23:08', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('15097bb4a9e34cdba7c0a6b2c350bb1820180514192216', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:22:16', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('97919e015df443fba87b9eb41bffa07420180514195356', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 19:53:56', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('7d96e12e9b084f1283b7d6e2005fda5020180514200421', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:04:21', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('ac8b11fffed04640af27d883b1ed260e20180514201314', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:13:14', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f53049f5b2554761b72cec7a2d93c73a20180514203228', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:32:28', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('bc9fcc93afe7443597741f93d800acb520180514203229', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:32:29', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1cd05084a22040078b95b771ae98ab0b20180514203337', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:33:37', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('1b59d9fd258c4d798b55a434addae73020180514203707', 'c4098c63c68b4e968d04dfaf6854eda320180514154959', '20', 'integral', '积分小游戏', '2018-05-14 20:37:07', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('989bf5a20c9d4bf38133226eed7186c420180514222947', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:29:47', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('f075c4a610334487ae91489f98131fa620180514223133', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:31:33', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into JOINACTIVITY (id, integralid, join_integral, activitymark, activityname, jointime, openid, sellerpublicnumberid)
values ('5fc536e6da87416e97e9371df2cca4f120180514223143', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', 'integral', '积分小游戏', '2018-05-14 22:31:43', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 634 records loaded
prompt Loading LOG_INFO...
prompt Table is empty
prompt Loading SYS_CONFIG...
prompt Table is empty
prompt Loading SYS_MENU...
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b76', '活动审批', '/approve', '2017-08-09 15:15:53', '2017-08-09 15:15:53', '活动审批信息', null, '/img/index/shengpi-icon.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b75', '系统设置', '/system', '2017-08-09 15:15:54', '2017-08-09 15:15:54', '系统设置信息', null, '/img/index/shezhi-icon.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('db9f0b905d3a4dcb9a6da2a0324ba9b74', '我的活动', '/activity', '2017-08-09 15:15:50', '2017-08-09 15:15:50', '我的活动信息', null, '/img/index/my-activities-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('2ec1354c3c794b6ab3dad2d3e0189b1b', '活动申请', '/activityApply', '2017-08-09 15:15:51', '2017-08-09 15:15:51', '活动申请信息', null, '/img/index/apply-for-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('a076e99766b74001b0154b9d378e0065', '活动报表', '/activityForm', '2017-08-09 15:15:52', '2017-08-09 15:15:52', '活动报表信息', null, '/img/index/statement-ICON.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('b354e99766b74001b0154b9d378e0890', '公众号配置', '/publicNumber/index', '2017-08-19 15:15:52', '2017-08-19 25:15:52', '公众号配置', null, '/img/index/weixinshezhi.png', '0');
insert into SYS_MENU (id, name, href, create_date, update_date, remarks, parent_id, img, delflag)
values ('q2e4e99766b74001b0154b9d378ef925', '报表分析', '/scanCount', '2017-08-29 15:15:56', '2017-08-29 15:15:52', '报表分析', null, '/img/index/statement-ICON.png', '0');
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
values ('2b39e87d086b4086bf84220f05583683', '砸金蛋', '/image/zadan-img.png', '/breakEggConfig/goToBreakEgg', 'breakEgg', '2017-11-1 13:38:07', '/breakEggConfig/goApproveList', '/breakEggConfig/berakEggReport', '/breakEggConfig/myAllEggActivity', '/breakEggConfig/breakEggActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84227875772154', '一元购', '/image/yiyuangou-img.png', '/oneMoneyShopConfig/oneMoneyShopEidt', 'oneMoneyShop', '2017-11-1 13:38:08', '/oneMoneyShopConfig/goApproveList', '/oneMoneyShopConfig/oneMoneyReport', '/oneMoneyShopConfig/myAllOneMoneyActivity', '/oneMoneyShopConfig/oneShopActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f04083684', '拼图小游戏', '/image/pingtu-img.png', '/puzzleConfig/puzzleEdit', 'puzzle', '2017-11-1 13:38:09', '/puzzleConfig/goApproveList', '/puzzleConfig/puzzleReport', '/puzzleConfig/myAllPuzzleActivity' || chr(10) || '', '/puzzleConfig/puzzleActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f05083555', '拼团', '/image/pingtuan-img.png', '/groupPurchaseConfig/groupPurchaseEdit', 'groupPurchase', '2017-11-1 13:38:10', '/groupPurchaseConfig/goApproveList', '/groupPurchaseConfig/purchaseReport', '/groupPurchaseConfig/myAllGroupPurchaseActivity', '/groupPurchaseConfig/purchaseActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('58a8781c51154c899023734cccf9c608', '分享砍价', '/image/kanjia-img.png', '/shareBargainConfig/shareBargainConfigUpdate', 'shareBargain', '2017-11-1 13:38:01', '/shareBargainConfig/approveShareBargain', '/shareBargainConfig/shareBargainReport', '/shareBargainConfig/shareBargainActivityByUserId', '/shareBargainConfig/shareBargainActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f04083683', '抢红包', '/image/hongbao-img.png', '/robRedConfig/robRedConfigUpdate', 'robRed', '2017-11-1 13:38:02', '/robRedConfig/redRobApprove', '/robRedConfig/redRobReport', '/robRedConfig/allMyActvity', '/robRedConfig/redActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('ba13fff2da9f4fdd8bf7e3c8d2b63da7', '转盘抽奖', '/image/zhuanpan-img.png', '/turntableConfig/activityEdit', 'turntable', '2017-11-1 13:38:03', '/turntableConfig/turntableApproval', '/turntableConfig/turntableReportAll', '/turntableConfig/turntableMyAllActivity', '/turntableConfig/turntableMyAllActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f88899984', '刮刮乐', '/image/guaguale-img.png', '/scratchCardConfig/scratchCardUpdate', 'scratchCard', '2017-11-1 13:38:04', '/scratchCardConfig/scratchCardApproval', '/scratchCardConfig/scratchCardReportAll', '/scratchCardConfig/scratchCardMyAllActivity', '/scratchCardConfig/cardActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('5489e12d896b9654bf8a360f0ae8d514', '集赞', '/image/jizan-img.png', '/accumulateFabulousConfig/accumulateEdit', 'accumulateFabulous', '2017-11-1 13:38:06', '/accumulateFabulousConfig/accumulateApprove', '/accumulateFabulousConfig/accumulateReport', '/accumulateFabulousConfig/myAccumulate' || chr(10) || '', '/accumulateFabulousConfig/accumulateActivityJson');
insert into TB_ACTIVITY (id, activity_name, img, href, remarks, update_date, approvehref, reporthref, activityhref, integral_choice_href)
values ('2b39e87d086b4086bf84220f04083682', '积分兑换', '/image/jifenduihuan-img.png', '/integralConfig/integralConfigUpdate', 'integral', '2017-11-1 13:38:05', '/integralConfig/approveIntegral', '/integralConfig/integralReportAll', '/integralConfig/MyIntegralActivity', null);
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
values ('4352e9f212544ea1ae14adb69718da9a20180126153838', '圆通快递', 'yt');
insert into TB_EXPRESS (id, name, remark)
values ('3baee1a220bf4c75b7529e6d6c73f88d20180126162054', '中通快递', 'zt');
insert into TB_EXPRESS (id, name, remark)
values ('3599601dd701466db11b85fefa069f2220180126163052', '顺丰速运', 'sf');
insert into TB_EXPRESS (id, name, remark)
values ('eb2264d51ab943dca2c974f1cf3938c020180202114230', '现场领奖', null);
insert into TB_EXPRESS (id, name, remark)
values ('ad78e196650d4fe6bea52c604683b0e820180330152649', '菜鸟驿站', 'cn');
insert into TB_EXPRESS (id, name, remark)
values ('b043effd72fa4df0843e266aec80369820180330152740', '韵达快递', 'yd');
insert into TB_EXPRESS (id, name, remark)
values ('535a73b220844c5cb26edf2b861a34a720180205163306', '德邦物流', null);
insert into TB_EXPRESS (id, name, remark)
values ('d49e7c76ad984100b55137c16600538620180330152728', '天天快递', 'tt');
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
insert into TB_INTEGRAL (integral_id, sign_integral, background_img, belong_activity_id, moblec_background_img, acitivity_launch_userid, acitivity_launch_usercode, join_prople_number, winning_prople_number, state, create_time, comfirmuserid, comfirmtime, comfirmadvise, comfirmusername, applyphone, applyusername, total, spare_one, spare_two, need_integral)
values ('c20aac6716654310a68fbbea0d38e13d20180515170042', '1888', '/image/jifenduihuan-img.png', '2b39e87d086b4086bf84220f04083682', '/upload/jifenduihuan-bg.png', '701', '100651', null, null, '1', '2018-05-15 17:00:42', '-1', '2018-05-15 17:01:00', 'ok', '系统管理员', '13888888888', '品牌商一', null, null, null, '35');
commit;
prompt 1 records loaded
prompt Loading TB_INTEGRAL_ACTIVITY...
prompt Table is empty
prompt Loading TB_INTEGRAL_EXCHANGE...
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('9a649c7cb1344dbfaea805fdc5d442f520180514231110', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', null, '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-14 23:11:10', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('b29c6f2ce08e491d93aa8c650403f78a20180514231136', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-14 23:11:36', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('7addffd485fa40ae947bf390c42caaf920180514231147', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '很失败', '北京市北京市东城区汉拿山', '13499785197', '4', '品牌商一', '701', '100651', 'DSAFFA', '顺丰速运', '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-14 23:11:47', '2018-05-14 23:17:41', null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('fc044f75aacb4959aba048b630c80c5d20180514231423', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', null, '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-14 23:14:23', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('a0ba64545fe14b8e87c505fe5957c9d620180515232337', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '陈小兵', '四川省成都市武侯区地铁1号线世纪城[地铁站]', '15878089562', '3', null, null, null, null, null, null, '从小丘西行百二十步隔篁竹闻水声', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFwAhvcBf4n9f4dibraOURqCR6qf9UekX63gicUoh7f4RbPpLy8qWcRy36GicX0wIl65sR0wz07T0wDP4pibDdY2tg4K/132', '2018-05-15 23:23:37', null, '71a903945eab413580949844e815d59920180515232337', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('730f9fe624064678b80ec22d8ed7724620180516092948', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '青程钢', '四川省成都市双流县三利云锦', '18482101665', '3', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:29:48', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('6ab98bd7b51144a9ac9c60bea2ffb5f520180516093028', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:30:28', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('98a946cd5b534e0c9b76109b51beea3020180516093040', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:30:40', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('7a82b45482a2411aa3a5ea396fa3760c20180516093117', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:31:17', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('e524480ee33944878a315659df1ac23720180516155342', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:53:42', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('b8e0b5a9e4d1428fa54b2320986806be20180516155534', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:55:34', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('bfb09ef2a8c24d07ab169d847b459f2520180518020056', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:00:56', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('6370f0d275f74964a805fcdea9acddb620180518111358', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, null, '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 11:13:58', null, '6fcf3a11ef744e5ea831884f768465de20180518111358', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('d56845cc52e34a7989691fee0ee3b39520180514230519', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/3Dhua-0.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '陈小兵', '四川省成都市武侯区地铁1号线世纪城[地铁站]', '15878089562', '4', '品牌商一', '701', '100651', '3333', '中通快递', '积分参与小游戏', '从小丘西行百二十步隔篁竹闻水声', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFwAhvcBf4n9f4dibraOURqCR6qf9UekX63gicUoh7f4RbPpLy8qWcRy36GicX0wIl65sR0wz07T0wDP4pibDdY2tg4K/132', '2018-05-14 23:05:19', '2018-05-14 23:05:37', null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('c94ff5cda8464af2b3378e019c1f1e5220180514231717', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '陈小兵', '四川省成都市武侯区地铁1号线世纪城[地铁站]', '15878089562', '4', '品牌商一', '701', '100651', 'DFASF', '中通快递', '积分参与小游戏', '从小丘西行百二十步隔篁竹闻水声', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFwAhvcBf4n9f4dibraOURqCR6qf9UekX63gicUoh7f4RbPpLy8qWcRy36GicX0wIl65sR0wz07T0wDP4pibDdY2tg4K/132', '2018-05-14 23:17:17', '2018-05-14 23:17:35', null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('ee87883c658148e69c47900b55fde97020180515105752', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-15 10:57:52', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('91d586eb25754555af7270d0cc313a3020180515115222', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVat-1GjA2Tph66j0XHFlAy5Ts', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '超', 'http://thirdwx.qlogo.cn/mmopen/mYV4XUK0fyuIGDibQZfDyWL1jHia7rngg3P7u8v6qtM7Nmqj5ib41uIYiagWjueqLricCwea4x4doKvpialc8Thdg3aQNIMKP2EnuH/132', '2018-05-15 11:52:22', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('3df96f6b0c5049609cb46651e29fb36720180516093000', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:30:00', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('7580a2f499974f89a06f11794a95dc1320180516102728', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 10:27:28', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('c19885cb4b744d899f6576939a5e5fad20180516155326', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:53:26', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('3ee0fd70e3fb40b49ac39ccba68108ac20180516155422', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/3Dhua-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:54:22', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('0ccf9aec20b241d28bc6160e5e58896520180516155600', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/3Dhua-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:56:00', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('c564a4fee7ca45a78c11ba932fbcb80620180516155805', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:58:05', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('57ad063b5a8f4825a489c07eac255f1b20180516173923', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 17:39:23', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('b25c4d7a837b4441b12de0255ac831a920180518015900', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat9hwiXdq2i_P21feAUH5AHs', '小天', '山东省菏泽市郓城县黄集乡辛庄村000', '18653083883', '3', null, null, null, null, null, null, '骚的要有贞操', null, '2018-05-18 01:59:00', null, 'a42795d3c30a4273b278d8e962a762cf20180518015900', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('391ce1f8ef7f4f18b08916e92f91c2f020180518015956', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 01:59:56', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('a48ba02fe4304665a5e1a855db97519620180518020000', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat9hwiXdq2i_P21feAUH5AHs', '小天', '山东省菏泽市郓城县黄集乡辛庄村000', '18653083883', '3', null, null, null, null, null, null, '骚的要有贞操', null, '2018-05-18 02:00:00', null, 'f55ae93a465441029df3320e81fbf02e20180518020000', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('be89429269b745ccb92a59b30498fbf720180518020041', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:00:41', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('ad0d4abeef404d69afee63c775dbde7220180518020204', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:02:04', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('9a77294334b54cb3a1efe629afa449a420180514225652', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/3Dhua-0.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '青程钢', '四川省成都市双流县三利云锦', '18482101665', '4', '品牌商一', '701', '100651', '32432', '现场领奖', '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-14 22:56:52', '2018-05-14 23:09:20', null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('ec9ac361adb14fce90d12e44d47333b920180514231126', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', null, '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-14 23:11:26', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('e749a375113247139a6aa287f6bd61a720180514231413', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', null, '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-14 23:14:13', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('d5fd5f0e30e64379a8e68287436e0ba420180514231431', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/3Dhua-0.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-14 23:14:31', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('dd81af8153ae461a9d76cf8dce5fba0720180515170121', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-15 17:01:21', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('9c5a167eb0a74afc973f1f54f700574520180515171040', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-15 17:10:40', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('5c14c32745b9476281f3f3db4e2feba220180516093019', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:30:19', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('95566552c2da41019d2d563828e8923620180516093106', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:31:06', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('bb42ea50f66247c3b2c340a4439b99c920180516155509', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:55:09', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('f966e9d3e6dc4cc2953da26f25ebbcec20180516155516', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:55:16', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('7cce437167544a0fbfbc4fec0d83f4fc20180516155629', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:56:29', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('a28a930f68f940c28bb0f40f1385d89e20180516155737', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', '7a3da1211f17471287caf6ec099fdf2d20180515170042', '35', '武汉到是', '/upload/5liangchun.png', '1', null, null, 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '很失败', '北京市北京市东城区汉拿山', '13499785197', '4', '品牌商一', '701', '100651', '321v ', '中通快递', null, '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:57:37', '2018-05-16 16:01:38', 'c5801e5cdadc48ef90c2fb9691e01f3620180516155737', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('995636d061054f5cbd3daf14dc10777220180518104831', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, null, '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 10:48:31', null, '33023dbaab3d403f86579dd47cabe19f20180518104831', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('d20f55d39c1e4fcab3758fa55ffce0a820180518110114', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, null, '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 11:01:14', null, 'edc98a10583c42dcaefe5e2f214dc60220180518110114', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('ab50113548ea4ce29236e15a4363a64620180518111501', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 11:15:01', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('ceed2a90961e4fc4bcfccb1c56583fe620180514224635', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '从小丘西行百二十步隔篁竹闻水声', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFwAhvcBf4n9f4dibraOURqCR6qf9UekX63gicUoh7f4RbPpLy8qWcRy36GicX0wIl65sR0wz07T0wDP4pibDdY2tg4K/132', '2018-05-14 22:46:35', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('e9beec1d91c44e43acbe6a861b1a197520180514224852', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChyo0ylrfvPmct1gwa43MSBI69Y461yDia1oW6qCwJEsdZ4sqcZ6zCibdF5Duo89ib0KAFdWwicrVg9Lxeqibn0g3JEy7/132', '2018-05-14 22:48:52', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('1a100dae1947435d8bba41f064bfb23b20180514225407', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '从小丘西行百二十步隔篁竹闻水声', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFwAhvcBf4n9f4dibraOURqCR6qf9UekX63gicUoh7f4RbPpLy8qWcRy36GicX0wIl65sR0wz07T0wDP4pibDdY2tg4K/132', '2018-05-14 22:54:07', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('52a98f4978fe4379ab2d23deb53fef4620180514230028', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '从小丘西行百二十步隔篁竹闻水声', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFwAhvcBf4n9f4dibraOURqCR6qf9UekX63gicUoh7f4RbPpLy8qWcRy36GicX0wIl65sR0wz07T0wDP4pibDdY2tg4K/132', '2018-05-14 23:00:28', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('18799596189a4fc9b52694ccc244c97220180515073857', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwa2sxv6CCTSM1RBwVPqTn0', '陈小兵', '四川省成都市武侯区地铁1号线世纪城[地铁站]', '15878089562', '3', null, null, null, null, null, '积分参与小游戏', '从小丘西行百二十步隔篁竹闻水声', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFwAhvcBf4n9f4dibraOURqCR6qf9UekX63gicUoh7f4RbPpLy8qWcRy36GicX0wIl65sR0wz07T0wDP4pibDdY2tg4K/132', '2018-05-15 07:38:57', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('94d1cb77d3364bc3a6f25e593e31db8120180515134653', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/3Dhua-0.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-15 13:46:53', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('92e86a7b12cd45c48179c67e99daaf8920180515170137', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '青程钢', '四川省成都市双流县三利云锦', '18482101665', '3', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-15 17:01:37', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('1ed7be53d11747408070e51e41b152fd20180515170941', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-15 17:09:41', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('1c0801e564414c1c8aa614021d7e6ec320180515171031', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-15 17:10:31', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('4c568aa6513c4eeaa0667ceab17ee5ca20180515171110', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-15 17:11:10', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('2c44e5941e15461daf98cbbbcbcfd90f20180516155242', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '很失败', '北京市北京市东城区汉拿山', '13499785197', '4', '品牌商一', '701', '100651', '789456', '顺丰速运', '积分参与小游戏', '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:52:42', '2018-05-16 16:01:54', null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('b4d7417f50bd4a52a7a7b004ab22763e20180516155456', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:54:56', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('1b2a30d9061b415295390b7566d1ec4e20180516155502', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', '很失败', '北京市北京市东城区汉拿山', '13499785197', '3', null, null, null, null, null, null, '唐唐', 'http://thirdwx.qlogo.cn/mmopen/jsWpDSQgSFxqTCAJUt4BianomFGKsIHG9iaKAn37r0pUEzBVqglbfpKz62eAXQwnhjD18yDCVkbYskUIYjRZTgWnEhEfdicSvJq/132', '2018-05-16 15:55:02', null, '94a8380c0d414d54891e6fea865378dd20180516155502', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('476915b8e2a94313826588d57b02de3b20180516155903', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, null, '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:59:03', null, '50092fdf2ee04696a763a8ad3115d93c20180516155903', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('b9a71ac6ee6746ba9320d014ce21ebb020180518020132', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:01:32', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('6e4480731fcd4430856bc77ddc95683c20180514224836', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '10', '积分小游戏', '/upload/chaxianban-01.png', '1', '79098d7ce60c4db4a39bdb68c3b7b62520180514213841', '积分小游戏', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '唐', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChyo0ylrfvPmct1gwa43MSBI69Y461yDia1oW6qCwJEsdZ4sqcZ6zCibdF5Duo89ib0KAFdWwicrVg9Lxeqibn0g3JEy7/132', '2018-05-14 22:48:36', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('2801158cd04642beaafe7366be2443fd20180515170129', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-15 17:01:29', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('5a583c14953e424ea91bd0ae8b12c3fd20180515171103', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-15 17:11:03', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('da47631542374b38bae7ee04b7151a8020180516093057', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '鱼', 'http://thirdwx.qlogo.cn/mmopen/KH4qQ6hIChw7dpATxbkShucegXVDEOr48SYVgcNqLhRicADL0goNvqK5XZZ6zgianyc2MkSKZOK8gb7kjkqyxwRfgSICXjCst5/132', '2018-05-16 09:30:57', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('baee46fbdca9407cbb12e228843c02e220180516155610', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/3Dhua-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:56:10', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('3a4e794ce9ac474abcc5d3e96a42e54e20180516155841', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 15:58:41', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('eed191f7802d4f19922c91e10c7ce43f20180516173951', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 17:39:51', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('325a3440e3ba4d0e80a8267c692cf50420180516174023', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/3Dhua-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-16 17:40:23', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('d0c34532ee9d4f06982eaf66721a6de920180518020019', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:00:19', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('6d9dd352cbfa4ad3888a5b9dfc681ce720180518020119', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/3Dhua-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:01:19', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('0fb06ff71af34d958ac4374a34af658d20180518020145', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:01:45', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('1a2e84b14d4545639ce18236ee9b8add20180518020155', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/hongjiu-0.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat9hwiXdq2i_P21feAUH5AHs', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '骚的要有贞操', null, '2018-05-18 02:01:55', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('a609c159ca6944a6aa1c4584a1f7351d20180518104732', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, null, '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 10:47:32', null, '068610130d02469eb32bc9c7acd48ef820180518104732', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('d47dac3884d54685acfb88ac5f97d65c20180518111231', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '2', 'bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', '20', '五粮醇大淡雅', '/upload/1526374842657.jpg', '1', null, null, 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, null, '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 11:12:31', null, '5a3bd271cfb44b109d18b7765eb192fc20180518111231', '7f04f5b8af8248b9b83a74aff6c607d620170915141439', null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('9c2e97ec9dc1490684414549e120b4e620180518111429', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', null, '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', null, null, null, '1', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 11:14:29', null, null, null, null, null);
insert into TB_INTEGRAL_EXCHANGE (integral_exchange_id, integral_id, exchange_type, exchange_prize_id, exchange_use_integral, exchange_prize_name, exchange_prize_img, exchange_prize_number, ten_activity_id, ten_activity_name, openid, addressee_name, addressee_address, addressee_phone, state, lssue_user_name, lssue_user_userid, lssue_user_usercode, deliver_number, deliver_company, qrcode, nickname, headimgurl, create_time, deliver_time, product_winning_info_id, belong_publicnumber_id, spareone, sparetwo)
values ('56aba61b5da44546bcc0ca60ce181f1920180518111512', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '35', '积分小游戏', '/upload/chaxianban-01.png', '1', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '妖怪君', '四川省成都市锦江区狮马路4号', '18780274871', '3', null, null, null, null, null, '积分参与小游戏', '妖妖妖怪君', 'http://thirdwx.qlogo.cn/mmopen/PiajxSqBRaELxFavluOzaicUwHkulcKBHN8ia7NmcEs1KVZsiaJOJKZYAvicopvxF4WNA2g4zQQ5csDENp9QVCrWMsg/132', '2018-05-18 11:15:12', null, null, null, null, null);
commit;
prompt 75 records loaded
prompt Loading TB_INTEGRAL_PRIZE...
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('6bea331534b143f1aaefa2569369ca9a20180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '插电板', '1', '50', null, '/upload/chaxianban-01.png', '1');
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('0d47300571544f998d1eb0bd9fc5234820180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '画', '1', '30', null, '/upload/3Dhua-0.png', '2');
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('6342d65a97784b2bb87650e5a95d78fa20180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '红包', '3', '30', '0.01', null, '3');
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('7cc49eecb48a45ebaae09d9e7fed3b0520180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分', '2', '30', '200', null, '4');
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('cec09c53bcee49cb8e24c6fbb860c14220180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '谢谢惠顾', '4', '30', null, null, '5');
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('09cc8ac2ddc94d2ab7005b95308f3c7420180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '红包', '3', '30', '0.02', null, '6');
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('d3d2b315eb8749f98a8bc7e55c796fe520180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分', '2', '30', '33', null, '7');
insert into TB_INTEGRAL_PRIZE (id, integral_id, name, type, weight, info, picture, grade)
values ('8b5a211ec31a44cc817888439f8191b820180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '红酒', '1', '30', null, '/upload/hongjiu-0.png', '8');
commit;
prompt 8 records loaded
prompt Loading TB_INTEGRAL_PRODUCT...
insert into TB_INTEGRAL_PRODUCT (id, integral_id, order_number, agent, product_id, product_img, product_name, product_number, product_introduce, need_integral, spec, degree, volume, surplus_product_number)
values ('bf7c2affa82c4d79ab1bb7ae41eb0b2720180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '01', '1', '351', '/upload/1526374842657.jpg', '五粮醇大淡雅', '20', null, '20', '6', '55', '750', '10');
insert into TB_INTEGRAL_PRODUCT (id, integral_id, order_number, agent, product_id, product_img, product_name, product_number, product_introduce, need_integral, spec, degree, volume, surplus_product_number)
values ('7a3da1211f17471287caf6ec099fdf2d20180515170042', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '01', '2', null, '/upload/5liangchun.png', '武汉到是', '20', '文档按时 ', '35', null, null, null, '19');
commit;
prompt 2 records loaded
prompt Loading TB_INTEGRAL_WINNING_INFO...
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('7b8360b975d64b088141ea3f45ca176920180516173920', 'a260ca409411483bb4dd24f8332de4a020180516173920', '积分签到', 'integral', '1888', '2018-05-16 17:39:20', '0', '0', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', 'f3cd41f8c92f462eae34e6c37ba6df0620180516173847', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('b312e9c542e74f97bdcc486e2892021620180516175336', 'bf24af3f6d5740a8b59641876a1a8fcf', '测试活动', 'robRed', '10', '2018-05-16 17:53:36', '2018-05-16', '2018-05-31', 'oRvVaty-lDNYjPT0lpmCvTlEfOvA', 'e25460d253ba47ff8cbea43e7d621ff620180516175333', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('ab15c277964b43e7b1a75f555c10e13620180517164008', 'b19d9e0c842843399220ec03e217f27620180517163126', '幸运刮刮乐', 'scratchCard', '100', '2018-05-17 16:40:08', '0', '0', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '885711e250354d92b77a3b603cf340c220180517164007', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('8e4d96a90a1444b4b20bb9b1c54e9e2920180516175703', 'bf24af3f6d5740a8b59641876a1a8fcf', '测试活动', 'robRed', '10', '2018-05-16 17:57:03', '2018-05-16', '2018-05-31', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '09774cc4ebe8440f94461f822920821e20180516175659', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('a776a34dd9fd41c0bd981d1393012ab2', '65fac51aec4f4d7da4822a1642e79b9420180517160733', '测试活动', 'turntable', '20', '2018-05-17 16:10:32', '0', '0', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', 'e325f82554464178aa194efa09b0d9f620180517161027', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('5517dd168db942ab82fe6ab2ed144550', '65fac51aec4f4d7da4822a1642e79b9420180517160733', '测试活动', 'turntable', '20', '2018-05-17 17:58:22', '0', '0', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', 'a8c4878607e14cc0959896da63c7859120180517175821', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('ad0d4abeef404d69afee63c775dbde7220180518020204', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'nine_Grid', '200', '2018-05-18 02:02:04', '0', '0', 'oRvVat9hwiXdq2i_P21feAUH5AHs', 'a8c7091e790140159589d10c7fb9ff4c20180518015720', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('ab50113548ea4ce29236e15a4363a64620180518111501', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'nine_Grid', '200', '2018-05-18 11:15:01', '0', '0', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', 'f3cd41f8c92f462eae34e6c37ba6df0620180516173847', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('c00223d0c4e4411587a953797b49c14e20180516173902', 'bf24af3f6d5740a8b59641876a1a8fcf', '测试活动', 'robRed', '10', '2018-05-16 17:39:02', '2018-05-16', '2018-05-31', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', 'b34d53754337408188db977c0537a0f720180516173847', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('81301282b57a403092938ff160b25b0320180517155330', '37d2c7f289f34da6a814dd85e77b5b3d', '测试活动', 'robRed', '10', '2018-05-17 15:53:30', '2018-05-17', '2018-05-31', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', 'ed4c6cdc6bcf4560874add668d151c6e20180517155312', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('f30cf1f7f0074ddca6e82c3abf793aac20180516175451', 'bf24af3f6d5740a8b59641876a1a8fcf', '测试活动', 'robRed', '10', '2018-05-16 17:54:51', '2018-05-16', '2018-05-31', 'oRvVatwOvZ8pg_71q-hURUzqwVJQ', '8424de2603dd48c9bc06cc7c1deffb7620180516175446', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('5ad222f858ab41bba893b8783d810a2c20180516175541', 'bf24af3f6d5740a8b59641876a1a8fcf', '测试活动', 'robRed', '10', '2018-05-16 17:55:41', '2018-05-16', '2018-05-31', 'oRvVat8fOLEokjzJgmRiIibqJ1bg', '7e49fe5b18414410b0bc6ac98a84592320180516175538', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('6d3d27e2feba4e36ac392eafd8bc544b20180517163406', 'b19d9e0c842843399220ec03e217f27620180517163126', '幸运刮刮乐', 'scratchCard', '100', '2018-05-17 16:34:06', '0', '0', 'oRvVat2FoIrexhM8z546Uq9t8Ttw', '3b4d06e6b04249218874b81686903cd720180517163354', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('27fd3ca27fcb49f4819cf8d6c0b7237020180518015744', '2260a3c63fe7410f94eeb573b4ec2ecd20180518015744', '积分签到', 'integral', '1888', '2018-05-18 01:57:44', '0', '0', 'oRvVat9hwiXdq2i_P21feAUH5AHs', 'a8c7091e790140159589d10c7fb9ff4c20180518015720', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
insert into TB_INTEGRAL_WINNING_INFO (id, belong_activity_id, activity_name, activity_name_type, winning_integral, create_time, starttime, endtime, openid, activity_wxuser_id, belong_publicnumber_id)
values ('b9a71ac6ee6746ba9320d014ce21ebb020180518020132', 'c20aac6716654310a68fbbea0d38e13d20180515170042', '积分小游戏', 'nine_Grid', '33', '2018-05-18 02:01:32', '0', '0', 'oRvVat9hwiXdq2i_P21feAUH5AHs', 'a8c7091e790140159589d10c7fb9ff4c20180518015720', '7f04f5b8af8248b9b83a74aff6c607d620170915141439');
commit;
prompt 15 records loaded
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
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company, scan_img, logo)
values ('7f04f5b8af8248b9b83a74aff6c607d620170915141439', '玖孚科技', 'wx3db6ea684d097397', 'cefef93ff906edaecb135e17dab1d878', '/upload/qrcode.png', '1445165502', 'BD5795D634ED6738117018F949C8B46B', null, null, '100651', 'JFfwsy', 'aAmrKzgYCDBsYTgwGJn_a04O8l_2OgcZ94_CnvHN8MY', '玖孚科技', '玖孚科技恭喜您', '玖孚科技祝福您', '701', 'BteyqG-wKKhjVt5REqiTHDQKCHg0t0kRoPDsFOBccP0', 'BOykU2jxeeUGvDe6_Yoeq9eA0wtQx9a_0ZHmoVmEdkc', '普拉斯', '/upload/bg.png', null);
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company, scan_img, logo)
values ('ec91f66c6fed42d487cb13551caa502220171120152026', '普什3D', 'wx92eab958dc8a82d1', 'b023def5423db45378c2def96437cb3b', '/upload/b3.png', '1284056801', null, null, null, '100666', 'push3dweixin', 'YTbbDHJub8JkuWY4gi2PhMd15B0G_W2nb49z5vzgZoU', '普什3D', '发红包祝福语', '普什3D红包', '708', null, null, null, null, null);
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
values ('634bc6b3855a48d2a72f0ec2d7d177ba20180511151139', '/upload/3Dhua-0.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('1edd1bac3a504ecd832bf21f40f4046a20180511151205', '/upload/hongjiu-0.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('d5b73eb7405c4140b9206f917a9b274320180516142148', '/upload/u=2024874167,1012015013&fm=27&gp=0.jpg', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('fe52185c9f0845729743cf99db338ec320180512155921', '/upload/qrcode.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('4e060f8b8bc04d7c93493a53a8d1067e20180512175811', '/upload/qrcode.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('f9fe63cf52f840d0aa9e6c7ec759a7b020180512200409', '/upload/1526126445823.jpg', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('8539d82fa15a4aa3973921576555038720180514154555', '/upload/3Dhua-01.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('ecc6f6d4c06049b2a84bbb388e2fe8ca20180514154559', '/upload/1218-02.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('184b034dc8db4577a95e4968c2c5cd4420180515103117', '/upload/liangchun.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('54c27485360e4d31bed25f8b153fa0e720180514154619', '/upload/jiuzhenbaoxiaojiu-0.png', 'admin', '-1', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('cdd4cbf26fef460491c33a6bf8c18ad720180514165543', '/upload/ok.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('23c4aacf75c1428ab904507a4447f33720180514170841', '/upload/dd.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('4f99814c83264d9c973892c3917072bc20180516142215', '/upload/2.png.jpg', '100651', '701', null);
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
values ('415a7bebd8d349ac8adb8e468ebf3d5e20180511151201', '/upload/1218-01.png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('d29bebee831f4dd9bf07b91f57c1bcc820180514170250', '/upload/bg (2).png', '100651', '701', null);
insert into UPLOAD_IMG (id, img_url, usercode, userid, spare_one)
values ('a41b261bbb97469abed972ae6800271920180514170340', '/upload/bg (2)1.png', '100651', '701', null);
commit;
prompt 22 records loaded
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
