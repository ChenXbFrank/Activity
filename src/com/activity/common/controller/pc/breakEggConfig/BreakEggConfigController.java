package com.activity.common.controller.pc.breakEggConfig;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.Activity;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.breakEgg.BreakEgg;
import com.activity.common.model.breakEgg.BreakEggAllWinInfo;
import com.activity.common.model.breakEgg.BreakEggPrize;
import com.activity.common.model.breakEgg.BreakEggWxUser;
import com.activity.common.model.breakEgg.BreakEggWxUserWinning;
import com.activity.common.model.breakEgg.TestEggPrize;
import com.activity.common.model.centerObjcet.IntegralExchangeActivity;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.shareBargain.ShareBargainWxuserService;
import com.activity.common.service.system.ActivityService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerRelationService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 砸蛋PC端配置
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/breakEggConfig")
public class BreakEggConfigController extends BaseController{
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	// 可申请活动service
	ActivityService activityService = ActivityService.getService();
	// 用户发起的活动service
	ShareBargainWxuserService shareBargainWxuserService = ShareBargainWxuserService.getService();
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	
	/**
	 * 进入砸蛋编辑页面
	 */
	public void goToBreakEgg(){
		String belongActivityId = getPara("activity");
		SystemUser user = CacheLoginUser();
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-砸金蛋活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-edit.html");
	}
	
	/**
	 * 保存砸蛋活动信息
	 */
	public void saveBreakEggInfo(){
		boolean result = false;
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		//砸蛋活动
		String breakEggObj = getPara("breakEggObj");
		JSONObject jsonEgg = JSONObject.fromObject(breakEggObj);
		//运单
		String billLists = getPara("billLists");
		//奖品配置
		String addAwards = getPara("addAwards");
		
		JSONArray json = JSONArray.fromObject(billLists);
		@SuppressWarnings("unchecked")
		List<SellerOutInfoChoice> sellerOutList = (List<SellerOutInfoChoice>) JSONArray.toCollection(json,SellerOutInfoChoice.class);
		for (SellerOutInfoChoice so : sellerOutList) {
			ActivitySellerOutInfo as = new ActivitySellerOutInfo();
			String recordId = so.getRecordId();
			//在这里处理运单状态   将该运单修改为已开展为活动中
			String sql = PropKit.use("database.properties").get("updateSelleInfoState");
			Db.update(sql,recordId);
			SellerOutInfo info = sellerOutInfoService.getSellerOutInfoByOutRecordId(recordId);
			result = as.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
			  .set("ACTIVITY_ID", activityId)
			  .set("SELLEROUTINFO_RECORDID", recordId)
			  .set("OUTNO", so.getOutNo())
			  .set("SELLER_USERCODE", info.getSellerId())
			  // 状态 1可以用 2不可用
			  .set("STATE", 2)
			  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("BreakEgg"))
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
		//配置的奖品
		JSONArray awardJson = JSONArray.fromObject(addAwards);
		@SuppressWarnings("unchecked")
		List<TestEggPrize> awardList = (List<TestEggPrize>) JSONArray.toCollection(awardJson,
				TestEggPrize.class);
		for (TestEggPrize p : awardList) {
			BreakEggPrize eggPrize=new BreakEggPrize();
			result=eggPrize.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
			        .set("EGG_ID", activityId)
			        .set("PRIZENAME", p.getName())
			        .set("PRIZEIMG", p.getPic1Src())
			        .set("PRIZETYPE", p.getType())
			        .set("PRIZENUMBER", p.getNumber())
			        .set("SURPLUS_PRIZE_NUMBER", p.getNumber())
			        .set("PRIZEPROBABILITY", p.getProbability())
			        .set("SURPLUS_PRIZE_PROBABILITY", p.getProbability())
			        .set("INTEGRAL", p.getIntegral())
			        .set("REDMONEY", p.getMoney())
			        .save(); 
		}
		SystemUser user = CacheLoginUser();
		//活动信息
		BreakEgg egg=new BreakEgg();
		String picSrc = jsonEgg.get("picSrc").toString();
		Activity activity = Activity.dao.findById(jsonEgg.get("belongId"));
		result=egg.set("ID", activityId)
		   .set("ACTIVITYNAME", jsonEgg.get("activityName").toString())
		   .set("BACKGROUND_IMG", activity.getImg())
		   .set("BELONG_ACTIVITY_ID", jsonEgg.get("belongId").toString())
		   .set("MOBLE_BACKGROUND_IMG", picSrc)
		   .set("ACITIVITY_LAUNCH_USERID", user.getUserId())
		   .set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
		   .set("STATE", "0")
		   .set("CREATE_TIME", DateUitils.newDateByYMD())
		   .set("APPLYPHONE", user.getPhone())
		   .set("APPLYUSERNAME", user.getUserName())
		   .set("BREAKNUMBER", jsonEgg.get("scanWinningNum").toString())
		   .set("STARTTIME", jsonEgg.get("startTime").toString())
		   .set("ENDTIME", jsonEgg.get("endTime").toString())
		   .set("TOTAL",jsonEgg.get("total").toString()).save();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "保存砸蛋活动信息")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 返回json格式
	 */
	public void breakEggActivityJson() {
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		String sql="SELECT * FROM TB_BREAK_EGG WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		// 这是分享砍价的活动
		List<BreakEgg> code = BreakEgg.dao.find(sql,userCode);
		for (BreakEgg sb : code) {
			IntegralExchangeActivity ba = new IntegralExchangeActivity();
			ba.setActivityId(sb.getId());
			ba.setActivityImg(sb.getBackgroundImg());
			ba.setActivityName(sb.getActivityName());
			ba.setJoinNumber(sb.getJoinPropleNumber().toString());
			ba.setWinNumber(sb.getWinningPropleNumber().toString());
			activityList.add(ba);
		}
		renderJson(activityList);
	}
	
