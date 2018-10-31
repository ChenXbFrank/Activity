package com.activity.common.model.oneMoneyShop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.oneMoneyShop.base.BaseOneMoneyGroupWxUser;
import com.jfinal.plugin.activerecord.Page;

/**
 * 一元购活动
 * @author ChenXb
 *
 * 2017年11月24日
 */
@SuppressWarnings("serial")
public class OneMoneyGroupWxUser extends BaseOneMoneyGroupWxUser<OneMoneyGroupWxUser> {
	public static final OneMoneyGroupWxUser dao = new OneMoneyGroupWxUser();
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_ONE_MONEY_GROUP_WXUSER where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		if (!"".equals(startTime)&&startTime!=null && !"".equals(endTime)&&endTime!=null) {
			sql += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		Page<OneMoneyGroupWxUser> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			OneMoneyGroupWxUser sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
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
