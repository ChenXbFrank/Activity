package com.activity.common.controller.moblie.oneMoneyShop;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.oneMoneyShop.OneMoneyGroupWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyPrize;
import com.activity.common.model.oneMoneyShop.OneMoneyShop;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.oneMoney.OneMoneyService;
import com.activity.common.service.oneMoney.returnMoney.RefundUtil;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.probability.ProbabilityUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 一元购PC端配置
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/oneMoneyShop")
public class OneMoneyShopController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(OneMoneyShopController.class);
	OneMoneyService oneMoneyService = OneMoneyService.getService();
	RefundUtil refundUtil=RefundUtil.getRefundUtil();
	IndexService indexService =IndexService.getService();
	WxService wxService = WxService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ProbabilityUtils probabilityUtils = ProbabilityUtils.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IntegralService integralService = IntegralService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	/**
	 * 进入一元购活动
	 */
	public void oneMoney(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				//公众号ID
				String sellerPublicNumberId = getPara("sellerPublicNumber");
				// 活动ID
				String activity = getPara("Activity");
				//所扫二维码
				String qrcode = getPara("qrcode");
				String getOneMoneyShop = PropKit.use("database.properties").get("getOneMoneyShop");
				OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findFirst(getOneMoneyShop,activity);
				//当前活动的参与人数
				String joinPropleNumber = oneMoneyShop.getJoinPropleNumber();
				int parseInt = Integer.parseInt(joinPropleNumber);
				String sq="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
				OneMoneyPrize oneMoneyPrize = OneMoneyPrize.dao.findFirst(sq,activity);
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				String openid = getOpenid(sellerPublicNumber);
				boolean rest = IndexService.getService().queryQrcodeState(qrcode, activity, openid);
				//第一次扫码进入
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
				OneMoneyWxUser oneMoneyWxUser = oneMoneyService.getOneMoneyByOpenidAndQrCode(openid, qrcode);
				String WxUserId ="";
				//1=未保存成功  2=二维码已经使用  3=成功  4参加过了，并且已经支付过了   5参加过了，但是没有支付过！
				int resule = 1;
				if(rest){
					if(oneMoneyWxUser!=null){
						WxUserId = oneMoneyWxUser.getId();
						//并且已经支付了  进入邀请页面  如果没有支付进入homePage页面
						if(oneMoneyWxUser.getPayState().equals("1")){
							resule=4;
						}else if(oneMoneyWxUser.getPayState().equals("0")){
							resule=5;
						}
					}
					else{
						//判断是否存在和保存微信用户
						if(wxuser.getSubscribe().equals("1")){
							//保存微信用户
							wxService.saveWxUser(wxuser,openid,sellerPublicNumber,newId());
						}
						//保存用户参加记录
						WxUserId=newId();
						String nickName = "";
						String headimgurl = "";
						if (wxuser.getSubscribe().equals("1")) {
							nickName = wxuser.getNickname();
							headimgurl = wxuser.getHeadimgurl();
							// 判断名称是否包含表情符号
							Boolean emoji = EmojiUtils.containsEmoji(nickName);
							if (emoji) {
								try {
									nickName = java.net.URLEncoder.encode(nickName, "UTF-8");
								} catch (UnsupportedEncodingException e) {
									e.printStackTrace();
								}
							}
						}
						int saveCommentWxUser = oneMoneyService.saveOneMoneyWxUser(WxUserId, activity, openid, nickName, headimgurl, uitils.newDate(), sellerPublicNumber.getId(), qrcode, oneMoneyShop.getActivityName(), "0");
						// 查询出所属运单
						Map<String, Object> map = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
						//这是开启活动的运单
						ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map.get("activitySellerInfo");
						String mark = PropKit.use("system.properties").get("OneMoneyShop");
						rest = new ActivityCode().set("ID", newId()).set("CODE", qrcode).set("SELLEROUTINFO_RECORDID", activitySellerInfo.getSellerOutInfoRecordId())
								.set("ACTIVITYNAME", oneMoneyShop.getActivityName()).set("SELLERPUBLICID", sellerPublicNumber.getId()).set("SELLERPUBLICNAME", sellerPublicNumber.getPublicNumberName()).set("ACTIVITY_WXID", WxUserId).set("OPENID", openid).set("NICKNAME", nickName).set("HEADIMG", headimgurl).set("MARK", mark).set("SING_NUMBER", "1").set("ACTIVITY_ID", activity).save();
						//给groupWxUser添加一个自己的信息  saveOneMoneyGroupWxUser  当前用户默认是创建者
						String saveSql1 = PropKit.use("database.properties").get("saveOneMoneyGroupWxUser");
						saveCommentWxUser= Db.update(saveSql1,newId(),WxUserId,wxuser.getOpenid(),nickName,
								headimgurl,uitils.newDate(),oneMoneyShop.getActivityName(),"0","1",oneMoneyShop.getGroupMoney(),"0",null,null);
						//修改一下参与人数  updateOneMoneyNumber
						String updateOneMoneyNumber = PropKit.use("database.properties").get("updateOneMoneyNumber");
						saveCommentWxUser=Db.update(updateOneMoneyNumber,parseInt+1+"",oneMoneyShop.getId());
						if(saveCommentWxUser>0){
							rest=true;
						}else{
							rest=false;
							}
						resule = 3;
					}
					setAttr("qrcode", qrcode);
					setAttr("oneMoneyShop", oneMoneyShop);
					setAttr("oneMoneyPrize", oneMoneyPrize);
					setAttr("openid", openid);
					setAttr("wxUserInfo", wxuser);
					setAttr("oneMoneyWxUserId", WxUserId);
					setAttr("oneMoneyWxUser", oneMoneyWxUser);
					setAttr("sellerPublicNumber", sellerPublicNumber);
				}else{
					// 二维码已经使用
					resule = 2;
				}
				if(resule == 1){
					renderError(404);
				}else if(resule == 2){
					render("/index/QRCodeInvalid.html");
				}else if(resule == 3){
					render("/oneMoneyShop/oneMoneyShop-homepage.html");
				}else if(resule == 4){
					//已经参加过了,再次进入
					//直接进入他参加过活动的那个邀请页面去
					String sql="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and CREATER != ? ";
					List<OneMoneyGroupWxUser> groupWxUserList = OneMoneyGroupWxUser.dao.find(sql,WxUserId,"1");
					String sql1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and CREATER = ? ";
					OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sql1,WxUserId,"1");
					//查询group整个组团的人数
					int joinNum= groupWxUserList.size()+1;
					/**
					 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
					 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
					 */
					String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
							+ "/oneMoneyShop/goFriendRedirect?oneMoneyWxUserId=" + WxUserId +"&oneMoneyId=" + oneMoneyShop.getId()
							+ "&sellerNumberId=" + sellerPublicNumberId+ "&qrcode=" + qrcode;
					//查询中奖人
					String sq1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and STATE = ? ";
					OneMoneyGroupWxUser winGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sq1,WxUserId,"1");
					String mywin="";
					OneMoneyWxUserWinning oneMoneyWxUserWinning=null;
					if(winGroupWxUser!=null){
						//中奖人的openID 
						String openId2 = winGroupWxUser.getOpenId();
						//查询出中奖记录
						String s3="select * from TB_ONEMONEY_WXUSER_WINNING where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
						oneMoneyWxUserWinning = OneMoneyWxUserWinning.dao.findFirst(s3,WxUserId,openid);
						if(oneMoneyWxUser.getOpenId().equals(openId2)){
							//自己中奖
							mywin="1";
						}else{
							//别人中奖
							mywin="0";
						}
					}
					int allPay=0;
					boolean result=false;
					//0未支付 1支付
					for (OneMoneyGroupWxUser o : groupWxUserList) {
						if(o.getPayState().equals("1")){
							allPay+=1;
						}
					}
					if(allPay==groupWxUserList.size()){
						result=true;
					}
					setAttr("allPay", result);
					setAttr("url", url);
					//这只是随便写的一个参数
					setAttr("oneMoneyWxUserWinning", oneMoneyWxUserWinning);
					setAttr("mywin", mywin);
					setAttr("joinNum", joinNum);
					setAttr("qrcode", qrcode);
					setAttr("winGroupWxUser", winGroupWxUser);
					setAttr("sellerNumberId", sellerPublicNumberId);
					setAttr("sellerPublicNumber", sellerPublicNumber);
					setAttr("oneMoneyGroupWxUser", oneMoneyGroupWxUser);
					setAttr("groupWxUserList", groupWxUserList);
					setAttr("oneMoneyShop", oneMoneyShop);
					setAttr("oneMoneyPrize", oneMoneyPrize);
					setAttr("oneMoneyWxUser", oneMoneyWxUser);
					// 判断是否属于活动时间内
					Date endDate = DateUitils.strToDateYMD(oneMoneyShop.getEndTime());
					// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
					boolean isEnd = DateUitils.isDateBefore(endDate);
					setAttr("isEnd", isEnd);
					render("/oneMoneyShop/oneMoneyShop-Invitation.html");
				}else if(resule == 5){
					//这里不需要添加信息了 直接进入主页面
					setAttr("qrcode", qrcode);
					setAttr("oneMoneyShop", oneMoneyShop);
					setAttr("oneMoneyPrize", oneMoneyPrize);
					setAttr("openid", openid);
					setAttr("wxUserInfo", wxuser);
					setAttr("oneMoneyWxUserId", WxUserId);
					setAttr("oneMoneyWxUser", oneMoneyWxUser);
					setAttr("sellerPublicNumber", sellerPublicNumber);
					render("/oneMoneyShop/oneMoneyShop-homepage.html");
				}
				return rest;
			}
		});
	}
	
	/**
	 * 立即抢购  立即支付   支付完才能邀请朋友
	 */
	public void payPurchase(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				Map<String, String> map = new HashMap<String, String>();
				String oneMoneyWxUserId = getPara("oneMoneyWxUserId");
				OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findById(oneMoneyWxUserId);
				String payState = oneMoneyWxUser.getPayState();
				//已经支付了
				if(payState.equals("1")){
					map.put("isPay", "true");
					map.put("result", "false");
					renderJson(map);
					return false;
				}else{
					String sellerNumberId = getPara("sellerNumberId");// 公众号
					SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerNumberId);
					ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
					ApiConfigKit.setThreadLocalAppId(spn.getAppId());
					String openid = getPara("openid");// openid
					WxUserInfo wxUserInfo = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
					ApiConfigKit.removeThreadLocalAppId();
					if(wxUserInfo.getSubscribe().equals("1")){
						//保存或修改微信用户
						wxService.saveWxUser(wxUserInfo,openid,spn,newId());
						//修改记录中的微信名称和头像地址  这是修改一元购的
						String sqlOneMoney = PropKit.use("database.properties").get("updateOneMoneyNameByOpenid");
						Db.update(sqlOneMoney,wxUserInfo.getNickname(),wxUserInfo.getHeadimgurl(),openid);
					}
					Random r = new Random(1000);
					//一元购的订单
					String out_trade_no = "money" + (r.nextInt() * 100) + newDateByYMD();
					String mchId = spn.getShopNumber(); //商户号
					// 判断支付的金额，是否等于0元，0元可不用支付
					String appId = spn.getAppId();
					// 判断是否已经支付
					map = WxConfigUitils.getWxConfigUitils().wxPay(openid, appId, spn.getPayKey(), mchId,
							oneMoneyWxUser.getPayMoney(), getRequest().getRemoteAddr(), out_trade_no);
					//在这里给订单号   商户号
					oneMoneyWxUser.set("ID", oneMoneyWxUserId).set("MCHID", mchId).set("PAYOUTNO", out_trade_no).update();
					//这里还要将这条group记录的订单号也要更新一下
					String sql="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
					OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sql,oneMoneyWxUserId,openid);
					boolean update = oneMoneyGroupWxUser.set("ID", oneMoneyGroupWxUser.getId())
					                   .set("MCHID", mchId)
					                   .set("PAYMONEY", oneMoneyWxUser.getPayMoney())
					                   .set("PAYOUTNO", out_trade_no)
					                   .update();
					map.put("result", "true");
					map.put("mchId", mchId);
					map.put("out_trade_no", out_trade_no);
					renderJson(map);
					return update;
				}
			}
		});
		
	}
	
	/**
	 * 支付成功了 跳转到邀请页面            这里应该到回调地址！！！
	 */
	public void inviteFriend(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String oneMoneyWxUserId = getPara("oneMoneyWxUserId");
				String oneMoneyId = getPara("oneMoneyId");
				String sellerNumberId = getPara("sellerNumberId");
				String qrcode = getPara("qrcode");
				String openId = getPara("openId");
				String getOneMoneyShop = PropKit.use("database.properties").get("getOneMoneyShop");
				OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findFirst(getOneMoneyShop,oneMoneyId);
				String sq="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
				OneMoneyPrize oneMoneyPrize = OneMoneyPrize.dao.findFirst(sq,oneMoneyId);
				OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findById(oneMoneyWxUserId);
				boolean update = new OneMoneyWxUser().set("ID", oneMoneyWxUserId)
						                             .set("PAYMONEY", oneMoneyWxUser.getPayMoney())
						                             .set("PAYSTATE", "1")
						                             .update();
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openId, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//将group里面这条记录的支付状态改为1 已支付
				String sq11="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and OPENID = ?";
				OneMoneyGroupWxUser groupWxUser = OneMoneyGroupWxUser.dao.findFirst(sq11,oneMoneyWxUserId,openId);
				groupWxUser.set("ID", groupWxUser.getId()).set("HEADIMGURL", wxuser.getHeadimgurl()).set("NICKNAME", wxuser.getNickname()).set("PAYSTATE", "1").update();
				String sql="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and CREATER != ? ";
				List<OneMoneyGroupWxUser> groupWxUserList = OneMoneyGroupWxUser.dao.find(sql,oneMoneyWxUserId,"1");
				String sql1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and CREATER = ? ";
				OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sql1,oneMoneyWxUserId,"1");
				//查询group整个组团的人数
				int joinNum= groupWxUserList.size()+1;
				/**
				 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
				 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
				 */
				String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
						+ "/oneMoneyShop/goFriendRedirect?oneMoneyWxUserId=" + oneMoneyWxUserId +"&oneMoneyId=" + oneMoneyId
						+ "&sellerNumberId=" + sellerNumberId+ "&qrcode=" + qrcode;
				//查询中奖人
				String sq1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and STATE = ? ";
				OneMoneyGroupWxUser winGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sq1,oneMoneyWxUserId,"1");
				String mywin="";
				OneMoneyWxUserWinning oneMoneyWxUserWinning=null;
				if(winGroupWxUser!=null){
					//中奖人的openID 
					String openId2 = winGroupWxUser.getOpenId();
					//查询出中奖记录
					String s3="select * from TB_ONEMONEY_WXUSER_WINNING where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
					oneMoneyWxUserWinning = OneMoneyWxUserWinning.dao.findFirst(s3,oneMoneyWxUserId,openId);
					if(oneMoneyWxUser.getOpenId().equals(openId2)){
						//自己中奖
						mywin="1";
					}else{
						//别人中奖
						mywin="0";
					}
				}
				int allPay=0;
				boolean result=false;
				//0未支付 1支付
				for (OneMoneyGroupWxUser o : groupWxUserList) {
					if(o.getPayState().equals("1")){
						allPay+=1;
					}
				}
				if(allPay==groupWxUserList.size()){
					result=true;
				}
				setAttr("allPay", result);
				setAttr("url", url);
				setAttr("oneMoneyWxUserWinning", oneMoneyWxUserWinning);
				//这只是随便写的一个参数
				setAttr("mywin", mywin);
				setAttr("joinNum", joinNum);
				setAttr("qrcode", qrcode);
				setAttr("winGroupWxUser", winGroupWxUser);
				setAttr("sellerNumberId", sellerNumberId);
				setAttr("sellerPublicNumber", sellerPublicNumber);
				setAttr("oneMoneyGroupWxUser", oneMoneyGroupWxUser);
				setAttr("groupWxUserList", groupWxUserList);
				setAttr("oneMoneyShop", oneMoneyShop);
				setAttr("oneMoneyPrize", oneMoneyPrize);
				setAttr("oneMoneyWxUser", oneMoneyWxUser);
				// 判断是否属于活动时间内
				Date endDate = DateUitils.strToDateYMD(oneMoneyShop.getEndTime());
				// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
				boolean isEnd = DateUitils.isDateBefore(endDate);
				setAttr("isEnd", isEnd);
				render("/oneMoneyShop/oneMoneyShop-Invitation.html");
				return update;
			}
		});
	}
	
	/**
	 * 分享砍价微信配置
	 */
	public void WxShareConfig() {
		String locationUrl = getPara("locationUrl");
		Map<String, String> wxConfigApi = WxConfigUitils.getWxConfigUitils().WxConfigApi(locationUrl);
		renderJson(wxConfigApi);
	}
	
	/**
	 * 重定向
	 */
	public void goFriendRedirect(){
		String sellerPublicNumberId = getPara("sellerNumberId");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
		+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
		+ JFinal.me().getContextPath() + "%2foneMoneyShop%2ffriendRedirect%3foneMoneyWxUserId%3d" + getPara("oneMoneyWxUserId")
		+ "%26oneMoneyId%3d" + getPara("oneMoneyId") + "%26appid%3d" + spn.getAppId() + "%26qrcode%3d" + getPara("qrcode")
		+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect";
		redirect(url);
	}
	
	
	/**
	 * 重定向 1.下一步需要获取openid,此处从新进入页面，需要授权
	 */
	public void friendRedirect() {
		String oneMoneyWxUserId = getPara("oneMoneyWxUserId");
		String oneMoneyId = getPara("oneMoneyId");
		String getOneMoneyShop = PropKit.use("database.properties").get("getOneMoneyShop");
		OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findFirst(getOneMoneyShop,oneMoneyId);
		OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findById(oneMoneyWxUserId);
		String belongPublicNumberId = oneMoneyWxUser.getBelongPublicNumberId();
		String sq="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
		OneMoneyPrize oneMoneyPrize = OneMoneyPrize.dao.findFirst(sq,oneMoneyId);
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(belongPublicNumberId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
		String openid = getOpenid(spn);
		String qrcode = getPara("qrcode");
		String sql="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and CREATER != ? ";
		List<OneMoneyGroupWxUser> groupWxUserList = OneMoneyGroupWxUser.dao.find(sql,oneMoneyWxUserId,"1");
		String sql1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and CREATER = ? ";
		OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sql1,oneMoneyWxUserId,"1");
		//查询group整个组团的人数
		int joinNum= groupWxUserList.size()+1;
		//查询中奖人
		String sq1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and STATE = ? ";
		OneMoneyGroupWxUser winGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sq1,oneMoneyWxUserId,"1");
		//这是自己进自己分享出去的页面
		if(oneMoneyWxUser.getOpenId().equals(openid)){
			String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
					+ "/oneMoneyShop/goFriendRedirect?oneMoneyWxUserId=" + oneMoneyWxUserId +"&oneMoneyId=" + oneMoneyId
					+ "&sellerNumberId=" + belongPublicNumberId+ "&qrcode=" + qrcode;
			String mywin="";
			OneMoneyWxUserWinning oneMoneyWxUserWinning=null;
			if(winGroupWxUser!=null){
				//中奖人的openID 
				String openId2 = winGroupWxUser.getOpenId();
				//查询出中奖记录
				String s3="select * from TB_ONEMONEY_WXUSER_WINNING where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
				oneMoneyWxUserWinning = OneMoneyWxUserWinning.dao.findFirst(s3,oneMoneyWxUserId,openid);
				if(oneMoneyWxUser.getOpenId().equals(openId2)){
					//自己中奖
					mywin="1";
				}else{
					//别人中奖
					mywin="0";
				}
			}
			int allPay=0;
			boolean result=false;
			//0未支付 1支付
			for (OneMoneyGroupWxUser o : groupWxUserList) {
				if(o.getPayState().equals("1")){
					allPay+=1;
				}
			}
			if(allPay==groupWxUserList.size()){
				result=true;
			}
			setAttr("allPay", result);
			setAttr("mywin", mywin);
			setAttr("oneMoneyWxUserWinning", oneMoneyWxUserWinning);
			setAttr("url", url);
			//	如果是自己点击进来不需要操作
			setAttr("joinNum", joinNum);
			setAttr("winGroupWxUser", winGroupWxUser);
			setAttr("qrcode", qrcode);
			setAttr("sellerPublicNumber", spn);
			setAttr("sellerNumberId", belongPublicNumberId);
			setAttr("sellerPublicNumber", spn);
			setAttr("oneMoneyGroupWxUser", oneMoneyGroupWxUser);
			setAttr("groupWxUserList", groupWxUserList);
			setAttr("oneMoneyShop", oneMoneyShop);
			setAttr("oneMoneyPrize", oneMoneyPrize);
			setAttr("oneMoneyWxUser", oneMoneyWxUser);
			// 判断是否属于活动时间内
			Date endDate = DateUitils.strToDateYMD(oneMoneyShop.getEndTime());
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean isEnd = DateUitils.isDateBefore(endDate);
			setAttr("isEnd", isEnd);
			render("/oneMoneyShop/oneMoneyShop-Invitation.html");
		}
		//这是别人进来帮忙一元购的页面
		else{
			//别人进来
			//根据openID和ONEMONEY_WXUSER_ID判断该用户是否已经加入到了该一元购活动
			//0 没有满 1满了
			String fulled="0";
			//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
			String joined="0";
			//支付状态 0未支付 1支付 2支付中
			String payState="0";
			String s="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
			OneMoneyGroupWxUser groupWxUser = OneMoneyGroupWxUser.dao.findFirst(s,oneMoneyWxUserId,openid);
			String s5="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ?";
			List<OneMoneyGroupWxUser> list = OneMoneyGroupWxUser.dao.find(s5,oneMoneyWxUserId);
			//开奖人数
			String openPrizeNumber = oneMoneyShop.getOpenPrizeNumber();
			int parseInt = Integer.parseInt(openPrizeNumber);
			if(list.size()<parseInt){
				//没有满
				fulled="0";
				if(groupWxUser==null){
					//0 代表 该用户还没有参加该活动的组团
					joined="0";
					//没有参加肯定没有支付了
					payState="0";
				}else{
					//1 代表已经参加了
					joined="1";
					//判断支付没有  0未支付 1支付
					String state = groupWxUser.getPayState();
					if(state.equals("0")||state.equals("2")){
						payState="0";
					}else{
						payState="1";
					}
				}
			}else{
				//满了
				fulled="1";
				if(groupWxUser==null){
					//0 代表 该用户还没有参加该活动的组团
					joined="0";
					payState="0";
				}else{
					//1 代表已经参加了
					joined="1";
					//判断支付没有  0未支付 1支付
					String state = groupWxUser.getPayState();
					if(state.equals("0")||state.equals("2")){
						payState="0";
					}else{
						payState="1";
					}
				}
			}
			// 0未支付 1支付
			setAttr("payState", payState);
			//0 没有满 1满了
			setAttr("fulled", fulled);
			//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
			setAttr("joined", joined);
			setAttr("openid", openid);
			setAttr("qrcode", qrcode);
			setAttr("sellerNumberId", belongPublicNumberId);
			setAttr("sellerPublicNumber", spn);
			setAttr("oneMoneyGroupWxUser", oneMoneyGroupWxUser);
			setAttr("oneMoneyWxUser", oneMoneyWxUser);
			setAttr("oneMoneyShop", oneMoneyShop);
			setAttr("oneMoneyPrize", oneMoneyPrize);
			// 判断是否属于活动时间内
			Date endDate = DateUitils.strToDateYMD(oneMoneyShop.getEndTime());
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean isEnd = DateUitils.isDateBefore(endDate);
			setAttr("isEnd", isEnd);
			Random r = new Random(1000);
			//一元购的订单
			String out_trade_no = "money" + (r.nextInt() * 100) + newDateByYMD();
			setAttr("out_trade_no", out_trade_no);
			render("/oneMoneyShop/oneMoneyShop-group.html");
		}
	}
	
	/**
	 * 立即加入队伍
	 */
	public void joinGroupPay(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				boolean rest=false;
				Map<String, String> map = new HashMap<String, String>();
				String oneMoneyWxUserId = getPara("oneMoneyWxUserId");
				OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findById(oneMoneyWxUserId);
				String belongPublicNumberId = oneMoneyWxUser.getBelongPublicNumberId();
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getPara("openid");// openid
				// 判断支付的金额，是否等于0元，0元可不用支付
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				String nickName="";
				if(wxuser.getSubscribe().equals("1")){
					nickName = wxuser.getNickname();
					//判断名称是否包含表情符号
					Boolean emoji =  EmojiUtils.containsEmoji(nickName);
					if(emoji){
						try {
							nickName=java.net.URLEncoder.encode(nickName, "UTF-8");
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
					//支付前判断该团满员没有满员
					String s5="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ?";
					List<OneMoneyGroupWxUser> list = OneMoneyGroupWxUser.dao.find(s5,oneMoneyWxUserId);
					String getOneMoneyShop = PropKit.use("database.properties").get("getOneMoneyShop");
					OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findFirst(getOneMoneyShop,oneMoneyWxUser.getOneMoneyId());
					//这里获取参与的人数   加团进来就数量+1
					 String joinPropleNumber = oneMoneyShop.getJoinPropleNumber();
					 int parseInt2 = Integer.parseInt(joinPropleNumber);
					//开奖人数
					String openPrizeNumber = oneMoneyShop.getOpenPrizeNumber();
					int parseInt = Integer.parseInt(openPrizeNumber);
					//没有满员
					if(list.size()<parseInt){
						String sellerNumberId = getPara("sellerNumberId");// 公众号
						SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerNumberId);
						String out_trade_no = getPara("out_trade_no");
						//去查询该订单号是否已经被同一时间段支付过了
						String mchId = spn.getShopNumber(); //商户号
						//先判断该用户是否存入在这个团里面
						String s="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
						OneMoneyGroupWxUser groupWxUser = OneMoneyGroupWxUser.dao.findFirst(s,oneMoneyWxUserId,openid);
						if(groupWxUser==null){
							String saveSql1 = PropKit.use("database.properties").get("saveOneMoneyGroupWxUser");
							//这里先将该用户存入到加团  订单号也存入该支付记录中  支付状态改为支付中
							int i = Db.update(saveSql1,newId(),oneMoneyWxUserId,openid,nickName,
									wxuser.getHeadimgurl(),uitils.newDate(),oneMoneyShop.getActivityName(),"0","0",oneMoneyShop.getGroupMoney(),"2",mchId,out_trade_no);
							log.error("---微信支付记录订单---"+out_trade_no+"---openid---"+openid+"---修改状态---"+i);
							//修改一下参与人数  updateOneMoneyNumber
							String updateOneMoneyNumber = PropKit.use("database.properties").get("updateOneMoneyNumber");
							i = Db.update(updateOneMoneyNumber,parseInt2+1+"",oneMoneyShop.getId());
							if(i>0){
								rest=true;
							}else{
								rest=false;
							}
							String appId = spn.getAppId();
							// 判断是否已经支付
							map = WxConfigUitils.getWxConfigUitils().wxPay(openid, appId, spn.getPayKey(), mchId,
									oneMoneyWxUser.getPayMoney(), getRequest().getRemoteAddr(), out_trade_no);
							map.put("result", "true");
						}else{
							String appId = spn.getAppId();
							// 判断是否已经支付
							map = WxConfigUitils.getWxConfigUitils().wxPay(openid, appId, spn.getPayKey(), mchId,
									oneMoneyWxUser.getPayMoney(), getRequest().getRemoteAddr(), groupWxUser.getPayOutNo());
							map.put("result", "true");
//							groupWxUser.set("ID", groupWxUser.getId()).set("MCHID", mchId).set("PAYOUTNO", out_trade_no).update();
//							log.error("---微信支付记录订单---"+out_trade_no+"---openid---"+openid);
						}
						
					}
					//已经满员  判断该进来的openID的用户 在团里没有
					else{
						String openId = getPara("openid");
						String s6="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
						//这是判断该用户是否在这个团里
						OneMoneyGroupWxUser groupUser = OneMoneyGroupWxUser.dao.findFirst(s6,oneMoneyWxUserId,openId);
						//在这个团里
						if(groupUser!=null){
							String sellerNumberId = getPara("sellerNumberId");// 公众号
							SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerNumberId);
							//去查询该订单号是否已经被同一时间段支付过了
							String mchId = spn.getShopNumber(); //商户号
							// 判断支付的金额，是否等于0元，0元可不用支付
							String appId = spn.getAppId();
							// 判断是否已经支付
							map = WxConfigUitils.getWxConfigUitils().wxPay(openid, appId, spn.getPayKey(), mchId,
									oneMoneyWxUser.getPayMoney(), getRequest().getRemoteAddr(), groupUser.getPayOutNo());
							map.put("result", "true");
						}else{
							map.put("result", "false");
						}
					}
				}else{
					map.put("result", "nofollow");
				}
				renderJson(map);
				return rest;
			}
		});
	}
	
	/**
	 * 加入成功之后  支付group中修改该用户信息  支付状态
	 */
	public void successJoin(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				boolean result=false;
				String oneMoneyWxUserId = getPara("oneMoneyWxUserId");
				String sellerNumberId = getPara("sellerNumberId");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerNumberId);
				String qrcode = getPara("qrcode");
				OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findById(oneMoneyWxUserId);
				String getOneMoneyShop = PropKit.use("database.properties").get("getOneMoneyShop");
				OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findFirst(getOneMoneyShop,oneMoneyWxUser.getOneMoneyId());
				String openid = getPara("openid");
				//判断当前人是否已经加入过该活动了
				String s2="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
				OneMoneyGroupWxUser moneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(s2,oneMoneyWxUserId,openid);
				//将该moneyGroupWxUser的支付状态修改为已支付
				result = moneyGroupWxUser.set("ID", moneyGroupWxUser.getId()).set("PAYSTATE", "1").update();
				String sql1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and CREATER = ? ";
				OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sql1,oneMoneyWxUserId,"1");
				String sq="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
				OneMoneyPrize oneMoneyPrize = OneMoneyPrize.dao.findFirst(sq,oneMoneyWxUser.getOneMoneyId());
				//添加前  判断该团是否满员了  并且都支付了？
				String s5="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and PAYSTATE = ? ";
				//开奖人数
				String openPrizeNumber = oneMoneyShop.getOpenPrizeNumber();
				int parseInt = Integer.parseInt(openPrizeNumber);
				//这里是查询的该团支付的集合
				List<OneMoneyGroupWxUser> list1 = OneMoneyGroupWxUser.dao.find(s5,oneMoneyWxUserId,"1");
				//根据openID和ONEMONEY_WXUSER_ID判断该用户是否已经加入到了该一元购活动
				//0 没有满 1满了
				String fulled="0";
				//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
				String joined="0";
				//支付状态 0未支付 1支付 2支付中
				String payState="0";
				String s="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? and OPENID = ? ";
				OneMoneyGroupWxUser groupWxUser = OneMoneyGroupWxUser.dao.findFirst(s,oneMoneyWxUserId,openid);
				String s51="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ?";
				List<OneMoneyGroupWxUser> list = OneMoneyGroupWxUser.dao.find(s51,oneMoneyWxUserId);
				if(list.size()<parseInt){
					//没有满
					fulled="0";
					if(groupWxUser==null){
						//0 代表 该用户还没有参加该活动的组团
						joined="0";
						//没有参加肯定没有支付了
						payState="0";
					}else{
						//1 代表已经参加了
						joined="1";
						//判断支付没有  0未支付 1支付
						String state = groupWxUser.getPayState();
						if(state.equals("0")||state.equals("2")){
							payState="0";
						}else{
							payState="1";
						}
					}
				}else{
					//满了
					fulled="1";
					if(groupWxUser==null){
						//0 代表 该用户还没有参加该活动的组团
						joined="0";
						payState="0";
					}else{
						//1 代表已经参加了
						joined="1";
						//判断支付没有  0未支付 1支付
						String state = groupWxUser.getPayState();
						if(state.equals("0")||state.equals("2")){
							payState="0";
						}else{
							payState="1";
						}
					}
				}
				//人数满了  则开奖
				if(list1.size()==parseInt){
					timeToOpenPrize(oneMoneyWxUserId);
					result=true;
				}
				// 0未支付 1支付
				setAttr("payState", payState);
				//0 没有满 1满了
				setAttr("fulled", fulled);
				//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
				setAttr("joined", joined);
				setAttr("openid", openid);
				setAttr("qrcode", qrcode);
				setAttr("sellerNumberId", sellerNumberId);
				setAttr("sellerPublicNumber", sellerPublicNumber);
				setAttr("oneMoneyGroupWxUser", oneMoneyGroupWxUser);
				setAttr("oneMoneyWxUser", oneMoneyWxUser);
				setAttr("oneMoneyShop", oneMoneyShop);
				setAttr("oneMoneyPrize", oneMoneyPrize);
				// 判断是否属于活动时间内
				Date endDate = DateUitils.strToDateYMD(oneMoneyShop.getEndTime());
				// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
				boolean isEnd = DateUitils.isDateBefore(endDate);
				Random r = new Random(1000);
				//一元购的订单
				String out_trade_no = "money" + (r.nextInt() * 100) + newDateByYMD();
				setAttr("out_trade_no", out_trade_no);
				setAttr("isEnd", isEnd);
				return result;
			}
		});
		render("/oneMoneyShop/oneMoneyShop-group.html");
	}
	
	/**
	 * 一元购 定时去循环判断该组团的人数是否达到了开奖的人数
	 */
	public void timeToOpenPrize(String oneMoneyWxUserId){
		//TB_ONE_MONEY_WXUSER  一元购微信参与用户记录  这全是参与一元购活动的创建者  0是未处理
		String sql="select * from TB_ONE_MONEY_WXUSER where HANDLE = ? and ID = ? ";
		//所有的创建者 在时间范围内
		OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findFirst(sql,"0",oneMoneyWxUserId);
		if(oneMoneyWxUser!=null){
			String oneMoneyId = oneMoneyWxUser.getOneMoneyId();
			String getOneMoneyShop = PropKit.use("database.properties").get("getOneMoneyShop");
			OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findFirst(getOneMoneyShop,oneMoneyId);
			String s1="select * from TB_ONE_MONEY_PRIZE where ONE_MONEY_ID = ? ";
			OneMoneyPrize oneMoneyPrize = OneMoneyPrize.dao.findFirst(s1,oneMoneyId);
			String openPrizeNumber = oneMoneyShop.getOpenPrizeNumber();
			//这是该活动的开奖人数
			int openPrizeNumberInt = Integer.parseInt(openPrizeNumber);
			//TB_ONE_MONEY_GROUP_WXUSER   一元购微信参与用户记录 组队的微信用户 在这里查看判断参与人数
			String getOneMoneyGroupWxUser = PropKit.use("database.properties").get("getOneMoneyGroupWxUser");
			List<OneMoneyGroupWxUser> oneMoneyGroupWxUserList = OneMoneyGroupWxUser.dao.find(getOneMoneyGroupWxUser,oneMoneyWxUserId);
			//如果人数达到了开奖的人数 则开奖了
			if(oneMoneyGroupWxUserList.size()==openPrizeNumberInt){
				boolean result=true;
				//这里先判断该一元购是否是满员了 并且都支付了
				for (OneMoneyGroupWxUser oneMoneyGroupWxUser : oneMoneyGroupWxUserList) {
					if(oneMoneyGroupWxUser.getPayState().equals("0")||oneMoneyGroupWxUser.getPayState().equals("2")){
						result=false;
						break;
					}
				}
				if(result){
					//公众号id
					String belongPublicNumberId = oneMoneyWxUser.getBelongPublicNumberId();
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
					ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
					
					int prizePoint = prizePoint(openPrizeNumberInt);
					//中奖用户
					OneMoneyGroupWxUser oneMoneyGroupWxUser = oneMoneyGroupWxUserList.get(prizePoint);
					String winningPropleNumber = oneMoneyShop.getWinningPropleNumber();
					int parseInt = Integer.parseInt(winningPropleNumber)+1;
					//一个一元购只会中一个奖  这里将中奖人数+1
					oneMoneyShop.set("ID", oneMoneyId).set("WINNING_PROPLE_NUMBER", parseInt+"").update();
					//将该用户的中奖状态修改  状态0未中奖 1中奖
					boolean update = oneMoneyGroupWxUser.set("ID", oneMoneyGroupWxUser.getId()).set("STATE", "1").update();
					//将活动发起者的中奖状态修改一下
					if(oneMoneyGroupWxUser.getCreater().equals("1")){
						oneMoneyWxUser.set("ID", oneMoneyWxUserId).set("STATE", "1").update();
					}
					//这是二维码 瓶码
					String scanCode = oneMoneyWxUser.getScanCode();
					//根据扫描的二维码查找出该二维码的参与情况
					String codeSql="select * from ACTIVITY_CODE where CODE =?";
					ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
					if(update){
						//保存中奖实物的记录
						String newId = newId();//product产品id
						String winNewId = newId(); //中奖记录的id
						ProductWinningInfo pwi=new ProductWinningInfo();
						boolean save = pwi.set("ID", newId)
						   .set("BELONG_ACTIVITY_ID", oneMoneyId)
						   .set("ACTIVITY_NAME_TYPE", PropKit.use("system.properties").get("OneMoneyShop"))
						   .set("ACTIVITY_NAME", oneMoneyShop.getActivityName())
						   .set("ACTIVITY_PRIZE_ID", oneMoneyPrize.getId())
						   .set("PRODUCT_NAME", oneMoneyPrize.getPrizeName())
						   .set("PRODUCT_IMG", oneMoneyPrize.getPrizeImg())
						   .set("CREATE_TIME", uitils.newDate())
						   .set("OPENID", oneMoneyGroupWxUser.getOpenId())
						   .set("ACTIVITY_WXUSER_ID", oneMoneyWxUser.getId())
						   .set("BELONG_PUBLICNUMBER_ID", oneMoneyWxUser.getBelongPublicNumberId())
						   .set("STATE", "2")
						   .set("WINNING_INFO_ID", winNewId)
						   .set("PAY_MONEY",oneMoneyShop.getGroupMoney())
						   .set("PRICE", oneMoneyShop.getGroupMoney())
						   .set("LOW_PRICE",oneMoneyShop.getGroupMoney())
						   .save();
						if(save){
							OneMoneyWxUserWinning omw=new OneMoneyWxUserWinning();
							save = omw.set("ID", winNewId)
							   .set("ONEMONEY_WXUSER_ID", oneMoneyWxUser.getId())
							   .set("BELONG_WINNING_PRIZE_ID", oneMoneyPrize.getId())
							   .set("PRIZE_PROJECT", oneMoneyPrize.getPrizeName())
							   .set("PRIZE_PROJECT_IMG", oneMoneyPrize.getPrizeImg())
							   .set("CREATE_TIME", uitils.newDate())
							   .set("OPENID", oneMoneyGroupWxUser.getOpenId())
							   .set("STATE", "2")
							   .set("PRODUCT_WINNING_INFO_ID", newId)
							   .save();
							if(activityCode!=null){
							//这里更新了该码的中奖情况
							activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", oneMoneyWxUser.getId()).set("WINTYPE", "1").set("WININGID", winNewId).update();
							}
						}
						for (int i = 0; i < oneMoneyGroupWxUserList.size(); i++) {
							//中奖者
							if(i==prizePoint){
								String activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + oneMoneyGroupWxUserList.get(i).getOpenId()+ "%26selectedVal%3d" + "";
								ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
								Tools.sendWinNotice(oneMoneyGroupWxUserList.get(i).getOpenId(), sellerPublicNumber, activityUrl, oneMoneyShop.getActivityName(), oneMoneyPrize.getPrizeName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
								ApiConfigKit.removeThreadLocalAppId();
							}
							//这是没有中奖的用户
							else{
								//发送没有中奖通知  
								String activityUrl="%2foneMoneyShop%2flosePrize%3foneMoneyGroupWxUserId%3d" + oneMoneyGroupWxUser.getId();
								ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
								Tools.sendWinNotice(oneMoneyGroupWxUserList.get(i).getOpenId(), sellerPublicNumber, activityUrl, oneMoneyShop.getActivityName(), "未中奖", getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
								ApiConfigKit.removeThreadLocalAppId();
								String payOutNo = oneMoneyGroupWxUserList.get(i).getPayOutNo();
								String payMoney = oneMoneyGroupWxUserList.get(i).getPayMoney();
								// 支付金额
								BigDecimal re1 = new BigDecimal(payMoney);
								BigDecimal re2 = new BigDecimal(Float.toString(100.00f));
								Float total_fee = re1.multiply(re2).floatValue();
								// 没有中奖的 还需要退款
								String restle = refundUtil.wechatRefund(sellerPublicNumber,payOutNo, total_fee);
								log.error("---退款执行返回---"+restle+"---订单编码---"+payOutNo+"---信息---"+oneMoneyGroupWxUserList.get(i).getOpenId());
							}
						}
					}
				}
				//处理完之后将该条记录的状态修改为已经处理了
				oneMoneyWxUser.set("ID", oneMoneyWxUser.getId()).set("HANDLE", "1").update();
			}
		}
	}
	
	/**
	 * 这里处理时间过期了  执行退款
	 */
	public void returnMoney(){
		//TB_ONE_MONEY_WXUSER  一元购微信参与用户记录  这全是参与一元购活动的创建者  0是未处理
		//所有的创建者 在时间范围内    首先判断该活动是否结束了
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowTime = sdf.format(date);
		//判断当前时间是不是大于一元购结束时间并且处理状态为未处理
		String sql="select * from TB_ONE_MONEY_SHOP where HANDLE = '0' and ENDTIME < '"+nowTime+"' ";
		//这就是没有处理的 并且活动时间到了 
		List<OneMoneyShop> oneMoneyList = OneMoneyShop.dao.find(sql);
		//这是查询小活动的并且没有处理的小活动
		String s="select * from TB_ONE_MONEY_WXUSER where ONE_MONEY_ID = ? and HANDLE = '0'";
		//这是查询团购的sql
		String sql1="select * from TB_ONE_MONEY_GROUP_WXUSER where ONEMONEY_WXUSER_ID = ? ";
		boolean result=false;
		if(oneMoneyList.size()!=0){
			//这里处理大活动
			for (OneMoneyShop oneMoneyShop : oneMoneyList) {
				//这是查询小活动的并且没有处理的小活动
				List<OneMoneyWxUser> list = OneMoneyWxUser.dao.find(s,oneMoneyShop.getId());
				String openPrizeNumber = oneMoneyShop.getOpenPrizeNumber();
				//这是开奖人数
				int parseInt = Integer.parseInt(openPrizeNumber);
				//这里开始处理微信参与的活动
				for (OneMoneyWxUser oneMoneyWxUser : list) {
					//这里判断一下  该用户发起的团是不是没有满员  没有满员则执行退款
					//这是查询大活动的开奖人数
					//公众号id
					String belongPublicNumberId = oneMoneyWxUser.getBelongPublicNumberId();
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
					//这里是查询参加该微信活动的用户数 （参团的所有人员）
					List<OneMoneyGroupWxUser> list1 = OneMoneyGroupWxUser.dao.find(sql1,oneMoneyWxUser.getId());
					//判断这个团里是不是满了 里面有没有支付的
					if(list1.size()==parseInt){
						for (OneMoneyGroupWxUser oneMoneyGroupWxUser : list1) {
							if(oneMoneyGroupWxUser.getPayState().equals("0")||oneMoneyGroupWxUser.getPayState().equals("2")){
								//这个true代表  判断这个团里是不是满了 里面有没有支付的   这也需要退款的
								result = true;
								break;
							}
						}
					}
					//参加的人数没有满足开奖人数   没有满团，则给所有人退款    //result：这里是给满了团，但是没有全部支付的，就是没有成功的人退款
					if(list1.size()<parseInt||result){
						for (OneMoneyGroupWxUser oneMoneyGroupWxUser : list1) {
							//执行退款
							String payOutNo = oneMoneyGroupWxUser.getPayOutNo();
							String payMoney = oneMoneyGroupWxUser.getPayMoney();
							if(!StringUtils.isEmpty(payOutNo)&&!StringUtils.isEmpty(payMoney)){
								// 支付金额
								BigDecimal re1 = new BigDecimal(payMoney);
								BigDecimal re2 = new BigDecimal(Float.toString(100.00f));
								Float total_fee = re1.multiply(re2).floatValue();
								// 没有中奖的 还需要退款    这里不知道为什么就是不执行更新状态
								refundUtil.wechatRefund(sellerPublicNumber,payOutNo, total_fee);
							}
						}
					}
					//将该微信活动的状态修改为已经处理过了
					oneMoneyWxUser.set("ID", oneMoneyWxUser.getId()).set("HANDLE", "1").update();
				}
				//将该大活动的状态修改为已经处理过了
				oneMoneyShop.set("ID", oneMoneyShop.getId()).set("HANDLE", "1").update();
			}
		}
	}
	
	/**
	 * 开奖人数里面取一个中奖的用户  
	 */
	public int prizePoint(int number){
		Random random = new Random();
		return random.nextInt(number);
	}
	
	/**
	 * 填写地址
	 */
	public void address(){
		String oneMoneyWinningId = getPara("oneMoneyWinningId");
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		OneMoneyWxUserWinning oneMoneyWxUserWinning = OneMoneyWxUserWinning.dao.findById(oneMoneyWinningId);
		Boolean result =  new OneMoneyWxUserWinning().set("ID", oneMoneyWinningId).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
			.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
		if(result){
			result = new ProductWinningInfo().set("ID", oneMoneyWxUserWinning.getProductWinningInfoId()).set("STATE", "3").set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).update();
		}
		renderJson(result);
	}
	
	/**
	 * 点击进入 中奖失败页面
	 */
	public void losePrize(){
		String oneMoneyGroupWxUserId = getPara("oneMoneyGroupWxUserId");
		OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findById(oneMoneyGroupWxUserId);
		setAttr("oneMoneyGroupWxUser", oneMoneyGroupWxUser);
		render("/oneMoneyShop/oneMoneyShop-lose.html");
	}
}
