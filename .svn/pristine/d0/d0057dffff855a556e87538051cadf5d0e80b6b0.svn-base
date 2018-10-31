package com.activity.common.service.robRed;

import java.util.List;

import com.activity.common.model.robRed.RobRedWxUserWining;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;

/**
 * 抢红包微信用户中奖记录
 * 
 * @author 唐
 *
 */
public class RobRedWxUserWiningService {
	private static RobRedWxUserWiningService robRedWxUserWiningService = new RobRedWxUserWiningService();

	private RobRedWxUserWiningService() {
	}

	public static RobRedWxUserWiningService getService() {
		return robRedWxUserWiningService;
	}

	/**
	 * 保存一个微信用户中奖记录
	 */
	public int saveRobRedWxUserWining(String id, String redWxUserId, String redPrizeId, String prizeProjectMoney,
			String prizeProject, String date, String openid) {
		// 保存中奖记录
		String saveSql = PropKit.use("database.properties").get("saveRobRedWxUserWining");
		return Db.update(saveSql, id, redWxUserId, redPrizeId, prizeProjectMoney, prizeProject, date, openid);
	}

	/**
	 * 根据微信参与记录ID ，查询出该记录的所有奖品
	 * 
	 * @param id
	 * @return
	 */
	public List<RobRedWxUserWining> queryRobRedWxUserWiningByWxUserId(String id) {
		// 保存中奖记录
		String sql = PropKit.use("database.properties").get("queryRobRedWxUserWiningByWxUserId");
		return RobRedWxUserWining.dao.find(sql, id);
	}

}
