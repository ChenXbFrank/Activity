package com.activity.common.service.system;

import java.util.ArrayList;
import java.util.List;

import com.activity.common.model.bigDataPlatform.SellerRelation;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 经销商关系
 * 
 * @author 唐
 *
 */
public class SellerRelationService {
	private static SellerRelationService sellerRelationService = new SellerRelationService();

	private SellerRelationService() {

	}

	public static SellerRelationService getService() {
		return sellerRelationService;
	}

	/**
	 * 根据TargetId查询代理的产品
	 * 
	 * @param TargetId
	 * @return
	 */
	public List<SellerRelation> getSrByTargetId(String TargetId) {
		String sql = PropKit.use("database.properties").get("getSrByTargetId");
		List<Record> srView = Db.find(sql, TargetId);
		List<SellerRelation> srList = new ArrayList<SellerRelation>();
		for (Record cord : srView) {
			SellerRelation sr = new SellerRelation();
			sr.mapping(cord, sr);
			srList.add(sr);
		}
		return srList;
	}
}
