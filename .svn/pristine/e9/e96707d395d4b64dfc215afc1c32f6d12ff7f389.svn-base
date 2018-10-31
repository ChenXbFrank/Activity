package com.activity.common.service.activity;

import java.util.List;

import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.integral.IntegalExchange;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;

/**
 * 实物产品中奖记录
 * @author 唐
 *
 */
public class ProductWinningInfoService {
	private static ProductWinningInfoService Service = new ProductWinningInfoService();
	private ProductWinningInfoService(){}
	public static ProductWinningInfoService getService() {return Service;}
	
	/**
	 * 保存一个产品中奖信息
	 * @param info
	 * @return
	 */
	public int saveProductWinningInfo(ProductWinningInfo info){
		String sql = PropKit.use("database.properties").get("saveProductWinningInfo");
		return Db.update(sql,info.getId(),info.getBelongActivityId(),info.getActivityName(),info.getActivityNameType(),info.getProductId()
				,info.getProductName(),info.getProductImg(),info.getActivityPrizeId(),info.getCreateTime(),info.getStartTime(),info.getEndTime(),info.getOpenId()
				,info.getActivityWxUserId(),info.getBelongPublicNumberId(),info.getState(),info.getWinningInfoId(),info.getAddresseeName(),info.getAddresseeAddress(),
				info.getAddresseePhone(),info.getPayMoney(),info.getPrice(),info.getLowPrice());
	}
	
	/**
	 * 查询出所有实物中奖记录
	 */
	public List<ProductWinningInfo> queryProductWinningInfo(String openid,String appid,String activeName,String state){
		String sql = PropKit.use("database.properties").get("queryProductWinningInfo");
		if(activeName != null && !"".equals(activeName)){
			sql += " AND ACTIVITY_NAME like '%" + activeName + "%'";
		}
		//2.未填写地址  7.待付款  8.待发货 4.已发货
		if(state != null && !"".equals(state)){
			if(state.equals("2")){
				sql += " AND STATE = "+state;
			}
			//待付款 先是地址填写了 
			else if(state.equals("7")){
				String s="3";
				sql += " AND STATE = '"+s +"' and LOW_PRICE != '0' and  PAY_MONEY ='0' ";
			}
			//待发货
			else if(state.equals("8")){
				//两种情况  0元砍价 地址填了即可    要钱的砍价地址填了 最低价不为0 并且支付金额不为0 
				String s="3";
				//这是0元砍价
				sql += " AND STATE = '"+s +"' and DELIVER_COMPANY  IS  NULL  and LOW_PRICE = PAY_MONEY ";
				//待付款的条件也满足
			}
			//已发货
			else if(state.equals("4")){
				sql += " AND STATE = "+state;
			}
			
		}
		sql += " order by  CREATE_TIME desc";
		return ProductWinningInfo.dao.find(sql,openid,appid);
	}
	
	/**
	 *修改实物中奖记录奖品记录 
	 */
	public boolean updatePrazleInfo(String productWinningInfoId,String name,String address ,String tel){
		boolean resutl = new ProductWinningInfo().set("ID", productWinningInfoId).set("STATE", "3").set("ADDRESSEE_NAME", name).set("ADDRESSEE_ADDRESS", address)
		.set("ADDRESSEE_PHONE", tel).update();
		return resutl;
	}
	
	
	/**
	 *修改参与积分小游戏记录的地址
	 */
	public boolean updateIntegarlPrazleInfo(String productWinningInfoId,String name,String address ,String tel){
		boolean resutl =new IntegalExchange().set("INTEGRAL_EXCHANGE_ID", productWinningInfoId).set("STATE", "3").set("ADDRESSEE_NAME", name).set("ADDRESSEE_ADDRESS", address)
		.set("ADDRESSEE_PHONE", tel).update();
		return resutl;
	}
}
