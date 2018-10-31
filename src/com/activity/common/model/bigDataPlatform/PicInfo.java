package com.activity.common.model.bigDataPlatform;

import com.activity.common.model.bigDataPlatform.base.BasePicInfo;
import com.jfinal.plugin.activerecord.Record;

/**
 * 产品图片
 * 
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class PicInfo extends BasePicInfo<PicInfo> {
	public static final PicInfo dao = new PicInfo();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public PicInfo mapping(Record cord, PicInfo info) {
		info.setPicId(cord.getNumber("PICID"));
		// info.setPic(cord.getStr("PIC"));
		info.setPicUrl(cord.getStr("PICURL"));
		info.setRemark(cord.getStr("REMARK"));
		info.setSortNo(cord.getStr("SORTNO"));
		info.setTargetId(cord.getNumber("TARGETID"));
		info.setTargetType(cord.getNumber("TARGETTYPE"));
		return info;
	}
}
