package com.activity.common.controller.moblie.groupPurchase;

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
import com.activity.common.model.groupPurchase.GroupPurchase;
import com.activity.common.model.groupPurchase.GroupPurchaseGroupWxUser;
import com.activity.common.model.groupPurchase.GroupPurchasePrize;
import com.activity.common.model.groupPurchase.GroupPurchaseWxUser;
import com.activity.common.model.groupPurchase.PurchaseWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.groupPurchase.GroupPurchaseService;
import com.activity.common.service.integral.IntegralService;
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
 * 拼团
 * @author ChenXb
 *
 * 2017年12月19日
 */
@ControllerPath(controllerKey = "/groupPurchase")
public class GroupPurchaseController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(GroupPurchaseController.class);
	GroupPurchaseService groupPurchaseService = GroupPurchaseService.getService();
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
	 * 进入拼团活动
	 */
	public void groupPurchase(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				//公众号ID
				String sellerPublicNumberId = getPara("sellerPublicNumber");
				// 活动ID
				String activity = getPara("Activity");
				//所扫二维码
				String qrcode = getPara("qrcode");
				String getGroupPurchase = PropKit.use("database.properties").get("getGroupPurchase");
				GroupPurchase groupPurchase = GroupPurchase.dao.findFirst(getGroupPurchase,activity);
				//参与人数
				String joinPropleNumber = groupPurchase.getJoinPropleNumber();
				int parseInt2 = Integer.parseInt(joinPropleNumber);
				String sq="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
				GroupPurchasePrize groupPurchasePrize = GroupPurchasePrize.dao.findFirst(sq,activity);
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getOpenid(sellerPublicNumber);
				boolean rest = IndexService.getService().queryQrcodeState(qrcode, activity, openid);
				//第一次扫码进入
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
				GroupPurchaseWxUser groupPurchaseWxUser = groupPurchaseService.getGroupPurchaseByOpenidAndQrCode(openid, qrcode);
				String WxUserId ="";
				//1=未保存成功  2=二维码已经使用  3=成功  4参加过了，并且已经支付过了   5参加过了，但是没有支付过！
				int resule = 1;
				if(rest){
					resule = 3;
					if(groupPurchaseWxUser!=null){
						WxUserId = groupPurchaseWxUser.getId();
						//并且已经支付了  进入邀请页面  如果没有支付进入homePage页面
						if(groupPurchaseWxUser!=null&&groupPurchaseWxUser.getPayState().equals("1")){
							resule=4;
						}else if(groupPurchaseWxUser!=null&&groupPurchaseWxUser.getPayState().equals("0")){
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
						int savePurchaseWxUser = groupPurchaseService.saveGroupPurchaseWxUser(WxUserId, activity, openid, nickName, headimgurl, uitils.newDate(), sellerPublicNumber.getId(), qrcode, groupPurchase.getActivityName(), "0",groupPurchase.getGroupPrice());
						// 查询出所属运单  保存当前所扫二维码已被使用的记录   没有活动 新建一个二维码失效记录
						Map<String, Object> map = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
						//这是开启活动的运单
						ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map.get("activitySellerInfo");
						String mark = PropKit.use("system.properties").get("GroupPurchase");
						rest = new ActivityCode().set("ID", newId()).set("CODE", qrcode).set("SELLEROUTINFO_RECORDID", activitySellerInfo.getSellerOutInfoRecordId())
								.set("ACTIVITYNAME", groupPurchase.getActivityName()).set("SELLERPUBLICID", sellerPublicNumber.getId()).set("SELLERPUBLICNAME", sellerPublicNumber.getPublicNumberName()).set("ACTIVITY_WXID", WxUserId).set("OPENID", openid).set("NICKNAME", nickName).set("HEADIMG", headimgurl).set("MARK", mark).set("SING_NUMBER", "1").set("ACTIVITY_ID", activity).save();
						//给groupWxUser添加一个自己的信息   当前用户默认是创建者
						String saveSql1 = PropKit.use("database.properties").get("saveGroupPurchaseGroupWxUser");
						savePurchaseWxUser= Db.update(saveSql1,newId(),WxUserId,wxuser.getOpenid(),nickName,
								wxuser.getHeadimgurl(),uitils.newDate(),groupPurchase.getActivityName(),"0","1",groupPurchase.getGroupPrice(),"0",null,null);
						//updateGroupPurchaseNumber 参与人数更新一下
						String updateGroupPurchaseNumber = PropKit.use("database.properties").get("updateGroupPurchaseNumber");
						savePurchaseWxUser = Db.update(updateGroupPurchaseNumber,parseInt2+1+"",activity);
						if(savePurchaseWxUser>0){
							rest=true;
						}else{
							rest=false;
							}
						}
					setAttr("qrcode", qrcode);
					setAttr("groupPurchase", groupPurchase);
					setAttr("groupPurchasePrize", groupPurchasePrize);
					setAttr("openid", openid);
					setAttr("wxUserInfo", wxuser);
					setAttr("groupPurchaseWxUserId", WxUserId);
					setAttr("groupPurchaseWxUser", groupPurchaseWxUser);
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
					render("/groupPurchase/groupPurchase-homepage.html");
				}else if(resule == 4){
					//已经参加过了,再次进入
					//直接进入他参加过活动的那个邀请页面去
					String sql="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER != ? ";
					List<GroupPurchaseGroupWxUser> groupWxUserList = GroupPurchaseGroupWxUser.dao.find(sql,WxUserId,"1");
					String sql1="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER = ? ";
					//这是团长
					GroupPurchaseGroupWxUser groupPurchaseGroupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(sql1,WxUserId,"1");
					//查询group整个组团的人数
					int joinNum= groupWxUserList.size()+1;
					String s5="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ?";
					List<GroupPurchaseGroupWxUser> list = GroupPurchaseGroupWxUser.dao.find(s5,WxUserId);
					//是不是全部支付 默认全部支付1  0没有全部支付
					String allPay="1";
					//查询这个团是不是全部支付
					for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser2 : list) {
						if(groupPurchaseGroupWxUser2.getPayState().equals("0")||groupPurchaseGroupWxUser2.getPayState().equals("2")){
							allPay="0";
						}
					}
					setAttr("allPay", allPay);
					/**
					 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
					 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
					 */
					String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
							+ "/groupPurchase/goFriendRedirect?groupPurchaseWxUserId=" + WxUserId +"&groupPurchaseId=" + groupPurchase.getId()
							+ "&sellerNumberId=" + sellerPublicNumberId+ "&qrcode=" + qrcode;
					String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
					int parseInt = Integer.parseInt(openPrizeNumber);
					if(joinNum==parseInt){
						//0 没有满 1满了
						setAttr("fulled", "1");
					}else if(joinNum<parseInt){
						//0 没有满 1满了
						setAttr("fulled", "0");
					}
					setAttr("url", url);
					setAttr("joinNum", joinNum);
					setAttr("qrcode", qrcode);
					setAttr("sellerNumberId", sellerPublicNumberId);
					setAttr("groupPurchaseGroupWxUser", groupPurchaseGroupWxUser);
					setAttr("groupWxUserList", groupWxUserList);
					setAttr("groupPurchase", groupPurchase);
					setAttr("groupPurchasePrize", groupPurchasePrize);
					setAttr("groupPurchaseWxUser", groupPurchaseWxUser);
					setAttr("sellerPublicNumber", sellerPublicNumber);
					// 判断是否属于活动时间内
					Date endDate = DateUitils.strToDateYMD(groupPurchase.getEndTime());
					// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
					boolean isEnd = DateUitils.isDateBefore(endDate);
					setAttr("isEnd", isEnd);
					render("/groupPurchase/groupPurchase-Invitation.html");
				}else if(resule == 5){
					//这里不需要添加信息了 直接进入主页面
					setAttr("qrcode", qrcode);
					setAttr("groupPurchase", groupPurchase);
					setAttr("groupPurchasePrize", groupPurchasePrize);
					setAttr("openid", openid);
					setAttr("wxUserInfo", wxuser);
					setAttr("groupPurchaseWxUserId", WxUserId);
					setAttr("groupPurchaseWxUser", groupPurchaseWxUser);
					setAttr("sellerPublicNumber", sellerPublicNumber);
					render("/groupPurchase/groupPurchase-homepage.html");
				}
				return rest;
			}
		});
	}
	
	/**
	 * 拼团支付
	 */
	public void groupPay(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				Map<String, String> map = new HashMap<String, String>();
				String purchaseWxUserId = getPara("groupPurchaseWxUserId");
				GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(purchaseWxUserId);
				String payState = groupPurchaseWxUser.getPayState();
				//已经支付了
				if(payState.equals("1")){
					map.put("isPay", "true");
					map.put("result", "false");
					renderJson(map);
					return false;
				}else{
					String groupPurchaseId = groupPurchaseWxUser.getGroupPurchaseId();
					GroupPurchase groupPurchase = GroupPurchase.dao.findById(groupPurchaseId);
					String sellerNumberId = getPara("sellerNumberId");// 公众号
					SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerNumberId);
					String openid = getPara("openid");// openid
					String belongPublicNumberId = groupPurchaseWxUser.getBelongPublicNumberId();
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
					ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
					ApiConfigKit.setThreadLocalAppId(spn.getAppId());
					//补全用户信息
					WxUserInfo wxUserInfo = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
					ApiConfigKit.removeThreadLocalAppId();
					if(wxUserInfo.getSubscribe().equals("1")){
						//保存或修改微信用户
						wxService.saveWxUser(wxUserInfo,openid,sellerPublicNumber,newId());
						String sqlPurchase = PropKit.use("database.properties").get("updatePurchaseNameByOpenid");
						Db.update(sqlPurchase,wxUserInfo.getNickname(),wxUserInfo.getHeadimgurl(),openid);
					}
					Random r = new Random(1000);
					//一元购的订单
					String out_trade_no = "purchase" + (r.nextInt() * 100) + newDateByYMD();
					String mchId = spn.getShopNumber(); //商户号
					// 判断支付的金额，是否等于0元，0元可不用支付
					String appId = spn.getAppId();
					// 判断是否已经支付
					map = WxConfigUitils.getWxConfigUitils().wxPay(openid, appId, spn.getPayKey(), mchId,
							groupPurchase.getGroupPrice(), getRequest().getRemoteAddr(), out_trade_no);
					//在这里给订单号   商户号
					groupPurchaseWxUser.set("ID", purchaseWxUserId).set("MCHID", mchId).set("PAYOUTNO", out_trade_no).update();
					//这里还要将这条group记录的订单号也要更新一下
					String sql="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and OPENID = ? ";
					GroupPurchaseGroupWxUser groupPurchaseGroupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(sql,purchaseWxUserId,openid);
					boolean update = groupPurchaseGroupWxUser.set("ID", groupPurchaseGroupWxUser.getId())
					                   .set("MCHID", mchId)
					                   .set("PAYMONEY", groupPurchase.getGroupPrice())
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
	 * 支付成功了 跳转到邀请页面
	 */
	public void inviteFriend(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String purchaseWxUserId = getPara("groupPurchaseWxUserId");
				String purchaseId = getPara("groupPurchaseId");
				String sellerNumberId = getPara("sellerNumberId");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerNumberId);
				String qrcode = getPara("qrcode");
				String openId = getPara("openId");
				String getGroupPurchase = PropKit.use("database.properties").get("getGroupPurchase");
				GroupPurchase groupPurchase = GroupPurchase.dao.findFirst(getGroupPurchase,purchaseId);
				String sq="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
				GroupPurchasePrize groupPurchasePrize = GroupPurchasePrize.dao.findFirst(sq,purchaseId);
				GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(purchaseWxUserId);
				boolean update = new GroupPurchaseWxUser().set("ID", purchaseWxUserId)
						                             .set("PAYMONEY", groupPurchase.getGroupPrice())
						                             .set("PAYSTATE", "1")
						                             .update();
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openId, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//将group里面这条记录的支付状态改为1 已支付
				String sq11="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and OPENID = ?";
				GroupPurchaseGroupWxUser groupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(sq11,purchaseWxUserId,openId);
				groupWxUser.set("ID", groupWxUser.getId()).set("PAYSTATE", "1").set("HEADIMGURL", wxuser.getHeadimgurl()).set("NICKNAME", wxuser.getNickname()).update();
				String sql="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER != ? ";
				List<GroupPurchaseGroupWxUser> groupWxUserList = GroupPurchaseGroupWxUser.dao.find(sql,purchaseWxUserId,"1");
				String sql1="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER = ? ";
				GroupPurchaseGroupWxUser groupPurchaseGroupWxUser =  GroupPurchaseGroupWxUser.dao.findFirst(sql1,purchaseWxUserId,"1");
				//查询group整个组团的人数
				int joinNum= groupWxUserList.size()+1;
				String s5="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ?";
				List<GroupPurchaseGroupWxUser> list = GroupPurchaseGroupWxUser.dao.find(s5,purchaseWxUserId);
				//是不是全部支付 默认全部支付1  0没有全部支付
				String allPay="1";
				//查询这个团是不是全部支付
				for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser2 : list) {
					if(groupPurchaseGroupWxUser2.getPayState().equals("0")||groupPurchaseGroupWxUser2.getPayState().equals("2")){
						allPay="0";
					}
				}
				setAttr("allPay", allPay);
				/**
				 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
				 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
				 */
				String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
						+ "/groupPurchase/goFriendRedirect?groupPurchaseWxUserId=" + purchaseWxUserId +"&groupPurchaseId=" + groupPurchase.getId()
						+ "&sellerNumberId=" + sellerNumberId+ "&qrcode=" + qrcode;
				
				
				String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
				int parseInt = Integer.parseInt(openPrizeNumber);
				if(joinNum==parseInt){
					//0 没有满 1满了
					setAttr("fulled", "1");
				}else if(joinNum<parseInt){
					//0 没有满 1满了
					setAttr("fulled", "0");
				}
				setAttr("url", url);
				setAttr("joinNum", joinNum);
				setAttr("qrcode", qrcode);
				setAttr("sellerNumberId", sellerNumberId);
				setAttr("groupPurchaseGroupWxUser", groupPurchaseGroupWxUser);
				setAttr("groupWxUserList", groupWxUserList);
				setAttr("groupPurchase", groupPurchase);
				setAttr("groupPurchasePrize", groupPurchasePrize);
				setAttr("groupPurchaseWxUser", groupPurchaseWxUser);
				setAttr("sellerPublicNumber", sellerPublicNumber);
				// 判断是否属于活动时间内
				Date endDate = DateUitils.strToDateYMD(groupPurchase.getEndTime());
				// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
				boolean isEnd = DateUitils.isDateBefore(endDate);
				setAttr("isEnd", isEnd);
				render("/groupPurchase/groupPurchase-Invitation.html");
				return update;
			}
		});
	}
	
	/**
	 * 重定向
	 */
	public void goFriendRedirect(){
		String sellerPublicNumberId = getPara("sellerNumberId");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
		+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
		+ JFinal.me().getContextPath() + "%2fgroupPurchase%2ffriendRedirect%3fgroupPurchaseWxUserId%3d" + getPara("groupPurchaseWxUserId")
		+ "%26groupPurchaseId%3d" + getPara("groupPurchaseId") + "%26appid%3d" + spn.getAppId() + "%26qrcode%3d" + getPara("qrcode")
		+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect";
		redirect(url);
	}
	
	
	/**
	 * 重定向 1.下一步需要获取openid,此处从新进入页面，需要授权
	 */
	public void friendRedirect() {
		String groupPurchaseWxUserId = getPara("groupPurchaseWxUserId");
		GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(groupPurchaseWxUserId);
		String groupPurchaseId = getPara("groupPurchaseId");
		String getGroupPurchase = PropKit.use("database.properties").get("getGroupPurchase");
		GroupPurchase groupPurchase = GroupPurchase.dao.findFirst(getGroupPurchase,groupPurchaseWxUser.getGroupPurchaseId());
		String belongPublicNumberId = groupPurchaseWxUser.getBelongPublicNumberId();
		String sq="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
		GroupPurchasePrize groupPurchasePrize = GroupPurchasePrize.dao.findFirst(sq,groupPurchaseId);
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(belongPublicNumberId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
		String openid = getOpenid(spn);
		String qrcode = getPara("qrcode");
		String sql="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER != ? ";
		List<GroupPurchaseWxUser> groupWxUserList = GroupPurchaseWxUser.dao.find(sql,groupPurchaseWxUserId,"1");
		String sql1="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER = ? ";
		GroupPurchaseGroupWxUser groupPurchaseGroupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(sql1,groupPurchaseWxUserId,"1");
		//查询group整个组团的人数
		int joinNum= groupWxUserList.size()+1;
		String s5="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ?";
		List<GroupPurchaseGroupWxUser> list = GroupPurchaseGroupWxUser.dao.find(s5,groupPurchaseWxUserId);
		//是不是全部支付 默认全部支付1  0没有全部支付
		String allPay="1";
		//查询这个团是不是全部支付
		for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser2 : list) {
			if(groupPurchaseGroupWxUser2.getPayState().equals("0")||groupPurchaseGroupWxUser2.getPayState().equals("2")){
				allPay="0";
				break;
			}
		}
		setAttr("allPay", allPay);
		//这是自己进自己分享出去的页面
		if(groupPurchaseWxUser.getOpenId().equals(openid)){
			String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
					+ "/groupPurchase/goFriendRedirect?groupPurchaseWxUserId=" + groupPurchaseWxUserId +"&groupPurchaseId=" + groupPurchase.getId()
					+ "&sellerNumberId=" + belongPublicNumberId+ "&qrcode=" + qrcode;
			String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
			int parseInt = Integer.parseInt(openPrizeNumber);
			if(joinNum==parseInt){
				//0 没有满 1满了
				setAttr("fulled", "1");
			}else if(joinNum<parseInt){
				//0 没有满 1满了
				setAttr("fulled", "0");
			}
			setAttr("url", url);
			setAttr("joinNum", joinNum);
			setAttr("qrcode", qrcode);
			setAttr("sellerNumberId", belongPublicNumberId);
			setAttr("groupPurchaseGroupWxUser", groupPurchaseGroupWxUser);
			setAttr("groupWxUserList", groupWxUserList);
			setAttr("groupPurchase", groupPurchase);
			setAttr("groupPurchasePrize", groupPurchasePrize);
			setAttr("groupPurchaseWxUser", groupPurchaseWxUser);
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			setAttr("sellerPublicNumber", sellerPublicNumber);
			// 判断是否属于活动时间内
			Date endDate = DateUitils.strToDateYMD(groupPurchase.getEndTime());
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean isEnd = DateUitils.isDateBefore(endDate);
			setAttr("isEnd", isEnd);
			render("/groupPurchase/groupPurchase-Invitation.html");
		}
		//这是别人进来帮忙一元购的页面
		else{
			//别人进来
			//根据openID和GROUP_PURCHASE_WXUSER_ID判断该用户是否已经加入到了该一元购活动
			//0 没有满 1满了
			String fulled="0";
			//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
			String joined="0";
			//支付状态 0未支付 1支付 2支付中
			String payState="0";
			String s="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and OPENID = ? ";
			GroupPurchaseGroupWxUser groupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(s,groupPurchaseWxUserId,openid);
			//开奖人数
			String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
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
			setAttr("groupWxUserList", groupWxUserList);
			setAttr("joinNum", joinNum);
			//0 没有满 1满了
			setAttr("fulled", fulled);
			//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
			setAttr("joined", joined);
			setAttr("openid", openid);
			setAttr("qrcode", qrcode);
			setAttr("sellerNumberId", belongPublicNumberId);
			setAttr("groupPurchaseGroupWxUser", groupPurchaseGroupWxUser);
			setAttr("groupPurchaseWxUser", groupPurchaseWxUser);
			setAttr("groupPurchase", groupPurchase);
			setAttr("groupPurchasePrize", groupPurchasePrize);
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			setAttr("sellerPublicNumber", sellerPublicNumber);
			// 判断是否属于活动时间内
			Date endDate = DateUitils.strToDateYMD(groupPurchase.getEndTime());
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean isEnd = DateUitils.isDateBefore(endDate);
			setAttr("isEnd", isEnd);
			Random r = new Random(1000);
			//拼团的订单
			String out_trade_no = "purchase" + (r.nextInt() * 100) + newDateByYMD();
			setAttr("out_trade_no", out_trade_no);
			render("/groupPurchase/groupPurchase-group.html");
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
				String groupPurchaseWxUserId = getPara("groupPurchaseWxUserId");
				String groupPurchaseId = getPara("groupPurchaseId");
				GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(groupPurchaseWxUserId);
				String belongPublicNumberId = groupPurchaseWxUser.getBelongPublicNumberId();
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
					String s5="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ?";
					List<GroupPurchaseGroupWxUser> list = GroupPurchaseGroupWxUser.dao.find(s5,groupPurchaseWxUserId);
					String getGroupPurchase = PropKit.use("database.properties").get("getGroupPurchase");
					GroupPurchase groupPurchase = GroupPurchase.dao.findFirst(getGroupPurchase,groupPurchaseId);
					String joinPropleNumber = groupPurchase.getJoinPropleNumber();
					int parseInt2 = Integer.parseInt(joinPropleNumber);
					//开奖人数
					String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
					int parseInt = Integer.parseInt(openPrizeNumber);
					//没有满员
					if(list.size()<parseInt){
						String sellerNumberId = getPara("sellerNumberId");// 公众号
						SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerNumberId);
						//一元购的订单
						String out_trade_no = getPara("out_trade_no");
						log.error("***out_trade_no**"+out_trade_no);
						//去查询该订单号是否已经被同一时间段支付过了
						String mchId = spn.getShopNumber(); //商户号
						//先判断该用户是否存入在这个团里面
						String s="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and OPENID = ? ";
						GroupPurchaseGroupWxUser groupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(s,groupPurchaseWxUserId,openid);
						if(groupWxUser==null){
							String saveSql1 = PropKit.use("database.properties").get("saveGroupPurchaseGroupWxUser");
							//这里先将该用户存入到加团  订单号也存入该支付记录中  支付状态改为支付中
							int i = Db.update(saveSql1,newId(),groupPurchaseWxUserId,openid,nickName,
									wxuser.getHeadimgurl(),uitils.newDate(),groupPurchase.getActivityName(),"0","0",groupPurchase.getGroupPrice(),"2",mchId,out_trade_no);
							String updateGroupPurchaseNumber = PropKit.use("database.properties").get("updateGroupPurchaseNumber");
							i = Db.update(updateGroupPurchaseNumber,parseInt2+1+"",groupPurchaseId);
							if(i>0){
								rest=true;
							}else{
								rest=false;
							}
							String appId = spn.getAppId();
							// 判断是否已经支付
							map = WxConfigUitils.getWxConfigUitils().wxPay(openid, appId, spn.getPayKey(), mchId,
									groupPurchaseWxUser.getPayMoney(), getRequest().getRemoteAddr(), out_trade_no);
							map.put("result", "true");
						}else{
							String appId = spn.getAppId();
							// 判断是否已经支付
							map = WxConfigUitils.getWxConfigUitils().wxPay(openid, appId, spn.getPayKey(), mchId,
									groupPurchaseWxUser.getPayMoney(), getRequest().getRemoteAddr(), groupWxUser.getPayOutNo());
							map.put("result", "true");
//							groupWxUser.set("ID", groupWxUser.getId()).set("MCHID", mchId).set("PAYOUTNO", out_trade_no).update();
						}
					}
					//已经满员  判断该进来的openID的用户 在团里没有
					else{
						String openId = getPara("openid");
						String s6="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and OPENID = ? ";
						//这是判断该用户是否在这个团里
						GroupPurchaseGroupWxUser groupUser = GroupPurchaseGroupWxUser.dao.findFirst(s6,groupPurchaseWxUserId,openId);
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
									groupPurchaseWxUser.getPayMoney(), getRequest().getRemoteAddr(), groupUser.getPayOutNo());
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
				String groupPurchaseWxUserId = getPara("groupPurchaseWxUserId");
				String sellerNumberId = getPara("sellerNumberId");
				String qrcode = getPara("qrcode");
				GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(groupPurchaseWxUserId);
				String getGroupPurchase = PropKit.use("database.properties").get("getGroupPurchase");
				GroupPurchase groupPurchase = GroupPurchase.dao.findFirst(getGroupPurchase,groupPurchaseWxUser.getGroupPurchaseId());
				String openid = getPara("openid");
				String belongPublicNumberId = groupPurchaseWxUser.getBelongPublicNumberId();
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//判断当前人是否已经加入过该活动了
				String s2="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and OPENID = ? ";
				GroupPurchaseGroupWxUser purchaseGroupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(s2,groupPurchaseWxUserId,openid);
				//将该moneyGroupWxUser的支付状态修改为已支付
				result=purchaseGroupWxUser.set("ID", purchaseGroupWxUser.getId()).set("HEADIMGURL", wxuser.getHeadimgurl()).set("NICKNAME", wxuser.getNickname()).set("PAYSTATE", "1").update();
				//这里给该用户发送参与通知
				String sql1="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER = ? ";
				GroupPurchaseGroupWxUser groupPurchaseGroupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(sql1,groupPurchaseWxUserId,"1");
				String sq="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
				GroupPurchasePrize groupPurchasePrize = GroupPurchasePrize.dao.findFirst(sq,groupPurchase.getId());
				//添加前  判断该团是否满员了  并且都支付了？
				String s5="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and PAYSTATE = ? ";
				//开奖人数
				String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
				int parseInt = Integer.parseInt(openPrizeNumber);
				List<GroupPurchaseGroupWxUser> list1 = GroupPurchaseGroupWxUser.dao.find(s5,groupPurchaseWxUserId,"1");
				//根据openID和GROUP_PURCHASE_WXUSER_ID判断该用户是否已经加入到了该一元购活动
				//0 没有满 1满了
				String fulled="0";
				//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
				String joined="0";
				//支付状态 0未支付 1支付 2支付中
				String payState="0";
				String sql="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and CREATER != ? ";
				List<GroupPurchaseWxUser> groupWxUserList = GroupPurchaseWxUser.dao.find(sql,groupPurchaseWxUserId,"1");
				String s="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? and OPENID = ? ";
				GroupPurchaseGroupWxUser groupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(s,groupPurchaseWxUserId,openid);
				String s51="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ?";
				List<GroupPurchaseGroupWxUser> list = GroupPurchaseGroupWxUser.dao.find(s51,groupPurchaseWxUserId);
				//是不是全部支付 默认全部支付1  0没有全部支付
				String allPay="1";
				int payFlag=0;
				//查询这个团是不是全部支付
				for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser2 : list) {
					if(groupPurchaseGroupWxUser2.getPayState().equals("0")||groupPurchaseGroupWxUser2.getPayState().equals("2")){
						payFlag=payFlag+1;
					}
				}
				if(payFlag==0){
					allPay="1";
				}else{
					allPay="0";
				}
				setAttr("allPay", allPay);
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
						if(state.equals("0")){
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
					timeToOpenPrize(groupPurchaseWxUserId);
					result=true;
				}
				//查询group整个组团的人数
				int joinNum= groupWxUserList.size()+1;
				setAttr("joinNum", joinNum);
				// 0未支付 1支付
				setAttr("payState", payState);
				//0 没有满 1满了
				setAttr("fulled", fulled);
				//0 代表 该用户还没有参加该活动的组团   1 代表已经参加了
				setAttr("joined", joined);
				setAttr("groupWxUserList", groupWxUserList);
				setAttr("openid", openid);
				setAttr("qrcode", qrcode);
				setAttr("sellerNumberId", sellerNumberId);
				setAttr("groupPurchaseGroupWxUser", groupPurchaseGroupWxUser);
				setAttr("groupPurchaseWxUser", groupPurchaseWxUser);
				setAttr("groupPurchase", groupPurchase);
				setAttr("groupPurchasePrize", groupPurchasePrize);
				setAttr("sellerPublicNumber", sellerPublicNumber);
				// 判断是否属于活动时间内
				Date endDate = DateUitils.strToDateYMD(groupPurchase.getEndTime());
				// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
				boolean isEnd = DateUitils.isDateBefore(endDate);
				setAttr("isEnd", isEnd);
				Random r = new Random(1000);
				//拼团的订单
				String out_trade_no = "purchase" + (r.nextInt() * 100) + newDateByYMD();
				setAttr("out_trade_no", out_trade_no);
				render("/groupPurchase/groupPurchase-group.html");
				return result;
			}
		});
	}
	
	/**
	 * 拼团 定时去循环判断该组团的人数是否达到了开奖的人数
	 */
	public void timeToOpenPrize(String groupPurchaseWxUserId){
		//TB_GROUP_PURCHASE_WXUSER  一元购微信参与用户记录  这全是参与一元购活动的创建者  0是未处理
		String sql="select * from TB_GROUP_PURCHASE_WXUSER where HANDLE = ? and ID = ? ";
		//所有的创建者 在时间范围内
		GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findFirst(sql,"0",groupPurchaseWxUserId);
		if(groupPurchaseWxUser!=null){
			String scanCode = groupPurchaseWxUser.getScanCode();
			//根据扫描的二维码查找出该二维码的参与情况
			String codeSql="select * from ACTIVITY_CODE where CODE =?";
			ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
			String groupPurchaseId = groupPurchaseWxUser.getGroupPurchaseId();
			String getGroupPurchase = PropKit.use("database.properties").get("getGroupPurchase");
			//找到拼团的大活动
			GroupPurchase groupPurchase = GroupPurchase.dao.findFirst(getGroupPurchase,groupPurchaseId);
			String winningPropleNumber = groupPurchase.getWinningPropleNumber();
			//该大活动的中奖人数
			int parseInt = Integer.parseInt(winningPropleNumber);
			String s1="select * from TB_GROUP_PURCHASE_PRIZE where GROUP_PURCHASE_ID = ? ";
			//该活动的奖品配置
			GroupPurchasePrize groupPurchasePrize = GroupPurchasePrize.dao.findFirst(s1,groupPurchaseId);
			//开奖人数
			String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
			//这是该活动的开奖人数
			int openPrizeNumberInt = Integer.parseInt(openPrizeNumber);
			String getGroupPurchaseGroupWxUser = PropKit.use("database.properties").get("getGroupPurchaseGroupWxUser");
			//根据微信参与活动找出该团里面的人
			List<GroupPurchaseGroupWxUser> groupPurchaseGroupWxUserList = GroupPurchaseGroupWxUser.dao.find(getGroupPurchaseGroupWxUser,groupPurchaseWxUser.getId());
			//如果人数达到了开奖的人数 则开奖了    这里是每个人都中奖   这里还要判断该团里的人是否都支付了
			if(groupPurchaseGroupWxUserList.size()==openPrizeNumberInt){
				//默认为0代表全部支付了
				int result=0;
				for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser : groupPurchaseGroupWxUserList) {
					if(groupPurchaseGroupWxUser.getPayState().equals("0")||groupPurchaseGroupWxUser.getPayState().equals("2")){
						//满员支付的时候 result+1
						result=result+1;
					}
				}
				//如果result=0 则代表全部支付了，才进行发送通知，否则...
				if(result==0){
					//公众号id
					String belongPublicNumberId = groupPurchaseWxUser.getBelongPublicNumberId();
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
					ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
					ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
					//先将活动创建人的状态改为中奖
					//每个人都中奖               这里循环该拼团活动 给团里的每个用户发送中奖通知，满团则每个人都中奖
					for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser : groupPurchaseGroupWxUserList) {
						//中奖状态改为中奖
						boolean update = groupPurchaseGroupWxUser.set("ID", groupPurchaseGroupWxUser.getId()).set("STATE", "1").update();
						//这里将中奖人数修改一下
						groupPurchase.set("ID", groupPurchaseId).set("WINNING_PROPLE_NUMBER", parseInt+1+"").update();
						if(update){
							//保存中奖实物的记录
							String newId = newId();//product产品id
							String winNewId = newId(); //中奖记录的id
							ProductWinningInfo pwi=new ProductWinningInfo();
							boolean save = pwi.set("ID", newId)
							   .set("BELONG_ACTIVITY_ID", groupPurchaseId)
							   .set("ACTIVITY_NAME_TYPE", PropKit.use("system.properties").get("GroupPurchase"))
							   .set("ACTIVITY_NAME", groupPurchase.getActivityName())
							   .set("ACTIVITY_PRIZE_ID", groupPurchasePrize.getId())
							   .set("PRODUCT_NAME", groupPurchasePrize.getPrizeName())
							   .set("PRODUCT_IMG", groupPurchasePrize.getPrizeImg())
							   .set("CREATE_TIME", uitils.newDate())
							   .set("OPENID", groupPurchaseGroupWxUser.getOpenId())
							   .set("ACTIVITY_WXUSER_ID", groupPurchaseWxUser.getId())
							   .set("BELONG_PUBLICNUMBER_ID", groupPurchaseWxUser.getBelongPublicNumberId())
							   .set("STATE", "2")
							   .set("WINNING_INFO_ID", winNewId)
							   .set("PAY_MONEY",groupPurchase.getGroupPrice())
							   .set("PRICE", groupPurchase.getGroupPrice())
							   .set("LOW_PRICE",groupPurchase.getGroupPrice())
							   .save();
							if(save){
								String nickName = groupPurchaseGroupWxUser.getNickName();
								//判断名称是否包含表情符号
								Boolean emoji =  EmojiUtils.containsEmoji(nickName);
								if(emoji){
									try {
										nickName=java.net.URLEncoder.encode(nickName, "UTF-8");
									} catch (UnsupportedEncodingException e) {
										e.printStackTrace();
									}
								}
								PurchaseWxUserWinning omw=new PurchaseWxUserWinning();
								save = omw.set("ID", winNewId)
								   .set("PURCHASE_WXUSER_ID", groupPurchaseWxUser.getId())
								   .set("BELONG_WINNING_PRIZE_ID", groupPurchasePrize.getId())
								   .set("PRIZE_PROJECT", groupPurchasePrize.getPrizeName())
								   .set("PRIZE_PROJECT_IMG", groupPurchasePrize.getPrizeImg())
								   .set("CREATE_TIME", uitils.newDate())
								   .set("OPENID", groupPurchaseGroupWxUser.getOpenId())
								   .set("NICKNAME", nickName)
								   .set("HEADIMGURL", groupPurchaseGroupWxUser.getHeadImgUrl())
								   .set("STATE", "2")
								   .set("PRODUCT_WINNING_INFO_ID", newId)
								   .save();
								if(activityCode!=null){
								//这里更新了该码的中奖情况
								activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", groupPurchaseWxUser.getId()).set("WINTYPE", "1").set("WININGID", winNewId).update();
								}
							}
							String activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + groupPurchaseGroupWxUser.getOpenId()+ "%26selectedVal%3d" + "";
							Tools.sendWinNotice(groupPurchaseGroupWxUser.getOpenId(), sellerPublicNumber, activityUrl, groupPurchase.getActivityName(), groupPurchasePrize.getPrizeName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
							ApiConfigKit.removeThreadLocalAppId();
						}
					}
					//处理完之后将该条记录的状态修改为已经处理了
					groupPurchaseWxUser.set("ID", groupPurchaseWxUser.getId()).set("HANDLE", "1").set("FULLED", "1").update();
				}
			}
		}
	}
	
	/**
	 * 填写地址
	 */
	public void address(){
		String purchaseWinningId = getPara("purchaseWinningId");
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		PurchaseWxUserWinning groupPurchaseWxUserWinning = PurchaseWxUserWinning.dao.findById(purchaseWinningId);
		Boolean result =  new PurchaseWxUserWinning().set("ID", purchaseWinningId).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
			.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
		if(result){
			result = new ProductWinningInfo().set("ID", groupPurchaseWxUserWinning.getProductWinningInfoId()).set("STATE", "3").set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).update();
		}
		renderJson(result);
	}
	
	/**
	 * 这里处理时间过期了  执行退款
	 */
	public void returnMoney(){
		//  一元购微信参与用户记录  这全是参与一元购活动的创建者  0是未处理
		//所有的创建者 在时间范围内    首先判断该活动是否结束了
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowTime = sdf.format(date);
		//判断当前时间是不是大于一元购结束时间并且处理状态为未处理
		String sql="select * from TB_GROUP_PURCHASE where HANDLE = '0' and ENDTIME < '"+nowTime+"' ";
		//这就是没有处理的 并且活动时间到了 
		List<GroupPurchase> groupPurchaseList = GroupPurchase.dao.find(sql);
		String s="select * from TB_GROUP_PURCHASE_WXUSER where GROUP_PURCHASE_ID = ? and HANDLE = '0'";
		//这是查询团购的sql
		String sql1="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where GROUP_PURCHASE_WXUSER_ID = ? ";
		//代表该团有支付的
		int result=0;
		if(groupPurchaseList.size()!=0){
			for (GroupPurchase groupPurchase : groupPurchaseList) {
				//这里是没有处理的微信活动
				List<GroupPurchaseWxUser> list = GroupPurchaseWxUser.dao.find(s,groupPurchase.getId());
				String openPrizeNumber = groupPurchase.getOpenPrizeNumber();
				//开团人数
				int parseInt = Integer.parseInt(openPrizeNumber);
				for (GroupPurchaseWxUser groupPurchaseWxUser : list) {
					//这是团购中没有处理的参加的微信活动的用户
					List<GroupPurchaseGroupWxUser> list2 = GroupPurchaseGroupWxUser.dao.find(sql1,groupPurchaseWxUser.getId());
					String belongPublicNumberId = groupPurchaseWxUser.getBelongPublicNumberId();
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
					//判断这个团里是不是满了 里面有没有支付的
					if(list2.size()==parseInt){
						for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser : list2) {
							if(groupPurchaseGroupWxUser.getPayState().equals("0")||groupPurchaseGroupWxUser.getPayState().equals("2")){
								//这个true代表  判断这个团里是不是满了 里面有没有支付的   这也需要退款的
								result = result+1;
							}
						}
					}
					//没有满团
					if(list2.size()<parseInt||(result!=0)){
						//执行退款
						for (GroupPurchaseGroupWxUser groupPurchaseGroupWxUser : list2) {
							//执行退款
							String payOutNo = groupPurchaseGroupWxUser.getPayOutNo();
							String payMoney = groupPurchaseGroupWxUser.getPayMoney();
							if(!StringUtils.isEmpty(payOutNo)&&!StringUtils.isEmpty(payMoney)){
								// 支付金额
								BigDecimal re1 = new BigDecimal(payMoney);
								BigDecimal re2 = new BigDecimal(Float.toString(100.00f));
								Float total_fee = re1.multiply(re2).floatValue();
								// 没有中奖的 还需要退款
								refundUtil.wechatRefund(sellerPublicNumber,payOutNo, total_fee);
							}
						}
					}
					//TODO 这里将小活动状态修改一下
					//将该微信活动的状态修改为已经处理过了
					groupPurchaseWxUser.set("ID", groupPurchaseWxUser.getId()).set("HANDLE", "1").update();
				}
				//TODO 这里将大活动的状态修改了
				//将该大活动的状态修改为已经处理过了
				groupPurchase.set("ID", groupPurchase.getId()).set("HANDLE", "1").update();
			}
		}
	}
	
}
