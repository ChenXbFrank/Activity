/**
 *
 */
package com.activity.common.service.system;

import java.util.List;
import java.util.Map;

import com.activity.common.model.centerObjcet.SuperPage;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.utils.system.Tools;
import com.jfinal.kit.PropKit;

/**
 * @author ChenXb
 *
 *         2017年8月26日
 */

public class LogService {
	private static LogService logService = new LogService();

	private LogService() {
	}

	public static LogService getService() {
		return logService;
	}

	/**
	 * 查询当前登录人的日志
	 */
	public List<LogInfo> getLogByUserCode(String userCode) {
		String sql = PropKit.use("database.properties").get("getLogByUserCode");
		return LogInfo.dao.find(sql, userCode);
	}

	/**
	 * 超级管理员查询所有的日志
	 */
	public List<LogInfo> getAllLog() {
		String sql = PropKit.use("database.properties").get("getAllLog");
		return LogInfo.dao.find(sql);
	}

	/**
	 * 日志查询 操作员ID 和时间范围查询
	 */
	public List<LogInfo> getLogByCondition(String userId, String startTime, String endTime) {
		String neirong = "1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(userId)) {
			neirong += "and USE_USERCODE = " + " '" + userId + "' ";
		}
		if (!"".equals(startTime) && !"".equals(endTime)) {
			neirong += " and USE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		// 我记得下次模糊的时候 不用插入 用 拼接 是这样的
		String sql = "select * from LOG_INFO where " + neirong;
		return LogInfo.dao.find(sql);
	}

	/**
	 * 分页查询 查询所有的管理员的信息
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String userCode,String startTime,String endTime) {
		return (Map<String, Object>) LogInfo.dao.paginate(pageNumber, pageSize,userCode,startTime,endTime);
	}

	/**
	 * 获取扩展对象 注意使用面向对象的思想解决问题！！！
	 */
	public SuperPage<LogInfo> getAllLogPage() {
		List<LogInfo> logInfos = getAllLog();
		if (logInfos.size() > 0) {
			SuperPage<LogInfo> page = new SuperPage<LogInfo>();
			for (LogInfo a : logInfos) {
				page.getList().add(a);
			}
			page.setCurrentPage(1);
			page.setTotalPages(Tools.getSize(logInfos.size()));
			return page;
		} else {
			return null;
		}
	}

	/**
	 * 获取扩展对象 注意使用面向对象的思想解决问题！！！
	 */
	public SuperPage<LogInfo> getLogPage(String userId, String startTime, String endTime) {
		List<LogInfo> logInfos = getLogByCondition(userId, startTime, endTime);
		if (logInfos.size() > 0) {
			SuperPage<LogInfo> page = new SuperPage<LogInfo>();
			for (LogInfo a : logInfos) {
				page.getList().add(a);
			}
			page.setCurrentPage(1);
			page.setTotalPages(Tools.getSize(logInfos.size()));
			return page;
		} else {
			return null;
		}
	}
}
