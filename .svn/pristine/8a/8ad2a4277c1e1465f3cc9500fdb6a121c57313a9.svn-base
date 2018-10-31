package com.activity.common.model.puzzle;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.puzzle.base.BasePuzzleWxUser;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.plugin.activerecord.Page;

/**
 * @author ChenXb
 *
 * 2017年11月29日
 */
@SuppressWarnings("serial")
public class PuzzleWxUser extends BasePuzzleWxUser<PuzzleWxUser> {
	public static final PuzzleWxUser dao = new PuzzleWxUser();
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate1(int pageNumber, int pageSize,String activityId,String nickName) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_PUZZLE_WXUSER where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityId) &&activityId!=null) {
			sql += " and PUZZLE_ID = '" + activityId + "'";
		}
		if (!"".equals(nickName) &&nickName!=null) {
			sql += " and NICKNAME like '%" + nickName + "%'";
		}
		Page<PuzzleWxUser> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			PuzzleWxUser sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
			if(StringUtils.isEmpty(sb.getNickName())){
				model.put("nickName", "未关注");
			}else{
				model.put("nickName", sb.getNickName());
			}
			model.put("headimgurl", sb.getHeadImgUrl());
			model.put("create_time", sb.getCreateTime());
			model.put("state", sb.getState());
			model.put("goodstate", sb.getGoodState());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
