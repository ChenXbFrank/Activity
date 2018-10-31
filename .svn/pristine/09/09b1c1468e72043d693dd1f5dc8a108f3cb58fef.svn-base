package com.activity.common.controller.pc.jzRedConfig;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.TbCustomActivity;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.centerObjcet.robRed.TestPrize;
import com.activity.common.model.jzRed.JzRed;
import com.activity.common.model.jzRed.JzRedPrize;
import com.activity.common.model.jzRed.JzRedWxUser;
import com.activity.common.model.jzRed.JzRedWxUserWining;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.customActivity.CustomActivityService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerRelationService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.system.Tools;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.web.controller.ControllerPath;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 尖庄红包
 * @author ChenXb
 *
 * 2018年8月21日
 */
@ControllerPath(controllerKey = "/jzRedConfig")
public class JzRedController extends BaseController{
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	
	CustomActivityService customActivityService = CustomActivityService.getService();
	
	/**
	 * 申请尖庄红包
	 */
	public void apply(){
		String belongActivityId = getPara("activity");
		SystemUser user = CacheLoginUser();
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-砸金蛋活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-edit.html");
	}
	
	/**
	 * 保存申请的尖庄活动
	 */
	public void saveApplyInfo(){
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		//红包配置信息
		String redconfig = getPara("redconfig");
		JSONObject jsonRedBao = JSONObject.fromObject(redconfig);
		TbCustomActivity activity = customActivityService.getActivityByRemark("jzRed");
		JzRed red=new JzRed();
		boolean result = false;
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
							JzRedPrize p=new JzRedPrize();
							result = p.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
							 .set("JZ_RED_ID", activityId) //红包活动ID
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
						}
					}
				}else{
					JzRedPrize p=new JzRedPrize();
					result = p.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
					 .set("JZ_RED_ID", activityId)
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
				}
			}
		//模式二
		}else if(jsonRedBao.get("Pattern").toString().equals("2")){
			//模式二
			String patternTwo = getPara("patternTwo");
			JSONObject jsonpatternTwo = JSONObject.fromObject(patternTwo);
			JzRedPrize p=new JzRedPrize();
			result = p.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
					 .set("JZ_RED_ID", activityId)
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
		}
		//模式二扫码次数等于参与次数，根据总瓶数*单个用户参与次数=该活动总共参与次数
		result = red.set("ID", activityId)
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
				   .set("TOTAL", jsonRedBao.get("sum").toString())
				   .set("RULEIMG", jsonRedBao.get("ruleImg").toString())
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
				  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("JzRed"))
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
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "保存-尖庄抢红包活动")
		.set("USE_TIME", uitils.newDate()).save();
		renderJson(map);
	}
	
	
	/**
	 * 尖庄红包审批页面
	 */
	public void approve(){
		setAttr("activityName", "");
		setAttr("state", "");
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入审批列表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-activity-approve.html");
	}
	
	/**
	 * 审批页面进来加载的方法
	 */
	public void approveJzRedPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = JzRed.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 审批尖庄红包活动详情
	 * //TODO  （其实也是我的活动详情）
	 */
	public void approveJzRedInfo(){
		String activityId = getPara("activityId");
		//查活动
		JzRed jzRed = JzRed.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_JZ_RED_PRIZE where JZ_RED_ID = ? ";
		List<JzRedPrize> prizeList = JzRedPrize.dao.find(sql1,activityId);
		setAttr("jzRed", jzRed);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "审批开酒瓶活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-activity-approve-info.html");
	}
	
	
	/**
	 * 处理审批
	 */
	public void handleApproveJzRed(){
		SystemUser user = CacheLoginUser();
		String activityId = getPara("activityId");
		String state = getPara("state");
		String advice = getPara("remake");
		JzRed jzRed = JzRed.dao.findById(activityId);
		boolean result = jzRed.set("ID", activityId)
		        .set("STATE", state)
		        .set("COMFIRMADVISE", advice)
		        .set("COMFIRMTIME", DateUitils.newDateByYMD())
		        .set("COMFIRMUSERID", user.getUserId())
		        .set("COMFIRMUSERNAME", user.getUserName())
		        .update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "审批开酒瓶活动-处理审批")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	
	/**
	 * 我的活动所有的尖庄红包活动
	 */
	public void allActivity(){
		SystemUser user = CacheLoginUser();
		String sql="select * from TB_JZ_RED where ACITIVITY_LAUNCH_USERCODE = ? ";
		List<JzRed> jzRedList = JzRed.dao.find(sql,user.getUserCode());
		setAttr("jzRedList", jzRedList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的所有的砸蛋活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-my-all-activity.html");
	}
	
	
	/**
	 * 尖庄红包活动详情
	 * //TODO  （其实也是我的活动详情）
	 */
	public void jzRedInfo(){
		String activityId = getPara("activityId");
		//查活动
		JzRed jzRed = JzRed.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_JZ_RED_PRIZE where JZ_RED_ID = ? ";
		List<JzRedPrize> prizeList = JzRedPrize.dao.find(sql1,activityId);
		setAttr("jzRed", jzRed);
		setAttr("sellerInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "审批开酒瓶活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-my-one-activity-info.html");
	}
	
	
	/**
	 * 查询我的活动
	 */
	public void searchJzRedActivity(){
		SystemUser user = CacheLoginUser();
		String activityName=getPara("activityName");
		String activityState=getPara("activityState");
		String sql="select * from TB_JZ_RED where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		//0申请中 1审批通过 2 已驳回
		if (!"".equals(activityState) &&activityState!=null) {
			sql += " and state = " + " '" + activityState + "' ";
		}
		sql += " and ACITIVITY_LAUNCH_USERCODE = " + " '" + user.getUserCode() + "' ";
		/*//= -1就是admin账号  否则就是普通经销商
		if(user.getUserId().intValue()!=-1){
			sql += " and ACITIVITY_LAUNCH_USERCODE = " + " '" + user.getUserCode() + "' ";
		}*/
		List<JzRed> list = JzRed.dao.find(sql);
		setAttr("jzRedList", list);
		setAttr("activityName", activityName);
		setAttr("state", activityState);
		render("/jzRedConfig/jz-my-all-activity.html");
	}
	
	/**
	 * 尖庄红包报表  approveJzRedPage
	 */
	public void report(){
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋报表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-activity-report-all.html");
	}
		
	/**
	 * 大活动更多详情的链接  参与的微信用户
	 */
	public void jzRedReportInfo(){
		String activityId = getPara("activityId");
		String activityName = getPara("activityName");
		setAttr("jzRedList", null);
		setAttr("activityId", activityId);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-activity-report.html");
	}
	
	/**
	 * 微信用户列表活动列表分页显示
	 */
	public void getJzRedWxUserInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = JzRedWxUser.dao.paginate1(Integer.parseInt(currentPage), page,activityId,nickName);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 更多详情的链接  中奖情况
	 */
	public void jzRedReportMoreInfo(){
		String jzRedWxUserId = getPara("jzRedWxUserId");
		String activityName = JzRedWxUser.dao.findById(jzRedWxUserId).getActivityName();
		String sql="select * from TB_JZ_RED_WXUSER_WININFO where JZ_RED_WXUSER_ID = ? ";
		List<JzRedWxUserWining> list = JzRedWxUserWining.dao.find(sql,jzRedWxUserId);
		setAttr("jzRedWxUserWinningList", list);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户-中奖情况")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-activity-report-info.html");
	}
	
	/**
	 * 查看中奖明细
	 */
	public void jzRedWinMoreInfo(){
		String jzRedWxUserId = getPara("jzRedWxUserId");
		String activityName = JzRedWxUser.dao.findById(jzRedWxUserId).getActivityName();
		String sql="select * from TB_JZ_RED_WXUSER_WININFO where JZ_RED_WXUSER_ID = ? ";
		List<JzRedWxUserWining> list = JzRedWxUserWining.dao.find(sql,jzRedWxUserId);
		String activityId = getPara("activityId");
		setAttr("jzRedWxUserWinList", list);
		setAttr("activityName", activityName);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户-中奖情况")
		.set("USE_TIME", uitils.newDate()).save();
		render("/jzRedConfig/jz-activity-report-info.html");
	}
	
	/**
	 * 删除尖庄红包活动
	 */
	public void deleteJzRedActivity(){
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
		//活动奖品配置
		String sql1="select * from TB_JZ_RED_PRIZE where JZ_RED_ID = ? ";
		List<JzRedPrize> prizeList = JzRedPrize.dao.find(sql1,activityId);
		for (JzRedPrize jzRedPrize : prizeList) {
			result=JzRedPrize.dao.deleteById(jzRedPrize.getId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		result=JzRed.dao.deleteById(activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "删除尖庄红包活动")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	 /**
	  * 导出尖庄红包活动活动
	  */
	 public void exportJzRedActivity(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "jzRedTemplate.xlsx";
		// 导出excel的标题
		String title ="大光瓶红包活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<JzRed> list=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_JZ_RED";
			list = JzRed.dao.find(sql);
		}else{
			// 这是根据usercode查询属于他的砸金蛋活动
			String sql="select * from TB_JZ_RED where ACITIVITY_LAUNCH_USERCODE = ? ";
			list = JzRed.dao.find(sql,userCode);
		}
		List<JzRed> list1=new ArrayList<>();
		/*活动状态：0申请中   1审批通过  2 已驳回  */
		for (JzRed jzRed : list) {
			if(jzRed.getState().equals("0")){
				jzRed.setSpareOne("申请中");
			}else if(jzRed.getState().equals("1")){
				jzRed.setSpareOne("通过");
			}else if(jzRed.getState().equals("2")){
				jzRed.setSpareOne("驳回");
			}
			list1.add(jzRed);
		}
		Tools.comExportExcel(list1, title, getResponse(),templateFilePath);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "开酒瓶活动参与的微信用户-导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	 }
	 
	 
	 /**
	  * 尖庄红包活动微信参与记录导出
	  */
	 public void exportJzRedWinWxUser(){
		 String activityId = getPara("activityId");
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "jzRedWxTemplate.xlsx";
		// 导出excel的标题
		String title ="大光瓶红包活动报表"+DateUitils.newDateByYMD();
		String sql="select * from TB_JZ_RED_WXUSER where JZ_RED_ID = ? ";
		List<JzRedWxUser> list = JzRedWxUser.dao.find(sql,activityId);
		//导出时用到的集合
		List<JzRedWxUser> list1=new ArrayList<>();
		for (JzRedWxUser jzRedWxUser : list) {
			JzRedWxUser ow=new JzRedWxUser();
			String nickName = jzRedWxUser.getNickName();
			String headImgUrl = jzRedWxUser.getHeadImgUrl();
			if(StringUtils.isEmpty(nickName)){
				ow.setNickName("未关注");
			}else{
				ow.setNickName(nickName);
			}
			if(StringUtils.isEmpty(headImgUrl)){
				ow.setHeadImgUrl("未关注");
			}else{
				ow.setHeadImgUrl(headImgUrl);
			}
			ow.setCreateTime(jzRedWxUser.getCreateTime());
			ow.setTotalMoney(jzRedWxUser.getTotalMoney());
			list1.add(ow);
		}
		Tools.comExportExcel(list1, title, getResponse(),templateFilePath);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "大光瓶红包活动参与记录导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	 }
}
