package com.activity.common.model.system.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 快递公司
 * 
 * @author 唐
 *
 * @param <M>
 */
@SuppressWarnings("serial")
public class BaseExpress<M extends BaseExpress<M>> extends Model<M> implements IBean {
	/**
	 * 系统ID
	 * 
	 * @param ID
	 */
	public java.lang.String getId() {
		return get("ID");
	}

	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	/**
	 * 系统名称
	 * 
	 * @param NAME
	 */
	public void setName(java.lang.String NAME) {
		set("NAME", NAME);
	}

	public java.lang.String getName() {
		return get("NAME");
	}

	/**
	 * 备注
	 * 
	 * @param REMARK
	 */
	public void setRemark(java.lang.String REMARK) {
		set("REMARK", REMARK);
	}

	public java.lang.String getRemark() {
		return get("REMARK");
	}

}
