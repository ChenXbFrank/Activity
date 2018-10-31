package com.activity.common.service.system;

import java.util.Map;
import com.activity.common.model.system.Advert;

public class AdvertService {
	
	private static AdvertService service = new AdvertService();
	private AdvertService() {}
	public static AdvertService getService(){return service;}
	
	/**
	 * 分页查询 查询所有的红包活动的信息
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String applyusername,String phone,String state) {
		return Advert.dao.paginate(pageNumber, pageSize,applyusername,phone,state);
	}
}
