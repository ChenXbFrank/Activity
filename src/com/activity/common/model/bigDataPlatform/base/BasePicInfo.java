package com.activity.common.model.bigDataPlatform.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 产品图片
 * 
 * @author 唐
 *
 *         2017年8月9日
 */
@SuppressWarnings("serial")
public class BasePicInfo<M extends BasePicInfo<M>> extends Model<M> implements IBean {
	public void setPicId(java.lang.Number PICID) {
		set("PICID", PICID);
	}

	public java.lang.Number getPicId() {
		return get("PICID");
	}

	public void setPic(java.lang.String PIC) {
		set("PIC", PIC);
	}

	public java.lang.String getPic() {
		return get("PIC");
	}

	public void setRemark(java.lang.String REMARK) {
		set("REMARK", REMARK);
	}

	public java.lang.String Remark() {
		return get("REMARK");
	}

	public void setTargetType(java.lang.Number TARGETTYPE) {
		set("TARGETTYPE", TARGETTYPE);
	}

	public java.lang.Number getTargetType() {
		return get("TARGETTYPE");
	}

	public void setTargetId(java.lang.Number TARGETID) {
		set("TARGETID", TARGETID);
	}

	public java.lang.Number getTargetId() {
		return get("TARGETID");
	}

	public void setPicUrl(java.lang.String PICURL) {
		set("PICURL", PICURL);
	}

	public java.lang.String getPicUrl() {
		return get("PICURL");
	}

	public void setSortNo(java.lang.String SORTNO) {
		set("SORTNO", SORTNO);
	}

	public java.lang.String getSortNo() {
		return get("SORTNO");
	}
}
