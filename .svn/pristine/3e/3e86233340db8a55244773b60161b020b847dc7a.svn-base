package com.activity.common.service.robRed;

import java.util.List;
import com.activity.common.model.robRed.RedWinningInfo;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;

/**
 * 抢红包奖品信息
 * @author 唐
 *
 */
public class RedWinningInfoService {
	private static RedWinningInfoService redWinningInfoService = new RedWinningInfoService();
	private RedWinningInfoService() {
	}
	public static RedWinningInfoService getService() {
		return redWinningInfoService;
	}
	
	/**
	 * 根据活动ID和OPenid和类型查询用户参与记录
	 * @param ActivityId
	 * @param Openid
	 * @param type
	 * @return
	 */
	public RedWinningInfo getRedWinningInfoByActivityIdAndOpenid(String ActivityId,String Openid,String type,String activityWxuserId){
		String sql = PropKit.use("database.properties").get("getRedWinningInfoByActivityIdAndOpenid");
		List<RedWinningInfo> rwiList = RedWinningInfo.dao.find(sql,ActivityId,Openid,type,activityWxuserId);
		RedWinningInfo in = null;
		for(RedWinningInfo rwiBL : rwiList){
			in = rwiBL;
		}
		return in;
	}
	
	/**
	 * 保存红包中奖记录
	 */
	public int saveRedInfo(RedWinningInfo info){
		String sql = PropKit.use("database.properties").get("saveRedInfo");
		return Db.update(sql,info.getId(),info.getBelongActivityId(),info.getActivityName(),info.getActivityNameType(),info.getWinningRedTotal()
				,info.getCreateTime(),info.getState(),info.getStartTime(),info.getEndTime(),info.getWithdrawals(),info.getOpenid(),info.getActivityWxUserId(),info.getBelongPublicnumberId());
	}
	
	/**
	 * 修改红包中奖记录状态和金额
	 */
	public int updateRedInfo(String state,String money ,String activityName,String id){
		String sql = PropKit.use("database.properties").get("updateRedInfo");
		return Db.update(sql,money,state,activityName,id);
	}
	
	/**
	 * 修改红包中奖记录状态
	 */
	public int updateRedInfoByState(String state ,String id){
		String sql = PropKit.use("database.properties").get("updateRedInfoByState");
		return Db.update(sql,state,id);
	}
	
	/**
	 * 根据openid和公众号ID查询记录
	 */
	public List<RedWinningInfo> queryRedInfoByPublicNumberAndOpenid(String publicNumber ,String openid){
		String sql = PropKit.use("database.properties").get("queryRedInfoByPublicNumberAndOpenid");
		return RedWinningInfo.dao.find(sql,publicNumber,openid);
	}
	
	/**
	 * 修改红包中奖记录已经提现
	 */
	public int updateRedInfoByWithdrawals(String withdrawals ,String state,String openid,String belongPublicnumberId){
		String sql = PropKit.use("database.properties").get("updateRedInfoByWithdrawals");
		return Db.update(sql,withdrawals,state,openid,belongPublicnumberId);
	}
	
}
