package com.activity.common.controller.pc.groupPurchaseConfig;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.controller.pc.system.UploadController;
import com.activity.common.model.activity.Activity;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.bigDataPlatform.PicInfo;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.centerObjcet.IntegralExchangeActivity;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.groupPurchase.GroupPurchase;
import com.activity.common.model.groupPurchase.GroupPurchasePrize;
import com.activity.common.model.groupPurchase.GroupPurchaseWxUser;
import com.activity.common.model.groupPurchase.PurchaseWxUserWinning;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.oneMoneyShop.OneMoneyAllWinInfo;
import com.activity.common.model.oneMoneyShop.TestOneMoneyPrize;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.puzzle.PuzzleWxUserWinning;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.shareBargain.ShareBargainWxuserService;
import com.activity.common.service.system.ActivityService;
import com.activity.common.service.system.ProductInfoService;
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
 * 团购活动PC端配置
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/groupPurchaseConfig")
public class GroupPurchaseConfigController extends BaseController {
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	// 可申请活动service
	ActivityService activityService = ActivityService.getService();
	// 用户发起的活动service
	ShareBargainWxuserService shareBargainWxuserService = ShareBargainWxuserService.getService();
	// 奖品信息的service
	ProductInfoService productInfoService = ProductInfoService.getService();
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	UploadController upload = UploadController.getUilt();
	/**
	 * 拼团编辑页面
	 */
	public void groupPurchaseEdit(){
		String belongActivityId = getPara("activity");
		SystemUser user = CacheLoginUser();
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-拼团活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-edit.html");
	}
	
	
	/**
	 * 拼团活动编辑数据保存
	 */
	public void purchaseSave(){
		boolean result = false;
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		//拼团活动
		String groupObj = getPara("groupObj");
		JSONObject jsonGroup = JSONObject.fromObject(groupObj);
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
			  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("GroupPurchase"))
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
		List<TestOneMoneyPrize> awardList = (List<TestOneMoneyPrize>) JSONArray.toCollection(awardJson,
				TestOneMoneyPrize.class);
		for (TestOneMoneyPrize p : awardList) {
			String imgPath = "";
			try {
				String img = p.getImg();
				if(!StringUtils.isEmpty(img)){
					imgPath = upload.getPlsImg(getRequest(),PropKit.use("system.properties").get("platform")+img);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			GroupPurchasePrize groupPrize=new GroupPurchasePrize();
			result=groupPrize.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
			        .set("GROUP_PURCHASE_ID", activityId)
			        .set("PRIZENAME", p.getName())
			        .set("PRIZEIMG", imgPath)
			        .set("PRIZENUMBER", jsonGroup.get("total").toString())
			        .set("SPEC", p.getSpec())
			        .set("DEEP", p.getDeep())
			        .set("VOLUME", p.getVolume())
			        .set("BOXCOUNT", p.getBoxCount())
			        .save(); 
		}
		SystemUser user = CacheLoginUser();
		//活动信息
		GroupPurchase group=new GroupPurchase();
		Activity activity = Activity.dao.findById(jsonGroup.get("belongId"));
		result=group.set("ID", activityId)
		   .set("ACTIVITYNAME", jsonGroup.get("activityName").toString())
		   .set("BACKGROUND_IMG", activity.getImg())
		   .set("BELONG_ACTIVITY_ID", jsonGroup.get("belongId").toString())
		   .set("MOBLE_BACKGROUND_IMG", jsonGroup.get("picSrc").toString())
		   .set("ACITIVITY_LAUNCH_USERID", user.getUserId())
		   .set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
		   .set("STATE", "0")
		   .set("CREATE_TIME", DateUitils.newDateByYMD())
		   .set("APPLYPHONE", user.getPhone())
		   .set("APPLYUSERNAME", user.getUserName())
		   .set("GROUPPRICE", jsonGroup.get("collagePrice").toString())
		   .set("OPENPRIZENUMBER", jsonGroup.get("groupNumber").toString())
		   .set("STARTTIME", jsonGroup.get("startTime").toString())
		   .set("ENDTIME", jsonGroup.get("endTime").toString())
		   .set("TOTAL",jsonGroup.get("total").toString())
		   .set("OUTTOTAL",jsonGroup.get("outtotal").toString())
		   .save();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "拼团活动编辑数据保存")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 这里是分享砍价的所有活动记录 当前登录人 
	 * 返回json格式
	 */
	public void purchaseActivityJson() {
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		String sql="SELECT * FROM TB_GROUP_PURCHASE WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		// 这是分享砍价的活动
		List<GroupPurchase> code = GroupPurchase.dao.find(sql,userCode);
		for (GroupPurchase sb : code) {
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
		setAttr("groupList", null);
		setAttr("activityName", "");
		setAttr("state", "");
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "拼团活动-进入审批列表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-approval.html");
	}
	
	/**
	 * 审批活动
	 */
	public void approveGroupPurchase(){
		String activityId = getPara("activityId");
		//查活动
		GroupPurchase groupPurchase = GroupPurchase.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
		List<GroupPurchasePrize> prizeList = GroupPurchasePrize.dao.find(sql1,activityId);
		setAttr("groupPurchase", groupPurchase);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "拼团活动-审批活动详情")
		.set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-approval-info.html");
	}
	
