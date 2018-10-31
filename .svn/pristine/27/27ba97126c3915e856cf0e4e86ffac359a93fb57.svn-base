/**
 *
 */
package com.activity.common.service.system;

import java.util.List;

import com.activity.common.model.shareBargain.ShareBargain;
import com.jfinal.kit.PropKit;

/**
 * @author ChenXb
 *
 *         2017年8月18日
 */
public class ActivityApproveService {
	private static ActivityApproveService activityApproveService = new ActivityApproveService();

	private ActivityApproveService() {

	}

	/**
	 * 懒汉式 就是申明的时候不new 在下边的时候判断是否为空的时候 才new出来 这样线程不安全
	 * 
	 * @return
	 */
	public static ActivityApproveService getService() {
		return activityApproveService;
	}

	/**
	 * 查询分享砍价活动状态为0的活动
	 */
	public List<ShareBargain> getShareActivityStateO() {
		String sql = PropKit.use("database.properties").get("getShareActivityStateO");
		return ShareBargain.dao.find(sql);
	}

}
