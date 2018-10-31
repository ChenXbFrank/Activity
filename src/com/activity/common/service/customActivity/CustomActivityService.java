package com.activity.common.service.customActivity;

import java.util.List;

import com.activity.common.model.activity.TbCustomActivity;

/**
 * 定制活动的service
 * 
 * @author ChenXb
 *
 * 2018年6月19日
 */
public class CustomActivityService {
	
	private static CustomActivityService customActivityService = new CustomActivityService();
	
	private CustomActivityService() {
	}

	public static CustomActivityService getService() {
		return customActivityService;
	}
	
	/**
	 * 查询所有的定制活动
	 * getCustomActivitise
	 * @author 81046
	 * @date 2018年6月19日上午11:08:22
	 * @return
	 */
	public List<TbCustomActivity> getCustomActivitise(){
		String sql=" select * from  TB_CUSTOM_ACTIVITY " ;
		return TbCustomActivity.dao.find(sql);
	}
	
	/**
	 * 根据活动标识获取活动信息
	 */
	public TbCustomActivity getActivityByRemark(String remark){
		String sql=" select * from  TB_CUSTOM_ACTIVITY where REMARKS = ? " ;
		return TbCustomActivity.dao.findFirst(sql,remark);
	}
}
