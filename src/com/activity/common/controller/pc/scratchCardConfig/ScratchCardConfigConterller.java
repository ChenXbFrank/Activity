package com.activity.common.controller.pc.scratchCardConfig;

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
import com.activity.common.model.centerObjcet.IntegralExchangeActivity;
import com.activity.common.model.centerObjcet.MiddleTurnTablePrize;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.scratchCard.ScratchCard;
import com.activity.common.model.scratchCard.ScratchCardPrize;
import com.activity.common.model.scratchCard.ScratchCardWxUser;
import com.activity.common.model.scratchCard.ScratchCardWxUserWinning;
import com.activity.common.model.system.SystemUser;
import com.activity.common.model.turntable.TurnWinInfo;
import com.activity.common.service.scratchCard.ScratchCardService;
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
 * 刮刮乐配置
 * 
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/scratchCardConfig")
public class ScratchCardConfigConterller extends BaseController{
	DateUitils uitils = DateUitils.getUitils();
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	ScratchCardService scratchCardSrevice = ScratchCardService.getService();
	
	/**
	 * 进入刮刮乐编辑页面
	 */
	public void scratchCardUpdate(){
		String belongActivityId = getPara("activity");
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入-刮刮乐抽奖活动配置").set("USE_TIME", uitils.newDate()).save();
		render("/scratchCardConfig/scratchcard-edit.html");
	}
	
