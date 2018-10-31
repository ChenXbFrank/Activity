package com.activity.common.model.puzzle;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.puzzle.base.BasePuzzle;
import com.activity.common.model.system.SystemUser;
import com.jfinal.plugin.activerecord.Page;

/**
 * @author ChenXb
 *
 * 2017年11月29日
 */
@SuppressWarnings("serial")
public class Puzzle extends BasePuzzle<Puzzle> {
	public static final Puzzle dao = new Puzzle();
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_PUZZLE where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
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
		Page<Puzzle> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			Puzzle sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
			model.put("applyusername", sb.getApplyUserName());
			model.put("applyphone", sb.getApplyPhone());
			model.put("create_time", sb.getCreateTime());
			model.put("create_time", sb.getCreateTime());
			model.put("starttime", sb.getStartTime());
			model.put("endtime", sb.getEndTime());
			model.put("comfirmtime", sb.getComfirmTime());
			model.put("comfirmusername", sb.getComfirmuserName());
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
