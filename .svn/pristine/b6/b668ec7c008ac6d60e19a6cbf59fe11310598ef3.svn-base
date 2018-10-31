package com.activity.common.model.system;

import com.activity.common.model.system.base.BaseSystemConfig;
import com.jfinal.plugin.activerecord.Record;

/**
 * 系统配置
 * 
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class SystemConfig extends BaseSystemConfig<SystemConfig> {
	public static final SystemConfig dao = new SystemConfig();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public SystemConfig mapping(Record cord, SystemConfig info) {
		info.setId(cord.getStr("ID"));
		info.setName(cord.getStr("NAME"));
		info.setValue(cord.getStr("VALUE"));
		info.setRemarks(cord.getStr("REMARKS"));
		return info;
	}
}
