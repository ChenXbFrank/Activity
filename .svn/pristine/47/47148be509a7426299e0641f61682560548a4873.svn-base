package com.activity.common.model.shareBargain;

import com.activity.common.model.shareBargain.base.BaseShareBargainPrize;
import com.jfinal.plugin.activerecord.Record;

/**
 * 分享砍价奖品配置表
 * 
 * @author 小石潭记丶
 *
 *         2017年8月9日
 */
@SuppressWarnings("serial")
public class ShareBargainPrize extends BaseShareBargainPrize<ShareBargainPrize> {
	public static final ShareBargainPrize dao = new ShareBargainPrize();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param user
	 * @return
	 */
	public ShareBargainPrize mapping(Record cord, ShareBargainPrize info) {
		info.setId(cord.getStr("ID"));
		info.setShareBargainId(cord.getStr("SHARE_BARGAIN_ID"));
		info.setProductId(cord.getStr("PRODUCTID"));
		info.setPrzieNumber(cord.getNumber("PRZIE_NUMBER"));
		info.setPrzieSurplusNumber(cord.getNumber("PRZIE_SURPLUS_NUMBER"));
		info.setOriginalPrice(cord.getStr("ORIGINAL_PRICE"));
		info.setLowPrice(cord.getStr("LOW_PRICE"));
		info.setBargainSection(cord.getStr("BARGAIN_SECTION"));
		info.setBargainNumber(cord.getNumber("BARGAIN_NUMBER"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setSpareTwo(cord.getStr("SPARE_TWO"));
		info.setProductIMG(cord.getStr("PRODUCTIMG"));
		info.setPrizeName(cord.getStr("PRIZENAME"));
		return info;
	}
}
