package com.activity.common.model.centerObjcet.wx;

/**
 * 微信卡券状态
 * 
 * @author 唐
 *
 */
public class WxCardStatus {
	// 错误码
	private String errcode;
	// 错误信息
	private String errmsg;
	// 卡券信息
	private WxCardOnCode card;
	// 用户openid
	private String openid;
	// 是否可以核销，true为可以核销，false为不可核销
	private String can_consume;
	// 当前code对应卡券的状态
	// NORMAL=正常 CONSUMED=已核销 EXPIRE=已过期 GIFTING=转赠中 GIFT_TIMEOUT=转赠超时
	// DELETE=已删除 UNAVAILABLE=已失效
	// code未被添加或被转赠领取的情况则统一报错：invalid serial code
	private String user_card_status;

	public String getErrcode() {
		return errcode;
	}

	public void setErrcode(String errcode) {
		this.errcode = errcode;
	}

	public String getErrmsg() {
		return errmsg;
	}

	public void setErrmsg(String errmsg) {
		this.errmsg = errmsg;
	}

	public WxCardOnCode getCard() {
		return card;
	}

	public void setCard(WxCardOnCode card) {
		this.card = card;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getCan_consume() {
		return can_consume;
	}

	public void setCan_consume(String can_consume) {
		this.can_consume = can_consume;
	}

	public String getUser_card_status() {
		return user_card_status;
	}

	public void setUser_card_status(String user_card_status) {
		this.user_card_status = user_card_status;
	}

}
