package com.activity.common.controller.pc.integralConfig;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.controller.pc.system.UploadController;
import com.activity.common.model.activity.Activity;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.bigDataPlatform.PicInfo;
import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.activity.common.model.centerObjcet.integral.AgentProductInfo;
import com.activity.common.model.centerObjcet.integral.TestIntegralPrize;
import com.activity.common.model.integral.IntegalExchange;
import com.activity.common.model.integral.Integral;
import com.activity.common.model.integral.IntegralPrize;
import com.activity.common.model.integral.IntegralProduct;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.system.ActivityService;
import com.activity.common.service.system.ProductInfoService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerRelationService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;
import net.sf.json.JSONArray;

/**
 * 积分配置控制器
 * @author
 *
 */
@ControllerPath(controllerKey = "/integralConfig")
public class IntegralConfigController extends BaseController{
	// 可申请活动service
	ActivityService activityService = ActivityService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	//积分活动service
	IntegralService integralService =IntegralService.getService();
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 奖品信息的service
	ProductInfoService productInfoService = ProductInfoService.getService();
	UploadController upload = UploadController.getUilt();
	
	/**
	 * 进入积分编辑
	 */
	public void integralConfigUpdate() {
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String belongActivityId = getPara("activity");
		// 查询出所有可发起活动
		List<Activity> activityList = activityService.getAllActivity();
		List<Activity> activityList1=new ArrayList<>();
		for (Activity activity : activityList) {
			if(!activity.getActivityName().equals("积分兑换")){
				activityList1.add(activity);
			}
		}
		setAttr("activityList", activityList1);
		List<SellerRelation> proList = sellerRelationService.getSrByTargetId(user.getTargetId().toString());
		setAttr("proList", proList);
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入活动审批页面")
				.set("USE_TIME", uitils.newDate()).save();
		setAttr("belongActivityId", belongActivityId);
		render("/integralConfig/intergral-edit.html");
	}
	