	/**
	 * 保存刮刮乐活动
	 */
	public void saveScratchCard(){
		String scratchCardObj = getPara("scratchCardObj");
		String billLists = getPara("billLists");
		String addAwards = getPara("addAwards");
		JSONObject json = JSONObject.fromObject(scratchCardObj);
		Activity activity = Activity.dao.findById(json.get("belongId").toString());
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String scratchcardId = newId();
		Boolean resutl = new ScratchCard().set("SCRATCHCARD_ID", scratchcardId).set("ACTIVITY_NAME", json.get("activityName")).set("BACKGROUND_IMG", activity.getImg())
			.set("BELONG_ACTIVITY_ID", activity.getId()).set("MOBLEC_BACKGROUND_IMG", json.get("picSrc")).set("ACITIVITY_LAUNCH_USERID", user.getUserId())
			.set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode()).set("STATE", "0").set("STARTTIME",  json.get("startTime")).set("ENDTIME",  json.get("endTime"))
			.set("CREATE_TIME", uitils.newDate()).set("APPLYUSERNAME", user.getUserName()).set("APPLYPHONE", user.getPhone())
			.set("TOTAL", json.get("total").toString()).set("SCAN_NUMBER", json.get("scanWinningNum")).save();
		Boolean sellerOutInfoSave = false;
		if(resutl){
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
				  .set("ACTIVITY_ID", scratchcardId)
				  .set("SELLEROUTINFO_RECORDID", recordId)
				  .set("OUTNO", so.getOutNo())
				  .set("SELLER_USERCODE", info.getSellerId())
				  // 状态 1可以用 2不可用
				  .set("STATE", 2)
				  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("ScratchCard"))
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
		Boolean prizeSave = false;
		if(sellerOutInfoSave){
			JSONArray jsonAddAwards = JSONArray.fromObject(addAwards);
			@SuppressWarnings("unchecked")
			List<MiddleTurnTablePrize> middleTurnTablePrize = (List<MiddleTurnTablePrize>) JSONArray.toCollection(jsonAddAwards,MiddleTurnTablePrize.class);
			for (MiddleTurnTablePrize mtp : middleTurnTablePrize) {
				prizeSave=new ScratchCardPrize().set("SCRATCHCARD_PRIZE_ID", newId()).set("SCRATCHCARD_ID", scratchcardId).set("PRIZE_TYPE", mtp.getType())
				.set("ORDER_NUMBER", mtp.getOrderNumber()).set("PRIZE_IMG", mtp.getPic1Src()).set("PRIZE_NAME", mtp.getName())
				.set("PRIZE_NUMBER", mtp.getNumber()).set("SURPLUS_PRIZE_NUMBER", mtp.getNumber()).set("PRIZE_PROBABILITY", mtp.getProbability())
				.set("SURPLUS_PRIZE_PROBABILITY", mtp.getProbability()).set("INTEGRAL_NUMEBR", mtp.getIntegral()).set("RED_NUMBER", mtp.getMoney())
				.set("CREATE_TIME", uitils.newDate()).save();
			}
		}
		Map<Object, Object> map = new HashMap<Object, Object>();
		if (prizeSave) {
			map.put("result", "true");
			map.put("activityId", scratchcardId);
		} else {
			map.put("result", "false");
			map.put("activityId", scratchcardId);
		}
		renderJson(map);
	}
	
	/**
	 * 这里是分享砍价的所有活动记录 当前登录人 
	 * 返回json格式
	 */
	public void cardActivityJson() {
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		String sql="SELECT * FROM TB_SCRATCHCARD WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		// 这是分享砍价的活动
		List<ScratchCard> code = ScratchCard.dao.find(sql,userCode);
		for (ScratchCard sb : code) {
			IntegralExchangeActivity ba = new IntegralExchangeActivity();
			ba.setActivityId(sb.getScratchcardId());
			ba.setActivityImg(sb.getBackGroundImg());
			ba.setActivityName(sb.getActivityName());
			ba.setJoinNumber(sb.getJoinPropleNumber().toString());
			ba.setWinNumber(sb.getWinningPropleNumber().toString());
			activityList.add(ba);
		}
		renderJson(activityList);
	}
	
	/**
	 * 刮刮乐活动审批页面
	 */
	public void scratchCardApproval(){
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查看-刮刮乐抽奖活动审批").set("USE_TIME", uitils.newDate()).save();
		setAttr("scratchCardList", null);
		setAttr("activityName", activityName);
		setAttr("state", state);
		render("/scratchCardConfig/scratchcard-approval.html");
	}
	
	/**
	 * 刮刮乐活动审批详细
	 */
	public void scratchCardApprovalInfo(){
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String activityId = getPara("activityId");
		ScratchCard scratchCard = ScratchCard.dao.findById(activityId);
		// 根据活动ID查询该活动的相关的信息
		List<ActivitySellerOutInfo> sellerInfoList = sellerOutInfoService.getSellerInfoByActivityId(activityId);
		List<ScratchCardPrize> scratchCardPrizeList = scratchCardSrevice.queryScratchCardPrizeByActivityId(activityId);
		setAttr("scratchCard", scratchCard);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("scratchCardPrizeList", scratchCardPrizeList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查看-刮刮乐抽奖活动审批单个活动详细").set("USE_TIME", uitils.newDate()).save();
		render("/scratchCardConfig/scratchcard-approval-info.html");
	}
	
	/**
	 * 审批
	 */
	public void approve(){
		String remake = getPara("remake");
		String activityId = getPara("activityId");
		String state = getPara("state");
		SystemUser user = CacheLoginUser();
		Boolean resutl =  new ScratchCard().set("SCRATCHCARD_ID", activityId).set("COMFIRMUSERID", user.getUserId()).set("COMFIRMTIME", uitils.newDate())
				.set("COMFIRMUSERNAME", user.getUserName()).set("COMFIRMADVISE", remake).set("STATE", state).update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "修改-转盘活动修改审批状态")
		.set("USE_TIME", uitils.newDate()).save();
		renderJson(resutl);
	}
	
	/**
	 * 删除活动
	 */
	public void deleteActivity(){
		String activityId = getPara("activityId");
		// 相关的运单
		List<ActivitySellerOutInfo> sellerInfoByActivityId = sellerOutInfoService.getSellerInfoByActivityId(activityId);
		for (ActivitySellerOutInfo a : sellerInfoByActivityId) {
			//在这里处理运单状态   将该运单修改为未在活动中
			String sql1 = PropKit.use("database.properties").get("updateSelleInfoNoState");
			Db.update(sql1,a.getSellerOutInfoRecordId());
			ActivitySellerOutInfo.dao.deleteById(a.getId());
		}
		List<ScratchCardPrize> scratchCardPrizeList = scratchCardSrevice.queryScratchCardPrizeByActivityId(activityId);
		for(ScratchCardPrize scratchCardPrizeBL: scratchCardPrizeList){
			ScratchCardPrize.dao.deleteById(scratchCardPrizeBL.getScratchCardPrizeId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		Boolean result = ScratchCard.dao.deleteById(activityId);
		renderJson(result.toString());
	}
	
	/**
	 * 我的全部刮刮乐活动
	 */
	public void scratchCardMyAllActivity(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		if(activityName == null){
			activityName="";
		}
		if(state == null){
			state="";
		}
		List<ScratchCard> scratchCardList = scratchCardSrevice.allScratchCard(activityName,state);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-我的活动-全部刮刮乐活动")
				.set("USE_TIME", uitils.newDate()).save();
		setAttr("scratchCardList", scratchCardList);
		setAttr("state", state);
		setAttr("activityName", activityName);
		render("/scratchCardConfig/scratchcard-my-all-activity.html");
	}
	
	/**
	 * 我的全部转盘活动中单个活动详细
	 */
	public void scratchCardActivityInfo(){
		String activityId = getPara("activityId");
		ScratchCard scratchCard = ScratchCard.dao.findById(activityId);
		// 根据活动ID查询该活动的相关的信息
		List<ActivitySellerOutInfo> sellerInfoList = sellerOutInfoService.getSellerInfoByActivityId(activityId);
		List<ScratchCardPrize> scratchCardPrizeList = scratchCardSrevice.queryScratchCardPrizeByActivityId(activityId);
		setAttr("scratchCard", scratchCard);
		setAttr("sellerInfoList", sellerInfoList);
		setAttr("scratchCardPrizeList", scratchCardPrizeList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-我的活动-《"+scratchCard.getActivityName()+"》详细")
		.set("USE_TIME", uitils.newDate()).save();
		render("/scratchCardConfig/scratch-my-one-activity-info.html");
	}
	
	/**
	 * 全部刮刮乐活动报表
	 */
	public void scratchCardReportAll(){
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
		setAttr("scratchCardList", null);
		render("/scratchCardConfig/scratch-activity-report-all.html");
	}
	
	/**
	 * 单个刮刮乐活动报表
	 */
	public void scratchCardReport(){
		String activityId = getPara("activityId");
		String activityName =  getPara("activityName");
		String nickName = getPara("nickName");
		setAttr("scratchCardWxUserList", null);
		setAttr("nickName", nickName);
		setAttr("activityName", activityName);
		setAttr("activityId", activityId);
		render("/scratchCardConfig/scratch-activity-report.html");
	}
	
	/**
	 * 单个刮刮乐活动报表详细
	 */
	public void scratchCardReportInfo(){
		String scratchCardWxUserId = getPara("scratchCardWxUserId");
		String activityName = getPara("activityName");
		ScratchCardWxUser scratchCardWxUser = ScratchCardWxUser.dao.findById(scratchCardWxUserId);
		String scratchCardId = scratchCardWxUser.getScratchCardId();
		List<ScratchCardWxUserWinning> scratchCardWxUserWinningList=scratchCardSrevice.queryScratchCardWxUserWinningByScratchCardWxUserId(scratchCardWxUserId);
		setAttr("scratchCardWxUserWinningList", scratchCardWxUserWinningList);
		setAttr("activityName", activityName);
		setAttr("activityId", scratchCardId);
		render("/scratchCardConfig/scratch-activity-report-info.html");
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String scratchCardWxuserWinningId = getPara("scratchCardWxuserWinningId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		ScratchCardWxUserWinning scratchCardWinning = ScratchCardWxUserWinning.dao.findById(scratchCardWxuserWinningId);
		boolean resutl = new ScratchCardWxUserWinning().set("SCRATCHCARD_WXUSER_WINNING_ID", scratchCardWxuserWinningId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(resutl){
			resutl = new ProductWinningInfo().set("ID", scratchCardWinning.getProductWinningInfoId()).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		//传递参数*******发货通知
		String openId = scratchCardWinning.getOpenId();
		if(openId!=null){
			String wxUserId = scratchCardWinning.getScratchCardWxuserId();
			ScratchCardWxUser wxUser = ScratchCardWxUser.dao.findById(wxUserId);
			String belongPublicNumberId = wxUser.getBelongPublicNumberId();
			String prizeName = scratchCardWinning.getPrizeProject();
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			//发送通知
			Tools.sendNotice(openId, sellerPublicNumber, prizeName, deliverCompany, deliverNumber, scratchCardWinning.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(resutl);
	}
	
	/**
	 * 查询所有的活动 分页显示   报表页面
	 */
	public void getScratchPageInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = ScratchCardService.getService().paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 查询刮刮乐详情
	 */
	public void getScratchPageMoreInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		String state = getPara("state");
		String goodsState = getPara("goodsState");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = ScratchCardWxUser.dao.paginate(Integer.parseInt(currentPage), page,activityId,nickName,state,goodsState);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 刮刮乐导出 审批
	 */
	public void exportCardExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "cardTemplate.xlsx";
		// 导出excel的标题
		String title ="刮刮乐活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<ScratchCard> list=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_SCRATCHCARD";
		    list = ScratchCard.dao.find(sql);
		}else{
			String sql="select * from TB_SCRATCHCARD where ACITIVITY_LAUNCH_USERCODE =? ";
			list=ScratchCard.dao.find(sql,userCode);
		}
		List<ScratchCard> scratchCardList=new ArrayList<>();
		//*活动状态：0申请中   1审批通过  2 已驳回  */
		for (ScratchCard shareBargain : list) {
			if(shareBargain.getState().equals("0")){
				shareBargain.setSpareOne("申请中");
			}else if(shareBargain.getState().equals("1")){
				shareBargain.setSpareOne("通过");
			}else if(shareBargain.getState().equals("2")){
				shareBargain.setSpareOne("驳回");
			}
			scratchCardList.add(shareBargain);
		}
		Tools.comExportExcel(scratchCardList, title, getResponse(),templateFilePath);
		renderNull();
		
	}
	
	/**
	 * 刮刮乐导出 报表详情
	 */
	public void exportCardInfoExcel(){
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "turnWxAllWinTemplate.xlsx";
		String title="刮刮乐详情报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_SCRATCHCARD_WXUSER where SCRATCHCARD_ID = ? ";
		List<ScratchCardWxUser> list = ScratchCardWxUser.dao.find(sql,activityId);
		//导出的时候  还需要加上发货的情况
		String sq1="select * from TB_SCRATCHCARD_WXUSER_WINNING where SCRATCHCARD_WXUSER_ID = ? ";
		List<TurnWinInfo> list1=new ArrayList<>();
		for (ScratchCardWxUser t : list) {
			TurnWinInfo ti=new TurnWinInfo();
			String cardWxuserId = t.getScratchCardWxuserId();
			//该条记录的中奖记录
			ScratchCardWxUserWinning wi = ScratchCardWxUserWinning.dao.findFirst(sq1,cardWxuserId);
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
}
