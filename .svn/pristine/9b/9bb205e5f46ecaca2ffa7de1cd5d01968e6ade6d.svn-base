package com.activity.common.service.system;

import java.util.List;

import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.black.BlackPrize;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 黑名单
 * @author ChenXb
 *
 * 2018年6月8日
 */
public class BlackListService {

	private static BlackListService blackListService = new BlackListService();

	private BlackListService() {

	}

	/**
	 * 懒汉式 就是申明的时候不new 在下边的时候判断是否为空的时候 才new出来 这样线程不安全
	 * 
	 * @return
	 */
	public static BlackListService getService() {
		return blackListService;
	}
	
	/**
	 * 
	 * getScanNumByOpenIdActivityMarkAndId
	 * 
	 * @author 81046
	 * @date 2018年6月4日下午3:25:35
	 * @param openId
	 *            微信id
	 * @param mark
	 *            活动标识
	 * @param activityWxId
	 *            微信小活动id
	 * @return
	 */
	public String getScanNumByOpenIdActivityMarkAndId(String openId, String mark, String activityId) {
		// 根据openid和微信活动id查询该用户的扫码次数
		String sql1 = "select count(*) from ACTIVITY_CODE where OPENID = ? and MARK = ? and ACTIVITY_ID = ? ";
		Long queryLong = Db.queryNumber(sql1, openId, mark, activityId).longValue();
		return queryLong + "";
	}

	/**
	 * 根据openid获取头像地址
	 */
	public String getHeadImgByOpenId(String openId){
		String sql="select * from ACTIVITY_CODE where openid = ? ";
		ActivityCode wxUser = ActivityCode.dao.findFirst(sql,openId);
		if(wxUser!=null){
			String headImg = wxUser.getHeadImg();
			if(headImg!=null){
				return headImg;
			}else{
				return "";
			}
		}else{
			return "";
		}
	}
	
	/**
	 * 根据openid和活动id，usercode查询该用户是否在黑名单里面了
	 */
	public boolean existBlackList(String openId,String activityId,String usercode){
		String sql="select count(*) from TB_BLACK_LIST  where OPENID = ? and ACTIVITYID = ? and USERCODE = ? ";
		Long queryLong = Db.queryNumber(sql, openId, activityId, usercode).longValue();
		int intValue = queryLong.intValue();
		if(intValue!=0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 根据usercode获取阀值
	 */
	public BlackPrize getBlackPrizeByUserCode(String userCode){
		String sql="select * from TB_BLACK_PRIZE where USERCODE = ? ";
		BlackPrize blackPrize = BlackPrize.dao.findFirst(sql,userCode);
		return blackPrize;
	}
	
	/**
	 * 根据运单记录id查找酒品名称
	 */
	public String getProductNameByRecordId(String recodeId){
		String sqlsr = "select PRODUCTNAME from TB_ACTIVITY_SELLEROUTINFO where SELLEROUTINFO_RECORDID = ? ";
		List<Record> listsr = Db.find(sqlsr, recodeId);
		String prizeName = "";
		for (Record record : listsr){
			prizeName = record.getStr("PRODUCTNAME");
		}
		return  prizeName;
	}
	
	/**
	 * 根据活动名称查询扫码记录
	 */
	public List<ActivityCode> getCodeByName(String activityName){
		// 这里查询所有的码中奖情况
		String sql = "select * from ACTIVITY_CODE where 1= 1";
		// 这里是模糊查询名字
		if (!StringUtils.isEmpty(activityName)){
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
		}
		// 这是所有的扫码记录
		return  ActivityCode.dao.find(sql);
	}
}
