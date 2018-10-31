package com.activity.common.controller.pc.customActivity;

import java.util.List;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.TbCustomActivity;
import com.activity.common.service.customActivity.CustomActivityService;
import com.web.controller.ControllerPath;

/**
 * 定制活动 pc
 * @author ChenXb
 *
 * 2018年6月19日
 */
@ControllerPath(controllerKey = "/customActivityConfig")
public class CustomActivityController extends BaseController{
	
	CustomActivityService customActivityService = CustomActivityService.getService();
	
	/**
	 * 申请查询所有的定制活动
	 */
	public void getActivity(){
		//查询定制活动
		List<TbCustomActivity> activityList = customActivityService.getCustomActivitise();
		setAttr("activityList", activityList);
		render("/customActivity/customActivity.html");
	}
	
	/**
	 * 查询所有的定制活动报表
	 */
	public void getAllActivityReport(){
		//查询定制活动
		List<TbCustomActivity> activityList = customActivityService.getCustomActivitise();
		setAttr("activityList", activityList);
		render("/customActivity/customActivity-report.html");
	}
	
	/**
	 * 查询所有的定制活动
	 */
	public void getAllActivity(){
		//查询定制活动
		List<TbCustomActivity> activityList = customActivityService.getCustomActivitise();
		setAttr("activityList", activityList);
		render("/customActivity/customActivity-activity.html");
	}
	
	
	/**
	 * 审批定制活动
	 */
	public void approveCustomActivity(){
		//查询定制活动
		List<TbCustomActivity> activityList = customActivityService.getCustomActivitise();
		setAttr("activityList", activityList);
		render("/customActivity/customActivity-approve.html");
	}
	
}
