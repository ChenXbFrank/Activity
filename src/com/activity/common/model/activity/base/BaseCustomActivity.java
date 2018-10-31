package com.activity.common.model.activity.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 定制活动 可以申请的活动
 * 
 * @author chenxb
 *
 * @param <M>
 */
@SuppressWarnings("serial")
public class BaseCustomActivity<M extends BaseCustomActivity<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 活动名称
	 */
	public void setActivityName(java.lang.String ACTIVITY_NAME) {
		set("ACTIVITY_NAME", ACTIVITY_NAME);
	}

	public java.lang.String getActivityName() {
		return get("ACTIVITY_NAME");
	}

	/**
	 * 背景图
	 */
	public void setImg(java.lang.String IMG) {
		set("IMG", IMG);
	}

	public java.lang.String getImg() {
		return get("IMG");
	}

	/**
	 * 路径
	 */
	public void setHref(java.lang.String HREF) {
		set("HREF", HREF);
	}

	public java.lang.String getHref() {
		return get("HREF");
	}

	/**
	 * 修改时间
	 */
	public void setUpDateDate(java.lang.String UPDATE_DATE) {
		set("UPDATE_DATE", UPDATE_DATE);
	}

	public java.lang.String getUpDateDate() {
		return get("UPDATE_DATE");
	}

	/**
	 * 备注信息
	 */
	public void setRemarks(java.lang.String REMARKS) {
		set("REMARKS", REMARKS);
	}

	public java.lang.String getRemarks() {
		return get("REMARKS");
	}

	/**
	 * 审核链接
	 */
	public void setApproveHref(java.lang.String APPROVEHREF) {
		set("APPROVEHREF", APPROVEHREF);
	}

	public java.lang.String getApproveHref() {
		return get("APPROVEHREF");
	}

	/**
	 * 活动报表的链接
	 */
	public void setReportHref(java.lang.String REPORTHREF) {
		set("REPORTHREF", REPORTHREF);
	}

	public java.lang.String getReportHref() {
		return get("REPORTHREF");
	}

	/**
	 * 查询当前人申请的活动   路径，返回json
	 * 积分选择的活动
	 */
	public void setIntegralChoiceHref(java.lang.String INTEGRAL_CHOICE_HREF) {
		set("INTEGRAL_CHOICE_HREF", INTEGRAL_CHOICE_HREF);
	}

	public java.lang.String getIntegralChoiceHref() {
		return get("INTEGRAL_CHOICE_HREF");
	}
	
	/**
	 * 对应活动记录查询的链接
	 */
	public void setActivityHref(java.lang.String ACTIVITYHREF) {
		set("ACTIVITYHREF", ACTIVITYHREF);
	}

	public java.lang.String getActivityHref() {
		return get("ACTIVITYHREF");
	}
	
	
}
