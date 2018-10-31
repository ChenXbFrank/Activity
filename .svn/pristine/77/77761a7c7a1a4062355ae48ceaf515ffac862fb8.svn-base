package com.activity.common.service.turntable;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.centerObjcet.turnTable.AgentTurnTable;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.model.system.SystemUser;
import com.activity.common.model.turntable.TurnTable;
import com.activity.common.model.turntable.TurnTablePrize;
import com.activity.common.model.turntable.TurnTableWxUser;
import com.activity.common.model.turntable.TurnTableWxUserWinning;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.probability.ProbabilityUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.alibaba.fastjson.JSON;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Record;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TurntableService {
	private final Logger log = LoggerFactory.getLogger(TurntableService.class);
	private static TurntableService Service = new TurntableService();
	public TurntableService() {}
	public static TurntableService getService() {return Service;}
	ProbabilityUtils probabilityUtils = ProbabilityUtils.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IndexService indexService = IndexService.getService();
	IntegralService integralService = IntegralService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	DateUitils uitils = DateUitils.getUitils();
	WxService wxService = WxService.getService();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param turntableActivityID
	 * @param qrcode
	 * @return
	 */
	public String TurntableActivity(String turntableActivityID, String qrcode) {
		TurnTable sb = TurnTable.dao.findById(turntableActivityID);
		DateUitils.getUitils();
		// 判断是否属于活动时间内
		Date startDate = DateUitils.strToDateYMD(sb.getStartTime());
		Date endDate = DateUitils.strToDateYMD(sb.getEndTime());
		// 判断当前时间是否大于活动开始时间 返回fasle表示小于当前时间，代表活动已经开始
		boolean startTime = DateUitils.isDateBefore(startDate);
		// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
		boolean endTime = DateUitils.isDateBefore(endDate);
		String redirect = "";
		// 判断活动是否审批通过
		if (sb.getState().toString().equals("1")) {
			if (startTime) {
				// 活动未开始
				System.out.println("活动未开始");
			} else {
				// 活动已经开始
				System.out.println("活动已经开始");
				if (endTime) {
					System.out.println("活动活动未结束  ");
					// 活动未结束
					/**
					 * 1.进入这里代表当前人可参加当前活动 2.获取活动发起者经销商公众号配置
					 */
					// 活动发起人的userCode
					String userCode = sb.getAcitivityLaunchUserCode();
					// 活动发起人的公众号信息
					List<SellerPublicNumber> sellerPublicNumberList = SellerPublicNumberService.getService()
							.getPublicNumberByUsercode(userCode);
					SellerPublicNumber spn = new SellerPublicNumber();
					for (SellerPublicNumber spnErgodic : sellerPublicNumberList) {
						spn = spnErgodic;
					}
					System.out.println("重定项");
					// 重定向
					redirect = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
							+ "&redirect_uri=http%3a%2f%2f"+ PropKit.use("system.properties").get("http")
							+ JFinal.me().getContextPath() + "%2fturntable%2fturntable%3fActivity%3d"
							+ sb.getTurnTableId() + "%26qrcode%3d" + qrcode + "%26spn%3d" + spn.getId() 
							+ "&response_type=code&scope=snsapi_userinfo&state=wx"
							+ "&connect_redirect=1#wechat_redirect";
				} else {
					// 活动已经结束
				}
			}
		} else {
			// 活动未审批通过
		}
		return redirect;
	}
	
	/**
	 * 进入转盘活动
	 * @return
	 */
	public synchronized Map<String, Object> turntableInto(String qrcode,String activity,String accessToken,String openid,SellerPublicNumber sellerPublicNumber){
		Map<String, Object> map = new HashMap<String, Object>();
		// 查询当前二维码是否已参加活动
		String queryActivityCode = PropKit.use("database.properties").get("getCodeByCodeAndActivity");
		Record recActivityCode = Db.findFirst(queryActivityCode,qrcode,activity);
		ActivityCode ac = null;
		if(recActivityCode!=null){
			ac = new ActivityCode().mapping(recActivityCode, new ActivityCode());
		}
		boolean rest = false;
		if (ac!=null) {// 说明有活动
			if (ac.getOpenId().equals(openid)) {
				// 自己进来查看，可以查看，但不用新建一个二维码失效记录
				rest = true;
			} else {
				rest = false;
			}
		} else {
			rest = true;
		}
		// 第一次扫码进入
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		// 默认该用户未关注
		String follow = "0";
		if (wxuser.getSubscribe().equals("1")) {
			// 不为空的时候则是获取该用户的关注情况
			follow = wxuser.getSubscribe();
		}
		// 1=未保存成功 2=二维码已经使用 3=成功
		int resule = 1;
		if (rest) {
			String queryTurnTable = PropKit.use("database.properties").get("getTurnTableById");
			Record rec = Db.findFirst(queryTurnTable,activity);
			TurnTable tt = new TurnTable().mapping(rec, new TurnTable());
			String propleNumber = tt.getJoinPropleNumber();
			int joinNum = Integer.parseInt(propleNumber);
			// 判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
			TurnTableWxUser ttwu = getTurnTableByOpenidAndQrCode(openid, qrcode);
			if (ttwu==null){
				ttwu = new TurnTableWxUser();
				ttwu.setTurntableWxuserId(newId());
				// 保存微信用户 现在的流程是不需要关注就可以参与抽奖，所以保存的信息就只有openid
				wxService.noSaveWxUser(wxuser, openid, sellerPublicNumber, newId());
				ttwu.setScanWinningNumber(tt.getScanTurnTableNumber());
				if (wxuser.getSubscribe().equals("1")) {
					// 判断名称是否包含表情符号
					Boolean emoji = EmojiUtils.containsEmoji(wxuser.getNickname());
					if (emoji) {
						try {
							wxuser.setNickname(java.net.URLEncoder.encode(wxuser.getNickname(), "UTF-8"));
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
				}
				// 保存活动用户参加记录
				rest = new TurnTableWxUser().set("TURNTABLE_WXUSER_ID", ttwu.getTurntableWxuserId()).set("TURNTABLE_ID", activity)
						.set("ACTIVITY_NAME", tt.getActivityName()).set("OPENID", openid)
						.set("NICKNAME", wxuser.getNickname())
						.set("HEADIMGURL", wxuser.getHeadimgurl()).set("BELONG_PUBLICNUMBER_ID", sellerPublicNumber.getId())
						.set("CREATE_TIME", uitils.newDate()).set("STATE", "0").set("SCAN_CODE", qrcode)
						.set("SCAN_WINNING_NUMBER", ttwu.getScanWinningNumber()).save();
				if(rest){
					// 查询出所属运单
					Map<String, Object> map1 = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
					//这是开启活动的运单
					ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map1.get("activitySellerInfo");
					int i = indexService.insertAtcitityCode(newId(), qrcode, activitySellerInfo.getSellerOutInfoRecordId().toString(), sellerPublicNumber.getId(), 
							sellerPublicNumber.getPublicNumberName(), ttwu.getTurntableWxuserId(), openid, wxuser.getNickname(), wxuser.getHeadimgurl(), PropKit.use("system.properties").get("Turntable"),"1", activity,tt.getActivityName());
					if(i==1){
						//将参与人数+1
						int joinedNum=joinNum+1;
						int joinNumebrUpdate = updateTurntableNumber(activity,joinedNum+"");
						if(joinNumebrUpdate==0){
							rest = false;
						}
					}
				}
			}
			resule = 3;
			List<AgentTurnTable> ttpList = queryTurnTablePrizeByActivityId(activity);
			map.put("follow", follow);
			map.put("scanWinningNumber", ttwu.getScanWinningNumber());
			map.put("qrcode", qrcode);
			map.put("turnTable", tt);
			map.put("openid", openid);
			map.put("wxUserInfo", wxuser);
			map.put("turnTablePrizeList", JSON.toJSONString(ttpList));
			map.put("turnTableWxUser", ttwu);
			map.put("sellerPublicNumber", sellerPublicNumber);
		} else {
			// 二维码已经使用
			resule = 2;
		}
		map.put("rest",rest);
		if (resule == 1) {
			map.put("url",404);
		} else if (resule == 2) {
			map.put("url","/index/QRCodeInvalid.html");
		} else if (resule == 3) {
			map.put("url","/turntable/index.html");
		}
		return map;
	}
	
	/**
	 * 只修改用户参与数量
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public int updateTurntableNumber(String activityId,String joinedNum){
		String sql = PropKit.use("database.properties").get("updateTurntableNumber");
		return Db.update(sql,joinedNum,activityId);
	}
	
	/**
	 * 根据openid和所扫码scanCode查询是否已经参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public TurnTableWxUser getTurnTableByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getTurnTableByOpenidAndQrCode");
		return TurnTableWxUser.dao.findFirst(sql,openid,scanCode);
	}
	
	/**
	 * 根据活动ID查询的奖品配置
	 */
	public List<TurnTablePrize> getTurnTablePrizeByActivityId(String turntableId){
		String sql = PropKit.use("database.properties").get("getTurnTablePrizeByActivityId");
		List<Record> record = Db.find(sql,turntableId);
		List<TurnTablePrize> ttpList = new ArrayList<TurnTablePrize>();
		for (Record cord : record) {
			TurnTablePrize ttp = new TurnTablePrize();
			ttp.mapping(cord, ttp);
			ttpList.add(ttp);
		}
		return ttpList;
	}
	
	/**
	 * 根据活动ID查询的奖品配置
	 */
	public List<AgentTurnTable> queryTurnTablePrizeByActivityId(String turntableId){
		String sql = PropKit.use("database.properties").get("getTurnTablePrizeByActivityId");
		List<Record> record = Db.find(sql,turntableId);
		List<AgentTurnTable> ttpList = new ArrayList<AgentTurnTable>();
		for (Record cord : record) {
			AgentTurnTable ttp = new AgentTurnTable();
			ttp.setTurntablePrizeId(cord.getStr("TURNTABLE_PRIZE_ID"));
			ttp.setTurntableId(cord.getStr("TURNTABLE_ID"));
			ttp.setPrizeType(cord.getStr("PRIZE_TYPE"));
			ttp.setOrderNumber(cord.getStr("ORDER_NUMBER"));
			if(cord.getStr("PRIZE_IMG") == null){
				ttp.setPrizeImg("");
			}else{
				ttp.setPrizeImg(cord.getStr("PRIZE_IMG"));
			}
			ttp.setPrizeName(cord.getStr("PRIZE_NAME"));
			ttp.setPrizeNumber(cord.getStr("PRIZE_NUMBER"));
			ttp.setSurplusPrizeNumber(cord.getStr("SURPLUS_PRIZE_NUMBER"));
			ttp.setPrizeProbability(cord.getStr("PRIZE_PROBABILITY"));
			ttp.setSurplusPrizeProbability(cord.getStr("SURPLUS_PRIZE_PROBABILITY"));
			ttp.setIntegralNumebr(cord.getStr("INTEGRAL_NUMEBR"));
			ttp.setRedNumber(cord.getStr("RED_NUMBER"));
			ttp.setCreateNime(cord.getStr("CREATE_TIME"));
			ttpList.add(ttp);
		}
		return ttpList;
	}
	
	
	/**
	 * 转盘奖品集合根据概率和剩余数量生成中奖奖品
	 * @param turnTablePrizeList
	 * @return
	 */
	public Object[] generateWinningPrize(List<TurnTablePrize> turnTablePrizeList ){
		Object[] winningPrize = new Object[2];
		//存储每个奖品新的概率区间
        List<Float> proSection = new ArrayList<Float>();
        proSection.add(0f);
        //总的概率区间
        float totalPro = 0f;
        for (TurnTablePrize ttpBL : turnTablePrizeList) {
        	//当前中奖概率
			String probStr = ttpBL.getSurplusPrizeProbability().indexOf("%") > 0
					? ttpBL.getSurplusPrizeProbability().substring(0, ttpBL.getSurplusPrizeProbability().indexOf("%"))
					: ttpBL.getSurplusPrizeProbability();
        	Float probability = Float.parseFloat(probStr);
            //每个概率区间为奖品概率乘以10000（把三位小数转换为整）再乘以剩余奖品数量
            totalPro += probability * 1000 * Integer.parseInt(ttpBL.getSurplusPrizeNumber());
            proSection.add(totalPro);
        }
		//获取总的概率区间中的随机数
        Random random = new Random();
        //记录中奖奖品
		TurnTablePrize winningTurnTablePrize = null;
        float randomPro = (float)random.nextInt((int)totalPro);
		 //判断取到的随机数在哪个奖品的概率区间中
        for (int i = 0,size = proSection.size(); i < size; i++) {
            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
            	winningTurnTablePrize = turnTablePrizeList.get(i);
            	winningPrize[0]=winningTurnTablePrize;
            	winningPrize[1]=i;
            }
        }
        
        return winningPrize;
	}
	
	/**
	 * 1.根据转盘ID修改转盘奖品剩余数量和概率
	 * @param Id
	 * @param Number
	 * @param Probability
	 * @return
	 */
	public int updateTurnTablePrizeNumberAndProbabilityById(String prizeId,String number,String probability){
		String sql = PropKit.use("database.properties").get("updateTurnTablePrizeNumberAndProbabilityById");
		return Db.update(sql,number,probability,prizeId);
	}
	
	/**
	 * 修改转盘活动剩余参与活动总数
	 */
	public int updateTurnTableTotalById(String activityId,String number,int joinPropleNumber,int winningPropleNumber){
		String sql = PropKit.use("database.properties").get("updateTurnTableTotalById");
		return Db.update(sql,number,joinPropleNumber,winningPropleNumber,activityId);
	}
	
	/**
	 * 修改转盘活动剩余可抽奖次数和本次中奖金额或积分值
	 */
	public int updateTurnTableWxUserJoinNumberById(String scanWinningNumber,String totalMoney,String totalIntegral,String turntableWxuserId,String integralWinningNumber,String redWinningNumber
			,String goodsWinningNumber,String thinklWinningNumber){
		String sql = PropKit.use("database.properties").get("updateTurnTableWxUserJoinNumberById");
		return Db.update(sql,scanWinningNumber,totalMoney,totalIntegral,integralWinningNumber,redWinningNumber,goodsWinningNumber,thinklWinningNumber,turntableWxuserId);
	}
	
	/**
	 * 查询所有的转盘活动
	 * @return
	 */
	public List<TurnTable> allTurnTable(String userCode,String activityName,String state){
		String sql = PropKit.use("database.properties").get("allTurnTable");
		if(!activityName.equals("")){
			sql+=" AND ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if(!state.equals("")){
			if(state.equals("全部")){
				
			}else if(state.equals("通过")){
				state="1";
				sql += " and STATE = " + state;
			}else if(state.equals("驳回")){
				state="2";
				sql += " and STATE = " + state;
			}else if(state.equals("申请中")){
				state="0";
				sql += " and STATE = " + state;
			}
		}
		if(userCode != null){
			sql += "AND ACITIVITY_LAUNCH_USERCODE ="+"'"+userCode+"'";
		}
		return TurnTable.dao.find(sql);
	}
	
	/**
	 * 保存转盘中奖记录
	 */
	public int saveTurnTableTotalWinning(String id,String turnTablewxUserId,String prizeType,String winningPrizeId,String winningNumber,String prizeName,String createTime,String openid,String state,String productImg,String ProductWinningInfoId){
		String sql = PropKit.use("database.properties").get("saveTurnTableTotalWinning");
		return Db.update(sql,id,turnTablewxUserId,prizeType,winningPrizeId,winningNumber,prizeName,createTime,openid,state,productImg,ProductWinningInfoId);
	}
	
	/**
	 * 查询本次扫码最多中奖三次的数据
	 */
	public List<TurnTableWxUserWinning> queryTurnTableWxUserWinningByOpenidAndTurnTableWxUserId(String openid , String turnTableWxUserId){
		String sql = PropKit.use("database.properties").get("queryTurnTableWxUserWinningByOpenidAndTurnTableWxUserId");
		return TurnTableWxUserWinning.dao.find(sql,openid,turnTableWxUserId);
	}
	
	/**
	 * 查询微信参与记录ID最多中奖三次的数据
	 */
	public List<TurnTableWxUserWinning> queryTurnTableWxUserWinningByTurnTableWxUserId(String turnTableWxUserId){
		String sql = PropKit.use("database.properties").get("queryTurnTableWxUserWinningByTurnTableWxUserId");
		return TurnTableWxUserWinning.dao.find(sql,turnTableWxUserId);
	}
	
	/**
	 * 报表查询所有的转盘活动
	 */
	public List<TurnTable> queryTurntableReportAll(String userCode,String userId,String activityName,String state,String startTime,String endTime){
		String sql = PropKit.use("database.properties").get("allTurnTable");
		if(!userCode.equals("0")){
			sql+=" AND ACITIVITY_LAUNCH_USERID = "+userId+"AND ACITIVITY_LAUNCH_USERCODE="+userCode;
		}
		// 这里是模糊查询名字
		if (activityName != null && !"".equals(activityName) ) {
			sql += " and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) && state != null) {
			sql += " and STATE = " + state;
		}
		if (!"".equals(userCode) && userCode != null) {
			sql += " and ACITIVITY_LAUNCH_USERCODE ="+"'"+userCode+"'";//'" +"'";
		}
		if (!"".equals(startTime) && !"".equals(endTime) && startTime != null && endTime != null) {
			sql += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		return TurnTable.dao.find(sql);
	}
	
	/**
	 * 根据活动ID查询微信用户参与记录
	 * @return
	 */
	public List<TurnTableWxUser> queryTurnTableWxUserByActivityId(String id,String nickName){
		String sql = PropKit.use("database.properties").get("queryTurnTableWxUserByActivityId");
		if(nickName!=null){
			sql +=" AND NICKNAME like '%" + nickName + "%'";
		}
		return TurnTableWxUser.dao.find(sql,id);
	}

	
	/**
	 * 分页查询 查询所有的转盘活动的信息
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		return TurnTable.dao.paginate(pageNumber, pageSize,activityName,state,startTime,endTime,user);
	}
	
	/**
	 * 这里需要先查询一下 该码是否已经中了奖了  没有中奖才执行
	 */
	public Boolean getTurnWxUserWinning(String openid,String turnTablewxUserId){
		String sql1 = PropKit.use("database.properties").get("queryTurnWxUserWinningByOpenidAndTurnWxUserId");
		 Record record = Db.findFirst(sql1,openid,turnTablewxUserId);
		 if(record==null){
			 return true;
		 }else{
			 return false;
		 }
	}
	
	public TurnTableWxUser getTurnTableWxUserById(String id) {
		String sql = PropKit.use("database.properties").get("getTurnTableWxUserById");
		Record rec = Db.findFirst(sql,id);
		TurnTableWxUser trunTable = new TurnTableWxUser().mapping(rec, new TurnTableWxUser());
		return trunTable;
	}
	
	
	/**
	 * 转盘生成奖品、
	 */
	public synchronized Map<String, Object> productWinning(String turntableId,String openid,String turnTablewxUserId,
			SellerPublicNumber sellerPublicNumber,String token){
		log.error("转盘抽奖---生产奖品---用户Openid="+openid+"---转盘ID="+turntableId+"---公众号ID="+sellerPublicNumber);
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				// TODO Auto-generated method stub
				TurnTableWxUser turnTableWxUser = getTurnTableWxUserById(turnTablewxUserId);
				//根据扫描的二维码查找出该二维码的参与情况
				String codeSql="select * from ACTIVITY_CODE where CODE =?";
				String scanCode = turnTableWxUser.getScanCode();
				ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
				String winId="";
				String winType="";
				boolean resutl = false;
				if (!turnTableWxUser.getScanWinningNumber().equals("0")) {
					// 修改用户参与转盘中奖纪录剩余抽奖次数
					int surplusScanWinningNumber = Integer.parseInt(turnTableWxUser.getScanWinningNumber()) - 1;
					// 格式化小数
					DecimalFormat df = new DecimalFormat("##0.00");
					//TurnTable turnTable = TurnTable.dao.findById(turntableId);
					String queryTurnTable = PropKit.use("database.properties").get("getTurnTableById");
					Record rec = Db.findFirst(queryTurnTable,turntableId);
					TurnTable turnTable = new TurnTable().mapping(rec, new TurnTable());
					String winningPropleNumbers = turnTable.getWinningPropleNumber();
					int winningPropleNumber = Integer.parseInt(winningPropleNumbers);
					// 剩余总瓶数
					int bottleTotal = Integer.parseInt(turnTable.getTotal());
					log.error("总数之前"+bottleTotal);
					// 查询当前活动所有奖品配置
					List<TurnTablePrize> ttpList = getTurnTablePrizeByActivityId(turntableId);
					// 生产中奖奖品
					Object[] winningPrize = generateWinningPrize(ttpList);
					// 所中奖品
					TurnTablePrize winningTurnTablePrize = (TurnTablePrize) winningPrize[0];
					map.put("TurnTablePrize", winningTurnTablePrize);
					// 所中奖品属于集合第几个
					int i = (int) winningPrize[1];
					// 总瓶数减去一个
					bottleTotal = bottleTotal - 1;
					Boolean turnWxUserWinning = getTurnWxUserWinning(openid, turnTablewxUserId);
					if (turnWxUserWinning) {
						// 将单个中奖奖品数量减一
						ttpList.get(i).setSurplusPrizeNumber(Integer.parseInt(ttpList.get(i).getSurplusPrizeNumber()) - 1 + "");
						// 从新计算和保存概率
						for (TurnTablePrize ttpBL : ttpList) {
							String newProbability = probabilityUtils.algorithm(Integer.parseInt(ttpBL.getSurplusPrizeNumber()), bottleTotal);
							// 根据转盘ID修改转盘奖品剩余数量和概率
							log.error("---转盘---修改剩余概率="+newProbability+"---剩余数量---="+ttpBL.getSurplusPrizeNumber());
							int updateTrunPrize = updateTurnTablePrizeNumberAndProbabilityById(
									ttpBL.getTurnTablePrizeId(), ttpBL.getSurplusPrizeNumber(), newProbability);
							if (updateTrunPrize > 0) {
								// 修改转盘活动剩余参与活动总数
								log.error("总数"+bottleTotal);
								int updateTurnTableTotal = updateTurnTableTotalById(turntableId,
										bottleTotal + "", Integer.parseInt(turnTable.getJoinPropleNumber()),
										Integer.parseInt(turnTable.getWinningPropleNumber()));
								log.error("修改"+updateTurnTableTotal);
								if (updateTurnTableTotal > 0) {
									resutl = true;
								} else {
									resutl = false;
								}
							}
						}
						int saveTurnTableTotalWinning = 0;
						if (resutl) {
							ActivityWxUser activityWxUser = indexService.queryUserByOpenidAndPublicNumberId(openid,
									sellerPublicNumber.getId());
							// 查找是否存在参与的红包获奖记录
							RedWinningInfo rwi = redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(
									turntableId, openid, PropKit.use("system.properties").get("Turntable"),
									turnTableWxUser.getTurntableWxuserId());
							// 查询是否存在参与的积分获奖记录
							IntegralWinningInfo integralWinningInfos = IntegralService
									.queryIntegralWinningInfo(turntableId, turnTablewxUserId, openid);
							// 保存红包
							if (winningTurnTablePrize.getPrizeType().equals("2")) {
								winType="2";
			        			String newId = UUID.randomUUID().toString().replaceAll("-", "");
			        			winId=newId;
			        			winningPropleNumber=winningPropleNumber+1;
								// 积分
								saveTurnTableTotalWinning = saveTurnTableTotalWinning(newId,
										turnTablewxUserId, winningTurnTablePrize.getPrizeType(),
										winningTurnTablePrize.getTurnTablePrizeId(),
										winningTurnTablePrize.getIntegralNumber(), winningTurnTablePrize.getPrizeName(),
										uitils.newDate(), openid, "1", winningTurnTablePrize.getPrizeImg(), "");
								if (saveTurnTableTotalWinning > 0) {
									saveTurnTableTotalWinning = updateTurnTableWxUserJoinNumberById(
											surplusScanWinningNumber + "", turnTableWxUser.getTotalMoney(),
											Integer.parseInt(turnTableWxUser.getTotalIntegral())
													+ Integer.parseInt(winningTurnTablePrize.getIntegralNumber()) + "",
											turnTableWxUser.getTurntableWxuserId(),
											Integer.parseInt(turnTableWxUser.getIntegralWinningNumber()) + 1 + "",
											turnTableWxUser.getRedWinningNumber(),
											turnTableWxUser.getGoodsWinningNumber(),
											turnTableWxUser.getThinkWinningNumber());
								}
								if (integralWinningInfos!=null) {
									saveTurnTableTotalWinning = integralService
											.updateIntegralWinningInfoByIntegralNumber(Integer
													.parseInt(integralWinningInfos.getWinningIntegral())
													+ Integer.parseInt(winningTurnTablePrize.getIntegralNumber()),
													integralWinningInfos.getId());
								} else {
									IntegralWinningInfo integralWinningInfo = new IntegralWinningInfo();
									integralWinningInfo.setId(UUID.randomUUID().toString().replaceAll("-", ""));
									integralWinningInfo.setBelongActivityId(turntableId);
									integralWinningInfo.setActivityName(turnTable.getActivityName());
									integralWinningInfo
											.setActivityNameType(PropKit.use("system.properties").get("Turntable"));
									integralWinningInfo.setWinningIntegral(winningTurnTablePrize.getIntegralNumber());
									integralWinningInfo.setCreateTime(uitils.newDate());
									integralWinningInfo.setStartTime("0");
									integralWinningInfo.setEndTime("0");
									integralWinningInfo.setOpenid(openid);
									integralWinningInfo.setActivityWxUserId(turnTablewxUserId);
									integralWinningInfo.setBelongPublicnumberId(sellerPublicNumber.getId());
									integralService.saveIntegralWinningInfo(integralWinningInfo);
								}
								int totalIntegral = Integer.parseInt(activityWxUser.getTotalIntegral())
										+ Integer.parseInt(winningTurnTablePrize.getIntegralNumber());
								int surplusTotalIntegral = Integer.parseInt(activityWxUser.getSurplusTotalIntegral())
										+ Integer.parseInt(winningTurnTablePrize.getIntegralNumber());
								saveTurnTableTotalWinning = indexService.updateWxUserIntegralAndMoneyById(
										totalIntegral + "", surplusTotalIntegral + "", activityWxUser.getTotalMoney(),
										activityWxUser.getSurplusTotalMoney(), activityWxUser.getId());
								//发送中奖积分通知
								String activityUrl="%2fpersonalCenter%2fmyIntegral%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + turnTableWxUser.getOpenId()+ "%26startTime%3d" + ""+ "%26endTime%3d" + "";
								Tools.sendWinNotice(turnTableWxUser.getOpenId(), sellerPublicNumber, activityUrl, turnTable.getActivityName(), winningTurnTablePrize.getPrizeName(), token);
							} else if (winningTurnTablePrize.getPrizeType().equals("1")) {
								String turnTableTotalWinningId = UUID.randomUUID().toString().replaceAll("-", "");
								String productWinningInfoId = UUID.randomUUID().toString().replaceAll("-", "");
								// 保存一个实物中奖信息
								ProductWinningInfo productWinningInfo = new ProductWinningInfo();
								productWinningInfo.setId(productWinningInfoId);
								productWinningInfo.setBelongActivityId(turntableId);
								productWinningInfo.setActivityName(turnTable.getActivityName());
								productWinningInfo
										.setActivityNameType(PropKit.use("system.properties").get("Turntable"));
								productWinningInfo.setProductId("");
								productWinningInfo.setProductName(winningTurnTablePrize.getPrizeName());
								productWinningInfo.setProductImg(winningTurnTablePrize.getPrizeImg());
								productWinningInfo.setActivityPrizeId(winningTurnTablePrize.getTurnTablePrizeId());
								productWinningInfo.setCreateTime(uitils.newDate());
								productWinningInfo.setStartTime(turnTable.getStartTime());
								productWinningInfo.setEndTime(turnTable.getEndTime());
								productWinningInfo.setOpenId(openid);
								productWinningInfo.setActivityWxUserId(turnTablewxUserId);
								productWinningInfo.setBelongPublicNumberId(activityWxUser.getBelongPublicNumberId());
								productWinningInfo.setState("2");
								productWinningInfo.setPayMoney("0");
								productWinningInfo.setPrice("0");
								productWinningInfo.setLowPrice("0");
								productWinningInfo.setWinningInfoId(turnTableTotalWinningId);
								saveTurnTableTotalWinning = productWinningInfoService
										.saveProductWinningInfo(productWinningInfo);
								if (saveTurnTableTotalWinning > 0) {
									winType="1";
				        			winId=turnTableTotalWinningId;
				        			winningPropleNumber=winningPropleNumber+1;
									// 实物
									saveTurnTableTotalWinning = saveTurnTableTotalWinning(
											turnTableTotalWinningId, turnTablewxUserId,
											winningTurnTablePrize.getPrizeType(),
											winningTurnTablePrize.getTurnTablePrizeId(), "0",
											winningTurnTablePrize.getPrizeName(), uitils.newDate(), openid, "2",
											winningTurnTablePrize.getPrizeImg(), productWinningInfoId);
									if (saveTurnTableTotalWinning > 0) {
										saveTurnTableTotalWinning = updateTurnTableWxUserJoinNumberById(surplusScanWinningNumber + "",
														turnTableWxUser.getTotalMoney(),
														turnTableWxUser.getTotalIntegral(),
														turnTableWxUser.getTurntableWxuserId(),
														turnTableWxUser.getIntegralWinningNumber(),
														turnTableWxUser.getRedWinningNumber(),
														Integer.parseInt(turnTableWxUser.getGoodsWinningNumber()) + 1
																+ "",
														turnTableWxUser.getThinkWinningNumber());
									}
								}
								//发送实物中奖通知
								String activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + turnTableWxUser.getOpenId()+ "%26selectedVal%3d" + "";
								Tools.sendWinNotice(turnTableWxUser.getOpenId(), sellerPublicNumber, activityUrl, turnTable.getActivityName(), winningTurnTablePrize.getPrizeName(), token);
							} else if (winningTurnTablePrize.getPrizeType().equals("3")) {
								winType="3";
			        			String newId = UUID.randomUUID().toString().replaceAll("-", "");
			        			winId=newId;
			        			winningPropleNumber=winningPropleNumber+1;
								// 红包
								saveTurnTableTotalWinning = saveTurnTableTotalWinning(newId,
										turnTablewxUserId, winningTurnTablePrize.getPrizeType(),
										winningTurnTablePrize.getTurnTablePrizeId(),
										winningTurnTablePrize.getRedNumber(), winningTurnTablePrize.getPrizeName(),
										uitils.newDate(), openid, "1", winningTurnTablePrize.getPrizeImg(), "");
								if (saveTurnTableTotalWinning > 0) {
									// 修改用户参与转盘中奖纪录剩余抽奖次数
									Float totalMoney = Float.parseFloat(turnTableWxUser.getTotalMoney())
											+ Float.parseFloat(winningTurnTablePrize.getRedNumber());
									saveTurnTableTotalWinning = updateTurnTableWxUserJoinNumberById(
											surplusScanWinningNumber + "", df.format(totalMoney),
											turnTableWxUser.getTotalIntegral(), turnTableWxUser.getTurntableWxuserId(),
											turnTableWxUser.getIntegralWinningNumber(),
											Integer.parseInt(turnTableWxUser.getRedWinningNumber()) + 1 + "",
											turnTableWxUser.getGoodsWinningNumber(),
											turnTableWxUser.getThinkWinningNumber());
								}
								if (rwi == null) {
									// 保存红包中奖记录
									RedWinningInfo redWinningInfo = new RedWinningInfo();
									redWinningInfo.setId( UUID.randomUUID().toString().replaceAll("-", ""));
									redWinningInfo.setBelongActivityId(turntableId);
									redWinningInfo.setActivityName(turnTable.getActivityName());
									redWinningInfo
											.setActivityNameType(PropKit.use("system.properties").get("Turntable"));
									redWinningInfo.setWinningRedTotal(winningTurnTablePrize.getRedNumber());
									redWinningInfo.setCreateTime(uitils.newDate());
									if (surplusScanWinningNumber == 0) {
										redWinningInfo.setState("1");
									} else {
										redWinningInfo.setState("0");
									}
									redWinningInfo.setStartTime(turnTable.getStartTime());
									redWinningInfo.setEndTime(turnTable.getEndTime());
									redWinningInfo.setWithdrawals("0");
									redWinningInfo.setOpenid(openid);
									redWinningInfo.setActivityWxUserId(turnTableWxUser.getTurntableWxuserId());
									redWinningInfo.setBelongPublicnumberId(sellerPublicNumber.getId());
									saveTurnTableTotalWinning = redWinningInfoService.saveRedInfo(redWinningInfo);
									// 判断该次扫码剩余0次抽奖机会
									if (surplusScanWinningNumber == 0) {
										// 修改用户参与转盘中奖纪录剩余抽奖次数
										Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
												+ Float.parseFloat(winningTurnTablePrize.getRedNumber());
										Float surplusTotalMoney = Float
												.parseFloat(activityWxUser.getSurplusTotalMoney())
												+ Float.parseFloat(redWinningInfo.getWinningRedTotal());
										saveTurnTableTotalWinning = indexService.updateWxUserIntegralAndMoneyById(
												activityWxUser.getTotalIntegral(),
												activityWxUser.getSurplusTotalIntegral(), df.format(totalMoney),
												df.format(surplusTotalMoney), activityWxUser.getId());
									} else {
										Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
												+ Float.parseFloat(winningTurnTablePrize.getRedNumber());
										saveTurnTableTotalWinning = indexService.updateWxUserIntegralAndMoneyById(
												activityWxUser.getTotalIntegral(),
												activityWxUser.getSurplusTotalIntegral(), df.format(totalMoney),
												activityWxUser.getSurplusTotalMoney(), activityWxUser.getId());
									}
								} else {
									if (surplusScanWinningNumber == 0) {
										Float winningRedTotal = Float.parseFloat(rwi.getWinningRedTotal())
												+ Float.parseFloat(winningTurnTablePrize.getRedNumber());
										saveTurnTableTotalWinning = redWinningInfoService.updateRedInfo("1",
												df.format(winningRedTotal), turnTable.getActivityName(), rwi.getId());
										if (saveTurnTableTotalWinning > 0) {
											// 修改用户参与转盘中奖纪录剩余抽奖次数
											Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
													+ Float.parseFloat(winningTurnTablePrize.getRedNumber());
											Float surplusTotalMoney = Float
													.parseFloat(activityWxUser.getSurplusTotalMoney())
													+ Float.parseFloat(rwi.getWinningRedTotal());
											saveTurnTableTotalWinning = indexService.updateWxUserIntegralAndMoneyById(
													activityWxUser.getTotalIntegral(),
													activityWxUser.getSurplusTotalIntegral(), df.format(totalMoney),
													df.format(surplusTotalMoney), activityWxUser.getId());
										}
									} else {
										Float winningRedTotal = Float.parseFloat(rwi.getWinningRedTotal())
												+ Float.parseFloat(winningTurnTablePrize.getRedNumber());
										saveTurnTableTotalWinning = redWinningInfoService.updateRedInfo("0",
												df.format(winningRedTotal), turnTable.getActivityName(), rwi.getId());
										if (saveTurnTableTotalWinning > 0) {
											Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
													+ Float.parseFloat(winningTurnTablePrize.getRedNumber());
											saveTurnTableTotalWinning = indexService.updateWxUserIntegralAndMoneyById(
													activityWxUser.getTotalIntegral(),
													activityWxUser.getSurplusTotalIntegral(), df.format(totalMoney),
													activityWxUser.getSurplusTotalMoney(), activityWxUser.getId());
										}
									}
								}
								//发送红包中奖通知
								String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + turnTableWxUser.getOpenId();
								Tools.sendWinNotice(turnTableWxUser.getOpenId(), sellerPublicNumber, activityUrl, turnTable.getActivityName(), winningTurnTablePrize.getPrizeName(), token);
							} else if (winningTurnTablePrize.getPrizeType().equals("4")) {
								winType="4";
			        			String newId =  UUID.randomUUID().toString().replaceAll("-", "");
			        			winId=newId;
								// 谢谢惠顾
								saveTurnTableTotalWinning = saveTurnTableTotalWinning(newId,
										turnTablewxUserId, winningTurnTablePrize.getPrizeType(),
										winningTurnTablePrize.getTurnTablePrizeId(), "0",
										winningTurnTablePrize.getPrizeName(), uitils.newDate(), openid, "1",
										winningTurnTablePrize.getPrizeImg(), "");
								if (saveTurnTableTotalWinning > 0) {
									saveTurnTableTotalWinning = updateTurnTableWxUserJoinNumberById(
											surplusScanWinningNumber + "", turnTableWxUser.getTotalMoney(),
											turnTableWxUser.getTotalIntegral(), turnTableWxUser.getTurntableWxuserId(),
											turnTableWxUser.getIntegralWinningNumber(),
											turnTableWxUser.getRedWinningNumber(),
											turnTableWxUser.getGoodsWinningNumber(),
											Integer.parseInt(turnTableWxUser.getThinkWinningNumber()) + 1 + "");
								}
							}
							if (saveTurnTableTotalWinning > 0) {
								resutl = true;
								if (rwi != null) {
									if (surplusScanWinningNumber == 0) {
										saveTurnTableTotalWinning = redWinningInfoService.updateRedInfoByState("1",
												rwi.getId());
										if (!winningTurnTablePrize.getPrizeType().equals("3")) {
											// 最后的中奖不是红包中奖，将之前红包中奖修改已完成，累加值微信用户可提现金额中，如果最后一次扫码中奖红包已经累加
											Float surplusTotalMoney = Float
													.parseFloat(activityWxUser.getSurplusTotalMoney())
													+ Float.parseFloat(rwi.getWinningRedTotal());
											saveTurnTableTotalWinning = indexService.updateWxUserIntegralAndMoneyById(
													activityWxUser.getTotalIntegral(),
													activityWxUser.getSurplusTotalIntegral(),
													activityWxUser.getTotalMoney(), df.format(surplusTotalMoney),
													activityWxUser.getId());
										}
									}
								}
							}
						}
						map.put("resutl", "true");
						if(activityCode!=null){
							//这里更新了该码的中奖情况
							activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", turnTableWxUser.getTurntableWxuserId()).set("WINTYPE", winType).set("WININGID", winId).update();
						}
						//这里将中奖人数更新一下
						turnTable.set("TURNTABLE_ID", turntableId).set("WINNING_PROPLE_NUMBER", winningPropleNumber).update();
						log.error("转盘抽奖---生产奖品---用户Openid="+openid+"---所中奖品ID="+winningTurnTablePrize.getTurnTablePrizeId()+"---所中奖名称="+winningTurnTablePrize.getPrizeName());
					} else {
						map.put("resutl", "false");
					}
					return resutl;
				}else{
					return false;
				}
			}
		});
		//查询当前的微信用户给前端
		String sq="select * from ACTIVITY_WXUSER where openid = ? ";
		ActivityWxUser activityWxUser = ActivityWxUser.dao.findFirst(sq,openid);
		String surplusTotalMoney = activityWxUser.getSurplusTotalMoney();
		map.put("surplusTotalMoney", surplusTotalMoney);
		String orderId="wly"+uitils.RandomNumber();
		map.put("orderId", orderId);
		return map;
	}
	
	/**
	 * 生成ID 当前毫秒数
	 * 
	 * @param args
	 */
	public static String newId() {
		return UUID.randomUUID().toString().replaceAll("-", "") + newDateByYMD();
	}
	
	/**
	 * 新建时间并格式转换 年月日
	 */
	public static String newDateByYMD() {
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyyMMddHHmmss");
		return time.format(date);
	}
}
