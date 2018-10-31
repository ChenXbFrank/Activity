package com.activity.common.model.integral;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.integral.base.BaseIntegalExchange;
import com.jfinal.plugin.activerecord.Page;

/**
 * 积分兑换记录
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class IntegalExchange extends BaseIntegalExchange<IntegalExchange>{
	public static final IntegalExchange dao = new IntegalExchange();
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String nickName) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_INTEGRAL_EXCHANGE where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(nickName)&&nickName!=null) {
			sql += "and NICKNAME like '%" + nickName + "%'";
		}
		Page<IntegalExchange> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			IntegalExchange sb = page.getList().get(i);
			model.put("id", sb.getIntegralExchangeId());
			model.put("intid", sb.getIntegralId());
			model.put("activityname", sb.getTenActivityName());
			model.put("headurl", sb.getHeadimgUrl());
			model.put("exchangtime", sb.getCreateTime());
			model.put("nickName", sb.getNickName());
			model.put("integraltype", sb.getExchangeType());
			model.put("integral", sb.getExchangeUseIntegral());
			model.put("integralinfo", "兑换"+sb.getExchangePrizeName());
			model.put("receivename", sb.getAddresseeName());
			model.put("recephone", sb.getAddresseePhone());
			model.put("receaddress", sb.getAddresseeAddress());
			model.put("sendname", sb.getLssueUserName());
			model.put("delivercompany", sb.getDeliverCompany());
			model.put("delivernum", sb.getDeliverNumber());
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
