package com.activity.common.model.bigDataPlatform;

import com.activity.common.model.bigDataPlatform.base.BaseProductInfo;
import com.jfinal.plugin.activerecord.Record;

/**
 * 产品信息表
 * 
 * @author 小石潭记丶
 *
 *         2017年7月31日
 */
@SuppressWarnings("serial")
public class ProductInfo extends BaseProductInfo<ProductInfo> {
	public static final ProductInfo dao = new ProductInfo();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public ProductInfo mapping(Record cord, ProductInfo info) {
		info.setProductId(cord.getNumber("PRODUCTID"));
		info.setBrandsId(cord.getNumber("BRANDSID"));
		info.setProductCode(cord.getStr("PRODUCTCODE"));
		info.setProductName(cord.getStr("PRODUCTNAME"));
		info.setDegree(cord.getNumber("DEGREE"));
		info.setProductYear(cord.getNumber("PRODUCTYEAR"));
		info.setVolume(cord.getNumber("VOLUME"));
		info.setRemark(cord.getStr("REMARK"));
		info.setProductType(cord.getStr("PRODUCTTYPE"));
		info.setStatus(cord.getNumber("STATUS"));
		info.setSpec(cord.getNumber("SPEC"));
		info.setKindId(cord.getStr("KIND_ID"));
		info.setDegreeId(cord.getStr("DEGREE_ID"));
		info.setCapacityId(cord.getStr("CAPACITY_ID"));
		info.setSpecId(cord.getStr("SPEC_ID"));
		return info;
	}
}
