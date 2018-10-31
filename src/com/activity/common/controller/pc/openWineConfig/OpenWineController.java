package com.activity.common.controller.pc.openWineConfig;

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
import com.activity.common.model.breakEgg.TestEggPrize;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.openWine.OpenWine;
import com.activity.common.model.openWine.OpenWinePrize;
import com.activity.common.model.openWine.OpenWineSharePrize;
import com.activity.common.model.openWine.OpenWineWxUser;
import com.activity.common.model.openWine.OpenWineWxUserWinning;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.openWine.OpenWineService;
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
 * @author ChenXb
 *
 * 2018年6月19日
 */
@ControllerPath(controllerKey = "/openWineConfig")
public class OpenWineController extends BaseController{
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	
	OpenWineService openWineService = OpenWineService.getService();
	/**
	 * 申请开酒瓶的页面
	 * applyOpenWine
	 * @author 81046
	 * @date 2018年6月19日下午3:32:59
	 */
	public void applyOpenWine(){
		String belongActivityId = getPara("activity");
		SystemUser user = CacheLoginUser();
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-砸金蛋活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/openWine/openWine-edit.html");
	}
	
	/**
	 * 申请开酒瓶活动
	 */
	public void saveApplyInfo(){
		Boolean result=false;
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		//这是活动信息
		String openWineObj = getPara("openWineObj");
		//需要信息时，直接jsonOpenWine.get("***")
		JSONObject jsonOpenWine = JSONObject.fromObject(openWineObj);
		//这是运单信息
		String billLists = getPara("billLists");
		JSONArray json = JSONArray.fromObject(billLists);
		@SuppressWarnings("unchecked")
		List<SellerOutInfoChoice> sellerOutList = (List<SellerOutInfoChoice>) JSONArray.toCollection(json,SellerOutInfoChoice.class);
		//String recordIdList= "";
		for (SellerOutInfoChoice so : sellerOutList) {
			ActivitySellerOutInfo as = new ActivitySellerOutInfo();
			String recordId = so.getRecordId();
			String sql = PropKit.use("database.properties").get("updateSelleInfoState");
			Db.update(sql,recordId);
			//recordIdList = recordIdList + recordId +" ,";
			SellerOutInfo info = sellerOutInfoService.getSellerOutInfoByOutRecordId(recordId);
			result = as.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
			  .set("ACTIVITY_ID", activityId)
			  .set("SELLEROUTINFO_RECORDID", recordId)
			  .set("OUTNO", so.getOutNo())
			  .set("SELLER_USERCODE", info.getSellerId())
			  // 状态 1可以用 2不可用
			  .set("STATE", 2)
			  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("OpenWine"))
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
		/*//在这里处理运单状态   将该运单修改为已开展为活动中
		if(!StringUtils.isEmpty(recordIdList)){
			String sql = PropKit.use("database.properties").get("updateSelleInfoState");
			//去除最后一个，
			recordIdList = recordIdList.substring(0,recordIdList.length() - 1);
			Db.update(sql,recordIdList);
		}*/
		//这是奖品配置信息
		String addAwards = getPara("addAwards");
		JSONArray awardJson = JSONArray.fromObject(addAwards);
		@SuppressWarnings("unchecked")
		List<TestEggPrize> awardList = (List<TestEggPrize>) JSONArray.toCollection(awardJson,
				TestEggPrize.class);
		//保存奖品配置信息
		for (TestEggPrize tp : awardList) {
			OpenWinePrize op=new OpenWinePrize();
			String money=tp.getMoney();
			if(tp.getType().equals("4")){
				money="0";
			}
			op.set("ID", newId())
			  .set("OPENWINE_ID", activityId)
			  .set("PRIZENAME", tp.getName())
			  .set("PRIZEIMG", tp.getPic1Src())
			  .set("PRIZETYPE", tp.getType())
			  .set("REDMONEY", money)
			  .set("PRIZENUMBER", tp.getNumber())
			  .set("PRIZEPROBABILITY", tp.getProbability())
			  .set("SURPLUS_PRIZE_NUMBER", tp.getNumber())
			  .set("SURPLUS_PRIZE_PROBABILITY", tp.getProbability())
			  .set("INTEGRAL", tp.getIntegral())
			  .save();
		}
		//分享奖品配置
		String shareAwards = getPara("shareAwards");
		JSONArray awardShareJson = JSONArray.fromObject(shareAwards);
		@SuppressWarnings("unchecked")
		List<TestEggPrize> awardShareList = (List<TestEggPrize>) JSONArray.toCollection(awardShareJson,
				TestEggPrize.class);
		//保存奖品配置信息
		for (TestEggPrize tp : awardShareList) {
			OpenWineSharePrize op=new OpenWineSharePrize();
			String money=tp.getMoney();
			if(tp.getType().equals("4")){
				money="0";
			}
			op.set("ID", newId())
			  .set("OPENWINE_ID", activityId)
			  .set("PRIZENAME", tp.getName())
			  .set("PRIZEIMG", tp.getPic1Src())
			  .set("PRIZETYPE", tp.getType())
			  .set("REDMONEY", money)
			  .set("PRIZENUMBER", tp.getNumber())
			  .set("PRIZEPROBABILITY", tp.getProbability())
			  .set("SURPLUS_PRIZE_NUMBER", tp.getNumber())
			  .set("SURPLUS_PRIZE_PROBABILITY", tp.getProbability())
			  .set("INTEGRAL", tp.getIntegral())
			  .save();
		}
		SystemUser user = CacheLoginUser();
		//保存活动信息
		OpenWine ow=new OpenWine();
		TbCustomActivity customActivity = TbCustomActivity.dao.findById(jsonOpenWine.get("belongId"));
		result=ow.set("ID", activityId)
		  .set("ACTIVITYNAME", jsonOpenWine.get("activityName"))
		  .set("BACKGROUND_IMG", customActivity.getImg())
		  .set("BELONG_ACTIVITY_ID", jsonOpenWine.get("belongId") )
		  .set("MOBLE_BACKGROUND_IMG", jsonOpenWine.get("picSrc"))
		  .set("ACITIVITY_LAUNCH_USERID", user.getUserId())
		  .set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
		  .set("STATE", "0")
		  .set("CREATE_TIME", DateUitils.newDateByYMD())
		  .set("APPLYPHONE", user.getPhone())
		  .set("APPLYUSERNAME", user.getUserName())
		  .set("STARTTIME", jsonOpenWine.get("startTime"))
		  .set("ENDTIME", jsonOpenWine.get("endTime"))
		  .set("APPLYUSERID", user.getUserId())
		  .set("TOTAL", jsonOpenWine.get("total"))
		  .set("SHAREIMG", jsonOpenWine.get("picSrc3"))
		  //.set("TOTALMONEY", jsonOpenWine.get("totalmoney"))
		  .save();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "保存开酒瓶活动信息")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	
	/**
	 * 开酒瓶审批页面
	 */
	public void approveOpenWine(){
		setAttr("openWineList", null);
		setAttr("activityName", "");
		setAttr("state", "");
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入审批列表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/openWine/approveOpenWine.html");
	}
	
