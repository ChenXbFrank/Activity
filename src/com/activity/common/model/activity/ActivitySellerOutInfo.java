package com.activity.common.model.activity;

import com.activity.common.model.activity.base.BaseActivitySellerOutInfo;
import com.jfinal.plugin.activerecord.Record;

/**
 * 活动与运单表
 * 
 * @author cxb
 *
 */
@SuppressWarnings("serial")
public class ActivitySellerOutInfo extends BaseActivitySellerOutInfo<ActivitySellerOutInfo> {
	public static final ActivitySellerOutInfo dao = new ActivitySellerOutInfo();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public ActivitySellerOutInfo mapping(Record cord, ActivitySellerOutInfo info) {
		info.setId(cord.getStr("ID"));
		info.setActivityId(cord.getStr("ACTIVITY_ID"));
		info.setSellerOutInfoRecordId(cord.getStr("SELLEROUTINFO_RECORDID"));
		info.setOutNo(cord.getStr("OUTNO"));
		info.setSellerUserCode(cord.getStr("SELLER_USERCODE"));
		info.setState(cord.getStr("STATE"));
		info.setBelongActivity(cord.getStr("BELONG_ACTIVITY"));
		info.setOutSellerName(cord.getStr("OUTSELLERNAME"));
		info.setProductName(cord.getStr("PRODUCTNAME"));
		info.setDeep(cord.getNumber("DEEP"));
		info.setVolume(cord.getNumber("VOLUME"));
		info.setSpec(cord.getStr("SPEC"));
		info.setBoxSize(cord.getStr("BOXSIZE"));
		info.setBandName(cord.getStr("BANDNAME"));
		return info;
	}
}
