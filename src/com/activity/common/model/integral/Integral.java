package com.activity.common.model.integral;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.integral.base.BaseIntegral;
import com.activity.common.model.system.SystemUser;
import com.jfinal.plugin.activerecord.Page;

/**
 * 积分兑换
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class Integral extends BaseIntegral<Integral>{
	public static final Integral dao = new Integral();
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_INTEGRAL where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		if (!"".equals(startTime)&&startTime!=null && !"".equals(endTime)&&endTime!=null) {
			sql += " and create_time >= '"+startTime+"' and create_time <= '"+endTime+"' ";
		}
		//= -1就是admin账号  否则就是普通经销商
		if(user.getUserId().intValue()!=-1){
			sql += " and ACITIVITY_LAUNCH_USERCODE = " + " '" + user.getUserCode() + "' ";
		}
		Page<Integral> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			Integral sb = page.getList().get(i);
			model.put("id", sb.getIntegralId());
//			model.put("activity_name", sb.getActivityName());
			model.put("applyusername", sb.getApplyUserName());
			model.put("applyphone", sb.getApplyPhone());
			model.put("create_time", sb.getCreateTime());
			model.put("comfirmtime", sb.getComfirmTime());
			model.put("comfirmusername", sb.getComfirmUserName());
			//扫码中奖次数
//			model.put("scannumber", sb.getScanNumber());
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
