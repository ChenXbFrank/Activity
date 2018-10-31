package com.activity.common.controller.pc.sellerOutInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.bigDataPlatform.SellerOutInfo;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerRelationService;
import com.web.controller.ControllerPath;
/**
 * 运单
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/sellerOutInfoConfig")
public class SellerOutInfoController extends BaseController{

	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	/**
	 * 条件筛选运单
	 */
	public void querySellerOutInfo(){
		//货品名称
		String name = getPara("name");
		//开始时间
		String startTime2 = getPara("startTime2");
		//结束时间
		String endTime2 = getPara("endTime2");
		//状态   0=全部 1=接收的货   2=发出的货
		String status = getPara("index");
		SystemUser user = CacheLoginUser();
		List<SellerOutInfo> soiList = null;
		List<SellerOutInfo> sendsoiList = null;
		if(status.equals("0")){
			// 运单信息
			soiList = sellerOutInfoService.querySoiByUserCode(user.getUserCode(),name,startTime2,endTime2);
			//发出的货
			sendsoiList = sellerOutInfoService.querySendSoiByUserCode(user.getTargetId().toString(),name,startTime2,endTime2);
		}else if(status.equals("1")){
			// 运单信息
			soiList = sellerOutInfoService.querySoiByUserCode(user.getUserCode(),name,startTime2,endTime2);
		}else if(status.equals("2")){
			//发出的货
			sendsoiList = sellerOutInfoService.querySendSoiByUserCode(user.getTargetId().toString(),name,startTime2,endTime2);
		}
		if(sendsoiList!=null){
			if(soiList==null){
				soiList=sendsoiList;
			}else{
				for(SellerOutInfo soi : sendsoiList){
					soiList.add(soi);
				}
			}
		}
		// 查询出所有不可用的订单
		List<ActivitySellerOutInfo> asoList = ActivitySellerOutInfoService.getService().getUseActivitySellerOutInfo();
		for (int i = 0; i < soiList.size(); i++) {
			int recordId = soiList.get(i).getRecordId().intValue();
			for (int j = 0; j < asoList.size(); j++) {
				int sellerOutInfoRecordId = Integer.parseInt(asoList.get(j).getSellerOutInfoRecordId());
				if (recordId == sellerOutInfoRecordId) {
					soiList.remove(i);
					i--;
				}
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("soiList", soiList);
		map.put("userTargetId", user.getTargetId());
		renderJson(map);
	}
	
	
}
