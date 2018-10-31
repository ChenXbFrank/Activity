package com.activity.common.controller.pc.robRedConfig;

import java.io.File;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.Activity;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.centerObjcet.IntegralExchangeActivity;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.centerObjcet.robRed.TestPrize;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.robRed.RedRodWinInfo;
import com.activity.common.model.robRed.RobRed;
import com.activity.common.model.robRed.RobRedPrize;
import com.activity.common.model.robRed.RobRedWxUser;
import com.activity.common.model.robRed.RobRedWxUserWining;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.robRed.RobRedPrizeService;
import com.activity.common.service.robRed.RobRedService;
import com.activity.common.service.robRed.RobRedWxUserService;
import com.activity.common.service.robRed.RobRedWxUserWiningService;
import com.activity.common.service.system.ActivityService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerRelationService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.system.Tools;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.web.controller.ControllerPath;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 抢红包活动
 * 
 * @author 唐
 */
@ControllerPath(controllerKey = "/robRedConfig")
public class RobRedConfigController extends BaseController {
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	//红包service
	RobRedService robRedService = RobRedService.getService();
	// 可申请活动service
	ActivityService activityService = ActivityService.getService();
	//抢红包奖品信息
	RobRedPrizeService robRedPrizeService = RobRedPrizeService.getService();
	//抢红包参与微信用户
	RobRedWxUserService robRedWxUserService = RobRedWxUserService.getService();
	//抢红包参与微信用户中奖记录
	RobRedWxUserWiningService robRedWxUserWiningService = RobRedWxUserWiningService.getService();
	// 时间工具类
	DateUitils uitils = DateUitils.getUitils();

