package com.activity.common.controller.pc.system;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.system.SystemUser;
import com.activity.common.utils.date.DateUitils;
import com.web.controller.ControllerPath;

/**
 * 分享砍价活动配置
 * 
 * @author 唐
 */
@ControllerPath(controllerKey = "/system")
public class SystemController extends BaseController {
	// 工具类
	DateUitils uitils = DateUitils.getUitils();

	/**
	 * 系统管理主页
	 */
	public void index() {
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "访问-系统管理-主页")
				.set("USE_TIME", uitils.newDate()).save();
		render("/system/system-index.html");
	}

	/**
	 * 日志查询
	 */
	public void logInfo() {
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-查询日志")
				.set("USE_TIME", uitils.newDate()).save();
		render("/system/operation-log.html");
	}

	/**
	 * 产品中心
	 */
	public void productCenter() {
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-产品中心")
				.set("USE_TIME", uitils.newDate()).save();
		render("/system/product-center.html");
	}

	/**
	 * 公众号信息
	 */
	public void publicInfos() {
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "查询-公众号信息")
				.set("USE_TIME", uitils.newDate()).save();
		render("/system/public-infos.html");
	}

	/**
	 * 公众号设置
	 */
	public void publicSet() {
		SystemUser user = CacheLoginUser();
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "访问-公众号设置")
				.set("USE_TIME", uitils.newDate()).save();
		render("/public-set/publicSet.html");
	}

}
