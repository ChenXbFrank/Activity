package com.activity.common.model.integral.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 集赞活动
 * @author ChenXb
 *
 * 2017年11月6日
 */
@SuppressWarnings("serial")
public class BaseJoinActivity<M extends BaseJoinActivity<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	public void setIntegralId(java.lang.String INTEGRALID) {
		set("INTEGRALID", INTEGRALID);
	}

	public java.lang.String getIntegralId() {
		return get("INTEGRALID");
	}
	
	public void setJoinIntegral(java.lang.String JOIN_INTEGRAL) {
		set("JOIN_INTEGRAL", JOIN_INTEGRAL);
	}

	public java.lang.String getJoinIntegral() {
		return get("JOIN_INTEGRAL");
	}
	
	/**
	 * 活动名称
	 */
	public void setActivityName(java.lang.String ACTIVITYNAME) {
		set("ACTIVITYNAME", ACTIVITYNAME);
	}

	public java.lang.String getActivityName() {
		return get("ACTIVITYNAME");
	}
	
	
	/**
	 * 活动标识
	 */
	public void setActivityMark(java.lang.String ACTIVITYMARK) {
		set("ACTIVITYMARK", ACTIVITYMARK);
	}

	public java.lang.String getActivityMark() {
		return get("ACTIVITYMARK");
	}
	

	/**
	 * 参与时间
	 */
	public void setJoinTime(java.lang.String JOINTIME) {
		set("JOINTIME", JOINTIME);
	}

	public java.lang.String getJoinTime() {
		return get("JOINTIME");
	}

	
	/**
	 * openid
	 */
	public void setOpenid(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenid() {
		return get("OPENID");
	}
	
	/**
	 * SELLERPUBLICNUMBERID
	 */
	public void setSellerPublicnumberid(java.lang.String SELLERPUBLICNUMBERID) {
		set("SELLERPUBLICNUMBERID", SELLERPUBLICNUMBERID);
	}

	public java.lang.String getSellerPublicnumberid() {
		return get("SELLERPUBLICNUMBERID");
	}
}
