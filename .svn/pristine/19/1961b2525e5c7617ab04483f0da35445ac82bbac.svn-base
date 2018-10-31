package com.activity.common.model.bigDataPlatform;

import com.activity.common.model.bigDataPlatform.base.BaseSellerRelation;
import com.jfinal.plugin.activerecord.Record;

/**
 * 经销商关系表
 * 
 * @author 小石潭记丶
 *
 *         2017年7月31日
 */
@SuppressWarnings("serial")
public class SellerRelation extends BaseSellerRelation<SellerRelation> {
	public static final SellerRelation dao = new SellerRelation();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public SellerRelation mapping(Record cord, SellerRelation info) {
		info.setSellerId(cord.getNumber("SELLERID"));
		info.setIsView(cord.getNumber("ISVIEW"));
		info.setChannelId(cord.getNumber("CHANNELID"));
		info.setProductId(cord.getNumber("PRODUCTID"));
		info.setBrandsId(cord.getNumber("BRANDSID"));
		info.setProductName(cord.getStr("PRODUCTNAME"));
		info.setDegree(cord.getNumber("DEGREE"));
		info.setVolume(cord.getNumber("VOLUME"));
		info.setSpec(cord.getNumber("SPEC"));
		return info;
	}
}
