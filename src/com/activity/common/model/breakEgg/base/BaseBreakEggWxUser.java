package com.activity.common.model.breakEgg.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 砸蛋移动端用户
 * @author ChenXb
 *
 * 2017年12月1日
 */
@SuppressWarnings("serial")
public class BaseBreakEggWxUser<M extends BaseBreakEggWxUser<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 活动ID
	 */
	public void setBreakEggId(java.lang.String BREAKEGG_ID) {
		set("BREAKEGG_ID", BREAKEGG_ID);
	}

	public java.lang.String getBreakEggId() {
		return get("BREAKEGG_ID");
	}

	/**
	 * 微信指定ID
	 */
	public void setOpenId(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenId() {
		return get("OPENID");
	}

	/**
	 * 微信昵称
	 */
	public void setNickName(java.lang.String NICKNAME) {
		set("NICKNAME", NICKNAME);
	}

	public java.lang.String getNickName() {
		return get("NICKNAME");
	}

	/**
	 * 微信头像
	 */
	public void setHeadImgUrl(java.lang.String HEADIMGURL) {
		set("HEADIMGURL", HEADIMGURL);
	}

	public java.lang.String getHeadImgUrl() {
		return get("HEADIMGURL");
	}

	/**
	 * 所属公众号
	 */
	public void setBelongPublicNumberId(java.lang.String BELONG_PUBLICNUMBER_ID) {
		set("BELONG_PUBLICNUMBER_ID", BELONG_PUBLICNUMBER_ID);
	}

	public java.lang.String getBelongPublicNumberId() {
		return get("BELONG_PUBLICNUMBER_ID");
	}
	
	/**
	 * 活动创建时间
	 */
	public void setCreateTime(java.lang.String CREATE_TIME) {
		set("CREATE_TIME", CREATE_TIME);
	}

	public java.lang.String getCreateTime() {
		return get("CREATE_TIME");
	}
	
	/**
	 * 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货 6已支付
	 */
	public void setState(java.lang.String STATE) {
		set("STATE", STATE);
	}

	public java.lang.String getState() {
		return get("STATE");
	}
	
	/**
	 * 扫码CODE
	 */
	public void setScanCode(java.lang.String SCAN_CODE) {
		set("SCAN_CODE", SCAN_CODE);
	}

	public java.lang.String getScanCode() {
		return get("SCAN_CODE");
	}

	/**
	 * 砸蛋奖品ID
	 */
	public void setBreakEggPrzieId(java.lang.String BREAKEGG_PRZIE_ID) {
		set("BREAKEGG_PRZIE_ID", BREAKEGG_PRZIE_ID);
	}

	public java.lang.String getBreakEggPrzieId() {
		return get("BREAKEGG_PRZIE_ID");
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
	 * 总金额
	 */
	public void setTotalMoney(java.lang.String TOTAL_MONEY) {
		set("TOTAL_MONEY", TOTAL_MONEY);
	}

	public java.lang.String getTotalMoney() {
		return get("TOTAL_MONEY");
	}
	
	/**
	 * 单次参与中奖积分
	 */
	public void setTotalIntegral(java.lang.String TOTAL_INTEGRAL) {
		set("TOTAL_INTEGRAL",TOTAL_INTEGRAL);
	}

	public java.lang.String getTotalIntegral() {
		return get("TOTAL_INTEGRAL");
	}
	
	/**
	 * 谢谢惠顾
	 */
	public void setThankNumber(java.lang.String THANKNUMBER) {
		set("THANKNUMBER",THANKNUMBER);
	}

	public java.lang.String getThankNumber() {
		return get("THANKNUMBER");
	}

	/**
	 * 实物次数
	 */
	public void setGoodsNumber(java.lang.String GOODSNUMBER) {
		set("GOODSNUMBER",GOODSNUMBER);
	}

	public java.lang.String getGoodsNumber() {
		return get("GOODSNUMBER");
	}
	

	/**
	 * 是否砸过了  是否砸过了  0没有砸过  1砸过了
	 */
	public void setIsClick(java.lang.String ISCLICK) {
		set("ISCLICK",ISCLICK);
	}

	public java.lang.String getIsClick() {
		return get("ISCLICK");
	}
}
