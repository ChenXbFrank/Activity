package com.activity.common.model.system.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

@SuppressWarnings("serial")
public class BaseAdvert<M extends BaseAdvert<M>> extends Model<M> implements IBean {

	public java.lang.String getId() {
		return get("ID");
	}

	public void setId(java.lang.String ID) {
		set("ID", ID);
	}
	
	public java.lang.String getSellerPublicId() {
		return get("SELLERPUBLICID");
	}

	public void setSellerPublicId(java.lang.String SELLERPUBLICID) {
		set("SELLERPUBLICID", SELLERPUBLICID);
	}
	
	public java.lang.String getPicture() {
		return get("PICTRUE");
	}

	public void setPicture(java.lang.String PICTRUE) {
		set("PICTRUE", PICTRUE);
	}
	
	public java.lang.String getLogo() {
		return get("LOGO");
	}

	public void setLogo(java.lang.String LOGO) {
		set("LOGO", LOGO);
	}
	
	public java.lang.String getAdvertUrl() {
		return get("ADVERT_URL");
	}

	public void setAdvertUrl(java.lang.String ADVERT_URL) {
		set("ADVERT_URL", ADVERT_URL);
	}
	
	/**
	 * 申请人ID
	 */
	public void setApplyUserId(java.lang.String APPLYUSERID) {
		set("APPLYUSERID", APPLYUSERID);
	}

	public java.lang.String getApplyUserId() {
		return get("APPLYUSERID");
	}
	/*
	 * 申请时间
	 */
	public void setCreateTime(java.lang.String CREATE_TIME) {
		set("CREATE_TIME", CREATE_TIME);
	}

	public java.lang.String getCreateTime() {
		return get("CREATE_TIME");
	}
	
	/**
	 * 申请人电话
	 */
	public void setApplyPhone(java.lang.String APPLYPHONE) {
		set("APPLYPHONE", APPLYPHONE);
	}

	public java.lang.String getApplyPhone() {
		return get("APPLYPHONE");
	}
	
	/**
	 * 申请人名称
	 */
	public void setApplyName(java.lang.String APPLYNAME) {
		set("APPLYNAME", APPLYNAME);
	}

	public java.lang.String getApplyName() {
		return get("APPLYNAME");
	}
	
	
	//审核：0：申请中 1：通过  2：驳回 
	public java.lang.String getStart() {
		return get("STATE");
	}

	public void setStart(java.lang.String STATE) {
		set("STATE", STATE);
	}
	
	/**
	 * 审核人的名称
	 */
	public void setComfirmuserName(java.lang.String COMFIRMUSERNAME) {
		set("COMFIRMUSERNAME", COMFIRMUSERNAME);
	}

	public java.lang.String getComfirmuserName() {
		return get("COMFIRMUSERNAME");
	}

	/**
	 * 审核时间
	 */
	public void setComfirmTime(java.lang.String COMFIRMTIME) {
		set("COMFIRMTIME", COMFIRMTIME);
	}

	public java.lang.String getComfirmTime() {
		return get("COMFIRMTIME");
	}

	/**
	 * 审核ID
	 */
	public void setComfirmuserId(java.lang.String COMFIRMUSERID) {
		set("COMFIRMUSERID", COMFIRMUSERID);
	}

	public java.lang.String getComfirmuserId() {
		return get("COMFIRMUSERID");
	}
	
	
	/**
	 * 审核建议
	 */
	public void setComfirmAdvise(java.lang.String COMFIRMADVISE) {
		set("COMFIRMADVISE", COMFIRMADVISE);
	}

	public java.lang.String getComfirmAdvise() {
		return get("COMFIRMADVISE");
	}
	
}
