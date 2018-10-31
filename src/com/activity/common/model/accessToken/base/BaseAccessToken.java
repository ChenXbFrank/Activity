package com.activity.common.model.accessToken.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * accesstoken
 * @author ChenXb
 *
 * 2018年8月13日
 */
@SuppressWarnings("serial")
public class BaseAccessToken<M extends BaseAccessToken<M>> extends Model<M> implements IBean {
	
	/**
	 * ACCESS_TOKEN
	 */
	public void setAccessToken(java.lang.String ACCESS_TOKEN) {
		set("ACCESS_TOKEN", ACCESS_TOKEN);
	}

	public java.lang.String getAccessToken() {
		return get("ACCESS_TOKEN");
	}

	/**
	 * APPID
	 */
	public void setAppId(java.lang.String APPID) {
		set("APPID", APPID);
	}

	public java.lang.String getAppId() {
		return get("APPID");
	}

	/**
	 * SAVE_TIME
	 */
	public void setSaveTime(java.lang.String SAVE_TIME) {
		set("SAVE_TIME", SAVE_TIME);
	}

	public java.lang.String SaveTime() {
		return get("SAVE_TIME");
	}
	
	/**
	 * SELLER_PUBLIC_NAME
	 */
	public void setSellerPublicName(java.lang.String SELLER_PUBLIC_NAME) {
		set("SELLER_PUBLIC_NAME", SELLER_PUBLIC_NAME);
	}

	public java.lang.String getSellerPublicName() {
		return get("SELLER_PUBLIC_NAME");
	}


}
