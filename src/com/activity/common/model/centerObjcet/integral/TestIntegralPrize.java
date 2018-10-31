package com.activity.common.model.centerObjcet.integral;

/**
 * @author ChenXb
 *
 * 2018年5月10日
 */
public class TestIntegralPrize {
	private String name;
	//奖品类型  积分、红包、实物、谢谢惠顾
	private String type;
	//权重，值越大  中奖概率越大
	private String weight;
	//红包值
	private String money;
	//积分值
	private String integral;
	//奖品图片
	private String picture;
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getIntegral() {
		return integral;
	}
	public void setIntegral(String integral) {
		this.integral = integral;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	
}
