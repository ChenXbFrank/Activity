package com.activity.common.controller.pc.accumulateFabulousConfig;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.accumulate.Accumulate;
import com.activity.common.model.accumulate.AccumulateAllWinInfo;
import com.activity.common.model.accumulate.AccumulateCommentWxUser;
import com.activity.common.model.accumulate.AccumulatePrize;
import com.activity.common.model.accumulate.AccumulateWxUserWinning;
import com.activity.common.model.accumulate.TestAccumulatePrize;
import com.activity.common.model.accumulate.TestSellerInfo;
import com.activity.common.model.activity.Activity;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.centerObjcet.IntegralExchangeActivity;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.accumulateFabulous.AccumulateService;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.shareBargain.ShareBargainWxuserService;
import com.activity.common.service.system.ActivityService;
import com.activity.common.service.system.IndexService;
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
 * 积攒排名获奖PC端
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/accumulateFabulousConfig")
public class AccumulateFabulousConfigController extends BaseController{
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
	// 集赞活动service
	AccumulateService accumulateService = AccumulateService.getService();
	IndexService indexService =IndexService.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IntegralService integralService = IntegralService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	/**
	 * 集赞编辑页面
	 */
	public void accumulateEdit(){
		String belongActivityId = getPara("activity");
		SystemUser user = CacheLoginUser();
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-集赞活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-edit.html");
	}
	
	/**
	 * 获取运单收到的运单
	 */
	public void sellInfo(){
		Integer pageNumber = getParaToInt("pageNumber");
		String outNo = getPara("outNumber");
		String name = getPara("name");
		String startTime2 = getPara("startTime2");
		String endTime2 = getPara("endTime2");
		SystemUser user = CacheLoginUser();
		// 运单信息   分页查询的结果  String userCode,int pageNumber,String name,String startTime2, String endTime2
		List<SellerOutInfo> soiList = sellerOutInfoService.getSoiByUserCode(user.getUserCode(),pageNumber,outNo,name,startTime2,endTime2);
		int totalPageSize = sellerOutInfoService.getSellerPage(user.getUserCode(), pageNumber,outNo, name, startTime2, endTime2);
		Map<String,Object> map=new HashMap<>();
		map.put("totalPageSize", totalPageSize);
		map.put("pageNumber", pageNumber);
		map.put("soiList", soiList);
		renderJson(map);
	}
	
	
	/**
	 * 获取运单   发出去的运单
	 */
	public void sendSellInfo(){
		Integer pageNumber = getParaToInt("pageNumber");
		String outNo = getPara("outNumber");
		String name = getPara("name");
		String startTime2 = getPara("startTime2");
		String endTime2 = getPara("endTime2");
		SystemUser user = CacheLoginUser();
		// 运单信息   分页查询的结果  String userCode,int pageNumber,String name,String startTime2, String endTime2
		List<SellerOutInfo> soiList = sellerOutInfoService.getSendSellerInfoByUserId(user.getTargetId().toString(),pageNumber,outNo,name,startTime2,endTime2);
		int totalPageSize = sellerOutInfoService.getSendSellerPage(user.getTargetId().toString(), pageNumber,outNo, name, startTime2, endTime2);
		Map<String,Object> map=new HashMap<>();
		map.put("totalPageSize", totalPageSize);
		map.put("pageNumber", pageNumber);
		map.put("soiList", soiList);
		renderJson(map);
	}
	
