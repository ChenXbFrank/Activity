prompt PL/SQL Developer import file
prompt Created on 2018年5月7日 by Administrator
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
values ('7f04f5b8af8248b9b83a74aff6c607d620170915141439', '玖孚科技', 'wx3db6ea684d097397', 'cefef93ff906edaecb135e17dab1d878', '/upload/qrcode.png', '1445165502', 'BD5795D634ED6738117018F949C8B46B', null, null, '100651', 'JFfwsy', 'aAmrKzgYCDBsYTgwGJn_a04O8l_2OgcZ94_CnvHN8MY', '玖孚科技', '玖孚科技恭喜您', '玖孚科技祝福您', '701', 'BteyqG-wKKhjVt5REqiTHDQKCHg0t0kRoPDsFOBccP0', 'BOykU2jxeeUGvDe6_Yoeq9eA0wtQx9a_0ZHmoVmEdkc', '普拉斯');
insert into TB_SELLER_PUBLICNUMBER (id, publicnumber_name, appid, appsecret, publicnumber_qrcode_img, shop_number, pay_key, spare_one, spare_two, seller_usercode, token, winning_news_id, sendername, wish, remarks, seller_userid, sendid, successid, company)
values ('ec91f66c6fed42d487cb13551caa502220171120152026', '普什3D', 'wx92eab958dc8a82d1', 'b023def5423db45378c2def96437cb3b', '/upload/b3.png', '1284056801', null, null, null, '100666', 'push3dweixin', 'YTbbDHJub8JkuWY4gi2PhMd15B0G_W2nb49z5vzgZoU', '普什3D', '发红包祝福语', '普什3D红包', '708', null, null, null);
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
