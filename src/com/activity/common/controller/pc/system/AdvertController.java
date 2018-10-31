package com.activity.common.controller.pc.system;

import java.util.HashMap;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.system.Advert;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.system.AdvertService;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.kit.PropKit;
import com.web.controller.ControllerPath;

/**
 * 广告控制器
 * 
 * @author ChenXb
 *
 *         2018年5月30日
 */
@ControllerPath(controllerKey = "/advert")
public class AdvertController extends BaseController {

	/**
	 * 广告模块（上传广告）
	 */
	public void index() {
		SystemUser user = CacheLoginUser();
		//根据此UserCode查询当前人是否存在广告
		String sql = "select * from TB_ADVERT where APPLYUSERID =?";
		Advert advert = Advert.dao.findFirst(sql,user.getUserCode());
		setAttr("advert", advert);
		render("/system/advert.html");
	}

	/**
	 * 广告模块（广告保存）
	 */
	public void approveSave() {
		SystemUser user = CacheLoginUser();
		String userCode = user.getUserCode();
		// 扫码页面的背景图
		String picture = getPara("picture");
		// 公司logo
		String logo = getPara("logo");
		// 广告图
		String advertUrl = getPara("advert");
		System.out.println("picture="+picture+"=logo="+logo+"=advert="+advertUrl);
		//根据此UserCode查询当前人是否存在广告
		String sql = "select * from TB_ADVERT where APPLYUSERID =?";
		Advert advert = Advert.dao.findFirst(sql,userCode);
		Boolean result = false;
		if(advert==null){
			result = new Advert().set("ID", newId()).set("APPLYUSERID",user.getUserCode()).set("CREATE_TIME",DateUitils.DateToString()).set("APPLYPHONE", user.getPhone())
			.set("APPLYNAME", user.getUserName()).set("STATE", "0").set("ADVERT_URL", advertUrl).set("PICTRUE", picture).set("LOGO", logo).save();
		}else{
			result = new Advert().set("ID", advert.getId()).set("APPLYUSERID",user.getUserCode()).set("APPLYPHONE", user.getPhone())
					.set("APPLYNAME", user.getUserName()).set("STATE", "0").set("ADVERT_URL", advertUrl).set("PICTRUE", picture).set("LOGO", logo).update();
		}
		renderJson(result);
	}
	
	/**
	 * 广告模块（广告审批）
	 */
	public void approve() {
		
		render("/system/approveAdvert.html");
	}
	
	/**
	 * 广告模块（广告审批列表）
	 */
	public void approveAll() {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String applyusername = getPara("applyusername");
		String phone = getPara("phone");
		String state = getPara("state");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = AdvertService.getService().paginate(Integer.parseInt(currentPage), page,applyusername,phone,state);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));		
		renderJson(model);
	}
	
	/**
	 * 审批详细
	 */
	public void approvalDetailed(){
		String advertId = getPara("advertid");
		Advert advert = Advert.dao.findById(advertId);
		setAttr("advert", advert); 
		render("/system/approveAdvert-info.html");
	}

	/**
	 * 审批结果
	 */
	public void approvalResult(){
		String state = getPara("state");
		String advertId = getPara("advertId");
		String remake = getPara("remake");
		SystemUser user = CacheLoginUser();
		boolean result = new Advert().set("ID", advertId).set("COMFIRMADVISE", remake).set("COMFIRMUSERNAME", user.getUserName())
				.set("COMFIRMTIME", DateUitils.DateToString()).set("COMFIRMUSERID", user.getUserCode()).set("STATE", state).update();
		renderJson(result);
	}
	
	/**
	 * 删除审批
	 */
	public void approvalDelete(){
		String advertId = getPara("advertId");
		boolean result = Advert.dao.deleteById(advertId);
		renderJson(result);
	}
	
	
}
