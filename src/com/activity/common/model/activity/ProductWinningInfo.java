package com.activity.common.model.activity;

import com.activity.common.model.activity.base.BaseProductWinningInfo;
import com.jfinal.plugin.activerecord.Record;

/**
 * 实物产品中奖记录
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class ProductWinningInfo extends BaseProductWinningInfo<ProductWinningInfo>{
	public static final ProductWinningInfo dao = new ProductWinningInfo();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public ProductWinningInfo mapping(Record cord, ProductWinningInfo info) {
		info.setId(cord.getStr("ID"));
		info.setBelongActivityId(cord.getStr("BELONG_ACTIVITY_ID"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setActivityNameType(cord.getStr("ACTIVITY_NAME_TYPE"));
		info.setProductId(cord.getStr("PRODUCT_ID"));
		info.setProductImg(cord.getStr("PRODUCT_IMG"));
		info.setProductName(cord.getStr("PRODUCT_NAME"));
		info.setActivityPrizeId(cord.getStr("ACTIVITY_PRIZE_ID"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setStartTime(cord.getStr("STARTTIME"));
		info.setEndTime(cord.getStr("ENDTIME"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setActivityWxUserId(cord.getStr("ACTIVITY_WXUSER_ID"));
		info.setBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setState(cord.getStr("STATE"));
		return info;
	}
}
