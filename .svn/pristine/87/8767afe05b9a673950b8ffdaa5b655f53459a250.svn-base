package com.activity.common.model.integral;

import com.activity.common.model.integral.base.BaseIntegralProduct;
import com.jfinal.plugin.activerecord.Record;

/**
 * 积分兑换产品
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class IntegralProduct extends BaseIntegralProduct<IntegralProduct>{
	public static final IntegralProduct dao = new IntegralProduct();
	
	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public IntegralProduct mapping(Record cord, IntegralProduct info) {
		info.setId(cord.getStr("ID"));
		info.setIntegralId(cord.getStr("INTEGRAL_ID"));
		info.setOrderNumber(cord.getStr("ORDER_NUMBER"));
		info.setAgent(cord.getStr("AGENT"));
		info.setProductId(cord.getStr("PRODUCT_ID"));
		info.setProductImg(cord.getStr("PRODUCT_IMG"));
		info.setProductName(cord.getStr("PRODUCT_NAME"));
		info.setProductNumber(cord.getStr("PRODUCT_NUMBER"));
		info.setProductIntroduce(cord.getStr("PRODUCT_INTRODUCE"));
		info.setNeedIntegral(cord.getStr("NEED_INTEGRAL"));
		info.setSpec(cord.getStr("SPEC"));
		info.setDegree(cord.getStr("DEGREE"));
		info.setVolume(cord.getStr("VOLUME"));
		info.setSurplusProductNumber(cord.getStr("SURPLUS_PRODUCT_NUMBER"));
		return info;
	}
	
	
}
