package com.activity.common.model.system;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.activity.common.model.system.base.BaseExpress;
import com.jfinal.plugin.activerecord.Page;

/**
 * 快递公司
 * @author ChenXb
 *
 * 2018年1月26日
 */
@SuppressWarnings("serial")
public class Express extends BaseExpress<Express> {
	public static final Express dao = new Express();

	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String name) {
		String sql=" from TB_EXPRESS where 1=1 ";
		// 这里是模糊查询名字
		if (!StringUtils.isEmpty(name)) {
			sql += " and NAME like '%" + name + "%'";
		}
		Page<Express> page = paginate(pageNumber, pageSize, "select *", sql);
		Map<String, Object> map = new HashMap<String, Object>();
		if(page!=null){
			map.put("list", page.getList());
			map.put("currentPage", page.getPageNumber());
			map.put("totalPages", page.getTotalPage());
		}
		return map;
	}
}