	/**
	 * 我的活动-抢红包活动，查询全部我的活动
	 */
	public void allMyActvity(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		List<RobRed> robredList = robRedService.getRobRedByUserCode(user.getUserCode(),activityName,state);
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		for (RobRed rr : robredList) {
			IntegralExchangeActivity ba = new IntegralExchangeActivity();
			ba.setActivityId(rr.getRedId());
			ba.setActivityImg(rr.getBackGroundImg());
			ba.setActivityName(rr.getActivityName());
			NumberFormat nf = NumberFormat.getInstance();
			try {
				ba.setJoinNumber(nf.parse(rr.getJoinPropleNumber()).toString());
				ba.setWinNumber(nf.parse(rr.getWinningPropleNumber()).toString());
			} catch (ParseException e) {
				e.printStackTrace();
			}
			activityList.add(ba);
		}
		//名称查询
		setAttr("activityName", activityName);
		//状态查询
		setAttr("state", state);
		setAttr("robredList", activityList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-抢红包活动-我的活动查询")
		.set("USE_TIME", uitils.newDate()).save();
		render("/robRedConfig/red-my-all-activity.html");
	}
	
	/**
	 * 这里是分享砍价的所有活动记录 当前登录人 
	 * 返回json格式
	 */
	public void redActivityJson() {
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String sql="SELECT * FROM TB_ROB_RED WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		List<RobRed> robredList = RobRed.dao.find(sql,user.getUserCode());
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		for (RobRed rr : robredList) {
			IntegralExchangeActivity ba = new IntegralExchangeActivity();
			ba.setActivityId(rr.getRedId());
			ba.setActivityImg(rr.getBackGroundImg());
			ba.setActivityName(rr.getActivityName());
			NumberFormat nf = NumberFormat.getInstance();
			try {
				ba.setJoinNumber(nf.parse(rr.getJoinPropleNumber()).toString());
				ba.setWinNumber(nf.parse(rr.getWinningPropleNumber()).toString());
			} catch (ParseException e) {
				e.printStackTrace();
			}
			activityList.add(ba);
		}
		renderJson(activityList);
	}
	
	/**
	 * 查询红包详细
	 */
	public void robRedInfo(){
		//红包基本信息
		String redRedId=getPara("activityId");
		RobRed rr = RobRed.dao.findById(redRedId);
		// 根据活动ID查询该活动的相关的信息
		List<ActivitySellerOutInfo> sellerInfoList = sellerOutInfoService.getSellerInfoByActivityId(redRedId);
		//奖品信息
		List<RobRedPrize> rrpList = robRedPrizeService.getRobRedPrizeByActivityId(redRedId);
		setAttr("robRed", rr);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("rrpList", rrpList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-抢红包活动-查询红包详细")
		.set("USE_TIME", uitils.newDate()).save();
		render("/robRedConfig/red-my-one-activity-info.html");
	}
	
	/**
	 * 红包报表页面
	 */
	public void redRobReport1(){
		// 这里查询该用户所有申请分享砍价的数据
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		String activityName = getPara("activityName");
		// 活动状态：0申请中 1审批通过 2 驳回
		String result = "";
		String state = getPara("state");
		if(state != null){
			if (state.equals("申请中")) {
				result = "0";
			} else if (state.equals("通过")) {
				result = "1";
			} else if (state.equals("驳回")) {
				result = "2";
			} else if (state.equals("全部")) {
				result = "";
			}
		}
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		
		List<RobRed> robRedList = robRedService.getAllRobRedByUserCode(userCode, activityName, result, startTime, endTime);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-抢红包活动-报表")
		.set("USE_TIME", uitils.newDate()).save();
		setAttr("user", user);
		setAttr("activityName", activityName);
		setAttr("state", state);
		setAttr("startTime", startTime);
		setAttr("endTime", endTime);
		setAttr("robRedList", robRedList);
		render("/robRedConfig/red-activity-report-all.html");
	}
	
	/**
	 * 红包报表查看单个活动详细
	 */
	public void singleRedRobReport(){
		// 这里查询该用户所有申请分享砍价的数据
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String nickName = getPara("nickName");
		String activityName = getPara("activityName");
		//活动ID
		String activityId = getPara("activityId");
		List<RobRedWxUser> rrwuList = robRedWxUserService.getRobRedWxUserByRedId(activityId,nickName);
		setAttr("rrwuList", rrwuList);
		setAttr("nickName", nickName);
		setAttr("activityId", activityId);
		setAttr("activityName", activityName);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-抢红包活动-单个活动报表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/robRedConfig/red-activity-report.html");
	}
	
	
	/**
	 * 红包报表详细
	 */
	public void redRobReportInfo(){
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String robRedWxUserId=getPara("robRedWxUserId");
		String activityId = getPara("activityId");
		//根据用户参与记录ID 查询用户中奖记录
		List<RobRedWxUserWining> rrwuwList = robRedWxUserWiningService.queryRobRedWxUserWiningByWxUserId(robRedWxUserId);
		setAttr("rrwuwList", rrwuwList);
		String activityName = getPara("activityName");
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-抢红包活动-单个活动报表详细")
		.set("USE_TIME", uitils.newDate()).save();
		setAttr("activityId", activityId);
		setAttr("activityName", activityName);
		render("/robRedConfig/red-activity-report-info.html");
	}
	
	/**
	 * 红包审批 **************************
	 */
	public void redRobApprove(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		setAttr("robRedList", null);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-抢红包活动-红包审批")
		.set("USE_TIME", uitils.newDate()).save();
		render("/robRedConfig/red-activity-approve.html");
	}
	
	/**
	 * 红包审批详细
	 */
	public void redRobApproveInfo(){
		//红包基本信息
		String redRedId=getPara("activityId");
		RobRed rr = RobRed.dao.findById(redRedId);
		// 根据活动ID查询该活动的相关的信息
		List<ActivitySellerOutInfo> sellerInfoList = sellerOutInfoService.getSellerInfoByActivityId(redRedId);
		//奖品信息
		List<RobRedPrize> rrpList = robRedPrizeService.getRobRedPrizeByActivityId(redRedId);
		setAttr("robRed", rr);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("rrpList", rrpList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-抢红包活动-"+rr.getActivityName()+"详细")
		.set("USE_TIME", uitils.newDate()).save();
		render("/robRedConfig/red-activity-approve-info.html");
	}
	
	
	/**
	 * 保存活动审批
	 */
	public void saveRedRobApprove(){
		String remake = getPara("remake");
		String activityId = getPara("activityId");
		String state = getPara("state");
		SystemUser user = CacheLoginUser();
		String sql = "select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellerOutInfo = ActivitySellerOutInfo.dao.find(sql, activityId);
		for (ActivitySellerOutInfo as : sellerOutInfo) {
			// 如果是驳回的话 将活动运单的状态改为可以用 状态 1可以用 2不可用
			if (state.equals("2")) {
				as.set("ID", as.getId()).set("STATE", 1).update();
			} else if (state.equals("1")) {
				as.set("ID", as.getId()).set("STATE", 2).update();
			}
		}
		new RobRed().set("RED_ID", activityId).set("STATE", state).set("COMFIRMUSERID", user.getUserId()).set("COMFIRMUSERNAME", user.getUserName())
				.set("COMFIRMTIME", uitils.newDate()).set("COMFIRMADVISE", remake).update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-抢红包活动-保存审核")
				.set("USE_TIME", uitils.newDate()).save();
		renderJson("result", "true");
	}
	
	/**
	 * 抢红包活动 配置   进入红包配置页面
	 */
	public void robRedConfigUpdate() {
		String belongActivityId = getPara("activity");
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-抢红包活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/robRedConfig/red-edit.html");
	}
	
	/**
	 * 这里保存红包的配置信息
	 */
	public void robRedConfigSave(){
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		//红包配置信息
		String redconfig = getPara("redconfig");
		System.out.println("传递模式一参数"+redconfig);
		JSONObject jsonRedBao = JSONObject.fromObject(redconfig);
		Activity activity = activityService.getActivityByRemarks("robRed");
		RobRed red=new RobRed();
		boolean result = false;
		String scanRobRedNum = "";
		//模式一
		if(jsonRedBao.get("Pattern").toString().equals("1")){
			String patternOne = getPara("patternOne");//金额合计，概率等参数
			String prizeLists = getPara("prizeList");//奖项集合
			//奖品的配置  都是数组
			JSONArray jsonPrizeLists = JSONArray.fromObject(prizeLists);
			//奖品概率
			JSONObject jsonpatternOne = JSONObject.fromObject(patternOne);//JSONArray jsonpatternOne = JSONArray.fromObject(patternOne);
			@SuppressWarnings("unchecked")
			List<TestPrize> prizeList = (List<TestPrize>) JSONArray.toCollection(jsonPrizeLists,TestPrize.class);
			//循环保存红包奖品配置信息
			for (TestPrize prize : prizeList) {
				//先判断是积分还是金钱
				if("积分".equals(prize.getPrize())){
					if(prize.getMoney()!=null||!prize.getMoney().equals("")){
						if(Integer.parseInt(prize.getMoney())!=0){
							RobRedPrize p=new RobRedPrize();
							result = p.set("RED_PRIZE_ID", UUID.randomUUID().toString().replaceAll("-", ""))
							 .set("RED_ID", activityId) //红包活动ID
							 .set("PRIZE_PROJECT", prize.getPrize()) //奖项名称
							 .set("SUBTOTAL", prize.getTotal().toString()) //小计
							 .set("RED_WINNING_PROBABILITY", prize.getProbability())  //积分中奖概率  注：模式一时积分中奖概率放入红包中奖人数
							 .set("INTEGRAL_WINNING_PROBABILITY", prize.getProbability())
							 .set("WINNING_INTEGRAL", prize.getMoney())  //中奖积分
							 .set("GET_PRIZE_NUMBER", prize.getPeople())  //积分中奖人数  注：模式一时积分中奖人数放入红包中奖人数
							 .set("RED_PROBABILITY_TOTAL", jsonpatternOne.get("prizeProbability").toString())  //积分概率合计  注：模式一时积分中奖概率合计放入红包中奖合计
							 .set("PRIZE_PROJECT_TOTAL_MONEY",jsonpatternOne.get("Bonus").toString())  //奖项金额合计
							 .set("RED_PROBABILITY_TOTAL", jsonpatternOne.get("prizeprobabilityTotal").toString())  //奖项概率合计
							 .set("CREATE_TIME",uitils.newDate())  //奖项创建时间
							 .set("SURPLUS_NUMBER",prize.getPeople())  //剩余数量
							 .set("SURPLUS_PRIZE_PROBABILITY",prize.getProbability())  // 剩余奖品中奖概率
							 .set("SURPLUS_PROBABILITY",jsonpatternOne.get("surplus").toString())  //剩余概率
							 .save();
							scanRobRedNum = "1";
						}
					}
				}else{
					RobRedPrize p=new RobRedPrize();
					result = p.set("RED_PRIZE_ID", UUID.randomUUID().toString().replaceAll("-", ""))
					 .set("RED_ID", activityId)
					 .set("PRIZE_PROJECT", prize.getPrize()) //奖项名称
					 .set("PRIZE_PROJECT_MONEY", prize.getMoney()) // 模式一:奖项金额(积分不填写) 
					 .set("GET_PRIZE_NUMBER", prize.getPeople())  //模式一:获奖人数 
					 .set("SUBTOTAL", prize.getTotal()) //金额小计
					 .set("RED_WINNING_PROBABILITY", prize.getProbability())  //红包中奖概率
					 .set("RED_PROBABILITY_TOTAL", jsonpatternOne.get("prizeprobabilityTotal").toString())  //概率合计
					 .set("PRIZE_PROJECT_TOTAL_MONEY",jsonpatternOne.get("Bonus").toString())  //奖项金额合计
					 .set("SURPLUS_PROBABILITY",jsonpatternOne.get("surplus").toString())  //剩余概率
					 .set("SURPLUS_NUMBER",prize.getPeople())  //剩余数量
					 .set("SURPLUS_PRIZE_PROBABILITY",prize.getProbability())  // 剩余奖品中奖概率
					 .set("CREATE_TIME",uitils.newDate())  //奖项创建时间
					 .save();
					scanRobRedNum = "1";
				}
			}
		//模式二
		}else if(jsonRedBao.get("Pattern").toString().equals("2")){
			//模式二
			String patternTwo = getPara("patternTwo");
			JSONObject jsonpatternTwo = JSONObject.fromObject(patternTwo);
			RobRedPrize p=new RobRedPrize();
			result = p.set("RED_PRIZE_ID", UUID.randomUUID().toString().replaceAll("-", ""))
					 .set("RED_ID", activityId)
					 .set("SCANRODREDNUM", jsonpatternTwo.get("scanRodRedNum").toString()) //扫码中奖次数
					 .set("PRIZE_PROJECT_MONEY", jsonpatternTwo.get("redMoney").toString()) // 模式二:红包金额
					 .set("GET_PRIZE_NUMBER", jsonpatternTwo.get("winningRedPeopleNumber").toString())  // 模式二:中奖人数
					 .set("RED_WINNING_PROBABILITY", jsonpatternTwo.get("redProbability").toString())//红包中奖概率
					 .set("INTEGRAL_WINNING_PROBABILITY", jsonpatternTwo.get("integralProbability").toString())  //积分概率合计
					 .set("WINNING_INTEGRAL", jsonpatternTwo.get("winningIntegral").toString())  //中奖积分
					 .set("WINNING_INTEGRAL_NUMBER", jsonpatternTwo.get("winningIntegralPeopleNumber").toString())  //积分获奖人数
					 .set("PRIZE_PROJECT_TOTAL_MONEY", jsonpatternTwo.get("prizeProjectTotalMoney").toString())  //奖项金额合计
					 .set("INTEGRAL_PROBABILITY_TOTAL", jsonpatternTwo.get("integralprobabilityTotal").toString())  //积分中奖概率合计
					 .set("RED_PROBABILITY_TOTAL", jsonpatternTwo.get("prizeprobabilityTotal").toString())  //奖项中奖概率合计
					 .set("SURPLUS_PROBABILITY",jsonpatternTwo.get("surplus").toString())  //剩余概率
					 .set("CREATE_TIME",uitils.newDate())  //奖项创建时间
					 .set("SURPLUS_NUMBER",jsonpatternTwo.get("winningRedPeopleNumber").toString())  //剩余数量
					 .set("SURPLUS_INTEGRAL",jsonpatternTwo.get("winningIntegral").toString())  //剩余积分
					 .set("SURPLUS_MONEY",jsonpatternTwo.get("redMoney").toString())  //剩余金额
					 .set("SURPLUS_PRIZE_PROBABILITY",jsonpatternTwo.get("redProbability").toString())  // 剩余奖品中奖概率
					 .set("SURPLUS_INTEGRAL_NUMBER",jsonpatternTwo.get("winningIntegralPeopleNumber").toString())  // 剩余积分数量
					 .set("SURPLUS_INTEGRAL_PROBABILITY",jsonpatternTwo.get("integralProbability").toString())  // 剩余积分奖品中奖概率
					 .save();
			scanRobRedNum = jsonpatternTwo.get("scanRodRedNum").toString();
		}
		//模式二扫码次数等于参与次数，根据总瓶数*单个用户参与次数=该活动总共参与次数
		int joinNumber = Integer.parseInt(scanRobRedNum)*Integer.parseInt(jsonRedBao.get("sum").toString());
		result = red.set("RED_ID", activityId)
				   .set("ACTIVITY_NAME", jsonRedBao.get("ActivityName").toString())
				   .set("ACITIVITY_LAUNCH_USERID", user.getUserId())
				   .set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
				   .set("STATE", "0")
				   .set("STARTTIME", jsonRedBao.get("StartTime").toString())
				   .set("ENDTIME", jsonRedBao.get("EndTime").toString())
				   .set("BACKGROUND_IMG", activity.getImg())
				   .set("MOBLEC_BACKGROUND_IMG", jsonRedBao.get("picsrc").toString())
				   .set("CREATE_TIME",uitils.newDate())
				   .set("APPLYPHONE",user.getPhone())
				   .set("APPLYUSERNAME",user.getUserName())
				   .set("SENDERNAME", jsonRedBao.get("SendOut").toString())
				   .set("WISH", jsonRedBao.get("Blessing").toString())
				   .set("REMARKS", jsonRedBao.get("Remarks").toString())
				   .set("PATTERN", jsonRedBao.get("Pattern").toString())
				   .set("BELONG_ACTIVITY_ID", jsonRedBao.get("belong").toString())
				   .set("TOTAL", joinNumber+"")
				   .set("SCAN_RED_NUMBER", scanRobRedNum)
				   .save();
		//运单信息
		String billLists = getPara("billLists");
		if(result){
			//这是运单信息
			JSONArray jsonBillLists = JSONArray.fromObject(billLists);
			@SuppressWarnings("unchecked")
			List<SellerOutInfoChoice> sellerOutList = (List<SellerOutInfoChoice>) JSONArray.toCollection(jsonBillLists,
					SellerOutInfoChoice.class);
			for (SellerOutInfoChoice so : sellerOutList) {
				ActivitySellerOutInfo as = new ActivitySellerOutInfo();
				String recordId = so.getRecordId();
				//在这里处理运单状态   将该运单修改为已开展为活动中
				String sql = PropKit.use("database.properties").get("updateSelleInfoState");
				Db.update(sql,recordId);
				SellerOutInfo info = sellerOutInfoService.getSellerOutInfoByOutRecordId(recordId);
				as.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
				  .set("ACTIVITY_ID", activityId)
				  .set("SELLEROUTINFO_RECORDID", recordId)
				  .set("OUTNO", so.getOutNo())
				  .set("SELLER_USERCODE", info.getSellerId())
				  // 状态 1可以用 2不可用
				  .set("STATE", 2)
				  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("RobRed"))
				  .set("OUTSELLERNAME", so.getRecsellerName())
				  .set("PRODUCTNAME", so.getProductName())
				  .set("DEEP", so.getDegree())
				  .set("VOLUME", so.getVolume())
				  .set("SPEC", so.getSpec())
				  .set("VOLUME", so.getVolume())
				  .set("BOXSIZE", so.getBoxCode())
				  .set("BANDNAME", so.getBrandsName())
				  .set("OUTDATE", so.getOutTime())
				  .save();
			}
		}
		Map<Object, Object> map = new HashMap<Object, Object>();
		if (result) {
			map.put("result", "true");
			map.put("activityId", activityId);
		} else {
			map.put("result", "false");
			map.put("activityId", activityId);
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "保存-抢红包活动")
		.set("USE_TIME", uitils.newDate()).save();
		renderJson(map);
	}

	/**
	 * 进入活动报表
	 */
	public void geToRebReport(){
		render("/robRedConfig/red-activity-report-all.html");
	}
	
	/**
	 * 查询所有的红包活动 分页显示   报表页面  
	 */
	public void getRebPageInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = robRedService.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 点击红包活动更多的时候
	 */
	public void redRobReport(){
		String activityId = getPara("activityId");
		setAttr("activityId", activityId);
		render("/robRedConfig/red-activity-report-all.html");
	}
	
	/**
	 * 进入到更多的页面
	 */
	public void goToMoreRedInfo(){
		String activityId = getPara("activityId");
		setAttr("activityId", activityId);
		render("/robRedConfig/red-activity-report.html");
	}
	
	/**
	 * 分页加载更多的数据
	 */
	public void getRebPageMoreInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityId = getPara("activityId");
		RobRed robRed = RobRed.dao.findById(activityId);
		String nickName = getPara("nickName");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = RobRedWxUser.dao.paginate1(Integer.parseInt(currentPage), page,activityId,nickName);
		model.put("bigActivityId", activityId);
		model.put("activityName", robRed.getActivityName());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 红包报表导出
	 */
	public void exportRebExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "rebTemplate.xlsx";
		// 导出excel的标题
		String title ="红包报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<RobRed> list=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from tb_rob_red";
		    list = RobRed.dao.find(sql);
		}else{
			String sql="select * from tb_rob_red where ACITIVITY_LAUNCH_USERCODE= ? ";
			list=RobRed.dao.find(sql,userCode);
		}
		List<RobRed> list1=new ArrayList<>();
		for (RobRed robRed : list) {
			if(robRed.getState().equals("0")){
				robRed.setSpareOne("申请中");
			}else if(robRed.getState().equals("1")){
				robRed.setSpareOne("通过");
			}else if(robRed.getState().equals("2")){
				robRed.setSpareOne("驳回");
			}
			list1.add(robRed);
		}
		Tools.comExportExcel(list1, title, getResponse(),templateFilePath);
		renderNull();
	}
	
