package com.activity.common.service.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.jfinal.kit.PropKit;

public class ActivitySellerOutInfoService {
	private static ActivitySellerOutInfoService Service = new ActivitySellerOutInfoService();

	private ActivitySellerOutInfoService() {
	}

	public static ActivitySellerOutInfoService getService() {
		return Service;
	}

	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	private final Logger log = LoggerFactory.getLogger(ActivitySellerOutInfoService.class);
	/**
	 * 根据运单查询出与当前运单有关联的活动
	 * 
	 * @param RecordId
	 * @return
	 */
	public ActivitySellerOutInfo getActivitySellerOutInfoByRecordId(String RecordId) {
		String sql = PropKit.use("database.properties").get("getActivitySellerOutInfoByRecordId");
		return ActivitySellerOutInfo.dao.findFirst(sql, RecordId);
	}

	
	/**
	 * 根据瓶码查询出的运单查找开启的活动运单  返回sign 和活动运单
	 */
	public Map<String,Object> getActivitySellerOutInfoByQrcode(String qrcode){
		//根据二维码瓶码查询属于到运单(会有多个运单)
		List<SellerOutInfo> sellList=new ArrayList<>();
		Map<String,Object> map=new HashMap<>();
		//盖外无四位验证码
		if(qrcode.length()==14){
			map.put("sign", 0);
			List<SellerOutInfo> sellList2=new ArrayList<>();
			sellList2 = sellerOutInfoService.getSoiByqrcode(qrcode);
			sellList2.addAll(sellerOutInfoService.getSoiByqrcodeRK(qrcode));
			for(SellerOutInfo soi : sellList2){
				String sql = "select id from TB_ACTIVITY_SELLEROUTINFO where outno = ?";  
				ActivitySellerOutInfo asoi = ActivitySellerOutInfo.dao.findFirst(sql,soi.getOutNo());
				if(asoi!=null){
					sellList.add(soi);
				}
			}	
			//盖内码无四位验证码
		}else if(qrcode.subSequence(0, 1).equals("N")){
			map.put("sign", 0);
			List<SellerOutInfo> sellList2=new ArrayList<>();
			sellList2=sellerOutInfoService.getSoiByqrcode(sellerOutInfoService.getWcodeByNcode(qrcode));
			sellList2.addAll(sellerOutInfoService.getSoiByqrcodeRK(qrcode));
			for(SellerOutInfo soi : sellList2){
				String sql = "select * from TB_ACTIVITY_SELLEROUTINFO where outno = ?";  
				ActivitySellerOutInfo asoi = ActivitySellerOutInfo.dao.findFirst(sql,soi.getOutNo());
				if(asoi!=null){
					sellList.add(soi);
				}
			}	
			//盖外码有四位验证码
		}else{
			map.put("sign", 1);
			List<SellerOutInfo> sellList2=new ArrayList<>();
			sellList2=sellerOutInfoService.getSoiByqrcode(qrcode);
			sellList2.addAll(sellerOutInfoService.getSoiByqrcodeRK(qrcode));
			for(SellerOutInfo soi : sellList2){
				String sql = "select * from TB_ACTIVITY_SELLEROUTINFO where outno = ?";  
				ActivitySellerOutInfo asoi = ActivitySellerOutInfo.dao.findFirst(sql,soi.getOutNo());
				if(asoi!=null){
					sellList.add(soi);
				}
			}	
		}
		log.error("根据瓶码查询运单sellList>"+sellList.toString());
		//这是开启活动的一个运单
		ActivitySellerOutInfo activitySellerInfo=null;
		for (SellerOutInfo sellerOutInfo : sellList) {
			ActivitySellerOutInfo activitySellerOutInfoByRecordId = ActivitySellerOutInfoService.getService()
			.getActivitySellerOutInfoByRecordId(sellerOutInfo.getRecordId().toString());
			if(activitySellerOutInfoByRecordId!=null){
				activitySellerInfo = activitySellerOutInfoByRecordId;
			}
		}
		map.put("activitySellerInfo", activitySellerInfo);
		return map;
	}
	
	
	/**
	 * 查询出已经使用的运单信息
	 * 
	 * @return
	 */
	public List<ActivitySellerOutInfo> getUseActivitySellerOutInfo() {
		String sql = PropKit.use("database.properties").get("getUseActivitySellerOutInfo");
		List<ActivitySellerOutInfo> aso = ActivitySellerOutInfo.dao.find(sql);
		return aso;
	}
}
