/**
 *
 */
package com.activity.common.controller.pc.system;

import java.util.HashMap;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.service.system.LogService;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.kit.PropKit;
import com.web.controller.ControllerPath;

/**
 * 日志控制器
 * 
 * @author ChenXb
 *
 *         2017年8月26日
 */
@ControllerPath(controllerKey = "/log")
public class LogController extends BaseController {
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	LogService logService = LogService.getService();

	/**
	 * 所有的日志
	 */
	public void index() {
		render("/system/operation-log.html");
	}

	/**
	 * 查询所有的日志 分页显示
	 */
	public void getLogPageInfos() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String userId = getPara("userId");
		String startTime = getPara("startTime");
		String endTime = getPara("endTime");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = LogService.getService().paginate(Integer.parseInt(currentPage), page,userId,startTime,endTime);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}


}
