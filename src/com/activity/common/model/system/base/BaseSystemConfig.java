package com.activity.common.model.system.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 系统配
 * 
 * @author 唐
 *
 * @param <M>
 */
@SuppressWarnings("serial")
public class BaseSystemConfig<M extends BaseSystemConfig<M>> extends Model<M> implements IBean {
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
	 * 系统值
	 * 
	 * @param VALUE
	 */
	public void setValue(java.lang.String VALUE) {
		set("VALUE", VALUE);
	}

	public java.lang.String getValue() {
		return get("VALUE");
	}

	/**
	 * 备注
	 * 
	 * @param REMARKS
	 */
	public void setRemarks(java.lang.String REMARKS) {
		set("REMARKS", REMARKS);
	}

	public java.lang.String getRemarks() {
		return get("REMARKS");
	}
}
