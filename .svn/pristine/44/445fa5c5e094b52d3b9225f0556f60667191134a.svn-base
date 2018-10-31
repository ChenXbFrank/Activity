package com.activity.common.controller.pc.puzzleConfig;

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
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.centerObjcet.IntegralExchangeActivity;
import com.activity.common.model.centerObjcet.SellerOutInfoChoice;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.oneMoneyShop.OneMoneyAllWinInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.puzzle.Puzzle;
import com.activity.common.model.puzzle.PuzzlePrize;
import com.activity.common.model.puzzle.PuzzleWxUser;
import com.activity.common.model.puzzle.PuzzleWxUserWinning;
import com.activity.common.model.puzzle.TestPuzzlePrize;
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
 * 小游戏PC端配置
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/puzzleConfig")
public class PuzzleConfigController extends BaseController{
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
	public void puzzleEdit(){
		String belongActivityId = getPara("activity");
		SystemUser user = CacheLoginUser();
		setAttr("soiList", null);
		List<SellerRelation> srList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("srList", srList);
		setAttr("userTargetId", user.getTargetId());
		setAttr("belongActivityId", belongActivityId);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "编辑-拼图活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-edit.html");
	}
	
	/**
	 * 保存拼图活动信息
	 */
	public void puzzleSave(){
		boolean result = false;
		String activityId = UUID.randomUUID().toString().replaceAll("-", "");
		//拼图活动
		String puzzleObj = getPara("puzzleObj");
		JSONObject jsonPuzzle = JSONObject.fromObject(puzzleObj);
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
			  .set("BELONG_ACTIVITY", PropKit.use("system.properties").get("Puzzle"))
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
		List<TestPuzzlePrize> awardList = (List<TestPuzzlePrize>) JSONArray.toCollection(awardJson,
				TestPuzzlePrize.class);
		for (TestPuzzlePrize p : awardList) {
			String imgPath = "";
			try {
				String img = p.getImg();
				if(!StringUtils.isEmpty(img)){
					imgPath = upload.getPlsImg(getRequest(),PropKit.use("system.properties").get("platform")+img);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			PuzzlePrize puzzlePrize=new PuzzlePrize();
			result=puzzlePrize.set("ID", UUID.randomUUID().toString().replaceAll("-", ""))
			        .set("PUZZLE_ID", activityId)
			        .set("PRODUCTIMG", imgPath)
			        .set("PRIZENAME", p.getName())
			        .set("PRIZENUMBER", jsonPuzzle.get("total").toString())
			        .set("SPEC", p.getSpec())
			        .set("DEEP", p.getDeep())
			        .set("VOLUME", p.getVolume())
			        .set("BOXCOUNT", p.getBoxCount())
			        .save(); 
		}
		SystemUser user = CacheLoginUser();
		//活动信息
		Puzzle puzzle=new Puzzle();
		String picSrc = jsonPuzzle.get("picSrc").toString();
		String bImg="";
		if(picSrc.equals("")||picSrc==null){
			//设置默认的背景图
			bImg="/upload/puzzle.png";
		}else{
			bImg=picSrc;
		}
		Activity activity = Activity.dao.findById(jsonPuzzle.get("belongId"));
		result=puzzle.set("ID", activityId)
		   .set("ACTIVITYNAME", jsonPuzzle.get("activityName").toString())
		   .set("BACKGROUND_IMG", activity.getImg())
		   .set("BELONG_ACTIVITY_ID", jsonPuzzle.get("belongId").toString())
		   .set("MOBLE_BACKGROUND_IMG", bImg)
		   .set("ACITIVITY_LAUNCH_USERID", user.getUserId())
		   .set("ACITIVITY_LAUNCH_USERCODE", user.getUserCode())
		   .set("STATE", "0")
		   .set("CREATE_TIME", DateUitils.newDateByYMD())
		   .set("APPLYPHONE", user.getPhone())
		   .set("APPLYUSERNAME", user.getUserName())
		   .set("STARTTIME", jsonPuzzle.get("startTime").toString())
		   .set("ENDTIME", jsonPuzzle.get("endTime").toString())
		   .set("PALYTIME", jsonPuzzle.get("playTime").toString())
		   .set("PUZZLEIMG", jsonPuzzle.get("puzzleImg").toString())
		   .set("LOOKTIME", jsonPuzzle.get("lookTime").toString())
		   .set("TOTAL",jsonPuzzle.get("total").toString()).save();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "保存拼图活动信息").set("USE_TIME", uitils.newDate()).save();
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
	public void puzzleActivityJson() {
		List<IntegralExchangeActivity> activityList = new ArrayList<IntegralExchangeActivity>();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		String sql="SELECT * FROM TB_PUZZLE WHERE ACITIVITY_LAUNCH_USERCODE=? AND STATE = '1' AND JOINED = '0'";
		// 这是分享砍价的活动
		List<Puzzle> code = Puzzle.dao.find(sql,userCode);
		for (Puzzle sb : code) {
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
		setAttr("puzzleList", null);
		setAttr("activityName", "");
		setAttr("state", "");
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-进入审批列表").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-approval.html");
	}
	
	/**
	 * 审批活动
	 */
	public void approvePuzzle(){
		String activityId = getPara("activityId");
		//查活动
		Puzzle puzzle = Puzzle.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_PUZZLE_PRIZE where PUZZLE_ID = ? ";
		List<PuzzlePrize> prizeList = PuzzlePrize.dao.find(sql1,activityId);
		setAttr("puzzle", puzzle);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-进入审批列表").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-approval-info.html");
	}
	
	/**
	 * 处理审批
	 */
	public void handleApprovePuzzle(){
		SystemUser user = CacheLoginUser();
		String activityId = getPara("activityId");
		String state = getPara("state");
		String advice = getPara("remake");
		Puzzle puzzle = Puzzle.dao.findById(activityId);
		boolean result = puzzle.set("ID", activityId)
		        .set("STATE", state)
		        .set("COMFIRMADVISE", advice)
		        .set("COMFIRMTIME", DateUitils.newDateByYMD())
		        .set("COMFIRMUSERID", user.getUserId())
		        .set("COMFIRMUSERNAME", user.getUserName())
		        .update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-处理审批").set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 我的所有的拼图活动
	 */
	public void myAllPuzzleActivity(){
		SystemUser user = CacheLoginUser();
		String sql="select * from TB_PUZZLE where ACITIVITY_LAUNCH_USERCODE = ? ";
		List<Puzzle> puzzleList = Puzzle.dao.find(sql,user.getUserCode());
		setAttr("puzzleList", puzzleList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-所有的拼图活动").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-my-all-activity.html");
	}
	
	/**
	 * 我的拼图活动  审批详情
	 */
	public void puzzleInfo(){
		String activityId = getPara("activityId");
		//查活动
		Puzzle puzzle = Puzzle.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_PUZZLE_PRIZE where PUZZLE_ID = ? ";
		List<PuzzlePrize> prizeList = PuzzlePrize.dao.find(sql1,activityId);
		setAttr("puzzle", puzzle);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-审批详情").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-my-one-activity-info.html");
	}
	
	/**
	 * 审批列表分页显示
	 */
	public void getPuzzleInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = Puzzle.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 活动报表
	 */
	public void puzzleReport(){
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-活动报表").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-activity-report-all.html");
	}
	
	/**
	 * 活动报表更多
	 */
	public void puzzleMoreReport(){
		String activityId = getPara("activityId");
		String activityName = getPara("activityName");
		setAttr("activityId", activityId);
		setAttr("activityName", activityName);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-微信活动报表").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-activity-report.html");
	}
	
	/**
	 * 这是参加大活动的微信用户
	 */
	public void getPuzzleWxUserInfoPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String currentPage = getPara("currentPage");
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = PuzzleWxUser.dao.paginate1(Integer.parseInt(currentPage), page,activityId,nickName);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 中奖纪录
	 */
	public void puzzleWinInfo(){
		String puzzleWxUserId = getPara("puzzleWxUserId");
		String activityName = getPara("activityName");
		String activityId = getPara("activityId");
		String sql="select * from TB_PUZZLE_WXUSER_WINNING where PUZZLE_WXUSER_ID = ? ";
		PuzzleWxUserWinning puzzleWxUserWinning = PuzzleWxUserWinning.dao.findFirst(sql,puzzleWxUserId);
		setAttr("puzzleWxUserWinning", puzzleWxUserWinning);
		setAttr("activityName", activityName);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-微信活动报表-中奖纪录").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-activity-report-info.html");
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String puzzleWxUserWinningId = getPara("puzzleWxUserWinningId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		PuzzleWxUserWinning puzzleWxUserWinning = PuzzleWxUserWinning.dao.findById(puzzleWxUserWinningId);
		boolean result = new PuzzleWxUserWinning().set("ID", puzzleWxUserWinningId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(result){
			result = new ProductWinningInfo().set("ID", puzzleWxUserWinning.getProductWinningInfoId()).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		String puzzleWxuserId = puzzleWxUserWinning.getPuzzleWxuserId();
		PuzzleWxUser puzzleWxUser = PuzzleWxUser.dao.findById(puzzleWxuserId);
		if(result){
			//发货状态改为已发货
			result=puzzleWxUser.set("ID", puzzleWxuserId).set("GOODSTATE", "1").update();
		}
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-微信活动报表-厂家发货").set("USE_TIME", uitils.newDate()).save();
		//传递参数*******发货通知
		String openId = puzzleWxUserWinning.getOpenId();
		if(openId!=null){
			String wxUserId = puzzleWxUserWinning.getPuzzleWxuserId();
			PuzzleWxUser wxUser = PuzzleWxUser.dao.findById(wxUserId);
			String belongPublicNumberId = wxUser.getBelongPublicNumberId();
			String prizeName = puzzleWxUserWinning.getPrizeProject();
			//发送通知
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			Tools.sendNotice(openId, sellerPublicNumber, prizeName, deliverCompany, deliverNumber, puzzleWxUserWinning.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(result);
	}
	
	/**
	 * 我的拼图活动  活动详情
	 */
	public void onePuzzleInfo(){
		String activityId = getPara("activityId");
		//查活动
		Puzzle puzzle = Puzzle.dao.findById(activityId);
		String sql="select * from TB_ACTIVITY_SELLEROUTINFO where ACTIVITY_ID = ? ";
		List<ActivitySellerOutInfo> sellInfoList = ActivitySellerOutInfo.dao.find(sql,activityId);
		String sql1="select * from TB_PUZZLE_PRIZE where PUZZLE_ID = ? ";
		List<PuzzlePrize> prizeList = PuzzlePrize.dao.find(sql1,activityId);
		setAttr("puzzle", puzzle);
		setAttr("sellInfoList", sellInfoList);
		setAttr("prizeList", prizeList);
		setAttr("activityId", activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-我的拼图活动-活动详情").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-my-one-activity-info.html");
	}
	
	/**
	 * 查询拼图活动
	 */
	public void searchPuzzleActivity(){
		String activityName = getPara("activityName");
		String state = getPara("state");
		String sql="select * from TB_Puzzle where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		List<Puzzle> puzzleList = Puzzle.dao.find(sql);
		setAttr("puzzleList", puzzleList);
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
		set("USE_FUNCTION", "拼图-查询拼图活动").set("USE_TIME", uitils.newDate()).save();
		render("/puzzleConfig/puzzle-my-all-activity.html");
		
	}
	
	
	/**
	 * 删除拼图活动
	 */
	public void deletePuzzleActivity(){
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
		String sql1="select * from TB_Puzzle_PRIZE where PUZZLE_ID = ? ";
		List<PuzzlePrize> prizeList = PuzzlePrize.dao.find(sql1,activityId);
		for (PuzzlePrize oneMoneyPrize : prizeList) {
			result=PuzzlePrize.dao.deleteById(oneMoneyPrize.getId());
		}
		//这里将扫码记录删除一下
		int delete = Db.update("delete from ACTIVITY_CODE where ACTIVITY_ID = ?", activityId);
		if(delete>0){
			System.out.println("***码记录删除成功***delete"+delete);
		}
		result=Puzzle.dao.deleteById(activityId);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-删除拼图活动").set("USE_TIME", uitils.newDate()).save();
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 拼图活动审批导出
	 */
	public void exportPuzzleExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "puzzleTemplate.xlsx";
		// 导出excel的标题
		String title ="拼图活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<Puzzle> puzzleList=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_PUZZLE";
			puzzleList = Puzzle.dao.find(sql);
		}else{
			// 这是根据usercode查询属于他的拼图活动
			String sql="select * from TB_PUZZLE where ACITIVITY_LAUNCH_USERCODE = ? ";
			puzzleList = Puzzle.dao.find(sql,userCode);
		}
		List<Puzzle> oneMoneyList1=new ArrayList<>();
		/*活动状态：0申请中   1审批通过  2 已驳回  */
		for (Puzzle puzzle : puzzleList) {
			if(puzzle.getState().equals("0")){
				puzzle.setSpareOne("申请中");
			}else if(puzzle.getState().equals("1")){
				puzzle.setSpareOne("通过");
			}else if(puzzle.getState().equals("2")){
				puzzle.setSpareOne("驳回");
			}
			oneMoneyList1.add(puzzle);
		}
		Tools.comExportExcel(oneMoneyList1, title, getResponse(),templateFilePath);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-拼图活动-导出").set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
	/**
	 * 拼图活动详情导出(包含中奖情况发货情况)
	 */
	public void exportPuzzleInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "oneMoneyPuzzleWxAllWinTemplate.xlsx";
		// 导出excel的标题
		String title ="拼图微信活动报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_PUZZLE_WXUSER where PUZZLE_ID = ? ";
		String sql1="select * from TB_PUZZLE_WXUSER_WINNING where PUZZLE_WXUSER_ID = ? ";
		List<PuzzleWxUser> puzzleWxUserList = PuzzleWxUser.dao.find(sql,activityId);
		List<OneMoneyAllWinInfo> puzzleAllWinInfoList=new ArrayList<>();
		for (PuzzleWxUser bew : puzzleWxUserList) {
			OneMoneyAllWinInfo baw =new OneMoneyAllWinInfo();
			String id = bew.getId();
			PuzzleWxUserWinning bw = PuzzleWxUserWinning.dao.findFirst(sql1,id);
			baw.setNickName(bew.getNickName());
			baw.setHeadImg(bew.getHeadImgUrl());
			baw.setCreateTime(bew.getCreateTime());
			//状态0开始拼图 1成功 2未成功 3未开始拼图
			String state2 = bew.getState();
			if(state2.equals("1")){
				baw.setWinState("中奖");
			}else{
				baw.setWinState("未中奖");
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
			puzzleAllWinInfoList.add(baw);
		}
		Tools.comExportExcel(puzzleAllWinInfoList, title, getResponse(),templateFilePath);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).
		set("USE_FUNCTION", "拼图-拼图活动-中奖详细-导出").set("USE_TIME", uitils.newDate()).save();
		renderNull();
	}
	
}
