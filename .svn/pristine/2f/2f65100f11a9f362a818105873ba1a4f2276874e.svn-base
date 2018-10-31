package com.activity.common.model.system;

import com.activity.common.model.system.base.BaseSystemMenu;
import com.jfinal.plugin.activerecord.Record;

/**
 * 系统菜单 tanghaobo
 */
@SuppressWarnings("serial")
public class SystemMenu extends BaseSystemMenu<SystemMenu> {
	public static final SystemMenu dao = new SystemMenu();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public SystemMenu mapping(Record cord, SystemMenu info) {
		info.setId(cord.getStr("ID"));
		info.setName(cord.getStr("NAME"));
		info.setHref(cord.getStr("HREF"));
		info.setCreateDate(cord.getStr("CREATE_DATE"));
		info.setUpDateDate(cord.getStr("UPDATE_DATE"));
		info.setRemarks(cord.getStr("REMARKS"));
		info.setParentId(cord.getStr("PARENT_ID"));
		info.setImg(cord.getStr("IMG"));
		info.setDelflag(cord.getStr("DELFLAG"));
		return info;
	}
}
