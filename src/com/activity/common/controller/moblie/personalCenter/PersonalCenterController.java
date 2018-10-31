package com.activity.common.controller.moblie.personalCenter;

import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.accumulate.AccumulateWxUserWinning;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.breakEgg.BreakEggWxUserWinning;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.groupPurchase.PurchaseWxUserWinning;
import com.activity.common.model.integral.IntegalExchange;
import com.activity.common.model.integral.Integral;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.integral.JoinActivity;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.puzzle.PuzzleWxUserWinning;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.model.scratchCard.ScratchCardWxUserWinning;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.activity.common.model.turntable.TurnTableWxUserWinning;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.robRed.RobRedWxUserService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.WxService;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.ICallback;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.alibaba.druid.util.StringUtils;
import com.web.controller.ControllerPath;


/**
 * 个人中心
 * 
 * @author 唐
 */
@ControllerPath(controllerKey = "/personalCenter")
public class PersonalCenterController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(PersonalCenterController.class);
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	IndexService indexService = IndexService.getService();
	RobRedWxUserService robRedWxUserService = RobRedWxUserService.getService();
	IntegralService integralService = IntegralService.getService();
	RedWinningInfoService redWinningInfoService =RedWinningInfoService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	WxService wxService = WxService.getService();
	
	
	/**
	 * 微信访问加载公众号配置，重定向至个人中心
	 */
	public void index() {
		// 公众号配置
		String BelongPublicNumberId = getPara("BPN");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(BelongPublicNumberId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
		redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
				+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
				+ JFinal.me().getContextPath() + "%2fpersonalCenter%2fpresonalCenter%3fAID%3d" + spn.getAppId()
				+ "%26BPN%3d" + BelongPublicNumberId
				+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect");
	}

	/**
	 * 个人中心   公众号进入个人中心
	 */
	public void presonalCenter(){
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(getPara("BPN"));
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(),spn.getAppId(), spn.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(spn.getAppId());
		String openid = getOpenid(spn);
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		String nickName=null;
		//关注了之后
		if(wxuser.getSubscribe().equals("1")){
			//保存微信用户
			wxService.saveWxUser(wxuser,openid,spn,newId());
			Db.execute(new ICallback() {
				@Override
				public Object call(Connection conn) throws SQLException {
					// TODO Auto-generated method stub
					CallableStatement proc = conn.prepareCall("{call updateNameOrHeadimgByOpenid(?,?,?)}");
					proc.setString(1, wxuser.getNickname());
					proc.setString(2, wxuser.getHeadimgurl());
					proc.setString(3, openid);
	                proc.execute();
					return proc;
				}
			});
			// 获取用户基本信息
			nickName = wxuser.getNickname();
			Boolean emoji =  EmojiUtils.containsEmoji(nickName);
			if(emoji){
				try {
					nickName=java.net.URLEncoder.encode(nickName, "UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
			/*ar = UserApi.getUserInfo(openid);
			nickName = ar.getStr("nickname");
			Boolean emoji =  EmojiUtils.containsEmoji(nickName);
			if(emoji){
				try {
					nickName=java.net.URLEncoder.encode(nickName, "UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}*/
		}
		//找出是否存在积分活动
		//找到当前用户发起的积分兑换
		Integral integral = integralService.getIntegralByUser(spn.getSellerUserCode(),spn.getSellerUserId());
		ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,spn.getId());
		setAttr("activityWxUser", awu);
		setAttr("integral", integral);
		setAttr("headimgurl", wxuser.getHeadimgurl());
		setAttr("nickName", nickName);
		setAttr("follow", wxuser.getSubscribe());
		setAttr("BelongPublicNumberId", spn.getId());
		setAttr("openid", openid);
		render("/index/Personal-Center.html");
	}

	/**
	 * 活动进入个人中心
	 */
	public void ActivityPresonalCenter(){
		// 公众号配置ID
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(getPara("BPN"));
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(),spn.getAppId(), spn.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(spn.getAppId());
		String openid =getPara("openid");
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		if(!StringUtils.isEmpty(openid)){
			if(!StringUtils.isEmpty(wxuser.getNickname())){
				Boolean emoji =  EmojiUtils.containsEmoji(wxuser.getNickname());
				if(emoji){
					try {
						wxuser.setNickname(java.net.URLEncoder.encode(wxuser.getNickname(), "UTF-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
			}
		}
		Db.execute(new ICallback() {
			@Override
			public Object call(Connection conn) throws SQLException {
				// TODO Auto-generated method stub
				CallableStatement proc = conn.prepareCall("{call updateNameOrHeadimgByOpenid(?,?,?)}");
				proc.setString(1, wxuser.getNickname());
				proc.setString(2, wxuser.getHeadimgurl());
				proc.setString(3, openid);
                proc.execute();
				return proc;
			}
		});
		//找出是否存在积分活动
		Integral integral = integralService.getIntegralByUser(spn.getSellerUserCode(),spn.getSellerUserId());
		ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,spn.getId());
		setAttr("activityWxUser", awu);
		setAttr("integral", integral);
		setAttr("headimgurl", wxuser.getHeadimgurl());
		setAttr("nickName", wxuser.getNickname());
		setAttr("BelongPublicNumberId", spn.getId());
		setAttr("openid", openid);
		render("/index/Personal-Center.html");
	}
	
	
	/**
	 * 我的奖品  
	 */
	public void myPrize(){
		String BelongPublicNumberId = getPara("BPN");
		String openid = getPara("oid");
		// 活动名称
		String activeName = getPara("activityName");
		// 状态
		String state = getPara("selectedVal");
		log.error("选择的状态***state**>"+state);
		List<ProductWinningInfo> productWinningInfoList = productWinningInfoService.queryProductWinningInfo(openid,BelongPublicNumberId,activeName,state);
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(BelongPublicNumberId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
		WxConfigUitils wx=WxConfigUitils.getWxConfigUitils();
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		//根据openid获取用户信息
		WxUserInfo wxUserInfo = wx.getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		if(wxUserInfo.getSubscribe().equals("1")){
			//保存或修改微信用户
			wxService.saveWxUser(wxUserInfo,openid,sellerPublicNumber,newId());
			Db.execute(new ICallback() {
				@Override
				public Object call(Connection conn) throws SQLException {
					// TODO Auto-generated method stub
					CallableStatement proc = conn.prepareCall("{call updateNameOrHeadimgByOpenid(?,?,?)}");
					proc.setString(1, wxUserInfo.getNickname());
					proc.setString(2, wxUserInfo.getHeadimgurl());
					proc.setString(3, openid);
	                proc.execute();
					return proc;
				}
			});
		}
		setAttr("productWinningInfoList", productWinningInfoList);
		setAttr("BPN", BelongPublicNumberId);
		setAttr("openid", openid);
		setAttr("activeName", activeName);
		setAttr("state", state);
		render("/index/standings.html");
	}
	
	/**
	 * 我的红包
	 */
	public void myRed(){
		String openid = getPara("oid");
		//公众号ID
		String SPNId = getPara("BPN");
		log.error("个人中心-我的红包-Openid="+openid+"-公众号ID="+SPNId);
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(SPNId);
		ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,spn.getId());
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(),spn.getAppId(), spn.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(spn.getAppId());
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		//默认该用户未关注
		String follow="0";
		if(wxuser.getSubscribe().equals("1")){
			//不为空的时候则是获取该用户的关注情况
			follow=wxuser.getSubscribe();
		}
		setAttr("follow", follow);
		String mch_billno = "wly"+uitils.RandomNumber();
		//查询所有所有活动中奖活动
		List<RedWinningInfo> redWinningInfoList = redWinningInfoService.queryRedInfoByPublicNumberAndOpenid(SPNId, openid);
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(SPNId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		WxConfigUitils wx=WxConfigUitils.getWxConfigUitils();
		//根据openid获取用户信息
		WxUserInfo wxUserInfo = wx.getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		if(wxUserInfo.getSubscribe().equals("1")){
			//保存或修改微信用户
			wxService.saveWxUser(wxUserInfo,openid,sellerPublicNumber,newId());
			Db.execute(new ICallback() {
				@Override
				public Object call(Connection conn) throws SQLException {
					// TODO Auto-generated method stub
					CallableStatement proc = conn.prepareCall("{call updateNameOrHeadimgByOpenid(?,?,?)}");
					proc.setString(1, wxUserInfo.getNickname());
					proc.setString(2, wxUserInfo.getHeadimgurl());
					proc.setString(3, openid);
	                proc.execute();
					return proc;
				}
			});
		}
		setAttr("openid", openid);
		setAttr("mch_billno",mch_billno);
		setAttr("activityWxUser", awu);
		setAttr("redWinningInfoList", redWinningInfoList);
		setAttr("SPNId", SPNId);
		setAttr("sellerPublicNumber", spn);
		setAttr("follow", follow);
		render("/robRed/robRed-personcenter.html");
	}
	
	/**
	 * 我的积分
	 */
	public void myIntegral(){
		String openid = getPara("oid");
		String sellerPublicNumberId = getPara("BPN");
		String startTime = getPara("startTime");
		String endtime = getPara("endTime");
		log.error("个人中心-我的积分-Openid="+openid+"-公众号ID="+sellerPublicNumberId);
		List<IntegralWinningInfo> integralWinningInfoList=integralService.getIntegralByOpenidAndPublicNumber(openid,sellerPublicNumberId,startTime,endtime);
		List<IntegalExchange> integalExchangeList=integralService.getIntegralExchangeByOpenidAndPublicNumber(openid,sellerPublicNumberId,startTime,endtime);
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		//将砸蛋的中奖信息更新
		WxConfigUitils wx=WxConfigUitils.getWxConfigUitils();
		WxUserInfo wxUserInfo = wx.getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		if(wxUserInfo.getSubscribe().equals("1")){
			//保存或修改微信用户
			wxService.saveWxUser(wxUserInfo,openid,sellerPublicNumber,newId());
			Db.execute(new ICallback() {
				@Override
				public Object call(Connection conn) throws SQLException {
					// TODO Auto-generated method stub
					CallableStatement proc = conn.prepareCall("{call updateNameOrHeadimgByOpenid(?,?,?)}");
					proc.setString(1, wxUserInfo.getNickname());
					proc.setString(2, wxUserInfo.getHeadimgurl());
					proc.setString(3, openid);
	                proc.execute();
					return proc;
				}
			});
		}
		List<JoinActivity> joinActivityList = integralService.getJoninList(openid, sellerPublicNumberId, startTime, endtime);
		setAttr("joinActivityList", joinActivityList);
		setAttr("integralWinningInfoList", integralWinningInfoList);
		setAttr("integalExchangeList", integalExchangeList);
		setAttr("openid", openid);
		setAttr("sellerPublicNumberId", sellerPublicNumberId);
		render("/index/my.integral.html");
	}
	
	/**
	 * 我的奖品-填写地址
	 */
	public void fillInAddress(){
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		String productWinningInfoId = getPara("productWinningInfoId");
		log.error("填写收货地址-中奖信息记录ID="+productWinningInfoId);
		ProductWinningInfo productWinningInfo = ProductWinningInfo.dao.findById(productWinningInfoId);
		log.error("*****productWinningInfo***"+productWinningInfo);
		Boolean result = false;
		//分享砍价
		if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("ShareBargain"))){
			ShareBargainWxuser shareBargainWxuser = ShareBargainWxuser.dao.findById(productWinningInfo.getWinningInfoId());
			result = new ShareBargainWxuser().set("ID", productWinningInfo.getWinningInfoId()).set("CONSIGNEE_NAME", addresseeName).set("CONSIGNEE_ADDRESS", address)
			.set("CONSIGNEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(shareBargainWxuser.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//积分活动
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("Integral"))){
			IntegalExchange integalExchange = IntegalExchange.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new IntegalExchange().set("INTEGRAL_EXCHANGE_ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(integalExchange.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//转盘
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("Turntable"))){
			TurnTableWxUserWinning turnTablewWinning = TurnTableWxUserWinning.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new TurnTableWxUserWinning().set("TURNTABLE_WXUSER_WINNING_ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
				.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(turnTablewWinning.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//刮刮卡
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("ScratchCard"))){
			ScratchCardWxUserWinning scratchCardWxUserWinning = ScratchCardWxUserWinning.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new ScratchCardWxUserWinning().set("SCRATCHCARD_WXUSER_WINNING_ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(scratchCardWxUserWinning.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//集赞
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("AccumulateFabulous"))){
			AccumulateWxUserWinning accumulateWxUserWinning = AccumulateWxUserWinning.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new AccumulateWxUserWinning().set("ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(accumulateWxUserWinning.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//砸蛋
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("BreakEgg"))){
			BreakEggWxUserWinning breakEggWxUserWinning = BreakEggWxUserWinning.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new BreakEggWxUserWinning().set("ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(breakEggWxUserWinning.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//一元购
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("OneMoneyShop"))){
			OneMoneyWxUserWinning oneMoneyWxUserWinning = OneMoneyWxUserWinning.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new OneMoneyWxUserWinning().set("ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(oneMoneyWxUserWinning.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//拼图
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("Puzzle"))){
			PuzzleWxUserWinning puzzleWxUserWinning = PuzzleWxUserWinning.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new PuzzleWxUserWinning().set("ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(puzzleWxUserWinning.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}
		//拼团
		else if(productWinningInfo.getActivityNameType().equals(PropKit.use("system.properties").get("GroupPurchase"))){
			PurchaseWxUserWinning purchaseWxUserWinning = PurchaseWxUserWinning.dao.findById(productWinningInfo.getWinningInfoId());
			result =  new PurchaseWxUserWinning().set("ID", productWinningInfo.getWinningInfoId()).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = productWinningInfoService.updatePrazleInfo(purchaseWxUserWinning.getProductWinningInfoId(),addresseeName,address,tel);
			}
		}else{
			//这里是处理积分小游戏的地址
			result = productWinningInfoService.updatePrazleInfo(productWinningInfoId,addresseeName,address,tel);
			IntegalExchange integalExchange = IntegalExchange.dao.findById(productWinningInfoId);
			//修改地址
			if(integalExchange!=null){
				result=productWinningInfoService.updateIntegarlPrazleInfo(productWinningInfoId, addresseeName, address, tel);
			}
		}
		renderJson(result);
	}
	
	/**
	 * 我的奖品-查询详细
	 */
	public void MyPrizeDetailed(){
		String productWinningInfoId = getPara("productWinningInfoId");
		String sql = PropKit.use("database.properties").get("getProWinInfo");
		ProductWinningInfo productWinningInfo = ProductWinningInfo.dao.findFirst(sql,productWinningInfoId);
		setAttr("productWinningInfo", productWinningInfo);
		render("/index/Order-details.html");
	}
}
