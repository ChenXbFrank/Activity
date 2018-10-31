package com.activity.common.controller.moblie.turntable;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.turntable.TurnTable;
import com.activity.common.model.turntable.TurnTableWxUser;
import com.activity.common.model.turntable.TurnTableWxUserWinning;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.WxService;
import com.activity.common.service.turntable.TurntableService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 转盘抽奖
 * 
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/turntable")
public class TurntableController extends BaseController {
	private static TurntableService turntableService = new TurntableService();
	WxService wxService = WxService.getService();
	DateUitils uitils = DateUitils.getUitils();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IndexService indexService = IndexService.getService();
	IntegralService integralService = IntegralService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	
	/**
	 * 进入转盘活动
	 */
	public void turntable() {
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				// 公众号ID
				String spnId = getPara("spn");
				// 活动ID
				String activity = getPara("Activity");
				// 所扫二维码
				String qrcode = getPara("qrcode");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(spnId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),
						sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getOpenid(sellerPublicNumber);
				map.putAll(turntableService.turntableInto(qrcode, activity, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()), openid, sellerPublicNumber));
				ApiConfigKit.removeThreadLocalAppId();
				if(map.get("rest").toString().equals("true")){
					TurnTableWxUser turnTableWxUser = (TurnTableWxUser) map.get("turnTableWxUser");
					WxUserInfo wxuser = (WxUserInfo) map.get("wxUserInfo");
					TurnTable turnTable = (TurnTable) map.get("turnTable");
					setAttr("follow", map.get("follow"));
					setAttr("scanWinningNumber", turnTableWxUser.getScanWinningNumber());
					setAttr("qrcode", qrcode);
					setAttr("turnTable", turnTable);
					setAttr("openid", openid);
					setAttr("wxUserInfo", wxuser);
					setAttr("turnTablePrizeList",map.get("turnTablePrizeList"));
					setAttr("turnTableWxUser", turnTableWxUser);
					setAttr("sellerPublicNumber", sellerPublicNumber);
					return true;
				}else{
					return false;
				}
			}
		});
		if(map.get("url").equals("404")){
			renderError(404);
		}else{
			render(map.get("url").toString());
		}
		
	}

	/**
	 * 转盘抽奖
	 */
	public void turntableLuckDraw() {
		String openid = getPara("openid");
		// 所参加活动ID
		String turntableId = getPara("activityId");
		// 公众号ID
		String SPNId = getPara("SPNId");
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(SPNId);
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		String accessToken = getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		String turnTablewxUserId = getPara("turnTablewxUserId");
		Map<String, Object> map = new HashMap<String, Object>();
		map=turntableService.productWinning(turntableId, openid, turnTablewxUserId, sellerPublicNumber, accessToken);
		renderJson(map);
	}

	/**
	 * 转盘抽奖-我的奖品-本次扫码最多中奖三次的数据
	 */
	public void myTurntablePrize() {
		String openid = getPara("openid");
		String SPNId = getPara("SPNId");
		String appId = getPara("AppId");
		String turnTablewxUserId = getPara("turnTablewxUserId");
		List<TurnTableWxUserWinning> ttwwList = turntableService
				.queryTurnTableWxUserWinningByOpenidAndTurnTableWxUserId(openid, turnTablewxUserId);
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(SPNId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),
				sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		WxConfigUitils wx = WxConfigUitils.getWxConfigUitils();
		// 根据openid获取用户信息
		WxUserInfo wxUserInfo = wx.getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		// 默认该用户未关注
		String follow = "0";
		if (wxUserInfo.getSubscribe().equals("1")) {
			follow = wxUserInfo.getSubscribe();
		}
		TurnTableWxUser turnTableWxUser = TurnTableWxUser.dao.findById(turnTablewxUserId);
		String turntableId = turnTableWxUser.getTurntableId();
		TurnTable turnTable = TurnTable.dao.findById(turntableId);
		setAttr("turnTable", turnTable);
		setAttr("follow", follow);
		setAttr("appId", appId);
		setAttr("SPNId", SPNId);
		setAttr("sellerPublicNumber", sellerPublicNumber);
		setAttr("openid", openid);
		setAttr("ttwwList", ttwwList);
		String turnTablewWinningId=null;
		if(ttwwList.size()!=0){
			turnTablewWinningId = ttwwList.get(0).getTurntableWxuserWinningId();
		}
		setAttr("turnTablewWinningId", turnTablewWinningId);
		setAttr("turnTablewxUserId", turnTablewxUserId);
		render("/turntable/my-price.html");
	}

	/**
	 * 转盘抽奖-我的奖品-填写奖品收货地址等信息
	 */
	public void turntablePrizeAddress() {
		String turnTablewWinningId = getPara("turnTablewWinningId");
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		TurnTableWxUserWinning turnTablewWinning = TurnTableWxUserWinning.dao.findById(turnTablewWinningId);
		Boolean resutl = new TurnTableWxUserWinning().set("TURNTABLE_WXUSER_WINNING_ID", turnTablewWinningId)
				.set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address).set("ADDRESSEE_PHONE", tel)
				.set("STATE", "3").update();
		if (resutl) {
			resutl = new ProductWinningInfo().set("ID", turnTablewWinning.getProductWinningInfoId()).set("STATE", "3")
					.set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address).set("ADDRESSEE_PHONE", tel)
					.update();
		}
		String turntableWxuserId = turnTablewWinning.getTurntableWxuserId();
		if(!StringUtils.isEmpty(turntableWxuserId)){
			TurnTableWxUser tableWxUser = TurnTableWxUser.dao.findById(turntableWxuserId);
			String belongPublicNumberId = tableWxUser.getBelongPublicNumberId();
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),
					sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			String openid = turnTablewWinning.getOpenId();
			WxConfigUitils wx = WxConfigUitils.getWxConfigUitils();
			// 根据openid获取用户信息
			WxUserInfo wxuser = wx.getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
			ApiConfigKit.removeThreadLocalAppId();
			//保存或修改微信用户
			wxService.saveWxUser(wxuser,openid,sellerPublicNumber,newId());
			//修改记录中的微信名称和头像地址  这是修改转盘的
			String sqlTA = PropKit.use("database.properties").get("updateTurnTableNameByOpenid");
			Db.update(sqlTA,wxuser.getNickname(),wxuser.getHeadimgurl(),openid);
		}
		renderJson(resutl);
	}
}
