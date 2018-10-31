package com.activity.common.model.activity;

import com.activity.common.model.activity.base.BaseActivityCode;
import com.jfinal.plugin.activerecord.Record;

@SuppressWarnings("serial")
public class ActivityCode extends BaseActivityCode<ActivityCode> {
	public static final ActivityCode dao = new ActivityCode();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public ActivityCode mapping(Record cord, ActivityCode info) {
		info.setId(cord.getStr("ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setCode(cord.getStr("CODE"));
		info.setSellerOutInfoRecordId(cord.getStr("SELLEROUTINFO_RECORDID"));
		info.setSignNumber(cord.getStr("SING_NUMBER"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setActivityId(cord.getStr("ACTIVITY_ID"));
		info.setMark(cord.getStr("MARK"));
		info.setActivityWxId(cord.getStr("ACTIVITY_WXID"));
		info.setWiningId(cord.getStr("WININGID"));
		info.setWinType(cord.getStr("WINTYPE"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImg(cord.getStr("HEADIMG"));
		info.setSellerPublicId(cord.getStr("SELLERPUBLICID"));
		info.setSellerPublicName(cord.getStr("SELLERPUBLICNAME"));
		info.setActivityName(cord.getStr("ACTIVITYNAME"));
		return info;
	}
}
