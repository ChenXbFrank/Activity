package com.activity.common.controller.moblie.integral;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.integral.IntegalExchange;
import com.activity.common.model.integral.Integral;
import com.activity.common.model.integral.IntegralActivity;
import com.activity.common.model.integral.IntegralPrize;
import com.activity.common.model.integral.IntegralProduct;
import com.activity.common.model.integral.IntegralWinObj;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.integral.JoinActivity;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.groupPurchase.GroupPurchaseService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.oneMoney.OneMoneyService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.robRed.RobRedWxUserWiningService;
import com.activity.common.service.scratchCard.ScratchCardService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.turntable.TurntableService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.system.Tools;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.web.controller.ControllerPath;

/**
 * 积分移动端控制器
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/integral")
public class IntegralController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(TurntableService.class);
	IndexService indexService = IndexService.getService();
	IntegralService integralService = IntegralService.getService();
	ScratchCardService scratchCardSrevice = ScratchCardService.getService();
	OneMoneyService oneMoneyService = OneMoneyService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	GroupPurchaseService groupPurchaseService = GroupPurchaseService.getService();
	RobRedWxUserWiningService robRedWxUserWiningService = RobRedWxUserWiningService.getService();
	RedWinningInfoService redWinService=RedWinningInfoService.getService();
	
	/**
	 * 签到
	 */
	public void sign(){
		//用户签到修改签到积分
		Integral integral = Integral.dao.findById(getPara("integralId"));
		ActivityWxUser activityWxUser = ActivityWxUser.dao.findById(getPara("wxUserId"));
		boolean resutl = false;
		String nowTime = DateUitils.newDateByYMD();
		int total=0;
		int surplusTotal=0;
		//是否第一次签到
		if(activityWxUser.getSianTime()==null){
			//这里是修改微信用户的总积分和该用户的剩余积分
			total = Integer.parseInt(activityWxUser.getTotalIntegral())+Integer.parseInt(integral.getSignIntegral());
			surplusTotal = Integer.parseInt(activityWxUser.getSurplusTotalIntegral())+Integer.parseInt(integral.getSignIntegral());
			resutl = new ActivityWxUser().set("ID", activityWxUser.getId()).set("TOTAL_INTEGRAL", total+"")
					.set("SURPLUS_TOTAL_INTEGRAL", surplusTotal+"").set("SIAN_TIME", nowTime).update();
			//保存该用户的签到记录
			IntegralWinningInfo integralWinningInfo = new IntegralWinningInfo();
			integralWinningInfo.setId(newId());
			integralWinningInfo.setBelongActivityId(newId());
			integralWinningInfo.setActivityName("积分签到");
			integralWinningInfo.setActivityNameType(PropKit.use("system.properties").get("Integral"));
			integralWinningInfo.setWinningIntegral(integral.getSignIntegral());
			integralWinningInfo.setCreateTime(uitils.newDate());
			integralWinningInfo.setStartTime("0");
			integralWinningInfo.setEndTime("0");
			integralWinningInfo.setOpenid(activityWxUser.getOpenId());
			integralWinningInfo.setActivityWxUserId(activityWxUser.getId());
			integralWinningInfo.setBelongPublicnumberId(activityWxUser.getBelongPublicNumberId());
			integralService.saveIntegralWinningInfo(integralWinningInfo);
		//今天已签过到
		}else if(activityWxUser.getSianTime().equals(nowTime)){
			resutl = false;
		//今天未签到
		}else if(!activityWxUser.getSianTime().equals(nowTime)){
			//这里是修改微信用户的总积分和该用户的剩余积分
			total = Integer.parseInt(activityWxUser.getTotalIntegral())+Integer.parseInt(integral.getSignIntegral());
			surplusTotal = Integer.parseInt(activityWxUser.getSurplusTotalIntegral())+Integer.parseInt(integral.getSignIntegral());
			resutl = new ActivityWxUser().set("ID", activityWxUser.getId()).set("TOTAL_INTEGRAL", total+"")
					.set("SURPLUS_TOTAL_INTEGRAL", surplusTotal+"").set("SIAN_TIME", nowTime).update();
			//保存该用户的签到记录
			IntegralWinningInfo integralWinningInfo = new IntegralWinningInfo();
			integralWinningInfo.setId(newId());
			integralWinningInfo.setBelongActivityId(newId());
			integralWinningInfo.setActivityName("积分签到");
			integralWinningInfo.setActivityNameType(PropKit.use("system.properties").get("Integral"));
			integralWinningInfo.setWinningIntegral(integral.getSignIntegral());
			integralWinningInfo.setCreateTime(uitils.newDate());
			integralWinningInfo.setStartTime("0");
			integralWinningInfo.setEndTime("0");
			integralWinningInfo.setOpenid(activityWxUser.getOpenId());
			integralWinningInfo.setActivityWxUserId(activityWxUser.getId());
			integralWinningInfo.setBelongPublicnumberId(activityWxUser.getBelongPublicNumberId());
			integralService.saveIntegralWinningInfo(integralWinningInfo);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		if(resutl){
			map.put("resutl", resutl);
			map.put("total", total);
			map.put("surplusTotal", surplusTotal);
		}
		renderJson(map);
	}
	
	/**
	 * 前往兑换产品
	 */
	public void exchangeProduct(){
		String PublicNumberId = getPara("BPN");
		String openid = getPara("oid");
		String integralId = getPara("integralId");
		Integral integral = Integral.dao.findById(integralId);
		String moblecBackgroundImg = integral.getMoblecBackgroundImg();
		setAttr("moblecBackgroundImg", moblecBackgroundImg);
		List<IntegralProduct> integralProductList = integralService.getIntegralProductByActivityId(integralId);
		ActivityWxUser wxUser = indexService.queryUserByOpenidAndPublicNumberId(openid,PublicNumberId);
		setAttr("wxUser", wxUser);
		setAttr("integralProductList", integralProductList);
		setAttr("openid", openid);
		setAttr("integral", integral);
		setAttr("integralId", integralId);
		setAttr("PublicNumberId", PublicNumberId);
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(PublicNumberId);
		setAttr("sellerPublicNumber", sellerPublicNumber);
		render("/integral/exchange-product.html");
	}
	 
	/**
	 * 前往兑换活动
	 */
	public void exchangeActivity(){
		String openid = getPara("oid");
		String PublicNumberId = getPara("BPN");
		String integralId = getPara("integralId");
		List<IntegralActivity> integralActivityList = integralService.getIntegralActivityByActivityId(integralId);
		ActivityWxUser wxUser = indexService.queryUserByOpenidAndPublicNumberId(openid,PublicNumberId);
		String qrcode="DH"+newId();
		String shareBargainNewId = newId();
		setAttr("wxUser", wxUser);
		setAttr("integralActivityList", integralActivityList);
		setAttr("openid", openid);
		setAttr("PublicNumberId", PublicNumberId);
		setAttr("integralId", integralId);
		setAttr("qrcode", qrcode);
		setAttr("shareBargainNewId", shareBargainNewId);
		Integral integral = Integral.dao.findById(integralId);
		String moblecBackgroundImg = integral.getMoblecBackgroundImg();
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(PublicNumberId);
		setAttr("sellerPublicNumber", sellerPublicNumber);
		setAttr("moblecBackgroundImg", moblecBackgroundImg);
		render("/index/mine.html");
	}
	
	/**
	 * 积分活动查询
	 */
	public void queryExchangeProduct(){
		String small = getPara("min");
		String big = getPara("max");
		String sort = getPara("sort");
		String activityId = getPara("activityId");
		List<IntegralProduct> integralProductList = integralService.queryIntegralProductByActivityId(small,big,sort,activityId);
		System.out.println(integralProductList.toString());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("integralProductList", integralProductList);
		map.put("min", small);
		map.put("max", big);
		map.put("sort", sort);
		renderJson(map);
	}
		
	/**
	 * 积分兑换奖品
	 */
	public void JoinProduct(){
		String wxUserId = getPara("wxUserId");
		//需要兑换产品ID
		String exchangeProductId = getPara("exchangeProductId");
		String publicNumberId = getPara("publicNumberId");
		String openid = getPara("openid");
		String integralId = getPara("integralId");
		Integral integral = Integral.dao.findById(integralId);
		String moblecBackgroundImg = integral.getMoblecBackgroundImg();
		setAttr("moblecBackgroundImg", moblecBackgroundImg);
		ActivityWxUser wxUser = ActivityWxUser.dao.findById(wxUserId);
		IntegralProduct integralProduct = IntegralProduct.dao.findById(exchangeProductId);
		setAttr("wxUser", wxUser);
		setAttr("integralProduct", integralProduct);
		setAttr("openid", openid);
		setAttr("integralId", integralId);
		setAttr("publicNumberId", publicNumberId);
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(publicNumberId);
		setAttr("sellerPublicNumber", sellerPublicNumber);
		render("/integral/needChange.html");
	}
	
	/**
	 * 参与积分九宫格活动
	 */
	public void joinIntegralActivity(){
		log.error("***参与积分九宫格活动***");
		//微信用户记录
		String wxUserId = getPara("wxUserId");
		ActivityWxUser wxUser = ActivityWxUser.dao.findById(wxUserId);
		String surplusTotalIntegral = wxUser.getSurplusTotalIntegral();
		String integralId = getPara("integralId");
		Integral integral = Integral.dao.findById(integralId);
		String needIntegral = integral.getNeedIntegral();
		//这里查找出该积分活动的配置奖品
		String sql="select * from TB_INTEGRAL_PRIZE where INTEGRAL_ID = ? ";
		List<IntegralPrize> prizeList = IntegralPrize.dao.find(sql,integralId);
		for (IntegralPrize ip : prizeList) {
			if(ip.getGrade().equals("1")){
				setAttr("prize1", ip);
			}else if(ip.getGrade().equals("2")){
				setAttr("prize2", ip);
			}
			else if(ip.getGrade().equals("3")){
				setAttr("prize3", ip);
			}
			else if(ip.getGrade().equals("4")){
				setAttr("prize4", ip);
			}
			else if(ip.getGrade().equals("5")){
				setAttr("prize5", ip);
			}
			else if(ip.getGrade().equals("6")){
				setAttr("prize6", ip);
			}
			else if(ip.getGrade().equals("7")){
				setAttr("prize7", ip);
			}
			else if(ip.getGrade().equals("8")){
				setAttr("prize8", ip);
			}
		}
		setAttr("integralId", integralId);
		setAttr("wxUserId", wxUserId);
		setAttr("openid", wxUser.getOpenId());
		String belongPublicNumberId = wxUser.getBelongPublicNumberId();
		setAttr("belongPublicNumberId", belongPublicNumberId);
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
		setAttr("sellerPublicNumber", sellerPublicNumber);
		setAttr("needIntegral", needIntegral);
		setAttr("surplusTotalIntegral", surplusTotalIntegral);
		render("/Integral-turn/index.html");
	}
	
	/**
	 * 九宫格的转盘 开始转  生成奖品给前端
	 */
	public void startPrize(){
		log.error("***九宫格的转盘 开始转  生成奖品给前端***");
		Map<String, Object> map = new HashMap<String, Object>();
		String integralId = getPara("integralId");
		String wxUserId = getPara("wxUserId");
		String openId = getPara("openid");
		ActivityWxUser wxUser = ActivityWxUser.dao.findById(wxUserId);
		Integral integral = Integral.dao.findById(integralId);
		//这里要先判断该用户是不是积分足够的
		int totalIntegral = Integer.parseInt(wxUser.getTotalIntegral());
		String surplusTotalIntegrals = wxUser.getSurplusTotalIntegral();
		int surplusTotalIntegral = Integer.parseInt(surplusTotalIntegrals);
		int needIntegral = Integer.parseInt(integral.getNeedIntegral());
		Double totalMoney = Double.parseDouble(wxUser.getTotalMoney());
		Double surplusMoney = Double.parseDouble(wxUser.getSurplusTotalMoney());
		//这是参与活动的id
		String integralExchangeId=newId();
		if(surplusTotalIntegral>=needIntegral){
			surplusTotalIntegral=surplusTotalIntegral-needIntegral;
			//减积分 转的时候减
			Boolean	result =new ActivityWxUser().set("ID", wxUserId).set("SURPLUS_TOTAL_INTEGRAL", surplusTotalIntegral).update();
			//添加参与活动的记录
			if(result){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//这里添加使用积分参与活动的记录
				JoinActivity ja=new JoinActivity();
				result=ja.set("ID", newId()).set("INTEGRALID", integralId).set("JOIN_INTEGRAL", integral.getNeedIntegral())
				.set("ACTIVITYMARK", PropKit.use("system.properties").get("Integral"))
				.set("ACTIVITYNAME", "积分小游戏").set("JOINTIME", sdf.format(new Date())).set("OPENID", wxUser.getOpenId()).set("SELLERPUBLICNUMBERID", wxUser.getBelongPublicNumberId()).save();
			}
			//这里查找出该积分活动的配置奖品
			String sql="select * from TB_INTEGRAL_PRIZE where INTEGRAL_ID = ?  order by Grade asc ";
			List<IntegralPrize> prizeList = IntegralPrize.dao.find(sql,integralId);
			int prizeIndex = Tools.getPrizeIndex(prizeList);
			//所中奖品
			IntegralPrize integralPrize = prizeList.get(prizeIndex);
			map.put("prizeIndex", prizeIndex);
			map.put("result", "true");
			log.error("***prizeIndex***"+prizeIndex);
			log.error("***中的奖品integralPrize***"+integralPrize+"***prizeIndex**>"+prizeIndex);
			//奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
			//保存积分
			if(integralPrize.getType().equals("2")){
				String newId = newId();
				integralExchangeId=newId;
				IntegralWinningInfo integralWinningInfo = new IntegralWinningInfo();
				integralWinningInfo.setId(newId);
				integralWinningInfo.setBelongActivityId(integralId);
				integralWinningInfo.setActivityName("积分小游戏");
				//转盘九宫格  的类型名称存：nine     ACTIVITY_NAME_TYPE
				integralWinningInfo.setActivityNameType("nine_Grid");
				integralWinningInfo.setWinningIntegral(integralPrize.getInfo());
				integralWinningInfo.setCreateTime(uitils.newDate());
				integralWinningInfo.setStartTime("0");
				integralWinningInfo.setEndTime("0");
				integralWinningInfo.setOpenid(openId);
				integralWinningInfo.setActivityWxUserId(wxUserId);
				integralWinningInfo.setBelongPublicnumberId(wxUser.getBelongPublicNumberId());
				int saveIntegralWinningInfo = integralService.saveIntegralWinningInfo(integralWinningInfo);
				int winInfo = Integer.parseInt(integralPrize.getInfo());
				if(saveIntegralWinningInfo>0){
					totalIntegral=totalIntegral+winInfo;
					surplusTotalIntegral=surplusTotalIntegral+winInfo;
					//将该用户的剩余的积分和总积分加上中奖的积分     TOTAL_MONEY    SURPLUS_TOTAL_MONEY
					wxUser.set("ID", wxUserId).set("TOTAL_INTEGRAL", totalIntegral+"").set("SURPLUS_TOTAL_INTEGRAL", surplusTotalIntegral+"").update();
				}
			}
			//红包
			else if(integralPrize.getType().equals("3")){
				String newId = newId();
				integralExchangeId=newId;
				Double winInfo = Double.parseDouble(integralPrize.getInfo());
				//红包的存储字段  RED_WXUSER_ID     nine         BELONG_ROB_RED_PRIZE_ID  这里存的是积分活动的id
				//这是红包微信小活动的记录
				//int saveRobRedWxUserWining = robRedWxUserWiningService.saveRobRedWxUserWining(newId(), "nine_Grid", integralId, winInfo+"", "红包", uitils.newDate(), openId);
				RedWinningInfo info=new RedWinningInfo();
				info.setId(newId);
				info.setBelongPublicnumberId(wxUser.getBelongPublicNumberId());
				info.setBelongActivityId(integralId);
				info.setActivityName("积分小游戏");
				//查询这个字段  ACTIVITY_NAME_TYPE
				info.setActivityNameType("nine_Grid");
				info.setWinningRedTotal(winInfo+"");
				info.setCreateTime(uitils.newDate());
				info.setState("1");
				info.setStartTime("");
				info.setEndTime("");
				info.setWithdrawals("0");
				info.setOpenid(openId);
				info.setActivityWxUserId(integralId);
				int saveRedInfo = redWinService.saveRedInfo(info);
				if(saveRedInfo > 0){
					totalMoney=totalMoney+winInfo;
					surplusMoney=surplusMoney+winInfo;
					//将该用户的剩余的积分和总积分加上中奖的积分         
					wxUser.set("ID", wxUserId).set("TOTAL_MONEY", totalMoney+"").set("SURPLUS_TOTAL_MONEY", surplusMoney+"").update();
				}
			}
			//实物
			else if(integralPrize.getType().equals("1")){
				String productWinningInfoId = newId(); // 个人中心 实物奖品 id
				integralExchangeId=productWinningInfoId;
				// 保存一个实物中奖信息
				ProductWinningInfo productWinningInfo = new ProductWinningInfo();
				productWinningInfo.setId(productWinningInfoId);
				productWinningInfo.setBelongActivityId(integralId);
				productWinningInfo.setActivityName("积分小游戏");
				//活动类型   nine     ACTIVITY_NAME_TYPE
				productWinningInfo.setActivityNameType("nine_Grid");
				productWinningInfo.setProductId("");
				productWinningInfo.setProductName(integralPrize.getName());
				productWinningInfo.setProductImg(integralPrize.getPicture());
				productWinningInfo.setActivityPrizeId(integralPrize.getId());
				productWinningInfo.setCreateTime(uitils.newDate());
				productWinningInfo.setStartTime("");
				productWinningInfo.setEndTime("");
				productWinningInfo.setOpenId(openId);
				productWinningInfo.setActivityWxUserId(wxUserId);
				productWinningInfo.setBelongPublicNumberId(wxUser.getBelongPublicNumberId());
				productWinningInfo.setState("2");
				productWinningInfo.setWinningInfoId(productWinningInfoId);
				productWinningInfo.setPayMoney("0");
				productWinningInfo.setPrice("0");
				productWinningInfo.setLowPrice("0");
				productWinningInfoService.saveProductWinningInfo(productWinningInfo);
			}
			//保存积分兑换活动记录
			 new IntegalExchange().set("INTEGRAL_EXCHANGE_ID", integralExchangeId).set("INTEGRAL_ID", integralId).set("EXCHANGE_TYPE", "1")
			.set("EXCHANGE_PRIZE_ID", integralId).set("EXCHANGE_USE_INTEGRAL", needIntegral+"").set("EXCHANGE_PRIZE_NAME", "积分小游戏")
			.set("EXCHANGE_PRIZE_IMG", integralPrize.getPicture()).set("EXCHANGE_PRIZE_NUMBER", "1").set("TEN_ACTIVITY_ID",integralId )
			.set("TEN_ACTIVITY_NAME", "积分小游戏").set("OPENID", openId).set("STATE", "1").set("QRCODE", "积分参与小游戏").set("NICKNAME", wxUser.getNickName())
			.set("HEADIMGURL", wxUser.getHeadImgUrl()).set("CREATE_TIME", uitils.newDate()).save();
		}else{
			map.put("result", "false");
		}
		renderJson(map);
	}
	
	/**
	 * 九宫格中奖纪录
	 */
	public void winRecord(){
		log.error("***九宫格中奖纪录***");
		String openid = getPara("openid");
		String integralId = getPara("integralId");
		String belongPublicNumberId = getPara("belongPublicNumberId");
		List<IntegralWinObj> results=new ArrayList<>();
		//先查询积分
		String sqlInt="select *  from TB_INTEGRAL_WINNING_INFO where openid = ? and ACTIVITY_NAME_TYPE = ? and BELONG_PUBLICNUMBER_ID = ? ";
		List<IntegralWinningInfo> listInt = IntegralWinningInfo.dao.find(sqlInt,openid,"nine_Grid",belongPublicNumberId);
		//奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
		for (IntegralWinningInfo ii : listInt) {
			IntegralWinObj iw=new IntegralWinObj();
			iw.setId(ii.getId());
			iw.setInfo(ii.getWinningIntegral());
			iw.setName("积分");
			iw.setType("2");
			iw.setWinTime(ii.getCreateTime());
			results.add(iw);
		}
		
		//再查红包
		String sqlRed="select *  from TB_RED_WINNING_INFO where openid = ? and ACTIVITY_NAME_TYPE = ?  and BELONG_ACTIVITY_ID = ? ";
		List<RedWinningInfo> listRed = RedWinningInfo.dao.find(sqlRed,openid,"nine_Grid",integralId);
		for (RedWinningInfo ii : listRed) {
			IntegralWinObj iw=new IntegralWinObj();
			iw.setId(ii.getId());
			iw.setInfo(ii.getWinningRedTotal());
			iw.setName("红包");
			iw.setType("3");
			iw.setWinTime(ii.getCreateTime());
			results.add(iw);
		}
		
		//最后查实物  
		String sqlPro="select * from TB_PRODUCT_WINNING_INFO where openid= ? and ACTIVITY_NAME_TYPE = ? and BELONG_PUBLICNUMBER_ID = ? ";
		List<ProductWinningInfo> listPro = ProductWinningInfo.dao.find(sqlPro,openid,"nine_Grid",belongPublicNumberId);
		for (ProductWinningInfo ii : listPro) {
			IntegralWinObj iw=new IntegralWinObj();
			iw.setId(ii.getId());
			iw.setInfo("实物");
			iw.setName(ii.getProductName());
			iw.setPicture(ii.getProductImg());
			iw.setType("1");
			iw.setWinTime(ii.getCreateTime());
			results.add(iw);
		}
		//将三个集合处理成一个前端的集合
		Tools.ListSort(results);
		setAttr("results", results);
		setAttr("openid", openid);
		setAttr("belongPublicNumberId", belongPublicNumberId);
		render("/Integral-turn/winRecord.html");
	}
	
	/**
	 * 立即兑换
	 */
	public void nowExchange(){
		String integralId = getPara("integralId");
		Integral integral = Integral.dao.findById(integralId);
		String moblecBackgroundImg = integral.getMoblecBackgroundImg();
		setAttr("moblecBackgroundImg", moblecBackgroundImg);
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		String openid = getPara("openid");
		//微信用户记录
		String wxUserId = getPara("wxUserId");
		String publicNumberId = getPara("publicNumberId");
		ActivityWxUser wxUser = ActivityWxUser.dao.findById(wxUserId);
		String integralProductId = getPara("integralProductId");
		IntegralProduct integralProduct = integralService.queryIntegralProductById(integralProductId);
		boolean resutl = false;
		if(!integralProduct.getSurplusProductNumber().equals("0")){
			resutl=Db.tx(new IAtom() {
				@Override
				public boolean run() throws SQLException {
					//保存实物中奖记录ProductWinningInfo
					String integalExchangeId = newId();
					String productWinningInfoId = newId();
					ProductWinningInfo productWinningInfo=new ProductWinningInfo();
					productWinningInfo.setId(productWinningInfoId);
					productWinningInfo.setBelongActivityId(integralId);
					productWinningInfo.setActivityName("积分兑换");
					productWinningInfo.setActivityNameType(PropKit.use("system.properties").get("Integral"));
					productWinningInfo.setProductId(integralProduct.getProductId());
					productWinningInfo.setProductName(integralProduct.getProductName());
					productWinningInfo.setProductImg(integralProduct.getProductImg());
					productWinningInfo.setActivityPrizeId(integralProduct.getId());
					productWinningInfo.setCreateTime(uitils.newDate());
					productWinningInfo.setStartTime("0");
					productWinningInfo.setEndTime("0");
					productWinningInfo.setOpenId(openid);
					productWinningInfo.setActivityWxUserId(wxUserId);
					productWinningInfo.setBelongPublicNumberId(publicNumberId);
					productWinningInfo.setState("3");
					productWinningInfo.setWinningInfoId(integalExchangeId);
					productWinningInfo.setAddresseeName(addresseeName);
					productWinningInfo.setAddresseeAddress(address);
					productWinningInfo.setAddresseePhone(tel);
					productWinningInfo.setPayMoney("0");
					productWinningInfo.setPrice("0");
					productWinningInfo.setLowPrice("0");
					int saveIntegralExchange = productWinningInfoService.saveProductWinningInfo(productWinningInfo);
					if(saveIntegralExchange>0){
						IntegalExchange integalExchange = new IntegalExchange();
						integalExchange.setIntegralExchangeId(integalExchangeId);
						integalExchange.setIntegralId(integralId);
						integalExchange.setExchangeType("2");
						integalExchange.setExchangePrizeId(integralProductId);
						integalExchange.setExchangeUseIntegral(integralProduct.getNeedIntegral());
						integalExchange.setExchangePrizeName(integralProduct.getProductName());
						integalExchange.setExchangePrizeImg(integralProduct.getProductImg());
						integalExchange.setExchangePrizeNumber("1");
						integalExchange.setOpenId(openid);
						integalExchange.setAddresseeName(addresseeName);
						integalExchange.setAddresseeAddress(address);
						integalExchange.setAddresseePhone(tel);
						integalExchange.setState("3");
						integalExchange.setNickName(wxUser.getNickName());
						integalExchange.setHeadimgUrl(wxUser.getHeadImgUrl());
						integalExchange.setCreateTime(uitils.newDate());
						integalExchange.setProductWinningInfoId(productWinningInfoId);
						integalExchange.setBelongPublicNumberId(publicNumberId);
						saveIntegralExchange = integralService.saveIntegralExchange(integalExchange);
						if(saveIntegralExchange == 1){
							//修改奖品剩余数量
							saveIntegralExchange = integralService.updateIntegralProductPrizeNumberById(Integer.parseInt(integralProduct.getSurplusProductNumber())-1+"",integralProductId);
							if(saveIntegralExchange == 1){
								//改变剩余积分
								int surplusTotalIntegral = Integer.parseInt(wxUser.getSurplusTotalIntegral())-Integer.parseInt(integralProduct.getNeedIntegral());
								saveIntegralExchange = indexService.updateWxUserIntegralAndMoneyById(wxUser.getTotalIntegral(),surplusTotalIntegral+"",wxUser.getTotalMoney(),wxUser.getSurplusTotalMoney(),wxUserId);
							}
						}
					}
					if(saveIntegralExchange>0){
						return true;
					}else{
						return false;
					}
				}
			});
		}
		if(resutl){
			setAttr("integralProduct", integralProduct);
			setAttr("name", addresseeName);
			setAttr("tel", tel);
			setAttr("address", address);
			setAttr("publicNumberId", publicNumberId);
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(publicNumberId);
			setAttr("sellerPublicNumber", sellerPublicNumber);
			setAttr("openid", openid);
			render("/integral/success.html");
		}else{
			render("/integral/prizeNotEnough.html");
		}
	}
}
