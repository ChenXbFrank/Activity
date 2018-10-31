package com.activity.common.utils.wxInterface;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import com.activity.common.model.accessToken.TbAccessToken;
import com.activity.common.model.centerObjcet.wx.AccessToken;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.http.HttpUtils;
import com.google.gson.Gson;

/**
 * @author ChenXb
 *
 *         2018年8月11日
 */
public class AccessTokenUtils {
	
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	
	public static String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

	public static String getAccessToken(String APPID, String APPSECRET) {
		url = url.replaceAll("APPID", APPID).replaceAll("APPSECRET", APPSECRET);
		URL Url = null;
		try {
			Url = new URL(url);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		String json = HttpUtils.get(Url);
		Gson gson = new Gson();
		AccessToken accessToken = gson.fromJson(json, AccessToken.class);
		String access_token = accessToken.getAccess_token();
		return access_token;
	}
	
	/**
	 * 循环获取accessToken值 每个小时更新一次吧
	 */
	public void getAccessTokenByPublicNumberList(){
		//查询所有的公众号信息
		String sql="select * from TB_SELLER_PUBLICNUMBER";
		List<SellerPublicNumber> list = SellerPublicNumber.dao.find(sql);
		
		for (SellerPublicNumber sellerPublicNumber : list) {
			//这是重新获取新的Token了
			String accessToken = getAccessToken(sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
			String appId = sellerPublicNumber.getAppId();
			//这里根据appid进行更新，修改
			//先查询该appid是否已经有值了，有值了则更新，否则保存
			TbAccessToken tbAccessToken = TbAccessToken.dao.findById(appId);
			if(tbAccessToken==null){
				new TbAccessToken().set("APPID", appId)
								   .set("ACCESS_TOKEN",accessToken)
								   .set("SAVE_TIME", uitils.newDate())
								   .set("SELLER_PUBLIC_NAME", sellerPublicNumber.getPublicNumberName())
								   .save();
			}else{
				tbAccessToken.set("APPID", appId)
						   	 .set("ACCESS_TOKEN",accessToken)
						     .set("SAVE_TIME", uitils.newDate())
						     .set("SELLER_PUBLIC_NAME", sellerPublicNumber.getPublicNumberName())
						     .update();
			}
		}
	}
	
	/**
	 * 根据appid查询出accessToken
	 */
	public static String getTokenByAppId(String appId){
		String sql="select * from TB_ACCESS_TOKEN where appid = ? ";
		return TbAccessToken.dao.findFirst(sql,appId).getAccessToken();
	}
}
