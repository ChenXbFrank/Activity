package com.activity.common.utils.http;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpRequest {
	/**
	 * get请求 无参
	 * 
	 * @param url
	 * @return
	 */
	public String HTTPGet(String url) {
		String value = null;
		try {
			URL urlGet = new URL(url);
			HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
			http.setRequestMethod("GET"); // 必须是get方式请求
			http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			http.setDoOutput(true);
			http.setDoInput(true);
			System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
			System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒
			http.connect();
			InputStream is = http.getInputStream();
			int size = is.available();
			byte[] jsonBytes = new byte[size];
			is.read(jsonBytes);
			value = new String(jsonBytes, "UTF-8");
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
}
