package com.activity.common.model.system.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 系统登陆用户 tanghaobo
 */
@SuppressWarnings("serial")
public class BaseSystemUser<M extends BaseSystemUser<M>> extends Model<M> implements IBean {
	/**
	 * 操作员ID
	 * 
	 * @param USERID
	 */
	public void setUserId(java.lang.Number USERID) {
		set("USERID", USERID);
	}

	public java.lang.Number getUserId() {
		return get("USERID");
	}

	/**
	 * 角色ID
	 * 
	 * @param ROLEID
	 */
	public void setRoleId(java.lang.Number ROLEID) {
		set("ROLEID", ROLEID);
	}

	public java.lang.Number getRoleId() {
		return get("ROLEID");
	}

	/**
	 * 操作员_操作员ID
	 * 
	 * @param TB_USERID
	 */
	public void setTbUserId(java.lang.Number TB_USERID) {
		set("TB_USERID", TB_USERID);
	}

	public java.lang.Number getTbUserId() {
		return get("TB_USERID");
	}

	/**
	 * 操作员编码
	 */
	public void setUserCode(java.lang.String USERCODE) {
		set("USERCODE", USERCODE);
	}

	public java.lang.String getUserCode() {
		return get("USERCODE");
	}

	/**
	 * 操作员名称
	 * 
	 * @param USERNAME
	 */
	public void setUserName(java.lang.String USERNAME) {
		set("USERNAME", USERNAME);
	}

	public java.lang.String getUserName() {
		return get("USERNAME");
	}

	/**
	 * 密码
	 * 
	 * @param PASSWORD
	 */
	public void setPassWord(java.lang.String PASSWORD) {
		set("PASSWORD", PASSWORD);
	}

	public java.lang.String getPassWord() {
		return get("PASSWORD");
	}

	/**
	 * 更新时间
	 * 
	 * @param INPUTDATE
	 */
	public void setInputDate(java.util.Date INPUTDATE) {
		set("INPUTDATE", INPUTDATE);
	}

	public java.util.Date getInputDate() {
		return get("INPUTDATE");
	}

	/**
	 * 状态 0启用 1禁止
	 * 
	 * @param STATUS
	 */
	public void setStatus(java.lang.Number STATUS) {
		set("STATUS", STATUS);
	}

	public java.lang.Number getStatus() {
		return get("STATUS");
	}

	/**
	 * 用户类型 1管理员 2普通用户
	 * 
	 * @param USERTYPE
	 */
	public void setUserType(java.lang.Number USERTYPE) {
		set("USERTYPE", USERTYPE);
	}

	public java.lang.Number getUserType() {
		return get("USERTYPE");
	}

	/**
	 * 操作员类别 1平台公司 2厂商 3经销商
	 * 
	 * @param TARGETTYPE
	 */
	public void setTargetType(java.lang.Number TARGETTYPE) {
		set("TARGETTYPE", TARGETTYPE);
	}

	public java.lang.Number getTargetType() {
		return get("TARGETTYPE");
	}

	/**
	 * type=3 经销商ID
	 * 
	 * @param TARGETID
	 */
	public void setTargetId(java.lang.Number TARGETID) {
		set("TARGETID", TARGETID);
	}

	public java.lang.Number getTargetId() {
		return get("TARGETID");
	}

	/**
	 * 平台权限 1web端 2pc端 3PDA，多个平台用逗号分隔
	 * 
	 * @param PLATFORMRIGHTS
	 */
	public void setPlatformRights(java.lang.String PLATFORMRIGHTS) {
		set("PLATFORMRIGHTS ", PLATFORMRIGHTS);
	}

	public java.lang.String getPlatformRights() {
		return get("PLATFORMRIGHTS ");
	}

	/**
	 * 部门ID
	 * 
	 * @param DEPARTMENTID
	 */
	public void setDepartmentId(java.lang.Number DEPARTMENTID) {
		set("DEPARTMENTID", DEPARTMENTID);
	}

	public java.lang.Number getDepartmentId() {
		return get("DEPARTMENTID");
	}

	/**
	 * 登陆手机号码
	 * 
	 * @param PHONE
	 */
	public void setPhone(java.lang.String PHONE) {
		set("PHONE", PHONE);
	}

	public java.lang.String getPhone() {
		return get("PHONE");
	}

}
