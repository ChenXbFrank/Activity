package com.activity.common.model.activity.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 活动与运单表
 * 
 * @author cxb
 *
 */
@SuppressWarnings("serial")
public class BaseActivitySellerOutInfo<M extends BaseActivitySellerOutInfo<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 活动ID
	 */
	public void setActivityId(java.lang.String ACTIVITY_ID) {
		set("ACTIVITY_ID", ACTIVITY_ID);
	}

	public java.lang.String getActivityId() {
		return get("ACTIVITY_ID");
	}

	/**
	 * 发货信息中的记录ID
	 */
	public void setSellerOutInfoRecordId(java.lang.String SELLEROUTINFO_RECORDID) {
		set("SELLEROUTINFO_RECORDID", SELLEROUTINFO_RECORDID);
	}

	public java.lang.String getSellerOutInfoRecordId() {
		return get("SELLEROUTINFO_RECORDID");
	}

	/**
	 * 出库单号
	 */
	public void setOutNo(java.lang.String OUTNO) {
		set("OUTNO", OUTNO);
	}

	public java.lang.String getOutNo() {
		return get("OUTNO");
	}

	/**
	 * 经销商userCode
	 */
	public void setSellerUserCode(java.lang.String SELLER_USERCODE) {
		set("SELLER_USERCODE", SELLER_USERCODE);
	}

	public java.lang.String getSellerUserCode() {
		return get("SELLER_USERCODE");
	}

	/**
	 * 状态 1可以用 2不可用
	 */
	public void setState(java.lang.String STATE) {
		set("STATE", STATE);
	}

	public java.lang.String getState() {
		return get("STATE");
	}

	/**
	 * 所属活动
	 */
	public void setBelongActivity(java.lang.String BELONG_ACTIVITY) {
		set("BELONG_ACTIVITY", BELONG_ACTIVITY);
	}

	public java.lang.String getBelongActivity() {
		return get("BELONG_ACTIVITY");
	}

	/**
	 * 该运单的渠道商
	 */
	public void setOutSellerName(java.lang.String OUTSELLERNAME) {
		set("OUTSELLERNAME", OUTSELLERNAME);
	}

	public java.lang.String getOutSellerName() {
		return get("OUTSELLERNAME");
	}

	/**
	 * 货品名称
	 */
	public void setProductName(java.lang.String PRODUCTNAME) {
		set("PRODUCTNAME", PRODUCTNAME);
	}

	public java.lang.String getProductName() {
		return get("PRODUCTNAME");
	}

	/**
	 * 度数
	 */
	public void setDeep(java.lang.Number DEEP) {
		set("DEEP", DEEP);
	}

	public java.lang.Number getDeep() {
		return get("DEEP");
	}

	/**
	 * 容量
	 */
	public void setVolume(java.lang.Number VOLUME) {
		set("VOLUME", VOLUME);
	}

	public java.lang.Number getVolume() {
		return get("VOLUME");
	}

	/**
	 * 规格
	 */
	public void setSpec(java.lang.String SPEC) {
		set("SPEC", SPEC);
	}

	public java.lang.String getSpec() {
		return get("SPEC");
	}

	/**
	 * 箱数
	 */
	public void setBoxSize(java.lang.String BOXSIZE) {
		set("BOXSIZE", BOXSIZE);
	}

	public java.lang.String getBoxSize() {
		return get("BOXSIZE");
	}

	/**
	 * 品牌名称
	 */
	public void setBandName(java.lang.String BANDNAME) {
		set("BANDNAME", BANDNAME);
	}

	public java.lang.String getBandName() {
		return get("BANDNAME");
	}
	
	/**
	 * 出库时间
	 * 
	 * @param OUTDATE
	 */
	public void setOutDate(java.lang.String OUTDATE) {
		set("OUTDATE", OUTDATE);
	}

	public java.lang.String getOutDate() {
		return get("OUTDATE");
	}
	
	/**
	 * 1接收的货  2发出的货
	 * 
	 * @param OUTDATE
	 */
	public void setSendorRec(java.lang.String SENDORREC) {
		set("SENDORREC", SENDORREC);
	}

	public java.lang.String getSendorRec() {
		return get("SENDORREC");
	}
}
