package com.activity.common.model.turntable;

import com.activity.common.model.turntable.base.BaseTurnTablePrize;
import com.jfinal.plugin.activerecord.Record;

/**
 * 转盘奖品配置
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class TurnTablePrize extends BaseTurnTablePrize<TurnTablePrize>{
	
	public static final TurnTablePrize dao = new TurnTablePrize();
	
	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public TurnTablePrize mapping(Record cord, TurnTablePrize info) {
		info.setTurnTablePrizeId(cord.getStr("TURNTABLE_PRIZE_ID"));
		info.setTurnTableId(cord.getStr("TURNTABLE_ID"));
		info.setPrizeType(cord.getStr("PRIZE_TYPE"));
		info.setOrderNumber(cord.getStr("ORDER_NUMBER"));
		info.setPrizeImg(cord.getStr("PRIZE_IMG"));
		info.setPrizeName(cord.getStr("PRIZE_NAME"));
		info.setPrizeNumber(cord.getStr("PRIZE_NUMBER"));
		info.setSurplusPrizeNumber(cord.getStr("SURPLUS_PRIZE_NUMBER"));
		info.setPrizeProbability(cord.getStr("PRIZE_PROBABILITY"));
		info.setSurplusPrizeProbability(cord.getStr("SURPLUS_PRIZE_PROBABILITY"));
		info.setIntegralNumber(cord.getStr("INTEGRAL_NUMEBR"));
		info.setRedNumber(cord.getStr("RED_NUMBER"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		return info;
	}
}
