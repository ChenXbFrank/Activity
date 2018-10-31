package com.activity.common.model.integral;

import com.activity.common.model.integral.base.BaseIntegralActivity;
import com.jfinal.plugin.activerecord.Record;

/**
 * 积分兑换活动参与次数
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class IntegralActivity extends BaseIntegralActivity<IntegralActivity>{
	public static final IntegralActivity dao = new IntegralActivity();
	
	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public IntegralActivity mapping(Record cord, IntegralActivity info) {
		info.setId(cord.getStr("ID"));
		info.setIntegralId(cord.getStr("INTEGRAL_ID"));
		info.setOrderNumber(cord.getStr("ORDER_NUMBER"));
		info.setActivityNumber(cord.getStr("ACTIVITY_NUMBER"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setActivityId(cord.getStr("ACTIVITY_ID"));
		info.setNeedIntegral(cord.getStr("NEED_INTEGRAL"));
		info.setTenActivityId(cord.getStr("TEN_ACTIVITY_ID"));
		info.setTenActivityName(cord.getStr("TEN_ACTIVITY_NAME"));
		info.setBackgroundImg(cord.getStr("BACKGROUND_IMG"));
		return info;
	}
}