	/**
	 * 保存积分
	 */
	public void integralActivitySave(){
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		//这里是签到积分
		String signIntegral = getPara("integral");
		//转一次所需积分
		String needIntegral = getPara("needIntegral");
		//移动端背景图
		String moblecBackgroundImg = getPara("picsrc");
		//属于活动
		String belongActivityId = getPara("belongActivityId");
		//积分活动ID
		String integralActivityId=newId();
		Boolean result = false;
		Activity activity =Activity.dao.findById(belongActivityId);
		//保存活动
		int saveIntegralActivity = integralService.saveIntegralActivity(integralActivityId, signIntegral, activity.getImg(),belongActivityId,moblecBackgroundImg,user.getUserId().toString(), 
				user.getUserCode(),"0", uitils.newDate(), user.getPhone(), user.getUserName(),"",needIntegral);
		if(saveIntegralActivity > 0){
			//积分兑换活动关联数据 (这是以前选的关联的活动，不需要了)  现在需要的是配置的奖项数据
			String integralExchangeActivity = getPara("addAwards");
			JSONArray bigjson = JSONArray.fromObject(integralExchangeActivity);
			@SuppressWarnings("unchecked")
			List<TestIntegralPrize> ieaList = (List<TestIntegralPrize>) JSONArray.toCollection(bigjson,TestIntegralPrize.class);
			for (int i = 0; i < ieaList.size(); i++) {
				TestIntegralPrize tp = ieaList.get(i);
				//然后循环保存奖品配置
				IntegralPrize ip=new IntegralPrize();
				String info="";
				//奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
				String type=tp.getType();
				if(tp.getType().equals("2")){
					info=tp.getIntegral();
				}else if(tp.getType().equals("3")){
					info=tp.getMoney();
				}
				int grade=i+1;
				result=ip.set("ID", newId()).set("INTEGRAL_ID", integralActivityId)
				  .set("NAME", tp.getName()).set("TYPE", type)
				  .set("WEIGHT", tp.getWeight()).set("INFO", info)
				  .set("PICTURE", tp.getPicture()).set("GRADE", grade+"").save();	
			}
				
			//判断积分兑换参与活动是否成功，成功后保存积分兑换商品
			if(result){
				//其他产品数据
				String allProductInfos = getPara("otherproducts");
				JSONArray otherproductjson = JSONArray.fromObject(allProductInfos);
				@SuppressWarnings("unchecked")
				List<AgentProductInfo> allProductInfosList = (List<AgentProductInfo>) JSONArray.toCollection(otherproductjson,AgentProductInfo.class);
				for(AgentProductInfo apiBL : allProductInfosList){
					int saveIntegralPrize = 0;
					if(apiBL.getAgent().equals("1")){
						// 保存产品图片
						PicInfo pi = productInfoService.getProductImgByProductId(apiBL.getGetProductId());
						String picUrl = pi.getPicUrl();
						String imgPath = "";
						try {
							if(!StringUtils.isEmpty(picUrl)){
								imgPath = upload.getPlsImg(getRequest(),PropKit.use("system.properties").get("platform")+picUrl);
							}
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						saveIntegralPrize = integralService.saveIntegralPrize(newId(), integralActivityId, apiBL.getOrderNumber(),apiBL.getAgent(), apiBL.getGetProductId(), imgPath,
								apiBL.getProductname(), apiBL.getProductNumber(), apiBL.getProductIntroduce(), apiBL.getExchange(),apiBL.getSpecifications(),
								apiBL.getDegrees(),apiBL.getCapacity(),apiBL.getProductNumber());
					}else{
						saveIntegralPrize = integralService.saveIntegralPrize(newId(), integralActivityId, apiBL.getOrderNumber(),apiBL.getAgent(), apiBL.getGetProductId(), apiBL.getProductImg(),
								apiBL.getProductname(), apiBL.getProductNumber(), apiBL.getProductIntroduce(), apiBL.getExchange(),apiBL.getSpecifications(),
								apiBL.getDegrees(),apiBL.getCapacity(),apiBL.getProductNumber());
					}
					
					if(saveIntegralPrize > 0){
						result = true;
					}else{
						result =false;
						break;
					}
				}
			}
		}else{
			result =false;
		}
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
		
	}
	
	/**
	 * 当前所有申请积分的活动 审核页面
	 */
	public void approveIntegral() {
		List<Integral> integralList = integralService.allIntegral();
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-所有积分兑换活动")
				.set("USE_TIME", uitils.newDate()).save();
		setAttr("integralList", integralList);
		render("/integralConfig/intergral-approve.html");
	}
	
	/**
	 * 积分审核详细
	 */
	public void integralApproveInfo(){
		String activityId = getPara("activityId");
		Integral integral = Integral.dao.findById(activityId);
		//这里查找出该积分活动的配置奖品
		String sql="select * from TB_INTEGRAL_PRIZE where INTEGRAL_ID = ? ";
		List<IntegralPrize> prizeList = IntegralPrize.dao.find(sql,activityId);
		//积分关联产品
		List<IntegralProduct> integralProduct = integralService.getIntegralProductByActivityId(activityId);
		setAttr("integral", integral);
		setAttr("prizeList", prizeList);
		setAttr("integralProduct", integralProduct);
		render("/integralConfig/intergral-approve-info.html");
	}
	
	/**
	 * 审批通过
	 */
	public void Approve(){
		String remake = getPara("remake");
		String activityId = getPara("activityId");
		String state = getPara("state");
		SystemUser user = CacheLoginUser();
		Boolean resutl =  new Integral().set("INTEGRAL_ID", activityId).set("COMFIRMUSERID", user.getUserId()).set("COMFIRMTIME", uitils.newDate())
				.set("COMFIRMUSERNAME", user.getUserName()).set("COMFIRMADVISE", remake).set("STATE", state).update();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "修改-积分活动修改审批状态")
		.set("USE_TIME", uitils.newDate()).save();
		renderJson(resutl);
	}
	
