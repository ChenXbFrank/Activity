package com.activity.common.model.groupPurchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.groupPurchase.base.BasePurchaseWxUserWinning;
import com.jfinal.plugin.activerecord.Page;

/**
 * 拼团活动
 * @author ChenXb
 *
 * 2017年12月6日
 */
@SuppressWarnings("serial")
public class PurchaseWxUserWinning extends BasePurchaseWxUserWinning<PurchaseWxUserWinning> {
	public static final PurchaseWxUserWinning dao = new PurchaseWxUserWinning();
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String,Object> paginate(int pageNumber, int pageSize,String purchaseWxuserId) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_PURCHASE_WXUSER_WINNING where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(purchaseWxuserId) &&purchaseWxuserId!=null) {
			sql += " and PURCHASE_WXUSER_ID = '" + purchaseWxuserId + "'";
		}
		Page<PurchaseWxUserWinning> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			PurchaseWxUserWinning sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("prizeName", sb.getPrizeProject());
			model.put("prizeType", sb.getPrizeType());
			model.put("nickName", sb.getNickName());
			model.put("headImg", sb.getHeadImgUrl());
			model.put("receiver", sb.getAddresseeName());
			model.put("recePhone", sb.getAddresseePhone());
			model.put("receAddress", sb.getAddresseeAddress());
			model.put("sender", sb.getLssueUserName());
			model.put("company", sb.getDeliverCompany());
			model.put("sellerNo", sb.getDeliverNumber());
			model.put("state", sb.getState());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
