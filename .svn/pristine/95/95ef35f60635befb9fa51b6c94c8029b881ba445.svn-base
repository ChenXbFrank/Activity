package com.activity.common.service.integral;

import java.text.ParseException;
import java.util.List;

import com.activity.common.model.accumulate.Accumulate;
import com.activity.common.model.breakEgg.BreakEgg;
import com.activity.common.model.centerObjcet.turnTable.AgentTurnTable;
import com.activity.common.model.groupPurchase.GroupPurchase;
import com.activity.common.model.integral.IntegalExchange;
import com.activity.common.model.integral.Integral;
import com.activity.common.model.integral.IntegralActivity;
import com.activity.common.model.integral.IntegralProduct;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.integral.JoinActivity;
import com.activity.common.model.oneMoneyShop.OneMoneyShop;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.puzzle.Puzzle;
import com.activity.common.model.robRed.RobRed;
import com.activity.common.model.robRed.RobRedWxUser;
import com.activity.common.model.scratchCard.ScratchCard;
import com.activity.common.model.scratchCard.ScratchCardWxUser;
import com.activity.common.model.shareBargain.ShareBargain;
import com.activity.common.model.shareBargain.ShareBargainHelp;
import com.activity.common.model.shareBargain.ShareBargainPrize;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.activity.common.model.turntable.TurnTable;
import com.activity.common.model.turntable.TurnTableWxUser;
import com.activity.common.service.accumulateFabulous.AccumulateService;
import com.activity.common.service.breakEgg.BreakEggService;
import com.activity.common.service.groupPurchase.GroupPurchaseService;
import com.activity.common.service.oneMoney.OneMoneyService;
import com.activity.common.service.puzzle.PuzzleService;
import com.activity.common.service.robRed.RobRedService;
import com.activity.common.service.robRed.RobRedWxUserService;
import com.activity.common.service.shareBargain.ShareBargainHelpService;
import com.activity.common.service.shareBargain.ShareBargainPrizeService;
import com.activity.common.service.shareBargain.ShareBargainService;
import com.activity.common.service.turntable.TurntableService;
import com.activity.common.utils.date.DateUitils;
import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 积分
 * @author 唐
 *
 */
public class IntegralService {
	private static IntegralService integralService = new IntegralService();
	private IntegralService() {}
	public static IntegralService getService(){return integralService;}
	RobRedService robRedService = RobRedService.getService();
	OneMoneyService oneMoneyService = OneMoneyService.getService();
	BreakEggService breakEggService = BreakEggService.getService();
	GroupPurchaseService groupPurchaseService = GroupPurchaseService.getService();
	AccumulateService accumulateService = AccumulateService.getService();
	RobRedWxUserService robRedWxUserService = RobRedWxUserService.getService();
	PuzzleService puzzleService = PuzzleService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ShareBargainService shareBargainService = ShareBargainService.getService();
	ShareBargainPrizeService shareBargainPrizeService = ShareBargainPrizeService.getService();
	TurntableService turntableService = TurntableService.getService();
	
	
	/**
	 * 全部积分活动
	 * @return
	 */
	public List<Integral> allIntegral(){
		String sql = PropKit.use("database.properties").get("allIntegral");
		List<Integral> integralList = Integral.dao.find(sql);
		return integralList;
	}
	
	/**
	 * 保存积分兑换活动的配置
	 */
	public int saveIntegralExchangeActivity(String id,String integralActivityId,String activityNumber,String activityName,
			String activityId,String needInteral,String tenActivityId,String tenActivityName,String img){
		String sql = PropKit.use("database.properties").get("saveIntegralExchangeActivity");
		return Db.update(sql, id, integralActivityId, activityNumber, activityName, activityId, needInteral, tenActivityId,tenActivityName,img);
	}
	
	/**
	 * 保存积分活动基础配置  NEED_INTEGRAL
	 */
	public int saveIntegralActivity(String integralActivityId,String signIntegral,String backgroundImg,String belongActivityId,String moblecBackgroundImg,String userId,String userCode,String state,
			String createTime,String applyPhone,String applyName,String total,String needIntegral){
		String sql = PropKit.use("database.properties").get("saveIntegralActivity");
		return Db.update(sql, integralActivityId, signIntegral, backgroundImg, belongActivityId, moblecBackgroundImg, userId, userCode,state,createTime,applyPhone,applyName,total,needIntegral);
	}

