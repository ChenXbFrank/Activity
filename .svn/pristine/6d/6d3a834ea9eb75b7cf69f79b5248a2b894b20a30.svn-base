package com.web.config;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model._MappingKit;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.BslPlugin;
import com.jfinal.i18n.I18nInterceptor;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.jfinal.weixin.sdk.jfinal.ApiController;
import com.jfinal.weixin.sdk.jfinal.MsgController;
import com.web.Interceptor.BaseInterceptor;
import com.web.Interceptor.LoginInterceptor;
import com.web.controller.AutoBindRoutes;

/**
 * API引导式配置
 */
public abstract class BaseConfig extends JFinalConfig {

	/**
	 * 配置常量
	 */
	@Override
	public void configConstant(Constants me) {
		/*
		 * //设置APP图片上传路径，读取配置文件配置的路径
		 * me.setBaseUploadPath(PropKit.use("system.properties").get(
		 * "baseUploadPath")); me.setMaxPostSize(512000000);
		 */
		// 加载少量必要配置，随后可用PropKit.get(...)获取值
		PropKit.use("system.properties");
		PropKit.use("task.properties");
		me.setDevMode(PropKit.getBoolean("devMode", false));
		// ApiConfigKit 设为开发模式可以在开发阶段输出请求交互的 xml 与 json 数据
		ApiConfigKit.setDevMode(me.getDevMode());
		//修改默认的上传下载文件路径
		me.setBaseUploadPath(PropKit.get("uploadFilePath"));
		// 配置公众号对象
		// ApiConfigKit.putApiConfig(getApiConfig());
		// 设置异常抛出页面
		me.setError404View("/error/404.html");
		me.setError500View("/error/500.html");
	}

	/**
	 * 配置路由
	 */
	@Override
	public void configRoute(Routes me) {
		AutoBindRoutes autoBindRoutes = new AutoBindRoutes();
		autoBindRoutes.addExcludeClass(ApiController.class);
		autoBindRoutes.addExcludeClass(MsgController.class);
		autoBindRoutes.addExcludeClass(BaseController.class);
		me.add(autoBindRoutes);
	}

	public static DruidPlugin createDruidPlugin() {
		return new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim());
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		C3p0Plugin cp = new C3p0Plugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim());
		// 配置Oracle驱动
		cp.setDriverClass("oracle.jdbc.driver.OracleDriver");
		me.add(cp);
		ActiveRecordPlugin arp = new ActiveRecordPlugin(cp);
		arp.setShowSql(true);
		arp.setTransactionLevel(Integer.parseInt(PropKit.get("level")));
		// static int TRANSACTION_NONE = 0; //JDBC驱动不支持事务
		// static int TRANSACTION_READ_UNCOMMITTED = 1; //允许脏读、不可重复读和幻读。
		// static int TRANSACTION_READ_COMMITTED = 2; //禁止脏读，但允许不可重复读和幻读。
		// static int TRANSACTION_REPEATABLE_READ = 4; //禁止脏读和不可重复读，单运行幻读。
		// static int TRANSACTION_SERIALIZABLE = 8; //禁止脏读、不可重复读和幻读。
		me.add(arp);
		// 配置Oracle方言
		arp.setDialect(new OracleDialect());
		// 配置属性名(字段名)大小写不敏感容器工厂
		arp.setContainerFactory(new CaseInsensitiveContainerFactory());
		// 所有配置在 MappingKit 中搞定
		_MappingKit.mapping(arp);
		// 缓存配置
		EhCachePlugin ecp = new EhCachePlugin();
		me.add(ecp);
		// 配置Bsl引擎模版视图
		me.add(new BslPlugin(PropKit.get("viewPath")));

		//配置定时器
		me.add(new Cron4jPlugin(PropKit.use("task.properties")));
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		me.add(new BaseInterceptor());
		me.add(new LoginInterceptor());
		me.add(new I18nInterceptor());
	}

	/**
	 * Template Engine 模板引擎
	 */
	// public void configEngine(Engine me){
	// me.addSharedFunction("/index/index.html");
	// }

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		
		
	}

	/**
	 * 获取配置
	 */
	// public static ApiConfig getApiConfig() {
	// ApiConfig ac = new ApiConfig();
	//
	// // 配置微信 API 相关常量
	// ac.setToken("qbtest");
	// ac.setAppId("wx3db6ea684d097397");
	// ac.setAppSecret("cefef93ff906edaecb135e17dab1d878");
	//
	// /**
	// * 是否对消息进行加密，对应于微信平台的消息加解密方式：
	// * 1：true进行加密且必须配置 encodingAesKey
	// * 2：false采用明文模式，同时也支持混合模式
	// */
	// ac.setEncryptMessage(PropKit.getBoolean("encryptMessage", false));
	// ac.setEncodingAesKey(PropKit.get("encodingAesKey", "setting it in config
	// file"));
	// return ac;
	// }
}
