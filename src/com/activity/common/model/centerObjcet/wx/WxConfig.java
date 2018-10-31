package com.activity.common.model.centerObjcet.wx;

/**
 * 微信基础参数对象
 */
public class WxConfig {
	public String token;
	public String appId;
	public String appSecret;

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getAppSecret() {
		return appSecret;
	}

	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}
}
