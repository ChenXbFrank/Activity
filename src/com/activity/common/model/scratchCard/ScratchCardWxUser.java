package com.activity.common.model.scratchCard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.scratchCard.base.BaseScratchCardWxUser;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 刮刮乐活动微信用户参与记录
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class ScratchCardWxUser extends BaseScratchCardWxUser<ScratchCardWxUser>{
	public static final ScratchCardWxUser dao = new ScratchCardWxUser();
	
	public ScratchCardWxUser mapping(Record cord, ScratchCardWxUser info) {
		info.setScratchCardWxuserId(cord.getStr("SCRATCHCARD_WXUSER_ID"));
		info.setScratchCardId(cord.getStr("SCRATCHCARD_ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setState(cord.getStr("STATE"));
		info.setScanCode(cord.getStr("SCAN_CODE"));
		info.setScanWinningNumber(cord.getStr("SCAN_WINNING_NUMBER"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setTotalMoney(cord.getStr("TOTAL_MONEY"));
		info.setTotalIntegral(cord.getStr("TOTAL_INTEGRAL"));
		info.setIntegralWinningNumber(cord.getStr("INTEGRAL_WINNING_NUMBER"));
		info.setRedWinningNumber(cord.getStr("RED_WINNING_NUMBER"));
		info.setGoodsWinningNumber(cord.getStr("GOODS_WINNING_NUMBER"));
		info.setThinkWinningNumber(cord.getStr("THINK_WINNING_NUMBER"));
		return info;
	}
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityId, String nickName,String state,String goodsState) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_SCRATCHCARD_WXUSER where 1=1 ";
		if (!"".equals(activityId)&&activityId!=null) {
			sql += " and SCRATCHCARD_ID = '" + activityId+"'";
		}
		// 这里是模糊查询名字
		if (!"".equals(nickName)&&nickName!=null) {
			sql += "and NICKNAME like '%" + nickName + "%'";
		}
		if (!"".equals(state)&&state!=null) {
			//1是未成功   其他都是成功
			if(state.equals("7")){
				sql += " and STATE != " + 1;
			}else{
				sql += " and STATE = " + state;
			}
		}
		if (!"".equals(goodsState)&&goodsState!=null) {
			sql += " and GOODS_STATE = " + goodsState;
		}
		Page<ScratchCardWxUser> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			ScratchCardWxUser sb = page.getList().get(i);
			model.put("id", sb.getScratchCardWxuserId());
			model.put("cardid", sb.getScratchCardId());
			model.put("activityname", sb.getActivityName());
			if(StringUtils.isEmpty(sb.getNickName())){
				model.put("nickName", "未关注");
			}else{
				model.put("nickName", sb.getNickName());
			}
			model.put("headimgurl", sb.getHeadImgUrl());
			model.put("create_time", sb.getCreateTime());
			model.put("state", sb.getState());
			model.put("redNum", sb.getRedWinningNumber());
			model.put("goodNum", sb.getGoodsWinningNumber());
			model.put("IntegralNum", sb.getIntegralWinningNumber());
			model.put("thankNum", sb.getThinkWinningNumber());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}