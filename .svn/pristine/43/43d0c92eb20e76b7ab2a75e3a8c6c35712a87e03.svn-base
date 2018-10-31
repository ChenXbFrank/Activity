package com.activity.common.service.system;

import java.util.ArrayList;
import java.util.List;

import com.activity.common.model.bigDataPlatform.PicInfo;
import com.activity.common.model.bigDataPlatform.ProductInfo;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 大数据平台产品信息
 * 
 * @author 唐
 *
 */
public class ProductInfoService {
	private static ProductInfoService productInfoService = new ProductInfoService();

	private ProductInfoService() {
	}

	public static ProductInfoService getService() {
		return productInfoService;
	}

	/**
	 * 根据产品ID，查询出产品信息
	 * 
	 * @param UserCode
	 * @return
	 */
	public List<ProductInfo> getProductInfoById(String productId) {
		String sql = PropKit.use("database.properties").get("getProductInfoById");
		List<Record> soiView = Db.find(sql, productId);
		List<ProductInfo> soiList = new ArrayList<ProductInfo>();
		for (Record cord : soiView) {
			ProductInfo soi = new ProductInfo();
			soi.mapping(cord, soi);
			soiList.add(soi);
		}
		return soiList;
	}

	/**
	 * 根据产品ID，查询出产品图片
	 */
	public PicInfo getProductImgByProductId(String productId) {
		String sql = PropKit.use("database.properties").get("getProductImgByProductId");
		List<Record> soiView = Db.find(sql, productId);
		PicInfo pinfo = new PicInfo();
		for (Record cord : soiView) {
			pinfo.mapping(cord, pinfo);
		}
		return pinfo;
	}
}
