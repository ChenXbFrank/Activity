package com.activity.common.model.activity.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

@SuppressWarnings("serial")
public class BaseActivityCode<M extends BaseActivityCode<M>> extends Model<M> implements IBean {

	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 微信唯一ID
	 * 
	 * @param OPENID
	 */
	public void setOpenId(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenId() {
		return get("OPENID");
	}
	
	/**
	 * 昵称
	 * 
	 * @param NICKNAME
	 */
	public void setNickName(java.lang.String NICKNAME) {
		set("NICKNAME", NICKNAME);
	}

	public java.lang.String getNickName() {
		return get("NICKNAME");
	}
	/**
	 * 昵称
	 * 
	 * @param HEADIMG
	 */
	public void setHeadImg(java.lang.String HEADIMG) {
		set("HEADIMG", HEADIMG);
	}

	public java.lang.String getHeadImg() {
		return get("HEADIMG");
	}

	/**
	 * 所扫码的CODE
	 * 
	 * @param OPENID
	 */
	public void setCode(java.lang.String CODE) {
		set("CODE", CODE);
	}

	public java.lang.String getCode() {
		return get("CODE");
	}

	/**
	 * 发货信息中的记录ID
	 * 
	 * @param OPENID
	 */
	public void setSellerOutInfoRecordId(java.lang.String SELLEROUTINFO_RECORDID) {
		set("SELLEROUTINFO_RECORDID", SELLEROUTINFO_RECORDID);
	}

	public java.lang.String getSellerOutInfoRecordId() {
		return get("SELLEROUTINFO_RECORDID");
	}

	/**
	 * 扫码次数
	 * 
	 * @param OPENID
	 */
	public void setSignNumber(java.lang.String SING_NUMBER) {
		set("SING_NUMBER", SING_NUMBER);
	}

	public java.lang.String getSignNumber() {
		return get("SING_NUMBER");
	}
	
	/**
	 * 活动标识
	 */
	public void setMark(java.lang.String MARK) {
		set("MARK", MARK);
	}

	public java.lang.String getMark() {
		return get("MARK");
	}

	/**
	 * 参加活动ID
	 * 
	 * @param OPENID
	 */
	public void setActivityId(java.lang.String ACTIVITY_ID) {
		set("ACTIVITY_ID", ACTIVITY_ID);
	}

	public java.lang.String getActivityId() {
		return get("ACTIVITY_ID");
	}
	
	/**
	 * 参加的微信活动
	 */
	public void setActivityWxId(java.lang.String ACTIVITY_WXID) {
		set("ACTIVITY_WXID", ACTIVITY_WXID);
	}

	public java.lang.String getActivityWxId() {
		return get("ACTIVITY_WXID");
	}
	
	/**
	 * 中奖的ID
	 */
	public void setWiningId(java.lang.String WININGID) {
		set("WININGID", WININGID);
	}

	public java.lang.String getWiningId() {
		return get("WININGID");
	}
	
	/**
	 * 中奖类型
	 */
	public void setWinType(java.lang.String WINTYPE) {
		set("WINTYPE", WINTYPE);
	}

	public java.lang.String getWinType() {
		return get("WINTYPE");
	}

	/**
	 * 备用字段一
	 */
	public void setSpareOne(java.lang.String SPARE_ONE) {
		set("SPARE_ONE", SPARE_ONE);
	}

	public java.lang.String getSpareOne() {
		return get("SPARE_ONE");
	}
	
	/**
	 * SELLERPUBLICID
	 */
	public void setSellerPublicId(java.lang.String SELLERPUBLICID) {
		set("SELLERPUBLICID", SELLERPUBLICID);
	}

	public java.lang.String getSellerPublicId() {
		return get("SELLERPUBLICID");
	}
	
	/**
	 * SELLERPUBLICNAME
	 */
	public void setSellerPublicName(java.lang.String SELLERPUBLICNAME) {
		set("SELLERPUBLICNAME", SELLERPUBLICNAME);
	}

	public java.lang.String getSellerPublicName() {
		return get("SELLERPUBLICNAME");
	}
	
	/**
	 * ACTIVITYNAME
	 */
	public void setActivityName(java.lang.String ACTIVITYNAME) {
		set("ACTIVITYNAME", ACTIVITYNAME);
	}

	public java.lang.String getActivityName() {
		return get("ACTIVITYNAME");
	}

}
