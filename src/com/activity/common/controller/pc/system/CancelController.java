package com.activity.common.controller.pc.system;

import com.activity.common.controller.moblie.base.BaseController;
import com.web.controller.ControllerPath;

/**
 * 核销控制器
 * 
 * @author ChenXb
 *
 *         2018年5月30日
 */
@ControllerPath(controllerKey = "/cancel")
public class CancelController extends BaseController {

	/**
	 * 核销模块
	 */
	public void index() {
		render("/system/cancel.html");
	}


}
