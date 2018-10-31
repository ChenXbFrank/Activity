package com.activity.common.controller.moblie.breakEgg;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.breakEgg.BreakEgg;
import com.activity.common.model.breakEgg.BreakEggWxUser;
import com.activity.common.model.breakEgg.BreakEggWxUserWinning;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.breakEgg.BreakEggService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.probability.ProbabilityUtils;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.ICallback;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 砸蛋移动端
 * 
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/breakEgg")
public class BreakEggController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(BreakEggController.class);
	private static BreakEggService breakEggService = new BreakEggService();
	IndexService indexService = IndexService.getService();
	WxService wxService = WxService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ProbabilityUtils probabilityUtils = ProbabilityUtils.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IntegralService integralService = IntegralService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();

	/**
	 * 进入砸蛋活动
	 */
	public void breakEgg() {
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				// 公众号ID
				String sellerPublicNumberId = getPara("sellerPublicNumber");
				// 活动ID
				String activityId = getPara("Activity");
				// 所扫二维码
				String qrcode = getPara("qrcode");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),
						sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getOpenid(sellerPublicNumber);
				map.putAll(breakEggService.breakEgg(sellerPublicNumber, qrcode, openid, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()), activityId));
				ApiConfigKit.removeThreadLocalAppId();
				log.error("---砸蛋活动---"+activityId+"---Openid---"+openid+"---公众号---"+sellerPublicNumber.getId());
				if(map.get("rest").toString().equals("true")){
					return true;
				}else{
					return false;
				}
			}
		});
		if(map.get("resule").toString().equals("3")){
			BreakEgg breakEgg = (BreakEgg) map.get("breakEgg");
			SellerPublicNumber sellerPublicNumber = (SellerPublicNumber)map.get("sellerPublicNumber");
			String breakEggWxUserId = (String) map.get("breakEggWxUserId");
			BreakEggWxUser breakEggWxUser = BreakEggWxUser.dao.findById(breakEggWxUserId);
			setAttr("sellerPublicNumber",sellerPublicNumber);
			setAttr("breakEggWxUser", breakEggWxUser);
			setAttr("breakEgg", breakEgg);
			setAttr("openid",map.get("openid"));
			setAttr("wxUserInfo",map.get("wxUserInfo"));
			setAttr("breakEggWxUserId",map.get("breakEggWxUserId"));
			setAttr("canClick",map.get("canClick"));
			setAttr("follow",map.get("follow"));
		}
		if(map.get("url").equals("404")){
			renderError(404);
		}else{
			render(map.get("url").toString());
		}
	}

	/**
	 * 点击砸蛋 生成奖品
	 */
	public void breakLuckDraw() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 所参加活动ID
		String breakEggId = getPara("breakEggId");
		// 公众号ID
		String sellerPublicNumberId = getPara("sellerPublicNumberId");
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		String openid = getPara("openid");
		String breakEggWxUserId = getPara("breakEggWxUserId");
		map.putAll(breakEggService.breakEggLuckDraw(breakEggWxUserId, breakEggId, openid, sellerPublicNumberId, sellerPublicNumber, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret())));
		renderJson(map);
	}

	/**
	 * 砸蛋中奖-我的奖品
	 */
	public void myBreakEggPrize() {
		String openid = getPara("openid");
		String breakEggWxUserId = getPara("breakEggWxUserId");
		BreakEggWxUserWinning breakEggWxUserWinning = breakEggService
				.queryBreakEggWxUserWinningByOpenidAndBreakEggWxUserId(openid, breakEggWxUserId);
		Map<String, Object> map = new HashMap<>();
		map.put("breakEggWxUserWinning", breakEggWxUserWinning);
		renderJson(map);
	}

	/**
	 * 砸蛋-我的奖品-填写奖品收货地址等信息
	 */
	public void address() {
		String breakEggWinningId = getPara("breakEggWinningId");
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		BreakEggWxUserWinning breakEggWxUserWinning = BreakEggWxUserWinning.dao.findById(breakEggWinningId);
		Boolean result = new BreakEggWxUserWinning().set("ID", breakEggWinningId).set("ADDRESSEE_NAME", addresseeName)
				.set("ADDRESSEE_ADDRESS", address).set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
		if (result) {
			result = new ProductWinningInfo().set("ID", breakEggWxUserWinning.getProductWinningInfoId())
					.set("STATE", "3").set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).update();
		}
		String openid = breakEggWxUserWinning.getOpenId();
		if (openid != null) {
			String breakeggWxuserId = breakEggWxUserWinning.getBREAKEGGWxuserId();
			BreakEggWxUser breakEggWxUser = BreakEggWxUser.dao.findById(breakeggWxuserId);
			String belongPublicNumberId = breakEggWxUser.getBelongPublicNumberId();
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			//补全用户信息
			WxUserInfo wxUserInfo = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
			//保存或修改微信用户
			wxService.saveWxUser(wxUserInfo,openid,sellerPublicNumber,newId());
			//修改记录中的微信名称和头像地址  这是修改砸蛋的
			String sqlBE = PropKit.use("database.properties").get("updateBreakEggNameByOpenid");
			Db.update(sqlBE,wxUserInfo.getNickname(),wxUserInfo.getHeadimgurl(),openid);
			ApiConfigKit.removeThreadLocalAppId();
		}
		renderJson(result);
	}
	
	/**
	 * 微信公众平台跳进来的链接 点击到个人中心的实物链接
	 */
	public void getGoods() {
		String appid = getPara("appid");
		String sql = "select * from TB_SELLER_PUBLICNUMBER where appid = ? ";
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findFirst(sql, appid);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),
				sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		String openid = getOpenid(sellerPublicNumber);
		setAttr("openid", openid);
		WxConfigUitils wx = WxConfigUitils.getWxConfigUitils();
		// 根据openid获取用户信息
		WxUserInfo wxuser = wx.getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		// 保存或修改微信用户
		wxService.saveWxUser(wxuser, openid, sellerPublicNumber, newId());
		setAttr("sellerPublicNumberId", sellerPublicNumber.getId());
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
		String sellerPublicNumberId = sellerPublicNumber.getId();
		// 活动名称
		String activeName = "";
		// 状态
		String state = "";
		List<ProductWinningInfo> productWinningInfoList = productWinningInfoService.queryProductWinningInfo(openid,
				sellerPublicNumberId, activeName, state);
		ApiConfigKit.removeThreadLocalAppId();
		setAttr("productWinningInfoList", productWinningInfoList);
		setAttr("BPN", sellerPublicNumberId);
		setAttr("openid", openid);
		setAttr("activeName", activeName);
		render("/index/standings.html");
	}

}
