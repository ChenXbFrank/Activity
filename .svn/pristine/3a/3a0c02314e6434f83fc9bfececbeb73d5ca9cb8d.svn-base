package com.activity.common.model.loginfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.loginfo.base.BaseLogInfo;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 日志
 * 
 * @author 唐
 *
 *         2017年8月25日
 */
@SuppressWarnings("serial")
public class LogInfo extends BaseLogInfo<LogInfo> {
	public static final LogInfo dao = new LogInfo();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public LogInfo mapping(Record cord, LogInfo info) {
		info.setId(cord.getStr("ID"));
		info.setUseUserCode(cord.getStr("USE_USERCODE"));
		info.setUseFunction(cord.getStr("USE_FUNCTION"));
		info.setUseTime(cord.getStr("USE_TIME"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		return info;
	}

	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return     from LOG_INFO order by use_time desc
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String userCode,String startTime,String endTime) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from LOG_INFO where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(userCode) &&userCode!=null) {
			sql += "and USE_USERCODE = " + " '" + userCode + "' ";
		}
		if (!"".equals(startTime)&&startTime!=null && !"".equals(endTime)&&endTime!=null) {
			sql += " and USE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		Page<LogInfo> page = paginate(pageNumber, pageSize, "select *", sql+" order by use_time desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			LogInfo logInfo = page.getList().get(i);
			model.put("id", logInfo.getId());
			model.put("use_usercode", logInfo.getUseUserCode());
			model.put("use_function", logInfo.getUseFunction());
			model.put("use_time", logInfo.getUseTime());
			model.put("spare_one", logInfo.getSpareOne());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
