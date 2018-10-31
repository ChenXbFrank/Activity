package com.activity.common.service.system;

import java.util.List;

import com.activity.common.model.activity.Activity;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.ehcache.CacheKit;

/**
 * 可申请活动
 * 
 * @author 唐
 *
 */
public class ActivityService {

	private static ActivityService activityService = new ActivityService();

	private ActivityService() {

	}

	/**
	 * 懒汉式 就是申明的时候不new 在下边的时候判断是否为空的时候 才new出来 这样线程不安全
	 * 
	 * @return
	 */
	public static ActivityService getService() {
		return activityService;
	}

	/**
	 * 获取全部活动
	 * 
	 * @return List<Activity>
	 */
	public List<Activity> getAllActivity() {
		List<Activity> activityList = CacheKit.get("activity", "activityList");
		if (activityList == null) {
			String sql = PropKit.use("database.properties").get("getAllActivity");
			activityList = Activity.dao.find(sql);
			CacheKit.put("activity", "activityList", activityList);
		}
		return activityList;
	}

	/**
	 * 根据remake 查询活动
	 */
	public Activity getActivityByRemarks(String remarks) {
		String sql = PropKit.use("database.properties").get("getActivityByRemarks");
		return Activity.dao.findFirst(sql, remarks);
	}
	
}
