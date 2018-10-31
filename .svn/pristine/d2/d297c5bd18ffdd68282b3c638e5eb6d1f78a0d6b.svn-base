package com.activity.common.service.robRed;

import java.util.List;

import com.activity.common.model.robRed.RobRedPrize;
import com.jfinal.kit.PropKit;

/**
 * 抢红包奖品信息
 * @author 唐
 *
 */
public class RobRedPrizeService {
	private static RobRedPrizeService robRedPrizeService = new RobRedPrizeService();
	private RobRedPrizeService() {
	}
	public static RobRedPrizeService getService() {
		return robRedPrizeService;
	}
	
	/**
	 * 根据activityId查询抢红包奖品配置
	 * @param activityId
	 */
	public List<RobRedPrize> getRobRedPrizeByActivityId(String activityId){
		String sql = PropKit.use("database.properties").get("getRobRedPrizeByActivityId");
		List<RobRedPrize> rrpList = RobRedPrize.dao.find(sql,activityId);
		return rrpList;
	}
	
	/**
	 * 转积分对象
	 */
	public RobRedPrize IntegralRRP(RobRedPrize rrpBL){
		RobRedPrize IntegralRRP = new RobRedPrize();
		IntegralRRP.setRedPrizeId(rrpBL.getRedPrizeId());
		IntegralRRP.setRedId(rrpBL.getRedId());
		IntegralRRP.setPrizeProject("积分");
		IntegralRRP.setPrizeProjectMoney(rrpBL.getWinningIntegral());//积分和金额都存放在奖项金额中
		IntegralRRP.setGetPrizeNumber(rrpBL.getWinningIntegralNumber());
		IntegralRRP.setSurplusIntegral(rrpBL.getSurplusIntegral());
		IntegralRRP.setSurplusMoney(rrpBL.getSurplusMoney()); 
		IntegralRRP.setScanRodRedNum(rrpBL.getScanRodRedNum());
		IntegralRRP.setRedWinningProbability(rrpBL.getIntegralWinningProbability());
		IntegralRRP.setProbabilityTotal(rrpBL.getIntegralProbabilityTotal());
		IntegralRRP.setSurplusProbability(rrpBL.getSurplusProbability());
		IntegralRRP.setSurplusNumber(rrpBL.getSurplusIntegralNumber());
		IntegralRRP.setSurplusPrizeProbability(rrpBL.getSurplusIntegralProbability());
		return IntegralRRP;
	}
	
	/**
	 * 转红包对象
	 */
	public RobRedPrize redRRP(RobRedPrize rrpBL){
		RobRedPrize redRRP = new RobRedPrize();
		redRRP.setRedPrizeId(rrpBL.getRedPrizeId());
		redRRP.setRedId(rrpBL.getRedId());
		redRRP.setPrizeProject("红包");
		redRRP.setPrizeProjectMoney(rrpBL.getPrizeProjectMoney());
		redRRP.setGetPrizeNumber(rrpBL.getGetPrizeNumber());
		redRRP.setSurplusIntegral(rrpBL.getSurplusIntegral());
		redRRP.setSurplusMoney(rrpBL.getSurplusMoney()); 
		redRRP.setScanRodRedNum(rrpBL.getScanRodRedNum());
		redRRP.setRedWinningProbability(rrpBL.getRedWinningProbability());
		redRRP.setProbabilityTotal(rrpBL.getProbabilityTotal());//红包中奖概率合计=积分中奖概率合计
		redRRP.setSurplusProbability(rrpBL.getSurplusProbability());
		redRRP.setSurplusNumber(rrpBL.getSurplusNumber());//红包剩余数量=积分剩余数量
		redRRP.setSurplusPrizeProbability(rrpBL.getSurplusPrizeProbability());//红包剩余概率=积分剩余概率
		return redRRP;
	}
}
