package com.web.config;

import com.jfinal.template.Engine;

public class SystemConfig extends BaseConfig {

	@Override
	public void configEngine(Engine me) {

	}

	// 在系统停止时调用的方法
	public void beforeJFinalStop() {
		System.out.println("******beforeJFinalStop*********");
	};

	// 在系统启动时调用的方法
	@Override
	public void afterJFinalStart() {
		System.out.println("********************************");
		System.out.println("***********十个活动启动|***********");
		System.out.println("********************************");
	}

}
