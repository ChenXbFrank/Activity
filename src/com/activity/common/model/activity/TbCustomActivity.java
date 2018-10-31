package com.activity.common.model.activity;

import com.activity.common.model.activity.base.BaseTbCustomActivity;
import com.jfinal.plugin.activerecord.Record;

/**
 * 定制活动 可以申请的活动
 * 
 * @author chenxb
 *
 */
@SuppressWarnings("serial")
public class TbCustomActivity extends BaseTbCustomActivity<TbCustomActivity> {
	public static final TbCustomActivity dao = new TbCustomActivity();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public TbCustomActivity mapping(Record cord, TbCustomActivity info) {
		info.setId(cord.getStr("ID"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setImg(cord.getStr("IMG"));
		info.setHref(cord.getStr("HREF"));
		info.setRemarks(cord.getStr("REMARKS"));
		info.setUpDateDate(cord.getStr("UPDATE_DATE"));
		info.setApproveHref(cord.getStr("APPROVEHREF"));
		info.setReportHref(cord.getStr("REPORTHREF"));
		info.setActivityHref(cord.getStr("ACTIVITYHREF"));
		info.setIntegralChoiceHref(cord.getStr("INTEGRAL_CHOICE_HREF"));
		return info;
	}
}
