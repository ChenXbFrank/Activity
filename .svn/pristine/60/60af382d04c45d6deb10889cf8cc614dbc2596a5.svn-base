package com.activity.common.service.system;

import java.util.List;

import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.jfinal.kit.PropKit;

/**
 * 经销商公众号配置
 * 
 * @author 唐
 *
 */
public class SellerPublicNumberService {
	private static SellerPublicNumberService sellerPublicNumberService = new SellerPublicNumberService();

	private SellerPublicNumberService() {
	}

	public static SellerPublicNumberService getService() {
		return sellerPublicNumberService;
	}

	/**
	 * 根据UserCode查询视图，返回单个用户信息
	 * 
	 * @param userCode
	 * @return
	 */
	public List<SellerPublicNumber> getPublicNumberByUsercode(String userCode) {
		// 查询一个集合，防止code相同
		String sql = PropKit.use("database.properties").get("getPublicNumberByUsercode");
		List<SellerPublicNumber> spnList = SellerPublicNumber.dao.find(sql, userCode);
		return spnList;
	}

	/**
	 * 查询所有的公众号信息
	 */
	public List<SellerPublicNumber> getAllPublicNumber() {
		String sql = PropKit.use("database.properties").get("getAllPublicNumber");
		List<SellerPublicNumber> sellerPublicNumberList = SellerPublicNumber.dao.find(sql);
		return sellerPublicNumberList;
	}

	/**
	 * 查询指定名称的公众号
	 */
	public List<SellerPublicNumber> getPublicNumberByCondition(String name) {
		String sql = "Select * from TB_SELLER_PUBLICNUMBER where PUBLICNUMBER_NAME like '%" + name + "%'";
		List<SellerPublicNumber> sellerPublicNumberList = SellerPublicNumber.dao.find(sql);
		return sellerPublicNumberList;
	}
}
