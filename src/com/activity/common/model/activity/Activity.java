package com.activity.common.model.activity;

import com.activity.common.model.activity.base.BaseActivity;
import com.jfinal.plugin.activerecord.Record;

/**
 * 活动 可以申请的活动
 * 
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class Activity extends BaseActivity<Activity> {
	public static final Activity dao = new Activity();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public Activity mapping(Record cord, Activity info) {
		info.setId(cord.getStr("ID"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setImg(cord.getStr("IMG"));
		info.setHref(cord.getStr("HREF"));
		info.setRemarks(cord.getStr("REMARKS"));
		info.setUpDateDate(cord.getStr("UPDATE_DATE"));
		info.setApproveHref(cord.getStr("APPROVEHREF"));
		info.setReportHref(cord.getStr("REPORTHREF"));
		info.setActivityHref(cord.getStr("ACTIVITYHREF"));
		return info;
	}
}
