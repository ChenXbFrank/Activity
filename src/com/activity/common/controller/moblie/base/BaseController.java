package com.activity.common.controller.moblie.base;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.system.SystemUser;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.ehcache.CacheKit;
import com.jfinal.weixin.sdk.api.AccessTokenApi;
import com.jfinal.weixin.sdk.api.SnsAccessToken;
import com.jfinal.weixin.sdk.api.SnsAccessTokenApi;


public class BaseController extends Controller {
	 private final static Logger log = LoggerFactory.getLogger(BaseController.class);
	// 工具类
	DateUitils uitils = DateUitils.getUitils();

	/**
	 * 获取openid和返回openid
	 */
	public synchronized String getOpenid(SellerPublicNumber spn) {
		//获取当前线程
		//Thread th=Thread.currentThread();
		String code = getPara("code");
		log.error("获取code**************code>"+code);
		String openid = (String) this.getSession().getAttribute(spn.getAppId());
		log.error("获取Session中的Openid="+openid+"公众号APPID="+spn.getAppId());
		if(openid == null || openid.equals("")){
			if (!StringUtils.isEmpty(code)) {
				log.error("*****************进来开始获取openID**********************");
				//将Code放入缓存 15秒内再次处理该code认为微信中转
				String wxCode = CacheKit.get("wxCode", code);
				log.error("访问时的code="+code+"缓存中是否存在="+wxCode);
				//是否存在当前记录
				if(!code.equals(wxCode)){
					CacheKit.put("wxCode", code, code);
					String appid = spn.getAppId();
					String appSecret = spn.getAppSecret();
					SnsAccessToken snsAccessToken = SnsAccessTokenApi.getSnsAccessToken(appid, appSecret, code);
					openid = snsAccessToken.getOpenid();
					getSession().setAttribute(appid, openid);
					if (StringUtils.isEmpty(openid)) {
						openid = getRequest().getRemoteAddr();
						getSession().setAttribute(appid, openid);
					}
				}else{
					renderError(404);
				}
			}else{
				renderError(404);
			}
		}
		// 判读openid是否包含英文字母。ip地址不包含英文字母
		if (openid.matches(".*[a-zA-z].*")) {
		} else {
			// 不包含英文字母
			getSession().setAttribute(spn.getAppId(), "");
		}
		return openid;
	}

	/**
	 * 获取AccessToken对象中的accessToken
	 */
	public String getAccessToken(String appId,String appScript) {
		String accessToken = AccessTokenApi.getAccessToken().getAccessToken();
		return accessToken;
	}
	
	/**
	 * 获取当前登陆人
	 */
	public SystemUser CacheLoginUser() {
		// 获取session的对象
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		return user;
	}

	/**
	 * 生成ID 当前毫秒数
	 * 
	 * @param args
	 */
	public static String newId() {
		return UUID.randomUUID().toString().replaceAll("-", "") + newDateByYMD();
	}

	/**
	 * 新建时间并格式转换 年月日
	 */
	public static String newDateByYMD() {
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyyMMddHHmmss");
		return time.format(date);
	}

}