	/**
	 * 进入审批列表
	 */
	public void goApproveList(){
		setAttr("eggList", null);
		setAttr("activityName", "");
		setAttr("state", "");
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入审批列表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-approve.html");
	}
	
	/**
	 * 审批砸蛋活动
	 */
	public void approveEgg(){
		String activityId = getPara("activityId");
		//查活动
		BreakEgg breakEgg = BreakEgg.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_BREAK_EGG_PRIZE where EGG_ID = ? ";
		List<BreakEggPrize> prizeList = BreakEggPrize.dao.find(sql1,activityId);
		setAttr("breakEgg", breakEgg);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "审批砸蛋活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-approve-info.html");
	}
	
	/**
	 * 处理审批
	 */
	public void handleApproveEgg(){
		SystemUser user = CacheLoginUser();
		String activityId = getPara("activityId");
		String state = getPara("state");
		String advice = getPara("remake");
		BreakEgg breakEgg = BreakEgg.dao.findById(activityId);
		boolean result = breakEgg.set("ID", activityId)
		        .set("STATE", state)
		        .set("COMFIRMADVISE", advice)
		        .set("COMFIRMTIME", DateUitils.newDateByYMD())
		        .set("COMFIRMUSERID", user.getUserId())
		        .set("COMFIRMUSERNAME", user.getUserName())
		        .update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "审批砸蛋活动-处理审批")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 我的所有的砸蛋活动
	 */
	public void myAllEggActivity(){
		SystemUser user = CacheLoginUser();
		String sql="select * from TB_BREAK_EGG where ACITIVITY_LAUNCH_USERCODE = ? ";
		List<BreakEgg> eggList = BreakEgg.dao.find(sql,user.getUserCode());
		setAttr("eggList", eggList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的所有的砸蛋活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-my-all-activity.html");
	}
	
	/**
	 * 我的砸蛋活动  审批详情
	 */
	public void eggInfo(){
		String activityId = getPara("activityId");
		//查活动
		BreakEgg breakEgg = BreakEgg.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_BREAK_EGG_PRIZE where EGG_ID = ? ";
		List<BreakEggPrize> prizeList = BreakEggPrize.dao.find(sql1,activityId);
		setAttr("breakEgg", breakEgg);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的砸蛋活动-审批详情")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-approve-info.html");
	}
	
	/**
	 * 审批列表分页显示
	 */
	public void getEggInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = BreakEgg.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 微信用户列表活动列表分页显示
	 */
	public void getBreakEggWxUserInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = BreakEggWxUser.dao.paginate1(Integer.parseInt(currentPage), page,activityId,nickName);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 我的砸蛋活动  活动详情
	 */
	public void oneEggInfo(){
		String activityId = getPara("activityId");
		//查活动
		BreakEgg breakEgg = BreakEgg.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_BREAK_EGG_PRIZE where EGG_ID = ? ";
		List<BreakEggPrize> prizeList = BreakEggPrize.dao.find(sql1,activityId);
		setAttr("breakEgg", breakEgg);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的砸蛋活动-活动详情")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-my-one-activity-info.html");
	}
	
	/**
	 * 删除砸蛋活动
	 */
	public void deleteEggActivity(){
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
		String sql1="select * from TB_BREAK_EGG_PRIZE where EGG_ID = ? ";
		List<BreakEggPrize> prizeList = BreakEggPrize.dao.find(sql1,activityId);
		for (BreakEggPrize breakEggPrize : prizeList) {
			result=BreakEggPrize.dao.deleteById(breakEggPrize.getId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		result=BreakEgg.dao.deleteById(activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "删除砸蛋活动")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 砸蛋报表
	 */
	public void berakEggReport(){
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋报表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-activity-report-all.html");
	}
	
	/**
	 * 大活动更多详情的链接  参与的微信用户
	 */
	public void breakEggMoreInfo(){
		String breakEggId = getPara("activityId");
		String activityName = getPara("activityName");
		setAttr("accumulateList", null);
		setAttr("activityId", breakEggId);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-activity-report.html");
	}
	
	/**
	 * 更多详情的链接  中奖情况
	 */
	public void breakEggWinMoreInfo(){
		String breakEggWxUserId = getPara("breakEggWxUserId");
		String activityName = BreakEggWxUser.dao.findById(breakEggWxUserId).getActivityName();
		String sql="select * from TB_BREAKEGG_WXUSER_WINNING where BREAKEGG_WXUSER_ID = ? ";
		List<BreakEggWxUserWinning> list = BreakEggWxUserWinning.dao.find(sql,breakEggWxUserId);
		setAttr("breakEggWxUserWinningList", list);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户-中奖情况")
		.set("USE_TIME", uitils.newDate()).save();
		render("/breakEggConfig/breakEgg-activity-report-info.html");
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String breakEggWxUserWinningId = getPara("breakEggWxUserWinningId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		BreakEggWxUserWinning breakEggWinning = BreakEggWxUserWinning.dao.findById(breakEggWxUserWinningId);
		boolean result = new BreakEggWxUserWinning().set("ID", breakEggWxUserWinningId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(result){
			result = new ProductWinningInfo().set("ID", breakEggWinning.getProductWinningInfoId()).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户-厂家发货")
		.set("USE_TIME", uitils.newDate()).save();
		//传递参数*******发货通知
		String openId = breakEggWinning.getOpenId();
		if(openId!=null){
			String wxUserId = breakEggWinning.getBREAKEGGWxuserId();
			BreakEggWxUser wxUser = BreakEggWxUser.dao.findById(wxUserId);
			String belongPublicNumberId = wxUser.getBelongPublicNumberId();
			String prizeName = breakEggWinning.getPrizeProject();
			//发送通知
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			Tools.sendNotice(openId, sellerPublicNumber, prizeName, deliverCompany, deliverNumber, breakEggWinning.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(result);
	}
	
	/**
	 * 砸蛋活动审批导出
	 */
	public void exportBreakEggExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "breakEggTemplate.xlsx";
		// 导出excel的标题
		String title ="砸金蛋活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<BreakEgg> breakEggList=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_BREAK_EGG";
			breakEggList = BreakEgg.dao.find(sql);
		}else{
			// 这是根据usercode查询属于他的砸金蛋活动
			String sql="select * from TB_BREAK_EGG where ACITIVITY_LAUNCH_USERCODE = ? ";
			breakEggList = BreakEgg.dao.find(sql,userCode);
		}
		List<BreakEgg> breakEggList1=new ArrayList<>();
		/*活动状态：0申请中   1审批通过  2 已驳回  */
		for (BreakEgg breakEgg : breakEggList) {
			if(breakEgg.getState().equals("0")){
				breakEgg.setSpareOne("申请中");
			}else if(breakEgg.getState().equals("1")){
				breakEgg.setSpareOne("通过");
			}else if(breakEgg.getState().equals("2")){
				breakEgg.setSpareOne("驳回");
			}
			breakEggList1.add(breakEgg);
		}
		Tools.comExportExcel(breakEggList1, title, getResponse(),templateFilePath);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户-导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
	/**
	 * 砸金蛋活动详情导出(包含中奖情况发货情况)
	 */
	public void exportBreakEggInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "breakEggWxAllWinTemplate.xlsx";
		// 导出excel的标题
		String title ="砸金蛋微信活动报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_BREAKEGG_WXUSER where BREAKEGG_ID = ? ";
		String sql1="select * from TB_BREAKEGG_WXUSER_WINNING where BREAKEGG_WXUSER_ID = ? ";
		List<BreakEggWxUser> breakEggWxUserList = BreakEggWxUser.dao.find(sql,activityId);
		List<BreakEggAllWinInfo> breakEggAllWinInfoList=new ArrayList<>();
		for (BreakEggWxUser bew : breakEggWxUserList) {
			BreakEggAllWinInfo baw =new BreakEggAllWinInfo();
			String id = bew.getId();
			BreakEggWxUserWinning bw = BreakEggWxUserWinning.dao.findFirst(sql1,id);
			baw.setNickName(bew.getNickName());
			baw.setHeadImg(bew.getHeadImgUrl());
			baw.setCreateTime(bew.getCreateTime());
			baw.setRedMoney(bew.getTotalMoney());
			baw.setGoodsNum(bew.getGoodsNumber());
			baw.setIntegral(bew.getTotalIntegral());
			baw.setThankNum(bew.getThankNumber());
			if(bw!=null){
				//奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
				String prizeType = bw.getPrizeType();
				if(prizeType.equals("1")){
					baw.setPrizeType("实物");
				}else if(prizeType.equals("2")){
					baw.setPrizeType("积分");
				}else if(prizeType.equals("3")){
					baw.setPrizeType("红包");
				}else if(prizeType.equals("4")){
					baw.setPrizeType("谢谢惠顾");
				}
				baw.setPrizeName(bw.getPrizeProject());
				baw.setPrizeInfo(bw.getWinningMoney());
				baw.setPrizeTime(bw.getCreateTime());
				baw.setReceiver(bw.getAddresseeName());
				baw.setReceivePhone(bw.getAddresseePhone());
				baw.setReceiveAddress(bw.getAddresseeAddress());
				baw.setSender(bw.getLssueUserName());
				baw.setLogisticsCompany(bw.getDeliverCompany());
				baw.setWayBill(bw.getDeliverNumber());
				//状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货
				String state = bw.getState();
				if(state.equals("1")){
					baw.setState("已经领取");
				}else if(state.equals("2")){
					baw.setState("未填写地址");
				}else if(state.equals("3")){
					baw.setState("地址已填写");
				}else if(state.equals("4")){
					baw.setState("已发货");
				}else if(state.equals("5")){
					baw.setState("未发货");
				}
			}
			breakEggAllWinInfoList.add(baw);
		}
		Tools.comExportExcel(breakEggAllWinInfoList, title, getResponse(),templateFilePath);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "砸蛋参与的微信用户-中奖情况-导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
}