	/**
	 * 保存集赞配置信息
	 */
	public void accumulateSave(){
		boolean result = false;
		SystemUser user = CacheLoginUser();
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		//collectObj活动名称  起始时间  背景图片 所属活动id
		String collectObj = getPara("collectObj");
		//奖品配置
		String addAwards = getPara("addAwards");
		//运单信息
		String billLists = getPara("billLists");
		//产品简介
		String briefIntroduction = getPara("briefIntroduction");
		//产品图片
		String picSrc0 = getPara("picSrc0");
		// 将前端的json数据转为JsonObject对象
		JSONObject jsonActivity = JSONObject.fromObject(collectObj);
		//保存集赞活动信息
		Accumulate accumulate=new Accumulate();
		Activity activity = Activity.dao.findById(jsonActivity.get("belongId"));
		result=accumulate.set("ID", activityId)
				  .set("ACTIVITYNAME", jsonActivity.get("activityName"))
				  .set("BACKGROUND_IMG", activity.getImg())
				  .set("BELONG_ACTIVITY_ID", jsonActivity.get("belongId"))
				  .set("MOBLE_BACKGROUND_IMG", jsonActivity.get("picSrc"))
				  .set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
				  .set("ACITIVITY_LAUNCH_USERID", user.getUserId())
				  .set("STARTTIME", jsonActivity.get("startTime").toString())
				  .set("ENDTIME", jsonActivity.get("endTime").toString())
				  .set("CREATE_TIME", DateUitils.newDateByYMD())
				  .set("APPLYUSERNAME", user.getUserName())
				  .set("APPLYUSERID", user.getUserCode())
				  .set("APPLYPHONE", user.getPhone())
				  .set("PRODUCTINTRODUCTION", briefIntroduction)
				  .set("PRODUCTIMG", picSrc0)
				  // state 活动状态：0申请中 1审批通过 2 已驳回 3下一步临时的状态
				  .set("STATE", 0)
				  .save();
		//活动运单信息
		
		JSONArray jsonSellerInfo = JSONArray.fromObject(billLists);
		@SuppressWarnings("unchecked")
		List<TestSellerInfo> sellerOutInfo = (List<TestSellerInfo>) JSONArray.toCollection(jsonSellerInfo,
				TestSellerInfo.class);
		// 分条保存运单信息
		for (TestSellerInfo so : sellerOutInfo) {
			String recordId = so.getRecordId();
			SellerOutInfo info = sellerOutInfoService.getSellerOutInfoByOutRecordId(recordId);
			//在这里处理运单状态   将该运单修改为已开展为活动中
			String sql = PropKit.use("database.properties").get("updateSelleInfoState");
			Db.update(sql,recordId);
			ActivitySellerOutInfo as = new ActivitySellerOutInfo();
			String status = so.getStatus();
			if(status.equals("接收的货")){
				status="1";
			}else{
				status="2";
			}
	     result = as.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
					.set("ACTIVITY_ID", activityId)
					.set("SELLEROUTINFO_RECORDID", so.getRecordId())
					.set("OUTNO", so.getOutNo())
					.set("SELLER_USERCODE", info.getUSERID())
					// 状态 1可以用 2不可用
					.set("STATE", 2)
					.set("BELONG_ACTIVITY", PropKit.use("system.properties").get("AccumulateFabulous"))
					.set("OUTSELLERNAME", info.getRecsellerName())
					.set("PRODUCTNAME", info.getProductName())
					.set("DEEP", info.getDegree())
					.set("VOLUME", info.getVolume())
					.set("SPEC", info.getSpec())
					.set("BOXSIZE", info.getBoxCode())
					.set("BANDNAME", info.getBrandsName())
					.set("OUTDATE", DateUitils.DateTostr(info.getOutDate()))
					//1接收的货  2发出的货
					.set("SENDORREC", status)
					.save();
		}
		
		//保存集赞奖品配置信息  两个奖项 分条保存
		JSONArray jsonAwards = JSONArray.fromObject(addAwards);
		@SuppressWarnings("unchecked")
		List<TestAccumulatePrize> awards = (List<TestAccumulatePrize>) JSONArray.toCollection(jsonAwards,
				TestAccumulatePrize.class);
		for (TestAccumulatePrize tp : awards) {
			AccumulatePrize ap=new AccumulatePrize();
			result=ap.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
			  .set("ACCUMULATE_ID", activityId)
			  .set("PRIZEGRADE", tp.getGrade())
			  .set("THRESHOLD", tp.getTotal())
			  .set("PRIZENAME", tp.getName())
			  .set("PRIZEIMG", tp.getPic1Src())
			  //奖品类型 1实物 2积分 3红包
			  .set("PRIZETYPE", tp.getType())
			  .set("REDMONEY", tp.getMoney())
			  .set("INTEGRAL", tp.getIntegral())
			  .save();
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "保存集赞配置信息")
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
	public void accumulateActivityJson() {
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		String sql="SELECT * FROM TB_ACCUMULATEFABULOUS WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		// 这是分享砍价的活动
		List<Accumulate> code = Accumulate.dao.find(sql,userCode);
		for (Accumulate sb : code) {
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
	 * 查看我的集赞活动
	 */
	public void myAccumulate(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		SystemUser user = CacheLoginUser();
		String userCode = user.getUserCode();
		String sql="select * from TB_ACCUMULATEFABULOUS where ACITIVITY_LAUNCH_USERCODE =? ";
		if(activityName!=null&&!"".equals(activityName)){
			sql += " and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if(state!=null&&!"".equals(state)){
			sql += " and state = " + " '" + state + "' ";
		}
		List<Accumulate> accumulateList = Accumulate.dao.find(sql,userCode);
		//集赞活动
		setAttr("accumulateList", accumulateList);
		setAttr("activityName", activityName);
		setAttr("state", state);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查看我的集赞活动")
		.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-activity.html");
	}
	
	/**
	 * 查看我的集赞活动的详情
	 */
	public void accumulateInfo(){
		String activityId = getPara("activityId");
		Accumulate accumulate = Accumulate.dao.findById(activityId);
		String sql="select * from TB_ACCUMULATEFABULOUS_PRIZE where ACCUMULATE_ID =? ";
		List<AccumulatePrize> accumulatePrizeList = AccumulatePrize.dao.find(sql,activityId);
		//查询活动相关的运单
		String sq="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ?";
		List<ActivitySellerOutInfo> sellerInfoList = ActivitySellerOutInfo.dao.find(sq,activityId);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("accumulate", accumulate);
		setAttr("accumulatePrizeList", accumulatePrizeList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查看我的集赞活动的详情")
		.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-activity-info.html");
	}
	
	/**
	 * 集赞活动审批
	 */
	public void accumulateApprove(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		setAttr("accumulateList", null);
		setAttr("activityName", activityName);
		setAttr("state", state);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "集赞活动审批")
		.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-activity-approval-all.html");
	}
	
	/**
	 * 分页显示分享砍价的活动报表       当前所有申请分享砍价的活动 审核页面   分页
	 */
	public void accumulateReportPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = Accumulate.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 查询所有的集赞活动 分页显示   报表页面
	 */
	public void getAccumulatePageInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String nickName = getPara("nickName");
		String accumulateId = getPara("accumulateId");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = AccumulateCommentWxUser.dao.paginate1(Integer.parseInt(currentPage), page,nickName,accumulateId);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 集赞活动审批 处理
	 */
	public void approveAccumulate(){
		String activityId = getPara("activityId");
		Accumulate accumulate = Accumulate.dao.findById(activityId);
		String sql="select * from TB_ACCUMULATEFABULOUS_PRIZE where ACCUMULATE_ID =? ";
		List<AccumulatePrize> accumulatePrizeList = AccumulatePrize.dao.find(sql,activityId);
		//查询活动相关的运单
		String sq="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ?";
		List<ActivitySellerOutInfo> sellerInfoList = ActivitySellerOutInfo.dao.find(sq,activityId);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("accumulate", accumulate);
		setAttr("accumulatePrizeList", accumulatePrizeList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "集赞活动审批 处理")
		.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-activity-approval-info.html");
	}
	
	/**
	 * 处理集赞审核
	 */
	public void handleAccumulateApprove(){
		String activityId = getPara("activityId");
		//活动状态：0申请中 1审批通过 2 已驳回
		String state = getPara("state");
		String advice = getPara("remake");
		SystemUser user = CacheLoginUser();
		Accumulate accumulate = Accumulate.dao.findById(activityId);
		boolean update = accumulate.set("ID", activityId)
		          .set("STATE", state)
		          .set("COMFIRMUSERID", user.getUserId())
		          .set("COMFIRMUSERNAME", user.getUserName())
		          .set("COMFIRMTIME", DateUitils.newDateByYMD())
		          .set("COMFIRMADVISE", advice)
		          .update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "处理集赞审核")
		.set("USE_TIME", uitils.newDate()).save();
		if(update){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 删除集赞活动
	 */
	public void deleteAccumulate(){
		boolean flag = false;
		String activityId = getPara("activityId");
		// 相关的运单
		List<ActivitySellerOutInfo> sellerInfoByActivityId = sellerOutInfoService.getSellerInfoByActivityId(activityId);
		for (ActivitySellerOutInfo a : sellerInfoByActivityId) {
			//在这里处理运单状态   将该运单修改为未在活动中
			String sql = PropKit.use("database.properties").get("updateSelleInfoNoState");
			Db.update(sql,a.getSellerOutInfoRecordId());
			flag = ActivitySellerOutInfo.dao.deleteById(a.getId());
		}
		String sql="select * from TB_ACCUMULATEFABULOUS_PRIZE where ACCUMULATE_ID = ? ";
		//相关的配置
		List<AccumulatePrize> list = AccumulatePrize.dao.find(sql,activityId);
		for (AccumulatePrize accumulatePrize : list) {
			flag=AccumulatePrize.dao.deleteById(accumulatePrize.getId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		flag = Accumulate.dao.deleteById(activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "删除集赞活动")
		.set("USE_TIME", uitils.newDate()).save();
		// 删除成功返回true
		if (flag) {
			renderJson("result", "true");
		} else {
			renderJson("result", "false");
		}
	}
	
	/**
	 * 集赞报表
	 */
	public void accumulateReport(){
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入集赞报表")
		.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-activity-report-all.html");
	}
	
	/**
	 * 大活动更多详情的链接
	 */
	public void accumulateMoreInfo(){
		String accumulateId = getPara("accumulateId");
		String activityName = getPara("activityName");
		setAttr("accumulateList", null);
		setAttr("activityId", accumulateId);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入集赞报表--微信参与用户")
		.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-activity-report.html");
	}
	
	/**
	 * 更多详情的链接
	 */
	public void accumulateCommentMoreInfo(){
		String accumulateCommentWxUserId = getPara("accumulateCommentWxUserId");
		String sql="select * from TB_ACCUMULATE_WXUSER_WINNING where ACCUMULATE_WXUSER_ID = ? ";
		List<AccumulateWxUserWinning> list = AccumulateWxUserWinning.dao.find(sql,accumulateCommentWxUserId);
		setAttr("activityId", accumulateCommentWxUserId);
		setAttr("helpList", list);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入集赞报表--微信参与用户中奖情况")
		.set("USE_TIME", uitils.newDate()).save();
		render("/accumulateFabulousConfig/accumulateFabulous-activity-report-info.html");
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String accumulateWxuserWinningId = getPara("accumulateWxuserWinningId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		AccumulateWxUserWinning accumulateWinning = AccumulateWxUserWinning.dao.findById(accumulateWxuserWinningId);
		boolean resutl = new AccumulateWxUserWinning().set("ID", accumulateWxuserWinningId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(resutl){
			resutl = new ProductWinningInfo().set("ID", accumulateWinning.getProductWinningInfoId()).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入集赞报表--微信参与用户中奖情况--厂家发货")
		.set("USE_TIME", uitils.newDate()).save();
		//传递参数*******发货通知
		String openId = accumulateWinning.getOpenId();
		if(openId!=null){
			String accumulateWxuserId = accumulateWinning.getAccumulateWxuserId();
			AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao.findById(accumulateWxuserId);
			String belongPublicNumberId = accumulateCommentWxUser.getBelongPublicNumberId();
			String prizeName = accumulateWinning.getPrizeProject();
			//发送通知
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			Tools.sendNotice(openId, sellerPublicNumber, prizeName, deliverCompany, deliverNumber, accumulateWinning.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(resutl);
	}
	
	
	/**
	 * 集赞活动审批导出
	 */
	public void exportAccumulateExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "accumulateFabulousTemplate.xlsx";
		// 导出excel的标题
		String title ="集赞活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<Accumulate> accumulateList=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_ACCUMULATEFABULOUS";
			accumulateList = Accumulate.dao.find(sql);
		}else{
			// 这是根据usercode查询属于他的集赞活动
			String sql="select * from TB_ACCUMULATEFABULOUS where ACITIVITY_LAUNCH_USERCODE = ? ";
			accumulateList = Accumulate.dao.find(sql,userCode);
		}
		List<Accumulate> accumulateList1=new ArrayList<>();
		/*活动状态：0申请中   1审批通过  2 已驳回  */
		for (Accumulate accumulate : accumulateList) {
			if(accumulate.getState().equals("0")){
				accumulate.setSpareOne("申请中");
			}else if(accumulate.getState().equals("1")){
				accumulate.setSpareOne("通过");
			}else if(accumulate.getState().equals("2")){
				accumulate.setSpareOne("驳回");
			}
			accumulateList1.add(accumulate);
		}
		Tools.comExportExcel(accumulateList1, title, getResponse(),templateFilePath);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入集赞报表--导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
	/**
	 * 集赞活动详情导出
	 */
	public void exportAccumulateInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "accumulateWxAllWinTemplate.xlsx";
		// 导出excel的标题
		String title ="集赞微信活动报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_ACCUMULATE_COMMENT_WXUSER where ACCUMULATE_ID = ? ";
		String sql1="select * from TB_ACCUMULATE_WXUSER_WINNING where ACCUMULATE_WXUSER_ID = ? ";
		List<AccumulateCommentWxUser> accumulateCommentList = AccumulateCommentWxUser.dao.find(sql,activityId);
		List<AccumulateAllWinInfo> accumulateAllWinInfoList=new ArrayList<>();
		for (AccumulateCommentWxUser bew : accumulateCommentList) {
			AccumulateAllWinInfo baw=new AccumulateAllWinInfo();
			//中奖和发货
			AccumulateWxUserWinning bw = AccumulateWxUserWinning.dao.findFirst(sql1,bew.getId());
			baw.setNickName(bew.getNickName());
			baw.setHeadImg(bew.getHeadImgUrl());
			baw.setCreateTime(bew.getCreateTime());
			baw.setHelpNum(bew.getHelpNumber()+"");
			//中奖情况 1一等奖 2阀值奖 3未中奖
			String winState = bew.getWinState();
			if(winState.equals("1")){
				baw.setWinState("一等奖 ");
			}else if(winState.equals("2")){
				baw.setWinState("阀值奖");
			}else if(winState.equals("3")){
				baw.setWinState("未中奖");
			}
			//奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
			if(bw!=null){
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
			accumulateAllWinInfoList.add(baw);
		}
		Tools.comExportExcel(accumulateAllWinInfoList, title, getResponse(),templateFilePath);
		renderNull();
	}
	
	/**
	 * 发货情况导出
	 */
	public void exportAccumulateSendInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "accumulateFabulousWxWinTemplate.xlsx";
		// 导出excel的标题
		String title ="集赞微信活动中奖报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_ACCUMULATE_WXUSER_WINNING where ACCUMULATE_WXUSER_ID = ? ";
		List<AccumulateWxUserWinning> list = AccumulateWxUserWinning.dao.find(sql,activityId);
		List<AccumulateWxUserWinning> list1=new ArrayList<>();
		for (AccumulateWxUserWinning accumulateWxUserWinning : list) {
			//状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货
			if(accumulateWxUserWinning.getState().equals("1")){
				accumulateWxUserWinning.setSpareOne("已经领取");
			}else if(accumulateWxUserWinning.getState().equals("2")){
				accumulateWxUserWinning.setSpareOne("未填写地址");
			}else if(accumulateWxUserWinning.getState().equals("3")){
				accumulateWxUserWinning.setSpareOne("地址已填写");
			}else if(accumulateWxUserWinning.getState().equals("4")){
				accumulateWxUserWinning.setSpareOne("已发货");
			}else if(accumulateWxUserWinning.getState().equals("5")){
				accumulateWxUserWinning.setSpareOne("未发货");
			}
			accumulateWxUserWinning.setPrizeType("实物");
			list1.add(accumulateWxUserWinning);
		}
		Tools.comExportExcel(list1, title, getResponse(),templateFilePath);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入集赞报表--微信参与用户--导出")
		.set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
}
