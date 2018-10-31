/**
 *
 */
package com.activity.common.controller.pc.publicNumberConfig;

import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.kit.PropKit;
import com.web.controller.ControllerPath;

/**
 * 公众号配置
 * 
 * @author ChenXb
 *
 *         2017年8月26日
 */
@ControllerPath(controllerKey = "/publicNumber")
public class PublicNumberConfigController extends BaseController {
	// 基础配置service
	IndexService indexService = IndexService.getService();
	// 工具类
	DateUitils uitils = DateUitils.getUitils();

	public void index() {
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "公众号配置")
				.set("USE_TIME", uitils.newDate()).save();
		String sql = "Select * from TB_SELLER_PUBLICNUMBER where SELLER_USERCODE = ? ";
		SellerPublicNumber publicNumber = SellerPublicNumber.dao.findFirst(sql, user.getUserCode());
		setAttr("publicNumber", publicNumber);
		render("/public-set/publicSet.html");
	}

	/**
	 * 查询所有的公众号信息
	 */
	public void getAllPublicNumber() {
		setAttr("sellerPublicNumberList", null);
		render("/system/public-infos.html");
	}
	
	/**
	 * 这里分页显示数据
	 */
	public void publicNumberPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int pageSize = Integer.parseInt(pageCount);
		Integer pageNumber = getParaToInt("pageNumber");
		String name = getPara("name");
		Map<String, Object> map = SellerPublicNumber.dao.paginate1(pageNumber, pageSize, name);
		renderJson(map);
	}

	/**
	 * 查询指定名称的公众号
	 */
	public void getPublicNumberByCondition() {
		// 公众号名称
		String name = getPara("name");
		List<SellerPublicNumber> sellerPublicNumberList = SellerPublicNumberService.getService()
				.getPublicNumberByCondition(name);
		setAttr("sellerPublicNumberList", sellerPublicNumberList);
		render("/system/public-infos.html");
	}

	/**
	 * 保存公众号配置
	 */
	public void savePublicNumberConfig() {
		// 公众号名称
		String definition = getPara("definition");
		// 公司名称
		String company = getPara("company");
		// 商户ID
		String merchant = getPara("merchant");
		// 开发者ID
		String appId = getPara("appId");
		// 支付密钥
		String payment = getPara("payment");
		// 开发者密钥
		String appStar = getPara("appStar");
		// Token
		String token = getPara("token");
		// 公众二维码图片
		String pic = getPara("pic");
		// 公众号ID
		String getId = getPara("getId");
		// 模板消息ID
		String moduleId = getPara("moduleId");
		// 发货通知模板消息ID
		String sendId= getPara("sendId");
		// 参与通知模板消息ID
		String SUCCESSID= getPara("SuccessId");
		//祝福语
		String wish = getPara("blessing");
		//红包备注
		String remarks = getPara("remarks");
		//红包发送者名称
		String senderName = getPara("sendOut");
		// 扫码页面的背景图
		String picture = getPara("picture");
		// logo
		String logo = getPara("logo");
		// phone
		String phone = getPara("phone");
		// 当前登陆用户
		Boolean result = false;
		SystemUser user = CacheLoginUser();
		String userCode = user.getUserCode();
		String sql = "select * from TB_SELLER_PUBLICNUMBER where SELLER_USERCODE =?";
		SellerPublicNumber publicNumber = SellerPublicNumber.dao.findFirst(sql, userCode);
		if (publicNumber == null) {
			String sellerPublicId = newId();
			result = new SellerPublicNumber().set("ID", sellerPublicId).set("PUBLICNUMBER_NAME", definition)
					.set("APPID", appId).set("APPSECRET", appStar).set("PUBLICNUMBER_QRCODE_IMG", pic)
					.set("SHOP_NUMBER", merchant).set("PAY_KEY", payment).set("SELLER_USERCODE", user.getUserCode()).set("SELLER_USERID", user.getUserId())
					.set("PHONE", phone).set("LOGO", logo).set("SCAN_IMG", picture).set("COMPANY", company).set("SUCCESSID", SUCCESSID).set("SENDID", sendId).set("TOKEN", token).set("WINNING_NEWS_ID", moduleId).set("SENDERNAME",senderName).set("WISH", wish).set("REMARKS",remarks).save();
		} else {
			if (pic != null) {
				result = new SellerPublicNumber().set("ID", getId).set("PUBLICNUMBER_NAME", definition)
						.set("APPID", appId).set("APPSECRET", appStar).set("PUBLICNUMBER_QRCODE_IMG", pic)
						.set("SHOP_NUMBER", merchant).set("PAY_KEY", payment).set("SELLER_USERCODE", userCode).set("SELLER_USERID", user.getUserId())
						.set("PHONE", phone).set("LOGO", logo).set("SCAN_IMG", picture).set("COMPANY", company).set("SUCCESSID", SUCCESSID).set("SENDID", sendId).set("TOKEN", token).set("WINNING_NEWS_ID", moduleId).set("SENDERNAME",senderName).set("WISH", wish).set("REMARKS",remarks).update();
			} else {
				result = new SellerPublicNumber().set("ID", getId).set("PUBLICNUMBER_NAME", definition)
						.set("APPID", appId).set("APPSECRET", appStar)
						.set("PUBLICNUMBER_QRCODE_IMG", publicNumber.getPublicNumberQrcodeImg())
						.set("SENDID", sendId).set("SHOP_NUMBER", merchant).set("PAY_KEY", payment).set("SELLER_USERCODE", userCode).set("SELLER_USERID", user.getUserId())
						.set("PHONE", phone).set("LOGO", logo).set("SCAN_IMG", picture).set("COMPANY", company).set("SUCCESSID", SUCCESSID).set("SENDID", sendId).set("TOKEN", token).set("WINNING_NEWS_ID", moduleId).set("SENDERNAME",senderName).set("WISH", wish).set("REMARKS",remarks).update();
			}
		}
		renderJson(result);
	}
}
