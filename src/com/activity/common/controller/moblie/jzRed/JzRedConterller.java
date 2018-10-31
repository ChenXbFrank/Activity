package com.activity.common.controller.moblie.jzRed;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.jzRed.JzRed;
import com.activity.common.model.jzRed.JzRedWxUserWining;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.service.jzRed.JzRedService;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;
/**
 * 尖庄抢红包定制活动
 * 
 * @author 唐
 */
@ControllerPath(controllerKey = "/jzRed")
public class JzRedConterller extends BaseController {
	private final Logger log = LoggerFactory.getLogger(JzRedConterller.class);
	
	JzRedService jzRedService = JzRedService.getService();
	
	/**
	 * 进入尖庄抢红包活动
	 */
	public void index() {
		log.error("尖庄抢红包定制活动进入活动Openid");
		String activityId = getPara("activityId");
		String qrcode = getPara("qrcode");
		String sellerPublicNumberId = getPara("sellerPublicNumberId");
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				// TODO Auto-generated method stub
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getOpenid(sellerPublicNumber);
				map.putAll(jzRedService.robRed(sellerPublicNumber, qrcode, openid, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()), activityId));
				ApiConfigKit.removeThreadLocalAppId();
				if(map.get("rest").toString().equals("true")){
					return true;
				}else{
					return false;
				}
			}
		});
		if(map.get("url").toString().equals("0")){
			JzRed jzRed = (JzRed) map.get("jzRed");
			SellerPublicNumber sellerPublicNumber = (SellerPublicNumber)map.get("sellerPublicNumber");
			WxUserInfo wxuser = (WxUserInfo) map.get("wxUserInfo");
			setAttr("scanWinningNumber", map.get("scanWinningNumber"));
			System.out.println("******==========="+map.get("scanWinningNumber"));
			setAttr("qrcode", map.get("qrcode"));
			setAttr("jzRed", jzRed);
			setAttr("openid", map.get("openid"));
			setAttr("mch_billno", map.get("mch_billno"));
			setAttr("jzwxuserid", map.get("jzwxuserid"));
			setAttr("sellerPublicNumber", sellerPublicNumber);
			setAttr("wxUserInfo", wxuser);
			render("/jzRed/jzRed-homepage.html");
		}else{
			render("/index/QRCodeInvalid.html");
		}
	}
	
	/**
	 * 立即抢红包
	 */
	public void nowJzRed(){
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String activityId = getPara("jzredActivityId");
				String sellerPublicNumberId = getPara("SPNId");
				String openid = getPara("openid");
				String jzwxuserid = getPara("jzwxuserid");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(getPara("SPNId"));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				map.putAll(jzRedService.nowJzRed(activityId, sellerPublicNumberId, openid, jzwxuserid, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret())));
				ApiConfigKit.removeThreadLocalAppId();
				if(map.get("rest").toString().equals("true")){
					return true;
				}else{
					return false;
				}
		   }
		});
		renderJson(map);
	}
	
	/**
	 * 进入零钱罐中
	 * 展示本次扫码所中奖品
	 */
	public void intoSmallChange(){
		String openid = getPara("openid");
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(getPara("SPNId"));
		String redId = getPara("redId");
		String follow = getPara("follow");
		//微信用户参与记录ID
		String jzWxUserId = getPara("jzWxUserId");
		//查询当前用参与记录的中奖
		List<JzRedWxUserWining> jzRedWxUserWiningList = jzRedService.queryJzRedWxUserWiningByWxUserId(jzWxUserId);
		JzRed jzRed = JzRed.dao.findById(redId);
		setAttr("jzRed", jzRed);
		setAttr("sellerPublicNumberId", sellerPublicNumber.getId());
		setAttr("sellerPublicNumber", sellerPublicNumber);
		setAttr("openid", openid);
		setAttr("follow", follow);
		setAttr("jzRedWxUserWiningList", jzRedWxUserWiningList);
		render("/jzRed/jzRed-record.html");
	}
}