	/**
	 * 处理审批
	 */
	public void handleApproveGroupPurchase(){
		SystemUser user = CacheLoginUser();
		String activityId = getPara("activityId");
		String state = getPara("state");
		String advice = getPara("remake");
		GroupPurchase groupPurchase = GroupPurchase.dao.findById(activityId);
		boolean result = groupPurchase.set("ID", activityId)
		        .set("STATE", state)
		        .set("COMFIRMADVISE", advice)
		        .set("COMFIRMTIME", DateUitils.newDateByYMD())
		        .set("COMFIRMUSERID", user.getUserId())
		        .set("COMFIRMUSERNAME", user.getUserName())
		        .update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "拼团活动-处理审批")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 我的所有的拼团活动
	 */
	public void myAllGroupPurchaseActivity(){
		SystemUser user = CacheLoginUser();
		String sql="select * from TB_GROUP_PURCHASE where ACITIVITY_LAUNCH_USERCODE = ? ";
		List<GroupPurchase> groupPurchaseList = GroupPurchase.dao.find(sql,user.getUserCode());
		setAttr("groupPurchaseList", groupPurchaseList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的所有的拼团活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-my-all-activity.html");
	}
	
	/**
	 * 我的拼团活动  审批详情
	 */
	public void groupPurchaseInfo(){
		String activityId = getPara("activityId");
		//查活动
		GroupPurchase groupPurchase = GroupPurchase.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
		List<GroupPurchasePrize> prizeList = GroupPurchasePrize.dao.find(sql1,activityId);
		setAttr("groupPurchase", groupPurchase);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的拼团活动-审批详情")
		.set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-approval-info.html");
	}
	
	/**
	 * 审批列表分页显示
	 */
	public void getGroupPurchaseInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = GroupPurchase.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 我的拼团活动  活动详情
	 */
	public void oneGroupPurchaseInfo(){
		String activityId = getPara("activityId");
		//查活动
		GroupPurchase groupPurchase = GroupPurchase.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
		List<GroupPurchasePrize> prizeList = GroupPurchasePrize.dao.find(sql1,activityId);
		setAttr("groupPurchase", groupPurchase);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的拼团活动-活动详情")
		.set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-one-activity-info.html");
	}
	
	/**
	 * 查询拼团活动
	 */
	public void searchGroupPurchaseActivity(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		String sql="select * from TB_GROUP_PURCHASE where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		List<GroupPurchase> GroupPurchaseList = GroupPurchase.dao.find(sql);
		setAttr("GroupPurchaseList", GroupPurchaseList);
		if(state.equals("0")){
			state="申请中";
		}else if(state.equals("2")){
			state="驳回";
		}else if(state.equals("1")){
			state="通过";
		}else if(state.equals("")){
			state="全部";
		}
		setAttr("activityName", activityName);
		setAttr("state", state);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的拼团活动-查询拼团活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-my-all-activity.html");
		
	}
	
	
	/**
	 * 删除拼团活动
	 */
	public void deleteGroupPurchaseActivity(){
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
		String sql1="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
		List<GroupPurchasePrize> prizeList = GroupPurchasePrize.dao.find(sql1,activityId);
		for (GroupPurchasePrize oneMoneyPrize : prizeList) {
			result=GroupPurchasePrize.dao.deleteById(oneMoneyPrize.getId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		result=GroupPurchase.dao.deleteById(activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "删除拼团活动")
		.set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 根据产品id获取图片
	 */
	public void getProductImg(){
		String productId = getPara("productId");
		PicInfo pi = productInfoService.getProductImgByProductId(productId);
		Map<String,String> map=new HashMap<>();
		map.put("Img", pi.getPicUrl());
		map.put("platform", PropKit.use("system.properties").get("platform"));
		renderJson(map);
	}
	
	/**
	 * 活动报表
	 */
	public void purchaseReport(){
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼团活动-活动报表").set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-report-all.html");
	}
	
	/**
	 * 活动报表更多
	 */
	public void purchaseMoreReport(){
		String activityId = getPara("activityId");
		String activityName = getPara("activityName");
		setAttr("activityId", activityId);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼团活动-活动报表-微信参与用户").set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-activity-report.html");
	}
	
	/**
	 * 这是参加大活动的微信用户
	 */
	public void getPurchaseWxUserInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String currentPage = getPara("currentPage");
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = GroupPurchaseWxUser.dao.paginate1(Integer.parseInt(currentPage), page,activityId,nickName);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 中奖纪录
	 */
	public void purchaseWinInfo(){
		String purchaseWxUserId = getPara("purchaseWxUserId");
		String activityName = getPara("activityName");
		String activityId = getPara("activityId");
		setAttr("purchaseWxUserWinningList", null);
		setAttr("activityName", activityName);
		setAttr("activityId", activityId);
		setAttr("purchaseWxUserId", purchaseWxUserId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼团活动-活动报表-微信参与用户-中奖纪录").set("USE_TIME", uitils.newDate()).save();
		render("/groupPurchaseConfig/groupPurchaseConfig-my-one-activity-info.html");
	}
	
	/**
	 * 拼团的成员
	 */
	public void groupUser(){
		Integer pageNumber = getParaToInt("pageNumber");
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String purchaseWxUserId = getPara("purchaseWxUserId");
		Map<String, Object> map = PurchaseWxUserWinning.dao.paginate(pageNumber, page, purchaseWxUserId);
		renderJson(map);
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String purchaseWxUserWinningId = getPara("purchaseWxUserWinningId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		PurchaseWxUserWinning purchaseWxUserWinning = PurchaseWxUserWinning.dao.findById(purchaseWxUserWinningId);
		boolean result = new PurchaseWxUserWinning().set("ID", purchaseWxUserWinningId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(result){
			result = new ProductWinningInfo().set("ID", purchaseWxUserWinning.getProductWinningInfoId()).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		String purchaseWxuserId = purchaseWxUserWinning.getGroupPurchaseWxUserId();
		GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(purchaseWxuserId);
		if(result){
			//发货状态改为已发货
			result=groupPurchaseWxUser.set("ID", purchaseWxuserId).set("GOODSTATE", "1").update();
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼团活动-活动报表-微信参与用户-中奖纪录-厂家发货").set("USE_TIME", uitils.newDate()).save();
		//传递参数*******发货通知
		String openId = purchaseWxUserWinning.getOpenId();
		if(openId!=null){
			String wxUserId = purchaseWxUserWinning.getGroupPurchaseWxUserId();
			GroupPurchaseWxUser wxUser = GroupPurchaseWxUser.dao.findById(wxUserId);
			String belongPublicNumberId = wxUser.getBelongPublicNumberId();
			String prizeName = purchaseWxUserWinning.getPrizeProject();
			//发送通知
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			Tools.sendNotice(openId, sellerPublicNumber, prizeName, deliverCompany, deliverNumber, purchaseWxUserWinning.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(result);
	}
	
	/**
	 * 拼团活动审批导出
	 */
	public void exportPurchaseExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "groupPurchaseTemplate.xlsx";
		// 导出excel的标题
		String title ="拼团活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<GroupPurchase> groupPurchaseList=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_GROUP_PURCHASE";
			groupPurchaseList = GroupPurchase.dao.find(sql);
		}else{
			// 这是根据usercode查询属于他的拼团活动
			String sql="select * from TB_GROUP_PURCHASE where ACITIVITY_LAUNCH_USERCODE = ? ";
			groupPurchaseList = GroupPurchase.dao.find(sql,userCode);
		}
		List<GroupPurchase> groupPurchaseList1=new ArrayList<>();
		/*活动状态：0申请中   1审批通过  2 已驳回  */
		for (GroupPurchase groupPurchase : groupPurchaseList) {
			if(groupPurchase.getState().equals("0")){
				groupPurchase.setSpareOne("申请中");
			}else if(groupPurchase.getState().equals("1")){
				groupPurchase.setSpareOne("通过");
			}else if(groupPurchase.getState().equals("2")){
				groupPurchase.setSpareOne("驳回");
			}
			groupPurchaseList1.add(groupPurchase);
		}
		Tools.comExportExcel(groupPurchaseList1, title, getResponse(),templateFilePath);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼团活动-活动报表-导出").set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
	/**
	 * 拼团活动详情导出(包含中奖情况发货情况)
	 */
	public void exportPurchaseInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "groupPurchaseWxAllWinTemplate.xlsx";
		// 导出excel的标题
		String title ="拼团微信活动报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_GROUP_PURCHASE_WXUSER where GROUP_PURCHASE_ID = ? ";
		String sql1="select * from TB_PURCHASE_WXUSER_WINNING where PURCHASE_WXUSER_ID = ? ";
		List<GroupPurchaseWxUser> groupPurchaseWxUserList = GroupPurchaseWxUser.dao.find(sql,activityId);
		List<OneMoneyAllWinInfo> groupPurchaseAllWinInfoList=new ArrayList<>();
		for (GroupPurchaseWxUser bew : groupPurchaseWxUserList) {
			OneMoneyAllWinInfo baw =new OneMoneyAllWinInfo();
			String id = bew.getId();
			PuzzleWxUserWinning bw = PuzzleWxUserWinning.dao.findFirst(sql1,id);
			baw.setNickName(bew.getNickName());
			baw.setHeadImg(bew.getHeadImgUrl());
			baw.setCreateTime(bew.getCreateTime());
			//满员情况 0未满员 1已满员
			String state2 = bew.getFulled();
			if(state2.equals("1")){
				baw.setWinState("已满员");
			}else{
				baw.setWinState("未满员");
			}
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
			groupPurchaseAllWinInfoList.add(baw);
		}
		Tools.comExportExcel(groupPurchaseAllWinInfoList, title, getResponse(),templateFilePath);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼团活动-活动报表-微信参与用户-导出").set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
}
