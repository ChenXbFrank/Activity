package com.activity.common.model.shareBargain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.shareBargain.base.BaseShareBargainWxuser;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 活动 可以申请的活动
 * 
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class ShareBargainWxuser extends BaseShareBargainWxuser<ShareBargainWxuser> {
	public static final ShareBargainWxuser dao = new ShareBargainWxuser();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public ShareBargainWxuser mapping(Record cord, ShareBargainWxuser info) {
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setJoinActivityId(cord.getStr("JOIN_ACTIVITY_ID"));
		info.setJoinBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setPrice(cord.getStr("PRICE"));
		info.setNowPrice(cord.getStr("NOW_PRICE"));
		info.setLowPrice(cord.getStr("LOW_PRICE"));
		info.setBargainSection(cord.getStr("BARGAIN_SECTION"));
		info.setBargainNumber(cord.getStr("BARGAIN_NUMBER"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setConsigneeName(cord.getStr("CONSIGNEE_NAME"));
		info.setConsigneeAddress(cord.getStr("CONSIGNEE_ADDRESS"));
		info.setConsigneePhone(cord.getStr("CONSIGNEE_PHONE"));
		info.setPayMoney(cord.getStr("PAY_MONEY"));
		info.setGoodsState(cord.getStr("GOODS_STATE"));
		info.setGoodsOddNumber(cord.getStr("GOODS_ODD_NUMBER"));
		info.setGoodsTime(cord.getStr("GOODS_TIME"));
		info.setGoodsCompany(cord.getStr("GOODS_COMPANY"));
		info.setId(cord.getStr("ID"));
		info.setshareBargainPrizeId(cord.getStr("SHAREBARGAIN_PRIZE_ID"));
		info.setPayOrder(cord.getStr("PAY_ORDER"));
		info.setMchId(cord.getStr("MCH_ID"));
		info.setState(cord.getStr("STATE"));
		info.setScanCode(cord.getStr("SCAN_CODE"));
		info.setSendName(cord.getStr("SENDNAME"));
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
		String sql=" from TB_SHARE_BARGAIN_WXUSER where 1=1 ";
		if (!"".equals(activityId)&&activityId!=null) {
			sql += " and JOIN_ACTIVITY_ID = '" + activityId+"'";
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
		Page<ShareBargainWxuser> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			ShareBargainWxuser sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("nickName", sb.getNickName());
			model.put("headimgurl", sb.getHeadImgUrl());
			model.put("create_time", sb.getCreateTime());
			model.put("state", sb.getState());
			model.put("goodstate", sb.getGoodsState());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
