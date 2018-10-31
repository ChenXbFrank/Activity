package com.activity.common.model.oneMoneyShop.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 一元购活动配置
 * @author ChenXb
 *
 * 2017年11月24日
 */
@SuppressWarnings("serial")
public class BaseOneMoneyPrize<M extends BaseOneMoneyPrize<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 所属一元购活动ID
	 */
	public void setOneMoneyId(java.lang.String ONE_MONEY_ID) {
		set("ONE_MONEY_ID", ONE_MONEY_ID);
	}

	public java.lang.String getOneMoneyId() {
		return get("ONE_MONEY_ID");
	}

	/**
	 * 奖品名称(这里只是酒)
	 */
	public void setPrizeName(java.lang.String PRIZENAME) {
		set("PRIZENAME", PRIZENAME);
	}

	public java.lang.String getPrizeName() {
		return get("PRIZENAME");
	}

	/**
	 * 奖品图片
	 */
	public void setPrizeImg(java.lang.String PRIZEIMG) {
		set("PRIZEIMG", PRIZEIMG);
	}

	public java.lang.String getPrizeImg() {
		return get("PRIZEIMG");
	}

	/**
	 * 奖品数量
	 */
	public void setPrizeNumber(java.lang.String PRIZENUMBER) {
		set("PRIZENUMBER", PRIZENUMBER);
	}

	public java.lang.String getPrizeNumber() {
		return get("PRIZENUMBER");
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
	 * 度数
	 */
	public void setDeep(java.lang.String DEEP) {
		set("DEEP", DEEP);
	}

	public java.lang.String getDeep() {
		return get("DEEP");
	}
	
	/**
	 * 容量
	 */
	public void setVolume(java.lang.String VOLUME) {
		set("VOLUME", VOLUME);
	}

	public java.lang.String getVolume() {
		return get("VOLUME");
	}
	
	/**
	 * 箱数
	 */
	public void setBoxCount(java.lang.String BOXCOUNT) {
		set("BOXCOUNT", BOXCOUNT);
	}

	public java.lang.String getBoxCount() {
		return get("BOXCOUNT");
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

}
