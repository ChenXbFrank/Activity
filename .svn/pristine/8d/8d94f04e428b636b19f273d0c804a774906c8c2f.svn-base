package com.activity.common.model.activity;

import com.activity.common.model.activity.base.BaseActivityWxUser;
import com.jfinal.plugin.activerecord.Record;

/**
 * 活动用户
 * 
 * @author 小石潭记丶
 *
 *         2017年8月9日
 */
@SuppressWarnings("serial")
public class ActivityWxUser extends BaseActivityWxUser<ActivityWxUser> {
	public static final ActivityWxUser dao = new ActivityWxUser();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public ActivityWxUser mapping(Record cord, ActivityWxUser info) {
		info.setOpenId(cord.getStr("OPENID"));
		info.setBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setSex(cord.getStr("SEX"));
		info.setCountry(cord.getStr("COUNTRY"));
		info.setProvince(cord.getStr("PROVINCE"));
		info.setCity(cord.getStr("CITY"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setId(cord.getStr("ID"));
		info.setTotalIntegral(cord.getStr("TOTAL_INTEGRAL"));
		info.setTotalMoney(cord.getStr("TOTAL_MONEY"));
		info.setSurplusTotalMoney(cord.getStr("SURPLUS_TOTAL_MONEY"));
		info.setSurplusTotalIntegral(cord.getStr("SURPLUS_TOTAL_INTEGRAL"));
		info.setSianTime(cord.getStr("SIAN_TIME"));
		return info;
	}
}