	/**
	 * 保存积分兑换奖品配置
	 */
	public int saveIntegralPrize(String id,String integralActivityId,String orderNumber,String agent,String productId,String productImg,
			String productName,String productNumber,String productIntroduce,String needIntegral,String spec,String degree,String volume,String surplusProductNumbr){
		String sql = PropKit.use("database.properties").get("saveIntegralPrize");
		return Db.update(sql, id, integralActivityId, orderNumber, agent, productId, productImg, productName,productNumber,productIntroduce,needIntegral,spec,degree,volume,surplusProductNumbr);
	}
	
	/**
	 * 查询出所有积分关联活动
	 */
	public List<IntegralActivity> getIntegralActivityByActivityId(String activityId){
		String sql = PropKit.use("database.properties").get("getIntegralActivityByActivityId");
		return IntegralActivity.dao.find(sql,activityId);
	}
	
	/**
	 * 查询出所有积分关联产品
	 */
	public List<IntegralProduct> getIntegralProductByActivityId(String activityId){
		String sql = PropKit.use("database.properties").get("getIntegralProductByActivityId");
		return IntegralProduct.dao.find(sql,activityId);
	}
	
	/**
	 * 根据积分区间 或者排序 查询出所有积分关联产品
	 */
	public List<IntegralProduct> queryIntegralProductByActivityId(String small,String big,String sort, String activityId){
		String sql = PropKit.use("database.properties").get("getIntegralProductByActivityId");
		if(!small.equals("") && !big.equals("")){
			sql += " AND a.NEED_INTEGRAL >= "+small+" AND a.NEED_INTEGRAL <= "+big;
		} 
		if(sort != null){
			if(sort.equals("1")){
				sql += " ORDER  BY to_number(a.NEED_INTEGRAL) ASC ";
			}else if(sort.equals("2")){
				sql += " ORDER  BY to_number(a.NEED_INTEGRAL) DESC ";
			}
		}
		return IntegralProduct.dao.find(sql,activityId);
	}
	
	/**
	 * 根据UserCode和UserId查询积分活动
	 */
	public Integral getIntegralByUser(String userCode,String userId){
		String sql = PropKit.use("database.properties").get("getIntegralByUser");
		Integral integral = Integral.dao.findFirst(sql,userId,userCode);
		return integral;
	}
	
