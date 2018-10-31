package com.activity.common.model.fireStorm;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.fireStorm.base.BaseFireStormRedWxUser;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 火爆小酒红包活动 
 * @author ChenXb
 *
 * 2018年7月3日      FIRE_STORM_RED_WXUSER
 */
@SuppressWarnings("serial")
public class FireStormRedWxUser extends BaseFireStormRedWxUser<FireStormRedWxUser>{
	public static final FireStormRedWxUser dao = new FireStormRedWxUser();
	
	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public FireStormRedWxUser mapping(Record cord, FireStormRedWxUser info) {
		info.setId(cord.getStr("ID"));
		info.setRedId(cord.getStr("RED_ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setState(cord.getStr("STATE"));
		info.setScanCode(cord.getStr("SCAN_CODE"));
		info.setScanRedNumber(cord.getStr("SCAN_RED_NUMBER"));	
		info.setTotalMoney(cord.getStr("TOTAL_MONEY"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		return info;
	}
	
	/**
	 * 根据红包用户的ID查询出用户
	 * @param id
	 * @return
	 */
	public ShareBargainWxuser getShareBargainHelpById(String id) {
		String sql = PropKit.use("database.properties").get("getShareBargainHelpById");
		ShareBargainWxuser rest = new ShareBargainWxuser();
		List<Record> rec = Db.find(sql,id);
		for(Record re : rec){
			ShareBargainWxuser wxUser = new ShareBargainWxuser();
			rest=wxUser.mapping(re, rest);
		}
		return rest;
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
		String sql=" from FIRE_STORM_RED_WXUSER t where 1=1";
		if (!"".equals(activityId)&&activityId!=null) {
			sql += " and t.RED_ID = '" + activityId+"'";
		}
		// 这里是模糊查询名字
		if (!"".equals(nickName)&&nickName!=null) {
			sql += "and t.NICKNAME like '%" + nickName + "%'";
		}
		Page<FireStormRedWxUser> page = paginate(pageNumber, pageSize, "select * ", sql+" order by t.CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			FireStormRedWxUser sb = page.getList().get(i);
			model.put("id", sb.getId());
			if(StringUtils.isEmpty(sb.getNickName())){
				model.put("nickName", "未关注");
			}else{
				model.put("nickName", sb.getNickName());
			}
			model.put("headimgurl", sb.getHeadImgUrl());
			model.put("create_time", sb.getCreateTime());
			model.put("scannumber", sb.getScanRedNumber());
			model.put("money", sb.getTotalMoney());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
