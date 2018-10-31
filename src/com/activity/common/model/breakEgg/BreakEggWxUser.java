package com.activity.common.model.breakEgg;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.breakEgg.base.BaseBreakEggWxUser;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 砸蛋参与微信用户
 * @author ChenXb
 *
 * 2017年12月1日
 */
@SuppressWarnings("serial")
public class BreakEggWxUser extends BaseBreakEggWxUser<BreakEggWxUser>{
	public static final BreakEggWxUser dao = new BreakEggWxUser();
	
	public BreakEggWxUser mapping(Record cord, BreakEggWxUser info) {
		info.setId(cord.getStr("ID"));
		info.setBreakEggId(cord.getStr("BreakEgg_ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setState(cord.getStr("STATE"));
		info.setScanCode(cord.getStr("SCAN_CODE"));
		info.setBreakEggPrzieId(cord.getStr("BREAKEGG_PRZIE_ID"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setSpareTwo(cord.getStr("SPARE_TWO"));
		info.setTotalMoney(cord.getStr("TOTAL_MONEY"));
		info.setTotalIntegral(cord.getStr("TOTAL_INTEGRAL"));
		info.setThankNumber(cord.getStr("THANKNUMBER"));
		info.setGoodsNumber(cord.getStr("GOODSNUMBER"));
		info.setIsClick(cord.getStr("ISCLICK"));
		return info;
	}
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate1(int pageNumber, int pageSize,String activityId, String nickName) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_BREAKEGG_WXUSER where 1=1 ";
		if (!"".equals(activityId)&&activityId!=null) {
			sql += " and BREAKEGG_ID = '" + activityId+"'";
		}
		// 这里是模糊查询名字
		if (!"".equals(nickName)&&nickName!=null) {
			sql += "and NICKNAME like '%" + nickName + "%'";
		}
		Page<BreakEggWxUser> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			BreakEggWxUser sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("eggId", sb.getBreakEggId());
			model.put("activityname", sb.getActivityName());
			if(StringUtils.isEmpty(sb.getNickName())){
				model.put("nickName", "未关注");
			}else{
				model.put("nickName", sb.getNickName());
			}
			model.put("headimgurl", sb.getHeadImgUrl());
			model.put("create_time", sb.getCreateTime());
			model.put("redMoney", sb.getTotalMoney());
			model.put("integral", sb.getTotalIntegral());
			model.put("goodsNum", sb.getGoodsNumber());
			model.put("thankNum", sb.getThankNumber());
			model.put("state", sb.getState());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}