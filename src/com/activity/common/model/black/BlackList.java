package com.activity.common.model.black;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.black.base.BaseBlackList;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 黑名单配置
 * @author ChenXb
 *
 * 2018年6月1日
 */
@SuppressWarnings("serial")
public class BlackList extends BaseBlackList<BlackList> {
	public static final BlackList dao = new BlackList();
	
	public BlackList mapping(Record cord, BlackList info) {
		info.setId(cord.getStr("ID"));
		info.setActivityName(cord.getStr("ACTIVITYNAME"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImg(cord.getStr("HEADIMG"));
		info.setProductName(cord.getStr("PRODUCTNAME"));
		info.setScanNumber(cord.getStr("SCANNUMBER"));
		info.setScanTime(cord.getStr("SCANTIME"));
		info.setDeleted(cord.getStr("DELETED"));
		info.setActivityType(cord.getStr("ACTIVITYTYPE"));
		info.setActivityId(cord.getStr("ACTIVITYID"));
		info.setThreUser(cord.getStr("THREUSER"));
		info.setUserCode(cord.getStr("USERCODE"));
		return info;
	}
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String nickName) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_BLACK_LIST where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(nickName) &&nickName!=null) {
			sql += " and NICKNAME like '%" + nickName + "%'";
		}
		Page<BlackList> page = paginate(pageNumber, pageSize, "select *", sql+" order by SCANNUMBER desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			BlackList sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("nickName", sb.getNickName());
			model.put("activityName", sb.getActivityName());
			model.put("headImg", sb.getHeadImg());
			model.put("productName", sb.getProductName());
			model.put("scanNumber", sb.getScanNumber());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
