package com.activity.common.model.system;

import com.activity.common.model.system.base.BaseSystemUser;
import com.jfinal.plugin.activerecord.Record;

/**
 * 系统登陆用户 tanghaobo
 */
@SuppressWarnings("serial")
public class SystemUser extends BaseSystemUser<SystemUser> {
	public static final SystemUser dao = new SystemUser();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param user
	 * @return
	 */
	public SystemUser mapping(Record cord, SystemUser user) {
		user.setUserId(cord.getNumber("USERID"));
		user.setRoleId(cord.getNumber("ROLEID"));
		user.setTbUserId(cord.getNumber("TB_USERID"));
		user.setUserCode(cord.getStr("USERCODE"));
		user.setUserName(cord.getStr("USERNAME"));
		user.setPassWord(cord.getStr("PASSWORD"));
		user.setInputDate(cord.getDate("INPUTDATE"));
		user.setStatus(cord.getNumber("STATUS"));
		user.setUserType(cord.getNumber("USERTYPE"));
		user.setTargetType(cord.getNumber("TARGETTYPE"));
		user.setTargetId(cord.getNumber("TARGETID"));
		user.setPlatformRights(cord.getStr("PLATFORMRIGHTS"));
		user.setDepartmentId(cord.getNumber("DEPARTMENTID"));
		user.setPhone(cord.getStr("PHONE"));
		return user;
	}
}