	/**
	 * 兑换红包活动
	 */
	public Boolean JoinRobred(String robRedActivityId,String publicNumberId,String openid,String qrcode,String newId,String scanRedNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		RobRed robRed = RobRed.dao.findById(robRedActivityId);
		//这里参与用户数量+1
		String joinPropleNumber = robRed.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		robRed.set("RED_ID", robRedActivityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存抢红包活动用户参加记录
		Boolean resutl = new RobRedWxUser().set("RED_WXUSER_ID", newId).set("ACTIVITY_NAME", robRed.getActivityName()).set("STARTTIME", robRed.getStartTime())
			.set("ENDTIME", robRed.getEndTime()).set("RED_ID", robRedActivityId).set("OPENID", openid).set("NICKNAME", wxUserName)
			.set("HEADIMGURL", headImgUrl).set("BELONG_PUBLICNUMBER_ID", publicNumberId).set("CREATE_TIME", uitils.newDate()).set("SCAN_CODE", qrcode)
			.set("SCAN_RED_NUMBER", scanRedNumber).set("JOINMODE", "2").save();
		return resutl;
	}
	
	/**
	 * 兑换刮刮卡活动
	 */
	public Boolean JoinCard(String activityId,String publicNumberId,String openid,String qrcode,String newId,String scanNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		ScratchCard card = ScratchCard.dao.findById(activityId);
		//这里参与用户数量+1
		String joinPropleNumber = card.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		card.set("SCRATCHCARD_ID", activityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存刮刮卡活动用户参加记录
		Boolean resutl = new ScratchCardWxUser().set("SCRATCHCARD_WXUSER_ID", newId).set("SCRATCHCARD_ID", activityId).set("ACTIVITY_NAME", card.getActivityName()).set("OPENID", openid)
				.set("NICKNAME", wxUserName).set("HEADIMGURL", headImgUrl).set("BELONG_PUBLICNUMBER_ID",publicNumberId)
				.set("CREATE_TIME", uitils.newDate()).set("STATE", "0").set("SCAN_CODE", qrcode).set("SCAN_WINNING_NUMBER",scanNumber).save();
		return resutl;
	}
	
	/**
	 * 兑换集赞活动
	 */
	public Boolean JoinAccumulate(String activityId,String publicNumberId,String openid,String qrcode,String newId,String scanNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		Accumulate accumulate = Accumulate.dao.findById(activityId);
		//这里参与用户数量+1
		String joinPropleNumber = accumulate.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		accumulate.set("ID", activityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存集赞活动用户参加记录
		int saveCommentWxUser = accumulateService.saveCommentWxUser(newId, activityId, openid, wxUserName, headImgUrl, uitils.newDate(), publicNumberId, qrcode, accumulate.getActivityName(), "1",accumulate.getProductIntroduction(),accumulate.getProductImg());
		if(saveCommentWxUser>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 兑换砸蛋活动
	 */
	public Boolean JoinBreakEgg(String activityId,String publicNumberId,String openid,String qrcode,String newId,String scanNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		BreakEgg breakEgg = BreakEgg.dao.findById(activityId);
		//这里参与用户数量+1
		String joinPropleNumber = breakEgg.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		breakEgg.set("ID", activityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存砸蛋活动用户参加记录
		int saveCommentWxUser = breakEggService.saveBreakEggWxUser(newId, activityId, openid, wxUserName, headImgUrl, uitils.newDate(), publicNumberId, qrcode, breakEgg.getActivityName(), "1");
		if(saveCommentWxUser>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 兑换一元购活动
	 */
	public Boolean JoinOneMoney(String activityId,String publicNumberId,String openid,String qrcode,String newId,String scanNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		OneMoneyShop oneMoney = OneMoneyShop.dao.findById(activityId);
		//这里参与用户数量+1
		String joinPropleNumber = oneMoney.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		oneMoney.set("ID", activityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存一元购活动用户参加记录
		int saveCommentWxUser = oneMoneyService.saveOneMoneyWxUser(newId, activityId, openid, wxUserName, headImgUrl, uitils.newDate(), publicNumberId, qrcode, oneMoney.getActivityName(), "0");
		if(saveCommentWxUser>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 兑换拼图活动
	 */
	public Boolean JoinPuzzle(String activityId,String publicNumberId,String openid,String qrcode,String newId,String scanNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		Puzzle puzzle = Puzzle.dao.findById(activityId);
		//这里参与用户数量+1
		String joinPropleNumber = puzzle.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		puzzle.set("ID", activityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存一元购活动用户参加记录
		int saveCommentWxUser = puzzleService.savePuzzleWxUser(newId, activityId, openid, wxUserName, headImgUrl, uitils.newDate(), publicNumberId, qrcode, puzzle.getActivityName(), "3");
		if(saveCommentWxUser>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 兑换拼团活动
	 */
	public Boolean JoinPurchase(String activityId,String publicNumberId,String openid,String qrcode,String newId,String scanNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		GroupPurchase groupPurchase = GroupPurchase.dao.findById(activityId);
		//这里参与用户数量+1
		String joinPropleNumber = groupPurchase.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		groupPurchase.set("ID", activityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存拼团活动用户参加记录
		int saveCommentWxUser = groupPurchaseService.saveGroupPurchaseWxUser(newId, activityId, openid, wxUserName, headImgUrl, uitils.newDate(), publicNumberId, qrcode, groupPurchase.getActivityName(), "0",groupPurchase.getGroupPrice());
		if(saveCommentWxUser>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 兑换转盘活动
	 */
	public Object[] JoinTurntable(String turntableActivityId,String publicNumberId,String openid,String qrcode,String newId,String scanNumber,
			String wxUserId,String wxUserName,String headImgUrl){
		TurnTable turnTable = TurnTable.dao.findById(turntableActivityId);
		//这里参与用户数量+1
		String joinPropleNumber = turnTable.getJoinPropleNumber();
		int parseInt = Integer.parseInt(joinPropleNumber);
		turnTable.set("TURNTABLE_ID", turntableActivityId).set("JOIN_PROPLE_NUMBER", parseInt+1+"").update();
		//保存抢红包活动用户参加记录
		Boolean resutl = new TurnTableWxUser().set("TURNTABLE_WXUSER_ID", newId).set("TURNTABLE_ID", turntableActivityId).set("ACTIVITY_NAME", turnTable.getActivityName()).set("OPENID", openid)
				.set("NICKNAME",wxUserName).set("HEADIMGURL", headImgUrl).set("BELONG_PUBLICNUMBER_ID",publicNumberId)
				.set("CREATE_TIME", uitils.newDate()).set("STATE", "0").set("SCAN_CODE", qrcode).set("SCAN_WINNING_NUMBER",scanNumber).save();
		List<AgentTurnTable> ttpList = turntableService.queryTurnTablePrizeByActivityId(turntableActivityId);
		TurnTableWxUser turnTableWxUser = TurnTableWxUser.dao.findById(newId);
		Object[] ret = new Object[8];
		if(resutl){
			ret[0]=scanNumber;
			ret[1]=qrcode;
			ret[2]=turnTable;
			ret[3]=openid;
			ret[4]=JSON.toJSONString(ttpList);
			ret[5]=turnTableWxUser;
			ret[6]=publicNumberId;
			ret[7]=turnTable.getActivityName();
		}else{
			ret = null;
		}
		return ret;
	}
	
	/**
	 * 兑换分享砍价活动
	 */
	/**
	 * 1.用户点击"立即砍价"代表参加该活动 2.新建一个用户参加活动记录 2.进入当前砍价信息页面，展示砍了多少，帮砍的好友 3.可邀请好友帮忙砍价
	 */
	public Object[] bargainInvitation(String newId,String belingPublicNumberId,String openid,String activityId,String qrcode,String nickName,String headImgUrl) {
		// 所属公众号
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(belingPublicNumberId);
		// 获取当前活动
		ShareBargain ab = ShareBargain.dao.findById(activityId);
		//修改砍价活动的参与人数
		int joinPropleNumber = ab.getJoinPropleNumber().intValue();
		new ShareBargain().set("ID", ab.getId()).set("JOIN_PROPLE_NUMBER",joinPropleNumber+1);
		// 活动奖品ID
		ShareBargainPrize sbp = new ShareBargainPrize();
		List<ShareBargainPrize> shareBargainPrizeList = shareBargainPrizeService.getShareBargainPrizeByActvityId(activityId);
		for(ShareBargainPrize shareBargainPrize:shareBargainPrizeList){
			sbp = shareBargainPrize;
		}
		String Id = newId;
		ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(Id);
		System.out.println("测试是"+sbw);
		if(sbw==null){
			sbw = new ShareBargainWxuser();
			// 新建一个用户参加活动记录
			sbw.setJoinActivityId(activityId);
			sbw.setNickName(nickName);
			sbw.setHeadImgUrl(headImgUrl);
			sbw.setJoinBelongPublicNumberId(belingPublicNumberId);
			sbw.setPrice(sbp.getOriginalPrice());
			sbw.setNowPrice(sbp.getOriginalPrice());
			sbw.setLowPrice(sbp.getLowPrice());
			sbw.setBargainSection(sbp.getBargainSection());
			sbw.setBargainNumber(sbp.getBargainNumber().toString());
			sbw.setshareBargainPrizeId(sbp.getId());
			sbw.setId(Id);
			// 保存为未发货
			sbw.setGoodsState("2");
			DateUitils.getUitils();
			new ShareBargainWxuser().set("ID", Id).set("OPENID", openid).set("NICKNAME", nickName)
					.set("HEADIMGURL", headImgUrl).set("JOIN_ACTIVITY_ID", activityId).set("SCAN_CODE", activityId)
					.set("BELONG_PUBLICNUMBER_ID", belingPublicNumberId).set("PRICE", sbp.getOriginalPrice()).set("LOW_PRICE", sbp.getLowPrice())
					.set("NOW_PRICE", sbp.getOriginalPrice()).set("BARGAIN_SECTION", sbp.getBargainSection()).set("BARGAIN_NUMBER", sbp.getBargainNumber().toString())
					.set("CREATE_TIME", uitils.newDate()).set("SHAREBARGAIN_PRIZE_ID", sbp.getId())
					.set("STATE", "1").set("GOODS_STATE", "2").save();
		}
		/**
		 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
		 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
		 */
		String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
				+ "/ShareBargain/friendRedirect?friendBargain=" + Id + "&activityId=" + activityId
				+ "&shareBargainPrizeId=" + sbp.getId() + "&appid=" + spn.getAppId();
		/**
		 * 查询出当前砍价活动帮助砍价的朋友
		 */
		List<ShareBargainHelp> sbhList = ShareBargainHelpService.getService()
				.getShareBargainHelpByFriendActivityId(sbw.getId());
		Object[] ret = new Object[7];
		ret[0]=url;
		ret[1]=ab;
		ret[2]=sbw;
		ret[3]=sbp;
		ret[4]=sbhList;
		ret[5]=spn;
		ret[6]=ab.getActivityName();
		return ret;
	}
	
	
	
	/**
	 * 查询积分关联产品返回单个对象
	 */
	public IntegralProduct queryIntegralProductById(String id){
		String sql = PropKit.use("database.properties").get("queryIntegralProductById");
		List<Record> record = Db.find(sql,id);
		IntegralProduct integralProduct = new IntegralProduct();
		for (Record cord : record) {
			integralProduct.mapping(cord,integralProduct);
		}
		return integralProduct;
	}
	
	
	/**
	 * 保存积分“立即兑换”记录
	 */
	public int saveIntegralExchange(IntegalExchange integalExchange){
		String sql = PropKit.use("database.properties").get("saveIntegralExchange");
		return Db.update(sql,integalExchange.getIntegralExchangeId(),
				integalExchange.getIntegralId(),
				integalExchange.getExchangeType(),
				integalExchange.getExchangePrizeId(),
				integalExchange.getExchangeUseIntegral(),
				integalExchange.getExchangePrizeName(),
				integalExchange.getExchangePrizeImg(),
				integalExchange.getExchangePrizeNumber(),
				integalExchange.getOpenId(),
				integalExchange.getAddresseeName(),
				integalExchange.getAddresseeAddress(),
				integalExchange.getAddresseePhone(),
				integalExchange.getState(),integalExchange.getNickName(),integalExchange.getHeadimgUrl(),integalExchange.getCreateTime(),integalExchange.getProductWinningInfoId(),integalExchange.getBelongPublicNumberId());
	}
	
	/**
	 * 报表查询所有的积分活动
	 */
	public List<Integral> queryIntegralReportAll(String userCode,String userId,String state,String startTime,String endTime){
		String sql = PropKit.use("database.properties").get("queryIntegralReportAll");
		if(!userCode.equals("0")){
			sql+=" AND ACITIVITY_LAUNCH_USERID = "+userId+"AND ACITIVITY_LAUNCH_USERCODE="+userCode;
		}
		if (!"".equals(state) && state != null) {
			sql += " and STATE = " + state;
		}
		if (!"".equals(startTime) && !"".equals(endTime) && startTime != null && endTime != null) {
			sql += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		return Integral.dao.find(sql);
	}
	
	/**
	 * 根据所属活动ID和微信参与记录ID和openid查询出是否存在积分记录
	 */
	public static IntegralWinningInfo queryIntegralWinningInfo(String belongActivityId,String JoinWxUserId,String openid){
		String sql = PropKit.use("database.properties").get("queryIntegralWinningInfo");
		return IntegralWinningInfo.dao.findFirst(sql,belongActivityId,JoinWxUserId,openid);
	}
	

	
	/**
	 * 新增积分获奖记录
	 */
	public int saveIntegralWinningInfo(IntegralWinningInfo info){
		String sql = PropKit.use("database.properties").get("saveIntegralWinningInfo");
		return Db.update(sql,info.getId(),info.getBelongActivityId(),info.getActivityName(),info.getActivityNameType(),info.getWinningIntegral(),info.getCreateTime(),info.getStartTime(),info.getEndTime()
				,info.getOpenid(),info.getActivityWxUserId(),info.getBelongPublicnumberId());
	}
	
	/**
	 * 查询所有的积分活动
	 * @return
	 */
	public List<Integral> allIntegral(String state){
		String sql = PropKit.use("database.properties").get("allIntegral");
		sql += " WHERE 1=1 ";
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
		return Integral.dao.find(sql);
	}
	
	/**
	 * 根据积分获得ID修改积分值
	 */
	public int updateIntegralWinningInfoByIntegralNumber(int i,String id){
		String sql = PropKit.use("database.properties").get("updateIntegralWinningInfoByIntegralNumber");
		return Db.update(sql,i+"",id);
	}
	
	/**
	 * 根据活动ID，查询积分兑换记录
	 */
	public List<IntegalExchange> queryIntegalExchangeByActivityId(String activityId,String nickName){
		String sql = PropKit.use("database.properties").get("queryIntegalExchangeByActivityId");
		if(nickName!=null){
			sql += " AND NICKNAME = "+nickName;
		}
		List<IntegalExchange> integalExchangeList = IntegalExchange.dao.find(sql,activityId);
		return integalExchangeList;
	}
	/**
	 * 修改奖品配置剩余数量
	 */
	public int updateIntegralProductPrizeNumberById(String surplusNumber,String id){
		String sql = PropKit.use("database.properties").get("updateIntegralProductPrizeNumberById");
		return Db.update(sql,surplusNumber,id);
	}
	
	/**
	 * 根据openid和publicNumber查询出当前公众号当前人的所有获得积分记录
	 * @throws ParseException 
	 */
	public List<IntegralWinningInfo> getIntegralByOpenidAndPublicNumber(String openid,String publicNumber,String startTime,String endTime){
		String sql = PropKit.use("database.properties").get("getIntegralByOpenidAndPublicNumber");
		if (!"".equals(startTime) && !"".equals(endTime) && startTime != null && endTime != null) {
			String st=startTime+" 00:00:00";
			String et=endTime+" 23:59:59";
			if(startTime.equals(endTime)){
				sql += " and create_time >= '"+st+"' and create_time <= '"+et+"' ";
			}else{
				sql += " and create_time >= '"+st+"' and create_time <= '"+et+"' ";
			}
		}
		sql += " order by CREATE_TIME desc ";
		List<IntegralWinningInfo> integralWinningInfoList = IntegralWinningInfo.dao.find(sql,openid,publicNumber);
		return integralWinningInfoList;
	}
	
	/**
	 * 根据openid和publicNumber查询出当前公众号当前人的所有兑换积分
	 */
	public List<IntegalExchange> getIntegralExchangeByOpenidAndPublicNumber(String openid,String publicNumber,String startTime,String endTime){
		String sql = PropKit.use("database.properties").get("getIntegralExchangeByOpenidAndPublicNumber");
		if (!"".equals(startTime) && !"".equals(endTime) && startTime != null && endTime != null) {
			String st=startTime+" 00:00:00";
			String et=endTime+" 23:59:59";
			if(startTime.equals(endTime)){
				sql += " and create_time >= '"+st+"' and create_time <= '"+et+"' ";
			}else{
				sql += " and create_time >= '"+st+"' and create_time <= '"+et+"' ";
			}
		}
		sql += " order by CREATE_TIME desc ";
		List<IntegalExchange> integalExchangeList = IntegalExchange.dao.find(sql,openid,publicNumber);
		return integalExchangeList;
	}
	
	/**
	 * 这里查询参与活动的记录
	 * getJoninList
	 * @author 81046
	 * @date 2018年5月14日上午9:34:46
	 * @param openid
	 * @param sellerPublicNumberId
	 * @param startTime
	 * @param endtime
	 * @return
	 */
	public List<JoinActivity> getJoninList(String openid,String sellerPublicNumberId,String startTime,String endtime){
		//这里查询参与活动的记录
		String sql="select * from JOINACTIVITY where 1= 1 ";
		if(!StringUtils.isEmpty(openid)){
			sql+="  and openid = '"+openid+"'";
		}
		if(!StringUtils.isEmpty(sellerPublicNumberId)){
			sql+="  and SELLERPUBLICNUMBERID = '"+sellerPublicNumberId+"'";
		}
		if(!StringUtils.isEmpty(startTime)&&!StringUtils.isEmpty(endtime)){
			String st=startTime+" 00:00:00";
			String et=endtime+" 23:59:59";
			if(startTime.equals(endtime)){
				sql += " and JOINTIME >= '"+st+"' and JOINTIME <= '"+et+"' ";
			}else{
				sql += " and JOINTIME >= '"+st+"' and JOINTIME <= '"+et+"' ";
			}
		}
		sql += " order by JOINTIME desc ";
		List<JoinActivity> joinActivityList = JoinActivity.dao.find(sql);
		return joinActivityList;
	}
}
