package com.activity.common.controller.pc.oneMoneyShopConfig;

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
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.oneMoneyShop.OneMoneyAllWinInfo;
import com.activity.common.model.oneMoneyShop.OneMoneyGroupWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyPrize;
import com.activity.common.model.oneMoneyShop.OneMoneyShop;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUserWinning;
import com.activity.common.model.oneMoneyShop.TestOneMoneyPrize;
import com.activity.common.model.publicNumber.SellerPublicNumber;
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
 * 一元购活动Config
 * @author ChenXb
 *
 * 2017年11月24日
 */
@ControllerPath(controllerKey = "/oneMoneyShopConfig")
public class OneMoneyShopConfigController extends BaseController{
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
	
	
	
	public void oneMoneyShopEidt(){
		String belongActivityId = getPara("activity");
		SystemUser user = CacheLoginUser();
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-一元购活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-edit.html");
	}
	
	/**
	 * 保存一元购的活动信息
	 */
	public void oneMoneySave(){
		boolean result = false;
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		//一元购活动
		String oneMoneyObj = getPara("oneMoneyObj");
		JSONObject jsonOneMoney = JSONObject.fromObject(oneMoneyObj);
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
			  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("OneMoneyShop"))
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
			OneMoneyPrize eggPrize=new OneMoneyPrize();
			result=eggPrize.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
			        .set("ONE_MONEY_ID", activityId)
			        .set("PRIZENAME", p.getName())
			        .set("PRIZEIMG", imgPath)
			        .set("PRIZENUMBER", jsonOneMoney.get("total").toString())
			        .set("SPEC", p.getSpec())
			        .set("DEEP", p.getDeep())
			        .set("VOLUME", p.getVolume())
			        .set("BOXCOUNT", p.getBoxCount())
			        .save(); 
		}
		SystemUser user = CacheLoginUser();
		//活动信息
		OneMoneyShop shop=new OneMoneyShop();
		String picSrc = jsonOneMoney.get("picSrc").toString();
		String bImg="";
		if(picSrc.equals("")||picSrc==null){
			//设置默认的背景图
			bImg="/upload/oneMoney.png";
		}else{
			bImg=picSrc;
		}
		Activity activity = Activity.dao.findById(jsonOneMoney.get("belongId"));
		result=shop.set("ID", activityId)
		   .set("ACTIVITYNAME", jsonOneMoney.get("activityName").toString())
		   .set("BACKGROUND_IMG", activity.getImg())
		   .set("BELONG_ACTIVITY_ID", jsonOneMoney.get("belongId").toString())
		   .set("MOBLE_BACKGROUND_IMG", bImg)
		   .set("ACITIVITY_LAUNCH_USERID", user.getUserId())
		   .set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
		   .set("STATE", "0")
		   .set("CREATE_TIME", DateUitils.newDateByYMD())
		   .set("APPLYPHONE", user.getPhone())
		   .set("APPLYUSERNAME", user.getUserName())
		   .set("OPENPRIZENUMBER", jsonOneMoney.get("scanWinningNum").toString())
		   .set("STARTTIME", jsonOneMoney.get("startTime").toString())
		   .set("ENDTIME", jsonOneMoney.get("endTime").toString())
		   .set("TOTAL",jsonOneMoney.get("total").toString()).save();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-保存活动配置信息").set("USE_TIME", uitils.newDate()).save();
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
	 * 这里是分享砍价的所有活动记录 当前登录人 
	 * 返回json格式
	 */
	public void oneShopActivityJson() {
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		String sql="SELECT * FROM TB_ONE_MONEY_SHOP WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		// 这是分享砍价的活动
		List<OneMoneyShop> code = OneMoneyShop.dao.find(sql,userCode);
		for (OneMoneyShop sb : code) {
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
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-进入审批列表").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-approval.html");
	}
	
	/**
	 * 审批活动
	 */
	public void approveOneMoney(){
		String activityId = getPara("activityId");
		//查活动
		OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
		List<OneMoneyPrize> prizeList = OneMoneyPrize.dao.find(sql1,activityId);
		setAttr("oneMoneyShop", oneMoneyShop);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-审批活动").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-approval-info.html");
	}
	
	/**
	 * 处理审批
	 */
	public void handleApproveOneMoney(){
		SystemUser user = CacheLoginUser();
		String activityId = getPara("activityId");
		String state = getPara("state");
		String advice = getPara("remake");
		OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findById(activityId);
		boolean result = oneMoneyShop.set("ID", activityId)
		        .set("STATE", state)
		        .set("COMFIRMADVISE", advice)
		        .set("COMFIRMTIME", DateUitils.newDateByYMD())
		        .set("COMFIRMUSERID", user.getUserId())
		        .set("COMFIRMUSERNAME", user.getUserName())
		        .update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-处理审批").set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 我的所有的一元购活动
	 */
	public void myAllOneMoneyActivity(){
		SystemUser user = CacheLoginUser();
		String sql="select * from TB_ONE_MONEY_SHOP where ACITIVITY_LAUNCH_USERCODE = ? ";
		List<OneMoneyShop> oneMoneyShopList = OneMoneyShop.dao.find(sql,user.getUserCode());
		setAttr("oneMoneyShopList", oneMoneyShopList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-所有的活动").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-my-all-activity.html");
	}
	
	/**
	 * 我的一元购活动  审批详情
	 */
	public void oneMoneyInfo(){
		String activityId = getPara("activityId");
		//查活动
		OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
		List<OneMoneyPrize> prizeList = OneMoneyPrize.dao.find(sql1,activityId);
		setAttr("oneMoneyShop", oneMoneyShop);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-单个的活动详情").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-approval-info.html");
	}
	
	/**
	 * 审批列表分页显示
	 */
	public void getOneMoneyInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = OneMoneyShop.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 我的一元购活动  活动详情
	 */
	public void oneOneMoneyInfo(){
		String activityId = getPara("activityId");
		//查活动
		OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
		List<OneMoneyPrize> prizeList = OneMoneyPrize.dao.find(sql1,activityId);
		setAttr("oneMoneyShop", oneMoneyShop);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-单个的活动详情").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-one-activity-info.html");
	}
	
	/**
	 * 查询一元购活动
	 */
	public void searchOneMoneyActivity(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		String sql="select * from TB_ONR_MONEY_SHOP where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		List<OneMoneyShop> oneMoneyShopList = OneMoneyShop.dao.find(sql);
		setAttr("oneMoneyShopList", oneMoneyShopList);
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
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-查询一元购活动").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-my-all-activity.html");
		
	}
	
	
	/**
	 * 删除一元购活动
	 */
	public void deleteOneMoneyActivity(){
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
		String sql1="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
		List<OneMoneyPrize> prizeList = OneMoneyPrize.dao.find(sql1,activityId);
		for (OneMoneyPrize oneMoneyPrize : prizeList) {
			result=OneMoneyPrize.dao.deleteById(oneMoneyPrize.getId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		result=OneMoneyShop.dao.deleteById(activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-删除一元购活动").set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 我的一元购活动 
	 */
	public void oneMoneyReport(){
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-一元购活动报表 ").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-activity-report-all.html");
	}
	
	/**
	 * 一元购点击更多
	 */
	public void oneMoneyMoreInfoReport(){
		String oneMoneyId = getPara("activityId");
		String activityName = getPara("activityName");
		setAttr("oneMoneyList", null);
		setAttr("activityId", oneMoneyId);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-活动报表-微信参与用户").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoney-activity-report.html");
	}
	
	/**
	 * 微信用户列表活动列表分页显示
	 */
	public void getOneMoneyWxUserInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = OneMoneyWxUser.dao.paginate1(Integer.parseInt(currentPage), page,activityId,nickName);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 点击查看中奖信息
	 */
	public void lookWinInfo(){
		String oneMoneyWxUserId = getPara("oneMoneyWxUserId");
		String sql="select NICKNAME from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and state = ? ";
		OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sql,oneMoneyWxUserId,"1");
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-活动报表-微信参与用户-中奖信息").set("USE_TIME", uitils.newDate()).save();
		renderJson(oneMoneyGroupWxUser);
	}
	
	/**
	 * 查看明细 去发货
	 */
	public void sendWinInfo(){
		String oneMoneyWxUserId = getPara("oneMoneyWxUserId");
		String sql="select * from TB_ONEMONEY_WXUSER_WINNING where ONEMONEY_WXUSER_ID = ? ";
		OneMoneyWxUserWinning oneMoneyWxUserWinning = OneMoneyWxUserWinning.dao.findFirst(sql,oneMoneyWxUserId);
		setAttr("oneMoneyWxUserWinning", oneMoneyWxUserWinning);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-活动报表-微信参与用户-中奖信息-去向发货页面").set("USE_TIME", uitils.newDate()).save();
		render("/oneMoneyShopConfig/oneMoneyShop-activity-report-info.html");
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String oneMoneyWxUserWinningId = getPara("oneMoneyWxUserWinningId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		OneMoneyWxUserWinning oneMoneyWxUserWinning = OneMoneyWxUserWinning.dao.findById(oneMoneyWxUserWinningId);
		boolean result = new OneMoneyWxUserWinning().set("ID", oneMoneyWxUserWinningId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(result){
			result = new ProductWinningInfo().set("ID", oneMoneyWxUserWinning.getProductWinningInfoId()).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-活动报表-微信参与用户-中奖信息-发货").set("USE_TIME", uitils.newDate()).save();
		//传递参数*******发货通知
		String openId = oneMoneyWxUserWinning.getOpenId();
		if(openId!=null){
			String wxUserId = oneMoneyWxUserWinning.getOneMoneyWxUserId();
			OneMoneyWxUser wxUser = OneMoneyWxUser.dao.findById(wxUserId);
			String belongPublicNumberId = wxUser.getBelongPublicNumberId();
			String prizeName = oneMoneyWxUserWinning.getPrizeProject();
			//发送通知
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			Tools.sendNotice(openId, sellerPublicNumber, prizeName, deliverCompany, deliverNumber, oneMoneyWxUserWinning.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(result);
	}
	
	/**
	 * 一元购活动审批导出
	 */
	public void exportOneMoneyExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "oneMoneyShopTemplate.xlsx";
		// 导出excel的标题
		String title ="一元购活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<OneMoneyShop> oneMoneyList=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_ONE_MONEY_SHOP";
			oneMoneyList = OneMoneyShop.dao.find(sql);
		}else{
			// 这是根据usercode查询属于他的一元购活动
			String sql="select * from TB_ONE_MONEY_SHOP where ACITIVITY_LAUNCH_USERCODE = ? ";
			oneMoneyList = OneMoneyShop.dao.find(sql,userCode);
		}
		List<OneMoneyShop> oneMoneyList1=new ArrayList<>();
		/*活动状态：0申请中   1审批通过  2 已驳回  */
		for (OneMoneyShop oneMoney : oneMoneyList) {
			if(oneMoney.getState().equals("0")){
				oneMoney.setSpareOne("申请中");
			}else if(oneMoney.getState().equals("1")){
				oneMoney.setSpareOne("通过");
			}else if(oneMoney.getState().equals("2")){
				oneMoney.setSpareOne("驳回");
			}
			oneMoneyList1.add(oneMoney);
		}
		Tools.comExportExcel(oneMoneyList1, title, getResponse(),templateFilePath);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-活动报表-导出").set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
	/**
	 * 一元购活动详情导出(包含中奖情况发货情况)
	 */
	public void exportOneMoneyInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "oneMoneyPuzzleWxAllWinTemplate.xlsx";
		// 导出excel的标题
		String title ="一元购微信活动报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_ONE_MONEY_WXUSER where ONE_MONEY_ID = ? ";
		String sql1="select * from TB_ONEMONEY_WXUSER_WINNING where ONEMONEY_WXUSER_ID = ? ";
		List<OneMoneyWxUser> oneMoneyWxUserList = OneMoneyWxUser.dao.find(sql,activityId);
		List<OneMoneyAllWinInfo> oneMoneyAllWinInfoList=new ArrayList<>();
		for (OneMoneyWxUser bew : oneMoneyWxUserList) {
			OneMoneyAllWinInfo baw =new OneMoneyAllWinInfo();
			String id = bew.getId();
			OneMoneyWxUserWinning bw = OneMoneyWxUserWinning.dao.findFirst(sql1,id);
			baw.setNickName(bew.getNickName());
			baw.setHeadImg(bew.getHeadImgUrl());
			baw.setCreateTime(bew.getCreateTime());
			//状态0未中奖 1中奖
			String state2 = bew.getState();
			if(state2.equals("0")){
				baw.setWinState("未中奖");
			}else if(state2.equals("1")){
				baw.setWinState("中奖");
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
			oneMoneyAllWinInfoList.add(baw);
		}
		Tools.comExportExcel(oneMoneyAllWinInfoList, title, getResponse(),templateFilePath);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "一元购-活动报表-微信参与用户-导出").set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
}
