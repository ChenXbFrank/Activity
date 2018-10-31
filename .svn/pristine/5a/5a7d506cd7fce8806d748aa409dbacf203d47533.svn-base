package com.activity.common.controller.moblie.shareBargain;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.bigDataPlatform.ProductInfo;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.shareBargain.ShareBargain;
import com.activity.common.model.shareBargain.ShareBargainHelp;
import com.activity.common.model.shareBargain.ShareBargainPrize;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.shareBargain.ShareBargainHelpService;
import com.activity.common.service.shareBargain.ShareBargainPrizeService;
import com.activity.common.service.shareBargain.ShareBargainWxuserService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.ProductInfoService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 分享砍价活动配置
 * 
 * @author 唐
 */
@ControllerPath(controllerKey = "/ShareBargain")
public class ShareBargainController extends BaseController {
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	EmojiUtils emojiUtils = EmojiUtils.getEmojiUtils();
	WxService wxService = WxService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	private static ShareBargainHelpService  shareBargainHelpService = new ShareBargainHelpService ();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	
	/**
	 * 分享砍价
	 */
	public void shareBargainIndex() {
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String spnId = getPara("spn");
				SellerPublicNumber spn = SellerPublicNumber.dao.findById(spnId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(spn.getAppId());
				String openid = getOpenid(spn);
				// 活动ID
				String activity = getPara("Activity");
				String publicNumberQrcodeImg = spn.getPublicNumberQrcodeImg();
				//获取当前用户，判断是否已经关注公众号
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				if(wxuser.getSubscribe().equals("1")){
					//保存微信用户
					wxService.saveWxUser(wxuser, openid, spn, newId());
				}
				String qrcode = getPara("qrcode");
				String friendBargainId = getPara("friendBargainId");
				// 获取当前活动
				ShareBargain ab = ShareBargain.dao.findById(activity);
				// 活动奖品
				List<ShareBargainPrize> sbpList = ShareBargainPrizeService.getService()
						.getShareBargainPrizeByActvityId(ab.getId());
				ShareBargainPrize sbp = new ShareBargainPrize();
				// 当前只有一个奖品的情况下
				for (ShareBargainPrize sbpErgodic : sbpList) {
					sbp = sbpErgodic;
				}
				List<ProductInfo> piList = ProductInfoService.getService().getProductInfoById(sbp.getProductId());
				// 产品信息
				ProductInfo pi = new ProductInfo();
				for (ProductInfo piErgodic : piList) {
					pi = piErgodic;
				}
				if (friendBargainId != null) {
					setAttr("friendBargainId", friendBargainId);
				}
				setAttr("SellerPublicNumber", spn);
				setAttr("publicNumberQrcodeImg", publicNumberQrcodeImg);
				setAttr("openid", openid);
				setAttr("qrcode", qrcode);
				setAttr("ShareBargain", ab);
				setAttr("ShareBargainPrize", sbp);
				setAttr("ProductInfo", pi);
				setAttr("WxUserInfo", wxuser);
				return true;
			}
		});
		render("/Bargain-activities/Bargain-homepage.html");
	}

	/**
	 * 分享砍价活动结束
	 */
	public void BargainError(){
		String activityId = getPara("activityId");
		ShareBargain ab = ShareBargain.dao.findById(activityId);
		// 活动奖品
		List<ShareBargainPrize> sbpList = ShareBargainPrizeService.getService()
				.getShareBargainPrizeByActvityId(ab.getId());
		ShareBargainPrize sbp = new ShareBargainPrize();
		// 当前只有一个奖品的情况下
		for (ShareBargainPrize sbpErgodic : sbpList) {
			sbp = sbpErgodic;
		}
		List<ProductInfo> piList = ProductInfoService.getService().getProductInfoById(sbp.getProductId());
		// 产品信息
		ProductInfo pi = new ProductInfo();
		for (ProductInfo piErgodic : piList) {
			pi = piErgodic;
		}
		setAttr("ShareBargainPrize", sbp);
		setAttr("ProductInfo", pi);
		setAttr("ShareBargain", ab);
		render("/Bargain-activities/Bargain-error.html");
	}
	
	
	/**
	 * 帮助砍价后，用户我也要砍价，重定向至index方法 1.因为获取openid需要配置微信访问链接
	 */
	public void IWantBargain() {
		String spnId = getPara("spn");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(spnId);
		String activity = getPara("Activity");
		String friendBargainId = getPara("friendBargainId");
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
				+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
				+ JFinal.me().getContextPath() + "%2fShareBargain%2fshareBargainIndex%3fspn%3d" + spnId + "%26Activity%3d" + activity
				+ "%26friendBargainId%3d" + friendBargainId
				+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect";
		redirect(url);
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
	 * 1.用户点击"立即砍价"代表参加该活动 2.新建一个用户参加活动记录 2.进入当前砍价信息页面，展示砍了多少，帮砍的好友 3.可邀请好友帮忙砍价
	 */
	public void bargainInvitation() {
		// 所属公众号
		String belingPublicNumberId = getPara("belingPublicNumberId");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(belingPublicNumberId);
		String openid = getPara("openid");
		// 活动ID
		String activityId = getPara("ActivityId");
		String qrcode = getPara("qrcode");
		// 用户昵称
		String nickName = getPara("nickName");
		// 头像地址
		String headImgUrl = getPara("headImgUrl");
		// 获取当前活动
		ShareBargain ab = ShareBargain.dao.findById(activityId);
		//修改砍价活动的参与人数
		int joinPropleNumber = ab.getJoinPropleNumber().intValue();
		// 活动奖品ID
		String shareBargainPrizeId = getPara("shareBargainPrizeId");
		ShareBargainPrize sbp = ShareBargainPrize.dao.findById(shareBargainPrizeId);
		String Id = "";
		// 判断当前是否已经发起过活动 1.发起过未支付不能再次发起，2.未发起过或已支付完成可再次发起
		// 查询出openid用户发起的未支付的活动
		List<ShareBargainWxuser> sbwList = ShareBargainWxuserService.getService().getSbwByOpenid(openid, activityId,qrcode);
		ShareBargainWxuser sbw = new ShareBargainWxuser();
		if (sbwList.size() > 0) {
			for (ShareBargainWxuser sbwErgodic : sbwList) {
				sbw = sbwErgodic;
			}
			Id = sbw.getId();
		} else {
			Id = newId();
			//判断名称是否包含表情符号
			Boolean emoji =  EmojiUtils.containsEmoji(nickName);
			if(emoji){
				try {
					nickName=java.net.URLEncoder.encode(nickName, "UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
			// 原价格
			String price = getPara("price");
			// 最低价
			String lowPrice = getPara("lowPrice");
			// 砍价区间
			String bargainSection = getPara("bargainSection");
			// 砍价次数
			String bargainNumber = getPara("bargainNumber");
			// 新建一个用户参加活动记录
			sbw.setJoinActivityId(activityId);
			sbw.setNickName(wxService.emoji(nickName));
			sbw.setHeadImgUrl(headImgUrl);
			sbw.setJoinBelongPublicNumberId(belingPublicNumberId);
			sbw.setPrice(price);
			sbw.setNowPrice(price);
			sbw.setLowPrice(lowPrice);
			sbw.setBargainSection(bargainSection);
			sbw.setBargainNumber(bargainNumber);
			sbw.setshareBargainPrizeId(shareBargainPrizeId);
			sbw.setId(Id);
			sbw.setScanCode(qrcode);
			// 保存为未发货
			sbw.setGoodsState("2");
			DateUitils.getUitils();
			new ShareBargainWxuser().set("ID", Id).set("OPENID", openid).set("NICKNAME", nickName)
					.set("HEADIMGURL", headImgUrl).set("JOIN_ACTIVITY_ID", activityId)
					.set("BELONG_PUBLICNUMBER_ID", belingPublicNumberId).set("PRICE", price).set("LOW_PRICE", lowPrice)
					.set("NOW_PRICE", price).set("BARGAIN_SECTION", bargainSection).set("BARGAIN_NUMBER", bargainNumber)
					.set("CREATE_TIME", uitils.newDate()).set("SHAREBARGAIN_PRIZE_ID", shareBargainPrizeId)
					.set("STATE", "1").set("SCAN_CODE", qrcode).set("GOODS_STATE", "2").save();
			
			String updateShareBargainNumber = PropKit.use("database.properties").get("updateShareBargainNumber");
			// 获取当前活动  参加人数+1
			Db.update(updateShareBargainNumber,joinPropleNumber+1,activityId);
		}
		/**
		 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
		 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
		 */
		String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
				+ "/ShareBargain/friendRedirect?friendBargain=" + Id + "&activityId=" + activityId
				+ "&shareBargainPrizeId=" + shareBargainPrizeId + "&appid=" + spn.getAppId();
		/**
		 * 查询出当前砍价活动帮助砍价的朋友
		 */
		List<ShareBargainHelp> sbhList = ShareBargainHelpService.getService()
				.getShareBargainHelpByFriendActivityId(sbw.getId());
		setAttr("url", url);
		setAttr("shareBargain", ab);
		setAttr("shareBargainWxuser", sbw);
		setAttr("shareBargainPrize", sbp);
		setAttr("sbhList", sbhList);
		setAttr("openid", openid);
		setAttr("sellerPublicNumber", spn);
		// 查询当前二维码是否已参加活动
		ActivityCode ac = IndexService.getService().getCodeByCodeAndActivity(qrcode, activityId);
		if (ac!=null) {// 说明有活动
			if (ac.getOpenId().equals(openid)) {
				// 自己进来查看，可以查看，但不用新建一个二维码失效记录
				render("/Bargain-activities/Bargain-Invitation.html");
			} else {
				// 二维码已经使用
				render("/index/QRCodeInvalid.html");
			}
		} else {
			// 查询出所属运单   没有活动 新建一个二维码失效记录   保存当前所扫二维码已被使用的记录
			Map<String, Object> map = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
			//这是开启活动的运单
			ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map.get("activitySellerInfo");
			String mark = PropKit.use("system.properties").get("ShareBargain");
			new ActivityCode().set("ID", newId()).set("CODE", qrcode).set("SELLEROUTINFO_RECORDID", activitySellerInfo.getSellerOutInfoRecordId())
			.set("ACTIVITYNAME", ab.getActivityName()).set("SELLERPUBLICID", spn.getId()).set("SELLERPUBLICNAME", spn.getPublicNumberName()).set("ACTIVITY_WXID", Id).set("OPENID", openid).set("NICKNAME", wxService.emoji(nickName)).set("HEADIMG", headImgUrl).set("MARK", mark).set("SING_NUMBER", "1").set("ACTIVITY_ID", activityId).save();
			String activityUrl="%2fShareBargain%2fBargainCenter%3fshareBargainPrizeId%3d" + sbp.getId() +"%26shareBargainWxuserId%3d" + Id+ "%26activityId%3d" + activityId+ "%26oid%3d" + openid;
			// 发送参与成功通知
			ApiConfigKit.setThreadLocalAppId(spn.getAppId());
			Tools.sendJoinNotice(openid, spn, activityUrl, ab.getActivityName(), getAccessToken(spn.getAppId(),spn.getAppSecret()));
			ApiConfigKit.removeThreadLocalAppId();
			render("/Bargain-activities/Bargain-Invitation.html");
		}
	}

	/**
	 * 个人中心 -查询自己正在开展的活动
	 */
	public void BargainCenter() {
		// 活动ID
		String activityId = getPara("activityId");
		String openid = getPara("oid");
		// 获取当前活动
		ShareBargain ab = ShareBargain.dao.findById(activityId);
		//用户参与记录ID
		String shareBargainWxuserId = getPara("shareBargainWxuserId");
		// 查询出奖品
		String shareBargainPrizeId = getPara("shareBargainPrizeId");
		ShareBargainPrize sbp = ShareBargainPrize.dao.findById(shareBargainPrizeId);
		ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(shareBargainWxuserId);
		String Id = "";
		if(sbw != null){	
			Id = sbw.getId();
			// 获取公众号配置
			SellerPublicNumber spn = SellerPublicNumber.dao.findById(sbw.getJoinBelongPublicNumberId());
			/**
			 * 朋友帮砍价链接 配置文件中的系统名称
			 * PropKit.use("system.properties").get("systemname")
			 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
			 */
			String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
					+ "/ShareBargain/friendRedirect?friendBargain=" + Id + "&activityId=" + activityId
					+ "&shareBargainPrizeId=" + shareBargainPrizeId + "&appid=" + spn.getAppId();
			/**
			 * 查询出当前砍价活动帮助砍价的朋友
			 */
			List<ShareBargainHelp> sbhList = ShareBargainHelpService.getService()
					.getShareBargainHelpByFriendActivityId(sbw.getId());
			// 判断是否属于活动时间内
			Date startDate = DateUitils.strToDateYMD(ab.getStartTime());
			Date endDate = DateUitils.strToDateYMD(ab.getEndTime());
			// 判断当前时间是否大于活动开始时间 返回fasle表示小于当前时间，代表活动已经开始
			boolean startTime = DateUitils.isDateBefore(startDate);
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean endTime = DateUitils.isDateBefore(endDate);
			if(!startTime && endTime){
				setAttr("isEnd", "true");
				System.out.println("活动时间内"); 
			}else{
				setAttr("isEnd", "false");
				System.out.println("活动也结束");
				
			}
			setAttr("url", url);
			setAttr("shareBargain", ab);
			setAttr("shareBargainWxuser", sbw);
			setAttr("shareBargainPrize", sbp);
			setAttr("sbhList", sbhList);
			setAttr("openid", openid);
			setAttr("sellerPublicNumber", spn);
			render("/Bargain-activities/Bargain-Invitation.html");
		} else {
			render("/Bargain-activities/Bargain-Over.html");
		}

	}

	/**
	 * 重定向 1.下一步需要获取openid,此处从新进入页面，需要授权
	 */
	public void friendRedirect() {
		String friendBargain = getPara("friendBargain");
		String activityId = getPara("activityId");
		String shareBargainPrizeId = getPara("shareBargainPrizeId");
		String appid = getPara("appid");
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appid
				+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
				+ JFinal.me().getContextPath() + "%2fShareBargain%2ffriendBargain%3ffriendBargain%3d" + friendBargain
				+ "%26activityId%3d" + activityId + "%26shareBargainPrizeId%3d" + shareBargainPrizeId
				+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect";
		redirect(url);
	}

	/**
	 * 点击链接后进入该方法，重订项至帮砍页面，需要微信授权
	 */
	public void friendBargain() {
		String friendBargainId = getPara("friendBargain");
		String activityId = getPara("activityId");
		// 活动奖品ID
		String shareBargainPrizeId = getPara("shareBargainPrizeId");
		ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(friendBargainId);
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(sbw.getJoinBelongPublicNumberId());
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
		String openid = getOpenid(spn);
		// 判断进入人是否属于当前活动发起人 相等进入活动
		if (sbw.getOpenId().equals(openid)) {
			redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
					+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
					+ JFinal.me().getContextPath() + "%2fShareBargain%2fBargainCenter%3fshareBargainPrizeId%3d"
					+ shareBargainPrizeId + "%26activityId%3d" + activityId + "%26oid%3d" + openid+"%26shareBargainWxuserId%3d"+friendBargainId
					+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect");
		} else {
			ShareBargain sb = ShareBargain.dao.findById(activityId);
			// 判断是否属于活动时间内
			Date startDate = DateUitils.strToDateYMD(sb.getStartTime());
			Date endDate = DateUitils.strToDateYMD(sb.getEndTime());
			// 判断当前时间是否大于活动开始时间 返回fasle表示小于当前时间，代表活动已经开始
			boolean startTime = DateUitils.isDateBefore(startDate);
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean endTime = DateUitils.isDateBefore(endDate);
			if(!startTime){
				if(endTime){
					redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
					+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
					+ JFinal.me().getContextPath() + "%2fShareBargain%2ffriendBarginInfo%3ffriendBargainId%3d"
					+ friendBargainId + "%26joinBelongPublicNumberId%3d" + spn.getId() + "%26activityId%3d" + activityId
					+ "%26shareBargainPrizeId%3d" + shareBargainPrizeId
					+ "&response_type=code&scope=snsapi_userinfo&state=wx" + "&connect_redirect=1#wechat_redirect");
				}else{
					render("/index/end.html");
				}
			}else{
				render("/index/end.html");
			}
		}
	}

	/**
	 * 朋友砍价页面
	 */
	public synchronized void friendBarginInfo() {
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String joinBelongPublicNumberId = getPara("joinBelongPublicNumberId");
				SellerPublicNumber spn = SellerPublicNumber.dao.findById(joinBelongPublicNumberId);
				String openid = getOpenid(spn);
				ApiConfigKit.setThreadLocalAppId(spn.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				// 朋友参加砍价或的ID
				String friendBargainId = getPara("friendBargainId");
				if (wxuser.getSubscribe().equals("1")) {
					wxService.saveWxUser(wxuser, openid, spn, newId());
				}
				ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(friendBargainId);
				// 所属活动ID
				String activityId = getPara("activityId");
				ShareBargain ab = ShareBargain.dao.findById(activityId);
				// 所属活动配置的奖品
				String shareBargainPrizeId = getPara("shareBargainPrizeId");
				ShareBargainPrize sbp = ShareBargainPrize.dao.findById(shareBargainPrizeId);
				String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
						+ "/ShareBargain/friendRedirect?friendBargain=" + friendBargainId + "&activityId=" + activityId
						+ "&shareBargainPrizeId=" + shareBargainPrizeId + "&appid=" + spn.getAppId();
				setAttr("spn", spn);
				List<ProductInfo> piList = ProductInfoService.getService().getProductInfoById(sbp.getProductId());
				// 产品信息
				ProductInfo pi = new ProductInfo();
				for (ProductInfo piErgodic : piList) {
					pi = piErgodic;
				}
				setAttr("ProductInfo", pi);
				setAttr("url", url);
				setAttr("shareBargain", ab);
				setAttr("shareBargainWxuser", sbw);
				setAttr("shareBargainPrize", sbp);
				setAttr("chopAKnifeOpenid", openid);
				setAttr("WxUserInfo", wxuser);
				setAttr("SellerPublicNumber", spn);
				setAttr("joinBelongPublicNumberId", joinBelongPublicNumberId);
				return true;
			}
		});
		render("/Bargain-activities/Bargain-help.html");
	}

	/**
	 * 砍一刀
	 */
	public void chopAKnife() {
		// 朋友参加砍价活动的ID
		String friendBargainId = getPara("friendBargainId");
		// 绑定 appId 到线程之上
		String appid = getPara("appid");
		String openid = getPara("chopAKnifeOpenid");
		String activityId = getPara("activityId");
		String shareBargainPrizeId = getPara("shareBargainPrizeId");
		String joinBelongPublicNumberId = getPara("joinBelongPublicNumberId");
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(joinBelongPublicNumberId);
		// 保存一个帮砍价记录
		// 获取当前用户，判断是否已经关注公众号
		ApiConfigKit.setThreadLocalAppId(appid);
		String accessToken = getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret());
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		Map<String, Object> map = shareBargainHelpService.kanyidao(accessToken, wxuser, appid, openid, friendBargainId, activityId, shareBargainPrizeId, joinBelongPublicNumberId);
		ApiConfigKit.removeThreadLocalAppId();
		renderJson(map);
	}

	/**
	 * 中奖后填写地址
	 */
	public void PrizeAddress() {
		String sbwId = getPara("sbw");
		String jpn = getPara("jpn");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(jpn);
		// 配置公众号对象
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(spn.getAppId());
		String openid = getOpenid(spn);
		ApiConfigKit.removeThreadLocalAppId();
		ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(sbwId);
		ShareBargain sb = ShareBargain.dao.findById(sbw.getJoinActivityId());
		ShareBargainPrize sbp = ShareBargainPrize.dao.findById(sbw.getshareBargainPrizeId());
		List<ProductInfo> piList = ProductInfoService.getService().getProductInfoById(sbp.getProductId());
		// 产品信息
		ProductInfo pi = new ProductInfo();
		for (ProductInfo piErgodic : piList) {
			pi = piErgodic;
		}
		setAttr("spn", spn);
		setAttr("sbw", sbw);
		setAttr("sb", sb);
		setAttr("pi", pi);
		setAttr("sbwId", sbwId);
		setAttr("jpn", jpn);
		setAttr("sbp", sbp);
		setAttr("openid", openid);
		render("/Bargain-activities/Bargain-address.html");
	}

	/**
	 * 保存地址并返回支付页面
	 */
	public void saveAddress() {
		String sbwId = getPara("sbwId");
		String name = getPara("name");// 名称
		String tel = getPara("tel");// 电话
		String address = getPara("address");// 地址
		ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(sbwId);
		boolean result = false;
		result = new ShareBargainWxuser().set("ID", sbw.getId()).set("CONSIGNEE_NAME", name)
				.set("CONSIGNEE_ADDRESS", address).set("CONSIGNEE_PHONE", tel).set("STATE", "3").update();
		if(result){
			result = new ProductWinningInfo().set("ID", sbw.getProductWinningInfoId()).set("STATE", "3").set("ADDRESSEE_NAME", name).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).update();
		}
		if (sbw.getPayMoney().equals("0")) {
			result = true;
		}
		String openid = sbw.getOpenId();
		if(openid!=null){
			String belongPublicNumberId = sbw.getJoinBelongPublicNumberId();
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			//补全用户信息
			WxUserInfo wxUserInfo = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
			ApiConfigKit.removeThreadLocalAppId();			
			//保存或修改微信用户
			wxService.saveWxUser(wxUserInfo,openid,sellerPublicNumber,newId());
			//修改记录中的微信名称和头像地址  这是修改砍价的
			String sqlShare = PropKit.use("database.properties").get("updateShareNameByOpenid");
			Db.update(sqlShare,wxUserInfo.getNickname(),wxUserInfo.getHeadimgurl(),openid);
		}
		
		renderJson(result);
	}

	/**
	 * 查出订单，展示信息，准备支付
	 */
	public void queryOrder() {
		String sbwId = getPara("sbwId");
		String jpn = getPara("jpn");// 公众号
		String openid = getPara("oid");// openid
		ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(sbwId);
		ShareBargainPrize sbp = ShareBargainPrize.dao.findById(sbw.getshareBargainPrizeId());
		List<ProductInfo> piList = ProductInfoService.getService().getProductInfoById(sbp.getProductId());
		// 产品信息
		ProductInfo pi = new ProductInfo();
		for (ProductInfo piErgodic : piList) {
			pi = piErgodic;
		}
		setAttr("sbwId", sbwId);
		setAttr("jpn", jpn);
		setAttr("openid", openid);
		setAttr("sbw", sbw);
		setAttr("pi", pi);
		render("/Bargain-activities/Bargain-Order.html");
	}

	/**
	 * 活动规则
	 */
	public void activityRule() {
		// 参加的经销商活动的ID
		String sbId = getPara("sbId");
		ShareBargain sb = ShareBargain.dao.findById(sbId);
		// 公众号
		String jpn = getPara("jpn");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(jpn);
		setAttr("sellerPublicNumber", spn);
		setAttr("shareBargain", sb);
		render("/Bargain-activities/Bargain-rules.html");

	}

	/**
	 * 返回微信支付所需参数
	 */
	public void wxPay() {
		String sbwId = getPara("sbwId");
		ShareBargainWxuser sbw = ShareBargainWxuser.dao.findById(sbwId);
		String state = "";
		Map<String, String> map = new HashMap<String, String>();
		String jpn = getPara("jpn");// 公众号
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(jpn);
		String openid = getPara("oid");// openid
		Random r = new Random(1000);
		String out_trade_no = "share" + (r.nextInt() * 100) + newDateByYMD();
		String mchId = spn.getShopNumber();
		// 判断支付的金额，是否等于0元，0元可不用支付
		boolean payState = true;
		if (sbw.getNowPrice().equals("0.0")) {
			payState = false;
		} else if (sbw.getNowPrice().equals("0")) {
			payState = false;
		} else if (sbw.getNowPrice().equals("0.00")) {
			payState = false;
		}
		if (payState) {
			// 判断是否已经支付
			if (sbw.getPayMoney().equals("0")) {
				map = WxConfigUitils.getWxConfigUitils().wxPay(openid, spn.getAppId(), spn.getPayKey(), mchId,
						sbw.getNowPrice(), getRequest().getRemoteAddr(), out_trade_no);
				boolean result = new ShareBargainWxuser().set("ID", sbwId).set("PAY_ORDER", out_trade_no)
						.set("MCH_ID", mchId).update();
				if (result) {
					state = "true";
				}
			}
		} else {
			// 修改状态为支付
			boolean result = new ShareBargainWxuser().set("ID", sbwId).set("PAY_ORDER", out_trade_no)
					.set("MCH_ID", mchId).set("PAY_MONEY", sbw.getNowPrice()).set("STATE", "6").update();
			if (result) {
				state = "0";
			}
		}
		map.put("result", state);
		renderJson(map);
	}

	/**
	 * 查询分享砍价订单
	 */
	public void bargainOrder() {
		// 活动ID
		String sbwId = getPara("sbwId");
		List<ShareBargainWxuser> sbwList = ShareBargainWxuserService.getService().getSbwById(sbwId);
		ShareBargainWxuser sbw = new ShareBargainWxuser();
		for (ShareBargainWxuser sbwErgodic : sbwList) {
			sbw = sbwErgodic;
		}
		ShareBargainPrize sbp = ShareBargainPrize.dao.findById(sbw.getshareBargainPrizeId());
		List<ProductInfo> piList = ProductInfoService.getService().getProductInfoById(sbp.getProductId());
		// 产品信息
		ProductInfo pi = new ProductInfo();
		for (ProductInfo piErgodic : piList) {
			pi = piErgodic;
		}
		setAttr("pi", pi);
		setAttr("sbw", sbw);
		setAttr("sbp", sbp);
		render("/index/Order-details.html");
	}

	/**
	 * 生成min->max之间的数,最小生成的随机数为min，最大生成的随机数为max
	 * 
	 * @param min
	 * @param max
	 * @return
	 */
	public static int getRandomNum(int min, int max) {
		Random rdm = new Random();
		return rdm.nextInt(max - min + 1) + min;
	}


}