package com.activity.common.controller.moblie.base;

import java.util.Map;

import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/** 扫一扫
 * @author ChenXb
 *
 * 2018年3月9日
 */
@ControllerPath(controllerKey = "/scan")
public class ScanController extends BaseController{
	
	public void index(){
		String appid = getPara("appid");
		String sql="select * from TB_SELLER_PUBLICNUMBER where appid = ? ";
		SellerPublicNumber sellerPublicNumber=SellerPublicNumber.dao.findFirst(sql,appid);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
		render("/index/scan.html");
	}
	
	/**
	 * 百度地图
	 * address
	 * @author 81046
	 * @date 2018年6月8日下午6:08:02
	 */
	public void address(){
		render("/index/address.html");
	}
	
	/**
	 * 高德地图
	 * address
	 * @author 81046
	 * @date 2018年6月8日下午6:08:02
	 */
	public void gaodeMap(){
		render("/index/gaode.html");
	}
	
	
	/**
	 * 公众号菜单的扫一扫
	 * */
	public void scanElement() {
		String href = getPara("href"); 
		Map<String, String> wxConfigApi = WxConfigUitils.getWxConfigUitils().WxConfigApi(href);
		renderJson(wxConfigApi);
	}
	
	
}