	/**
	 * 全部积分活动报表
	 */
	public void integralReportAll(){
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		// 活动状态：0申请中 1审批通过 2 驳回
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-积分活动-报表");
		setAttr("user", user);
		setAttr("state", state);
		setAttr("startTime", startTime);
		setAttr("endTime", endTime);
		setAttr("integralList", null);
		render("/integralConfig/intergral-report-all.html");
	}
	
	/**
	 * 单个积分活动报表
	 */
	public void integralReport(){
		String activityId = getPara("activityId");
		String nickName = getPara("nickName");
		String current=getPara("current");
		setAttr("integalExchangeList", null);
		setAttr("activityId", activityId);
		setAttr("nickName", nickName);
		setAttr("current", current);
		render("/integralConfig/intergral-report.html");
	}
	
	/**
	 * 厂家发货
	 */
	public void saveIssueGoods(){
		String integalExchangeId = getPara("integalExchangeId");
		String deliverNumber = getPara("deliverNumber");
		String deliverCompany = getPara("deliverCompany");
		String sendTime = getPara("sendTime");
		SystemUser user = CacheLoginUser();
		IntegalExchange integalExchange = IntegalExchange.dao.findById(integalExchangeId);
		boolean resutl = new IntegalExchange().set("INTEGRAL_EXCHANGE_ID", integalExchangeId).set("LSSUE_USER_NAME", user.getUserName()).set("LSSUE_USER_USERID", user.getUserId()).set("LSSUE_USER_USERCODE", user.getUserCode())
			.set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).set("STATE", "4").update();
		if(resutl){
			resutl=new ProductWinningInfo().set("ID", integalExchangeId).set("STATE", "4").set("DELIVER_NUMBER", deliverNumber).set("DELIVER_COMPANY", deliverCompany).set("DELIVER_TIME", sendTime).update();
		}
		if(resutl){
			//传递参数*******发货通知
			String openId = integalExchange.getOpenId();
			if(openId!=null){
				ProductWinningInfo productWinningInfo = ProductWinningInfo.dao.findById(integalExchangeId);
				String belongPublicNumberId = productWinningInfo.getBelongPublicNumberId();
				//发送通知
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				Tools.sendNotice(openId, sellerPublicNumber, productWinningInfo.getProductName(), deliverCompany, deliverNumber, productWinningInfo.getAddresseeAddress(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
				ApiConfigKit.removeThreadLocalAppId();
			}
			renderJson("resutl","true");
		}else{
			renderJson("resutl","false");
		}
		
	}
	
	
	/**
	 * 我的活动
	 */
	public void MyIntegralActivity(){
		String state = getPara("state");
		if(state == null){
			state="";
		}
		List<Integral> integralList = integralService.allIntegral(state);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-我的活动-积分兑换活动")
				.set("USE_TIME", uitils.newDate()).save();
		setAttr("integralList", integralList);
		setAttr("state", state);
		render("/integralConfig/intergral-my-activity.html");
	}
	
	/**
	 * 我的活动-查看单个活动详细
	 */
	public void MyIntegralActivityInfo(){
		String activityId = getPara("activityId");
		Integral integral = Integral.dao.findById(activityId);
		//这里查找出该积分活动的配置奖品
		String sql="select * from TB_INTEGRAL_PRIZE where INTEGRAL_ID = ? ";
		List<IntegralPrize> prizeList = IntegralPrize.dao.find(sql,activityId);
		List<IntegralProduct> integralProductList = integralService.getIntegralProductByActivityId(activityId);
		setAttr("integral", integral);
		setAttr("prizeList", prizeList);
		setAttr("integralProductList", integralProductList);
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-我的活动-转盘活动详细")
		.set("USE_TIME", uitils.newDate()).save();
		render("/integralConfig/intergral-my-one-activity.html");
	}
	
	/**
	 * 查询所有的积分活动 分页显示   报表页面  getIntegralPageInfos  
	 */
	public void getIntegralPageInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("activityName");
		String state = getPara("state");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = Integral.dao.paginate(Integer.parseInt(currentPage), page,activityName,state,startTime,endTime,CacheLoginUser());
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 积分兑换活动详情
	 */
	public void integralPageMoreInfo(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String nickName = getPara("nickName");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = IntegalExchange.dao.paginate(Integer.parseInt(currentPage), page,nickName);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 积分活动删除
	 */
	public void deleteIntegra(){
		boolean result=false;
		String activityId = getPara("activityId");
		//这里查找出该积分活动的配置奖品
		String sql="select * from TB_INTEGRAL_PRIZE where INTEGRAL_ID = ? ";
		List<IntegralPrize> prizeList = IntegralPrize.dao.find(sql,activityId);
		for (IntegralPrize integralPrize : prizeList) {
			IntegralPrize.dao.deleteById(integralPrize.getId());
		}
		String sql2="select * from TB_INTEGRAL_PRODUCT where integral_id = ? ";
		List<IntegralProduct> list2 = IntegralProduct.dao.find(sql2,activityId);
		for (IntegralProduct integralProduct : list2) {
			result=IntegralProduct.dao.deleteById(integralProduct.getId());
		}
		result = Integral.dao.deleteById(activityId);
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	/**
	 * 积分导出
	 */
	public void exportIntegralExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "integralTemplate.xlsx";
		// 导出excel的标题  年月日
		String title ="积分活动报表"+DateUitils.newDateByYMD();
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String userCode = user.getUserCode();
		List<Integral> list=new ArrayList<>();
		if(user.getUserId().intValue()==-1){
			String sql="select * from TB_INTEGRAL";
		    list = Integral.dao.find(sql);
		}else{
			String sql="select * from TB_INTEGRAL where ACITIVITY_LAUNCH_USERCODE =? ";
			list=Integral.dao.find(sql,userCode);
		}
		List<Integral> integralList=new ArrayList<>();
		//*活动状态：0申请中   1审批通过  2 已驳回  */
		for (Integral shareBargain : list) {
			if(shareBargain.getState().equals("0")){
				shareBargain.setSpareOne("申请中");
			}else if(shareBargain.getState().equals("1")){
				shareBargain.setSpareOne("通过");
			}else if(shareBargain.getState().equals("2")){
				shareBargain.setSpareOne("驳回");
			}
			integralList.add(shareBargain);
		}
		Tools.comExportExcel(integralList, title, getResponse(),templateFilePath);
		renderNull();
	}
	
	/**
	 * 导出积分活动报表详情
	 */
	public void exportIntegralInfoExcel(){
		// Jfinal获取项目文件路径
		String templateFilePath = JFinal.me().getServletContext().getRealPath("templete") + File.separator + "integralWxTemplate.xlsx";
		// 导出excel的标题
		String title ="积分活动详情报表"+DateUitils.newDateByYMD();
		String activityId = getPara("activityId");
		String sql="select * from TB_INTEGRAL_EXCHANGE where INTEGRAL_ID =? ";
		List<IntegalExchange> list=IntegalExchange.dao.find(sql,activityId);
		List<IntegalExchange> integralList=new ArrayList<>();
		//发货状态  1=兑换成功  2未填写地址 3地址已填写  4已发货  5未发货
		for (IntegalExchange shareBargain : list) {
			if(shareBargain.getState().equals("1")){
				shareBargain.setSpareOne("兑换成功");
			}else if(shareBargain.getState().equals("2")){
				shareBargain.setSpareOne("未填写地址");
			}else if(shareBargain.getState().equals("3")){
				shareBargain.setSpareOne("地址已填写");
			}else if(shareBargain.getState().equals("4")){
				shareBargain.setSpareOne("已发货");
			}else if(shareBargain.getState().equals("5")){
				shareBargain.setSpareOne("未发货");
			}
			//1=兑换参与记录   2=兑换产品
			if(shareBargain.getExchangeType().equals("1")){
				shareBargain.setSpareTwo("参与活动");
			}else if(shareBargain.getExchangeType().equals("2")){
				shareBargain.setSpareTwo("兑换奖品");
			}
			integralList.add(shareBargain);
		}
		Tools.comExportExcel(integralList, title, getResponse(),templateFilePath);
		renderNull();
	}
}
