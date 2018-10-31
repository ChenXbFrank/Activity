package com.activity.common.controller.pc.turntableConfig;

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
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.centerObjcet.IntegralExchangeActivity;
import com.activity.common.model.centerObjcet.MiddleTurnTablePrize;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.system.SystemUser;
import com.activity.common.model.turntable.TurnTable;
import com.activity.common.model.turntable.TurnTablePrize;
import com.activity.common.model.turntable.TurnTableWxUser;
import com.activity.common.model.turntable.TurnTableWxUserWinning;
import com.activity.common.model.turntable.TurnWinInfo;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerRelationService;
import com.activity.common.service.turntable.TurntableService;
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
 * 转盘抽奖配置类
 * 
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/turntableConfig")
public class TurntableConfigController extends BaseController {
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	TurntableService turntableService = TurntableService.getService();
	
	/**
	 * 转盘活动编辑页面
	 */
	public void activityEdit() {
		String belongActivityId = getPara("activity");
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-前往转盘活动编辑页面")
				.set("USE_TIME", uitils.newDate()).save();
		render("/turntableConfig/turntable-edit.html");
	}
	
	/**
	 * 保存转盘活动
	 */
	public void saveTurntableActivity(){
		//转盘配置
		String turntable =getPara("turntableObj");
		//运单信息
		String billLists =getPara("billLists");
		//奖品配置
		String addAwards =getPara("addAwards");
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		JSONObject json = JSONObject.fromObject(turntable);
		Activity activity = Activity.dao.findById(json.get("belongId").toString());
		String newActivityId = newId();
		Boolean rest = new TurnTable().set("TURNTABLE_ID", newActivityId).set("ACTIVITY_NAME", json.get("activityName").toString())
				.set("BACKGROUND_IMG", activity.getImg())
				.set("BELONG_ACTIVITY_ID", activity.getId()).set("MOBLEC_BACKGROUND_IMG", json.get("picSrc").toString())
				.set("ACITIVITY_LAUNCH_USERID", user.getUserId()).set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
				.set("TURNTABLE_NUMBER", json.get("awardNum").toString()).set("SPEED", json.get("speed").toString())
				.set("STATE", "0").set("STARTTIME", json.get("startTime").toString()).set("ENDTIME", json.get("endTime").toString())
				.set("CREATE_TIME", uitils.newDate()).set("APPLYUSERNAME", user.getUserName()).set("APPLYPHONE", user.getPhone())
				.set("TOTAL", json.get("total").toString()).set("SCAN_TURNTABLE_NUMBER", json.get("scanWinningNum").toString())
				.set("RULE_IMG", json.get("ruleImg").toString()).save();
		Boolean sellerOutInfoSave = false;
		if(rest){
			JSONArray jsonBillLists = JSONArray.fromObject(billLists);
			@SuppressWarnings("unchecked")
			List<SellerOutInfoChoice> sellerOutList = (List<SellerOutInfoChoice>) JSONArray.toCollection(jsonBillLists,SellerOutInfoChoice.class);
			for (SellerOutInfoChoice so : sellerOutList) {
				ActivitySellerOutInfo as = new ActivitySellerOutInfo();
				String recordId = so.getRecordId();
				//在这里处理运单状态   将该运单修改为已开展为活动中
				String sql = PropKit.use("database.properties").get("updateSelleInfoState");
				Db.update(sql,recordId);
				SellerOutInfo info = sellerOutInfoService.getSellerOutInfoByOutRecordId(recordId);
				sellerOutInfoSave = as.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
				  .set("ACTIVITY_ID", newActivityId)
				  .set("SELLEROUTINFO_RECORDID", recordId)
				  .set("OUTNO", so.getOutNo())
				  .set("SELLER_USERCODE", info.getSellerId())
				  // 状态 1可以用 2不可用
				  .set("STATE", 2)
				  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("Turntable"))
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
		Boolean turnTablePrizesave = false;
		if(sellerOutInfoSave){
			JSONArray jsonAddAwards = JSONArray.fromObject(addAwards);
			@SuppressWarnings("unchecked")
			List<MiddleTurnTablePrize> middleTurnTablePrize = (List<MiddleTurnTablePrize>) JSONArray.toCollection(jsonAddAwards,MiddleTurnTablePrize.class);
			for (MiddleTurnTablePrize mtp : middleTurnTablePrize) {
				turnTablePrizesave=new TurnTablePrize().set("TURNTABLE_PRIZE_ID", newId()).set("TURNTABLE_ID", newActivityId).set("PRIZE_TYPE", mtp.getType())
				.set("ORDER_NUMBER", mtp.getOrderNumber()).set("PRIZE_IMG", mtp.getPic1Src()).set("PRIZE_NAME", mtp.getName())
				.set("PRIZE_NUMBER", mtp.getNumber()).set("SURPLUS_PRIZE_NUMBER", mtp.getNumber()).set("PRIZE_PROBABILITY", mtp.getProbability())
				.set("SURPLUS_PRIZE_PROBABILITY", mtp.getProbability()).set("INTEGRAL_NUMEBR", mtp.getIntegral()).set("RED_NUMBER", mtp.getMoney())
				.set("CREATE_TIME", uitils.newDate()).save();
			}
		}
		Map<Object, Object> map = new HashMap<Object, Object>();
		if (turnTablePrizesave) {
			map.put("result", "true");
			map.put("activityId", newActivityId);
		} else {
			map.put("result", "false");
			map.put("activityId", newActivityId);
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "保存-转盘抽奖活动配置").set("USE_TIME", uitils.newDate()).save();
		renderJson(map);
	}
	
	/**
	 * 转盘活动审批页面
	 */
	public void turntableApproval(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-所有转盘抽奖活动")
				.set("USE_TIME", uitils.newDate()).save();
		setAttr("turnTable", null);
		setAttr("activityName", activityName);
		setAttr("state", state);
		render("/turntableConfig/turntable-approval.html");
	}
	
	/**
	 * 转盘活动审批详细
	 */
	public void turntableApprovalInfo(){
		String activityId = getPara("activityId");
		TurnTable tt = TurnTable.dao.findById(activityId);
		// 根据活动ID查询该活动的相关的信息
		List<ActivitySellerOutInfo> sellerInfoList = sellerOutInfoService.getSellerInfoByActivityId(activityId);
		List<TurnTablePrize> ttpList = turntableService.getTurnTablePrizeByActivityId(activityId);
		setAttr("turnTable", tt);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("ttpList", ttpList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-转盘抽奖活动-审批查询红包详细")
		.set("USE_TIME", uitils.newDate()).save();
		render("/turntableConfig/turntable-approval-info.html");
	}
	
	/**
	 * 我的全部转盘活动
	 */
	public void turntableMyAllActivity(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		SystemUser user = CacheLoginUser();
		List<TurnTable> tt = turntableService.allTurnTable(user.getUserCode(),activityName,state);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-我的活动-转盘抽奖活动")
				.set("USE_TIME", uitils.newDate()).save();
		setAttr("turnTable", tt);
		setAttr("state", state);
		setAttr("activityName", activityName);
		render("/turntableConfig/turntable-my-all-activity.html");
	}
	
	/**
	 * 当前人的转盘活动
	 * json格式返回
	 */
	public void turntableMyAllActivityJson(){
		SystemUser user = CacheLoginUser();
		String sql="SELECT * FROM TB_TURNTABLE WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		List<TurnTable> turnTableList = TurnTable.dao.find(sql,user.getUserCode());
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		for (TurnTable turnTable : turnTableList) {
			IntegralExchangeActivity ba = new IntegralExchangeActivity();
			ba.setActivityId(turnTable.getTurnTableId());
			ba.setActivityImg(turnTable.getBackGroundImg());
			ba.setActivityName(turnTable.getActivityName());
			NumberFormat nf = NumberFormat.getInstance();
			try {
				ba.setJoinNumber(nf.parse(turnTable.getJoinPropleNumber()).toString());
				ba.setWinNumber(nf.parse(turnTable.getWinningPropleNumber()).toString());
			} catch (ParseException e) {
				e.printStackTrace();
			}
			activityList.add(ba);
		}
		renderJson(activityList);
	}
	
	
	/**
	 * 我的全部转盘活动中单个活动详细
	 */
	public void turntableMyAllActivityInfo(){
		String activityId = getPara("activityId");
		TurnTable tt = TurnTable.dao.findById(activityId);
		// 根据活动ID查询该活动的相关的信息
		List<ActivitySellerOutInfo> sellerInfoList = sellerOutInfoService.getSellerInfoByActivityId(activityId);
		List<TurnTablePrize> ttpList = turntableService.getTurnTablePrizeByActivityId(activityId);
		setAttr("turnTable", tt);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("ttpList", ttpList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-我的活动-转盘活动详细")
		.set("USE_TIME", uitils.newDate()).save();
		render("/turntableConfig/turntable-my-one-activity-info.html");
	}
	
	/**
	 * 全部转盘活动报表
	 */
	public void turntableReportAll(){
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String activityName = getPara("activityName");
		// 活动状态：0申请中 1审批通过 2 驳回
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-转盘活动-报表");
		setAttr("user", user);
		setAttr("activityName", activityName);
		setAttr("state", state);
		setAttr("startTime", startTime);
		setAttr("endTime", endTime);
		setAttr("turnTableList", null);
		render("/turntableConfig/turntable-activity-report-all.html");
	}
	
	/**
	 * 单个转盘活动报表
	 */
	public void turntableReport(){
		String activityId = getPara("activityId");
		String activityName =  getPara("activityName");
		String nickName = getPara("nickName");
		setAttr("turnTableWxUserList", null);
		setAttr("nickName", nickName);
		setAttr("activityName", activityName);
		setAttr("activityId", activityId);
		render("/turntableConfig/turntable-activity-report.html");
	}
	
	/**
	 * 单个转盘活动报表详细
	 */
	public void turntableReportInfo(){
		String turntableWxUserId = getPara("turntableWxUserId");
		String activityName = getPara("activityName");
		String activityId = getPara("activityId");
		List<TurnTableWxUserWinning> turnTableWxUserWinningList=turntableService.queryTurnTableWxUserWinningByTurnTableWxUserId(turntableWxUserId);
		setAttr("turnTableWxUserWinningList", turnTableWxUserWinningList);
		setAttr("activityName", activityName);
		setAttr("activityId", activityId);
		render("/turntableConfig/turntable-activity-report-info.html");
	}
	
	
	/**
	 * 审批
	 */
	public void approve(){
		String remake = getPara("remake");
		String activityId = getPara("activityId");
		String state = getPara("state");
		SystemUser user = CacheLoginUser();
		Boolean resutl =  new TurnTable().set("TURNTABLE_ID", activityId).set("COMFIRMUSERID", user.getUserId()).set("COMFIRMTIME", uitils.newDate())
				.set("COMFIRMUSERNAME", user.getUserName()).set("COMFIRMADVISE", remake).set("STATE", state).update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "修改-转盘活动修改审批状态")
		.set("USE_TIME", uitils.newDate()).save();
		renderJson(resutl);
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String turntableWxUserWinningId = getPara("turntableWxUserId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		TurnTableWxUserWinning turnTablewWinning = TurnTableWxUserWinning.dao.findById(turntableWxUserWinningId);
		boolean resutl = new TurnTableWxUserWinning().set("TURNTABLE_WXUSER_WINNING_ID", turntableWxUserWinningId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(resutl){
			resutl = new ProductWinningInfo().set("ID", turnTablewWinning.getProductWinningInfoId()).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		//传递参数*******发货通知
		String openId = turnTablewWinning.getOpenId();
		if(openId!=null){
			String wxUserId = turnTablewWinning.getTurntableWxuserId();
			TurnTableWxUser wxUser = TurnTableWxUser.dao.findById(wxUserId);
			String belongPublicNumberId = wxUser.getBelongPublicNumberId();
			String prizeName = turnTablewWinning.getPrizeProject();
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			//发送通知
			Tools.sendNotice(openId, sellerPublicNumber, prizeName, deliverCompany, deliverNumber, turnTablewWinning.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(resutl);
	}
	
	/**
	 * 查询所有的转盘活动 分页显示   报表页面  转盘审批  分页
	 */
	public void getTurnPageInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = TurntableService.getService().paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 转盘活动详情分页
	 */
	public void turnInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		String state = getPara("state");
		String goodsState = getPara("goodsState");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = TurnTableWxUser.dao.paginate(Integer.parseInt(currentPage), page,activityId,nickName,state,goodsState);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 转盘审批 报表导出
	 */
	public void getTurnExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "turnTemplate.xlsx";
		// 导出excel的标题
		String title ="转盘申请活动报表"+DateUitils.newDateByYMD();
		String sql="select * from TB_TURNTABLE";
		List<TurnTable> list = TurnTable.dao.find(sql);
		List<TurnTable> turn1=new ArrayList<>();
		//*活动状态：0申请中   1审批通过  2 已驳回  */
		for (TurnTable turn : list) {
			if(turn.getState().equals("0")){
				turn.setSpareOne("申请中");
			}else if(turn.getState().equals("1")){
				turn.setSpareOne("通过");
			}else if(turn.getState().equals("2")){
				turn.setSpareOne("驳回");
			}
			turn1.add(turn);
		}
		Tools.comExportExcel(turn1, title, getResponse(),templateFilePath);
		renderNull();
	}
	
	
	/**
	 * 转盘活动 报表导出
	 */
	public void getTurnInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "turnWxAllWinTemplate.xlsx";
		// 导出excel的标题
		String title ="转盘活动详情报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_TURNTABLE_WXUSER where TURNTABLE_ID = ? ";
		List<TurnTableWxUser> list = TurnTableWxUser.dao.find(sql,activityId);
		//导出的时候  还需要加上发货的情况
		String sq1="select * from TB_TURNTABLE_WXUSER_WINNING where TURNTABLE_WXUSER_ID = ? ";
		List<TurnWinInfo> list1=new ArrayList<>();
		for (TurnTableWxUser t : list) {
			TurnWinInfo ti=new TurnWinInfo();
			String turntableWxuserId = t.getTurntableWxuserId();
			//该条记录的中奖记录
			TurnTableWxUserWinning wi = TurnTableWxUserWinning.dao.findFirst(sq1,turntableWxuserId);
			ti.setNickName(t.getNickName());
			ti.setHeadImg(t.getHeadImgUrl());
			ti.setCreateTime(t.getCreateTime());
			ti.setRedNum(t.getRedWinningNumber());
			ti.setIntNum(t.getIntegralWinningNumber());
			ti.setGoodsNum(t.getGoodsWinningNumber());
			ti.setThaNum(t.getThinkWinningNumber());
			//奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
			String prizeType = wi.getPrizeType();
			if(prizeType.equals("1")){
				ti.setPrizeType("实物");
			}else if(prizeType.equals("2")){
				ti.setPrizeType("积分");
			}else if(prizeType.equals("3")){
				ti.setPrizeType("红包");
			}else if(prizeType.equals("4")){
				ti.setPrizeType("谢谢惠顾");
			}
			ti.setPrizeTime(wi.getCreateTime());
			ti.setPrizeName(wi.getPrizeProject());
			ti.setPrizeInfo(wi.getWinningMoney());
			ti.setReceiver(wi.getAddresseeName());
			ti.setReceivePhone(wi.getAddresseePhone());
			ti.setReceiveAddress(wi.getAddresseeAddress());
			ti.setSender(wi.getLssueUserName());
			ti.setLogisticsCompany(wi.getDeliverCompany());
			ti.setWayBill(wi.getDeliverNumber());
			//状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货
			String state = wi.getState();
			if(state.equals("1")){
				ti.setState("已经领取");
			}else if(state.equals("2")){
				ti.setState("未填写地址");
			}else if(state.equals("3")){
				ti.setState("地址已填写");
			}else if(state.equals("4")){
				ti.setState("已发货");
			}else if(state.equals("5")){
				ti.setState("未发货");
			}
			list1.add(ti);
		}
		Tools.comExportExcel(list1, title, getResponse(),templateFilePath);
		renderNull();
	}
	
	/**
	 * 删除转盘活动
	 */
	public void deleteTurnTable(){
		boolean flag = false;
		String activityId = getPara("activityId");
		// 相关的运单
		List<ActivitySellerOutInfo> sellerInfoByActivityId = sellerOutInfoService.getSellerInfoByActivityId(activityId);
		for (ActivitySellerOutInfo a : sellerInfoByActivityId) {
			//在这里处理运单状态   将该运单修改为未在活动中
			String sql1 = PropKit.use("database.properties").get("updateSelleInfoNoState");
			Db.update(sql1,a.getSellerOutInfoRecordId());
			flag = ActivitySellerOutInfo.dao.deleteById(a.getId());
		}
		String sql="select * from TB_TURNTABLE_PRIZE where TURNTABLE_ID = ? ";
		//相关的配置
		List<TurnTablePrize> list = TurnTablePrize.dao.find(sql,activityId);
		for (TurnTablePrize turnTablePrize : list) {
			flag=TurnTablePrize.dao.deleteById(turnTablePrize.getTurnTablePrizeId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		flag = TurnTable.dao.deleteById(activityId);
		// 删除成功返回true
		if (flag) {
			renderJson("result", "true");
		} else {
			renderJson("result", "false");
		}
	}
}