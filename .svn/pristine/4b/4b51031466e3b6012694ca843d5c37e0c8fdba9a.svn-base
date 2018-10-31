package com.activity.common.model.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.activity.common.model.system.base.BaseAdvert;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class Advert extends BaseAdvert<Advert> {
	public static final Advert dao = new Advert();
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String applyusername,String phone,String state) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_ADVERT where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(applyusername) &&applyusername!=null) {
			sql += " and APPLYNAME like '%" + applyusername + "%'";
		}
		if (!"".equals(phone) &&phone!=null) {
			sql += " and APPLYPHONE like '%" + phone + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		Page<Advert> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			Advert sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("sellerpublicid", sb.getSellerPublicId());
			model.put("pictrue", sb.getPicture());
			model.put("logo", sb.getLogo());
			model.put("advert_url", sb.getAdvertUrl());
			model.put("applyuserid", sb.getApplyUserId());
			model.put("create_time", sb.getCreateTime());
			model.put("applyphone", sb.getApplyPhone());
			model.put("applyname", sb.getApplyName());
			model.put("state", sb.getStart());
			model.put("comfirmusername", sb.getComfirmuserName());
			model.put("comfirmtime", sb.getComfirmTime());
			model.put("comfirmuserid", sb.getComfirmuserId());
			model.put("comfirmadvise", sb.getComfirmAdvise());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