	/**
	 * 审批页面进来加载的方法
	 */
	public void approveOpenWinePage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = OpenWine.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 审批开酒瓶活动详情
	 * //TODO  （其实也是我的活动详情）
	 */
	public void approveOpenWineInfo(){
		String activityId = getPara("activityId");
		//查活动
		OpenWine openWine = OpenWine.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_OPENWINE_PRIZE where OPENWINE_ID = ? ";
		List<OpenWinePrize> prizeList = OpenWinePrize.dao.find(sql1,activityId);
		//分享奖品配置
		String sql2="select * from TB_OPENWINE_SHARE_PRIZE where OPENWINE_ID = ? ";
		List<OpenWineSharePrize> prizeShareList = OpenWineSharePrize.dao.find(sql2,activityId);
		setAttr("openWine", openWine);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeShareList", prizeShareList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "审批开酒瓶活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/openWine/approveOpenWineInfo.html");
	}
	
	
	/**
	 * 处理审批
	 */
	public void handleApproveEgg(){
		SystemUser user = CacheLoginUser();
		String activityId = getPara("activityId");
		String state = getPara("state");
		String advice = getPara("remake");
		OpenWine openWine = OpenWine.dao.findById(activityId);
		boolean result = openWine.set("ID", activityId)
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
	 * 删除开酒瓶活动
	 */
	public void deleteOpenWineActivity(){
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
		//分享奖品配置
		String sql2="select * from TB_OPENWINE_SHARE_PRIZE where OPENWINE_ID = ? ";
		List<OpenWineSharePrize> prizeShareList = OpenWineSharePrize.dao.find(sql2,activityId);
		for (OpenWineSharePrize openWineSharePrize : prizeShareList) {
			result=OpenWinePrize.dao.deleteById(openWineSharePrize.getId());
		}
		String sql1="select * from TB_OPENWINE_PRIZE where OPENWINE_ID = ? ";
		List<OpenWinePrize> prizeList = OpenWinePrize.dao.find(sql1,activityId);
		for (OpenWinePrize openWinePrize : prizeList) {
			result=OpenWinePrize.dao.deleteById(openWinePrize.getId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		result=OpenWine.dao.deleteById(activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "删除开酒瓶活动")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 开酒瓶活动的报表页面
	 */
	public void openWineReport(){
		render("/openWine/openWineReport.html");
	}
	
	/**
	 * 更多页面
	 */
	public void openWineWxUserReport(){
		String activityId = getPara("activityId");
		setAttr("activityId", activityId);
		render("/openWine/openWine-report-more.html");
	}
	
	/**
	 * 进入报表页面加载该方法 分页
	 *  //TODO 微信参与活动记录
	 */
	public void openWineWxUserReportPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityId = getPara("activityId");
		OpenWine openWine = OpenWine.dao.findById(activityId);
		String nickName = getPara("nickName");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = OpenWineWxUser.dao.paginate1(Integer.parseInt(currentPage), page,activityId,nickName);
		model.put("bigActivityId", activityId);
		model.put("activityName", openWine.getActivityName());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 根据微信参与id查询该用户的中奖记录（扫码中奖和分享中奖）
	 */
	public void openWineWinInfo(){
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String openWineWxuserId = getPara("openWineWxuserId");
		String activityId = getPara("activityId");
		String activityName = getPara("activityName");
		//根据用户参与记录ID 查询用户中奖记录
		List<OpenWineWxUserWinning> winInfoList = openWineService.getWinInfoByOpenWineWxId(openWineWxuserId);
		setAttr("winInfoList", winInfoList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-开酒瓶活动-单个活动报表详细")
		.set("USE_TIME", uitils.newDate()).save();
		setAttr("activityId", activityId);
		setAttr("activityName", activityName);
		render("/openWine/open-wine-report-info.html");
	}
	
	/**
	 * 开酒瓶的所有活动页面
	 */
	public void openWineAllActivity(){
		SystemUser user = CacheLoginUser();
		//查询该用户申请的所有的活动
		List<OpenWine> activityList = openWineService.getOpenWineAcByUserCode(user.getUserCode());
		setAttr("activityList", activityList);
		setAttr("activityName", "");
		setAttr("state", "");
		render("/openWine/openWineAllActivtiy.html");
	}
	
	/**
	 * 查询我的开酒瓶活动
	 */
	public void getOpenWinActivity(){
		SystemUser user = CacheLoginUser();
		String activityName=getPara("activityName");
		String activityState=getPara("activityState");
		String sql="select * from TB_OPENWINE where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
		}
		//0申请中 1审批通过 2 已驳回
		if (!"".equals(activityState) &&activityState!=null) {
			sql += " and state = " + " '" + activityState + "' ";
		}
		//= -1就是admin账号  否则就是普通经销商
		if(user.getUserId().intValue()!=-1){
			sql += " and ACITIVITY_LAUNCH_USERCODE = " + " '" + user.getUserCode() + "' ";
		}
		List<OpenWine> list = OpenWine.dao.find(sql);
		setAttr("activityList", list);
		setAttr("activityName", activityName);
		setAttr("state", activityState);
		render("/openWine/openWineAllActivtiy.html");
	}
	
	/**
	 * 我的活动详情
	 */
	public void openWineInfo(){
		String activityId = getPara("activityId");
		//查活动
		OpenWine openWine = OpenWine.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_OPENWINE_PRIZE where OPENWINE_ID = ? ";
		List<OpenWinePrize> prizeList = OpenWinePrize.dao.find(sql1,activityId);
		//分享奖品配置
		String sql2="select * from TB_OPENWINE_SHARE_PRIZE where OPENWINE_ID = ? ";
		List<OpenWineSharePrize> prizeShareList = OpenWineSharePrize.dao.find(sql2,activityId);
		setAttr("openWine", openWine);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeShareList", prizeShareList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "审批开酒瓶活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/openWine/openWineInfo.html");
	}
	
	/**
	 * 中奖详情
	 */
	 public void winInfo(){
		String openId = getPara("openid");
		String openWineWxUserId = getPara("openWineWxUserId");
		List<OpenWineWxUserWinning> list = openWineService.getOpenWineWinListByIdOpenId(openId, openWineWxUserId);
		setAttr("list", list);
		render("/openWine/open-wine-report-info.html");
	 }
	 
	 /**
	  * 导出开酒瓶活动
	  */
	 public void exportOpenWineActivity(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "openWineTemplate.xlsx";
		// 导出excel的标题
		String title ="开酒瓶活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<OpenWine> openWineList=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_OPENWINE";
			openWineList = OpenWine.dao.find(sql);
		}else{
			// 这是根据usercode查询属于他的砸金蛋活动
			String sql="select * from TB_OPENWINE where ACITIVITY_LAUNCH_USERCODE = ? ";
			openWineList = OpenWine.dao.find(sql,userCode);
		}
		List<OpenWine> openWineList1=new ArrayList<>();
		/*活动状态：0申请中   1审批通过  2 已驳回  */
		for (OpenWine openWine : openWineList) {
			if(openWine.getState().equals("0")){
				openWine.setSpareOne("申请中");
			}else if(openWine.getState().equals("1")){
				openWine.setSpareOne("通过");
			}else if(openWine.getState().equals("2")){
				openWine.setSpareOne("驳回");
			}
			openWineList1.add(openWine);
		}
		Tools.comExportExcel(openWineList1, title, getResponse(),templateFilePath);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "开酒瓶活动参与的微信用户-导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	 }
	 
	 
	 /**
	  * 开酒瓶微信参与记录导出
	  */
	 public void exportOpenWinWxUser(){
		 String activityId = getPara("activityId");
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "openWineWxTemplate.xlsx";
		// 导出excel的标题
		String title ="开酒瓶微信活动报表"+DateUitils.newDateByYMD();
		String sql="select * from TB_OPENWINE_WXUSER where OPENWINE_ID = ? ";
		List<OpenWineWxUser> list = OpenWineWxUser.dao.find(sql,activityId);
		//导出时用到的集合
		List<OpenWineWxUser> list1=new ArrayList<>();
		for (OpenWineWxUser openWineWxUser : list) {
			OpenWineWxUser ow=new OpenWineWxUser();
			String nickName = openWineWxUser.getNickName();
			String headImgUrl = openWineWxUser.getHeadImgUrl();
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
			ow.setCreateTime(openWineWxUser.getCreateTime());
			ow.setTotalMoney(openWineWxUser.getTotalMoney());
			String state = openWineWxUser.getState();
			if(state.equals("9")){
				ow.setSpareOne("已提现");
			}else{
				ow.setSpareOne("未提现");
			}
			list1.add(ow);
		}
		Tools.comExportExcel(list1, title, getResponse(),templateFilePath);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "开酒瓶微信参与记录导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	 }
}
