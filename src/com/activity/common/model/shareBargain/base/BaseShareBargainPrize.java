package com.activity.common.model.shareBargain.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 分享砍价奖品配置表
 * 
 * @author 小石潭记丶
 *
 *         2017年8月9日
 */
@SuppressWarnings("serial")
public class BaseShareBargainPrize<M extends BaseShareBargainPrize<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 分享砍价活动ID
	 */
	public void setShareBargainId(java.lang.String SHARE_BARGAIN_ID) {
		set("SHARE_BARGAIN_ID", SHARE_BARGAIN_ID);
	}

	public java.lang.String getShareBargainId() {
		return get("ACTIVSHARE_BARGAIN_IDITY_NAME");
	}

	/**
	 * 产品ID
	 */
	public void setProductId(java.lang.String PRODUCTID) {
		set("PRODUCTID", PRODUCTID);
	}

	public java.lang.String getProductId() {
		return get("PRODUCTID");
	}

	/**
	 * 产品图片
	 */
	public void setProductIMG(java.lang.String PRODUCTIMG) {
		set("PRODUCTIMG", PRODUCTIMG);
	}

	public java.lang.String getProductIMG() {
		return get("PRODUCTIMG");
	}

	/**
	 * 奖品数量
	 */
	public void setPrzieNumber(java.lang.Number PRZIE_NUMBER) {
		set("PRZIE_NUMBER", PRZIE_NUMBER);
	}

	public java.lang.Number getPrzieNumber() {
		return get("PRZIE_NUMBER");
	}

	/**
	 * 剩余数量
	 */
	public void setPrzieSurplusNumber(java.lang.Number PRZIE_SURPLUS_NUMBER) {
		set("PRZIE_SURPLUS_NUMBER", PRZIE_SURPLUS_NUMBER);
	}

	public java.lang.Number getPrzieSurplusNumber() {
		return get("PRZIE_SURPLUS_NUMBER");
	}

	/**
	 * 原价格
	 */
	public void setOriginalPrice(java.lang.String ORIGINAL_PRICE) {
		set("ORIGINAL_PRICE", ORIGINAL_PRICE);
	}

	public java.lang.String getOriginalPrice() {
		return get("ORIGINAL_PRICE");
	}

	/**
	 * 最低价
	 */
	public void setLowPrice(java.lang.String LOW_PRICE) {
		set("LOW_PRICE", LOW_PRICE);
	}

	public java.lang.String getLowPrice() {
		return get("LOW_PRICE");
	}

	/**
	 * 砍价区间
	 */
	public void setBargainSection(java.lang.String BARGAIN_SECTION) {
		set("BARGAIN_SECTION", BARGAIN_SECTION);
	}

	public java.lang.String getBargainSection() {
		return get("BARGAIN_SECTION");
	}

	/**
	 * 砍价次数
	 */
	public void setBargainNumber(java.lang.Number BARGAIN_NUMBER) {
		set("BARGAIN_NUMBER", BARGAIN_NUMBER);
	}

	public java.lang.Number getBargainNumber() {
		return get("BARGAIN_NUMBER");
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
	 * 备用字段二
	 */
	public void setSpareTwo(java.lang.String SPARE_TWO) {
		set("SPARE_TWO", SPARE_TWO);
	}

	public java.lang.String getSpareTwo() {
		return get("SPARE_TWO");
	}

	/**
	 * PRODUCTIMG
	 */
	public void setProductImg(java.lang.String PRODUCTIMG) {
		set("PRODUCTIMG", PRODUCTIMG);
	}

	public java.lang.String getProductImg() {
		return get("PRODUCTIMG");
	}
	
	/**
	 * PRIZENAME
	 */
	public void setPrizeName(java.lang.String PRIZENAME) {
		set("PRIZENAME", PRIZENAME);
	}

	public java.lang.String getPrizeName() {
		return get("PRIZENAME");
	}
}