	/**
	 * 导出红包详情报表
	 */
	public void exportRebInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "redWxTemplate.xlsx";
		// 导出excel的标题
		String title ="红包详情报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql=PropKit.use("database.properties").get("getRobRedWxUserByRedId");
		List<RobRedWxUser> list = RobRedWxUser.dao.find(sql,activityId);
		List<RedRodWinInfo> list1=new ArrayList<>();
		String sql1=PropKit.use("database.properties").get("getRobRedWxUserByRedWxuserId");
		for (RobRedWxUser r : list) {
			RedRodWinInfo rw=new RedRodWinInfo();
			rw.setNickName(r.getNickName());
			rw.setActivityName(r.getActivityName());
			rw.setCreateTime(r.getCreateTime());
			String redWxuserId = r.getRedWxuserId();
			RobRedWxUserWining win = RobRedWxUserWining.dao.findFirst(sql1,redWxuserId);
			if(win!=null){
				rw.setPrizeType(win.getPrizeProject());
				rw.setWinInfo(win.getWinningMoney());
			}
			list1.add(rw);
		}
		Tools.comExportExcel(list1, title, getResponse(),templateFilePath);
		renderNull();
	}
	
	/**
	 * 删除红包活动
	 */
	public void deleteRedActivity(){
		boolean result=false;
		String activityId = getPara("activityId");
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		for (ActivitySellerOutInfo activitySellerOutInfo : sellInfoList) {
			//在这里处理运单状态   将该运单修改为未在活动中
			String sql1 = PropKit.use("database.properties").get("updateSelleInfoNoState");
			Db.update(sql1,activitySellerOutInfo.getSellerOutInfoRecordId());
			result = ActivitySellerOutInfo.dao.deleteById(activitySellerOutInfo.getId());
		}
		//红包配置
		String sql1="select * from TB_ROB_RED_PRIZE where RED_ID = ? ";
		List<RobRedPrize> list = RobRedPrize.dao.find(sql1,activityId);
		for (RobRedPrize robRedPrize : list) {
			result = RobRedPrize.dao.deleteById(robRedPrize.getRedId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		result = RobRed.dao.deleteById(activityId);
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
}
