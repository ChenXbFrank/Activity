package com.activity.common.controller.pc.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.Activity;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.system.SystemMenu;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.shareBargain.ShareBargainPrizeService;
import com.activity.common.service.shareBargain.ShareBargainService;
import com.activity.common.service.system.ActivityService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.ProductInfoService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.key.MD5Util;
import com.jfinal.aop.Clear;
import com.jfinal.json.Jackson;
import com.jfinal.kit.PropKit;
import com.web.Interceptor.LoginInterceptor;
import com.web.controller.ControllerPath;

/**
 * IndexController 十个活动后台管理系统基础处理器
 */
@ControllerPath(controllerKey = "/")
public class IndexController extends BaseController {
	// 基础配置service
	IndexService indexService = IndexService.getService();
	// 可申请活动service
	ActivityService activityService = ActivityService.getService();
	// 分享砍价活动服务层
	ShareBargainService shareBargainService = ShareBargainService.getService();
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 分享砍价活动奖品配置
	ShareBargainPrizeService shareBargainPrizeService = ShareBargainPrizeService.getService();
	// 奖品信息的service
	ProductInfoService productInfoService = ProductInfoService.getService();
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	
	@Clear(LoginInterceptor.class)
	public void aaa() {
		String a = "{\"remark\":\"sda\", \"subscribe\":\"asa\"}";
		@SuppressWarnings("unchecked")
		Map<String, String> s = Jackson.getJson().parse(a,Map.class);
		System.out.println(s.get("remark"));
	}
	
	/**
	 * 访问登陆页面 Clear方法标注某个拦截器可不拦截。不写类全部拦截器都不拦截
	 */
	@Clear(LoginInterceptor.class)
	public void index() {
		render("/index/active-login.html");
	}

	/**
	 * 验证登陆
	 */
	@Clear(LoginInterceptor.class)
	public void loginValidate() {
		// 用户编号
		String userCode = getPara("userCode");
		// 用户密码
		String password = getPara("password");
		SystemUser user = new SystemUser();
		String information = "";
		List<SystemUser> UserList = indexService.getUserByCode(userCode);
		// 判断是否存在当前用户 所有集合都需验证是否为空
		if (UserList.size() != 0) {
			for (SystemUser forUser : UserList) {
				if (MD5Util.string2MD5(password).equals(forUser.getPassWord())) {
					user = forUser;
					information = "登陆成功";
					break;
				} else {
					information = "密码错误";
				}
			}
		} else {
			// 不存在当前登陆用户
			information = "找不到当前登陆用户";
		}
		// 判断当前登陆用户是否登陆成功

		boolean record = false;
		if (user.getUserCode() != null) {
			record = true;
			getSession().setAttribute("loginUser", user);
			HttpSession ses = getSession();
			ses.setMaxInactiveInterval(3600);
			// Constants.setThreadLocalConfig("loginUseBbean", user);
			// 保存日志
			new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "登陆")
					.set("USE_TIME", uitils.newDate()).save();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("record", record);
		map.put("information", information);
		map.put("user", user);
		renderJson(map);
	}

	/**
	 * 大数据平台请求验证登陆
	 */
	@Clear(LoginInterceptor.class)
	public void Validate() {
		// 用户编号
		String userCode = getPara("u");
		// 用户密码
		String password = getPara("p");
		SystemUser user = new SystemUser();
		boolean rest = false;
		List<SystemUser> UserList = indexService.getUserByCode(userCode);
		// 判断是否存在当前用户 所有集合都需验证是否为空
		if (UserList.size() != 0) {
			for (SystemUser forUser : UserList) {
				if (password.equals(forUser.getPassWord())) {
					user = forUser;
					rest = true;
					break;
				}
			}
		}
		if (user.getUserCode() != null) {
			getSession().setAttribute("loginUser", user);
			HttpSession ses = getSession();
			ses.setMaxInactiveInterval(7200);
			new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "登陆")
					.set("USE_TIME", uitils.newDate()).save();
		}
		String result = "true";
		// 判断是否有公众号配置
		List<SellerPublicNumber> sbnList = SellerPublicNumberService.getService()
				.getPublicNumberByUsercode(user.getUserCode());
		if (sbnList.size() == 0) {
			// 没有公众号
			result = "false";
		}
		setAttr("result", result);
		setAttr("user", user);
		if (rest) {
			render("/index/home.html");
		} else {
			render("/index/active-login.html");
		}
	}

	/**
	 * ajax验证成功后访问主页
	 */
	public void goHomePage() {
		SystemUser user = CacheLoginUser();
		String result = "true";
		// 判断是否有公众号配置
		List<SellerPublicNumber> sbnList = SellerPublicNumberService.getService()
				.getPublicNumberByUsercode(user.getUserCode());
		if (sbnList.size() == 0) {
			// 没有公众号
			result = "false";
		}
		setAttr("result", result);
		setAttr("user", user);
		render("/index/home.html");
	}

	/**
	 * 主页ajax获取菜单（功能模块）
	 */
	public void homePage() {
		Map<String, Object> map = new HashMap<String, Object>();
		String roleId = "";
		// 判断当前登陆人员是否属于最大权限
		SystemUser user = CacheLoginUser();
		if (PropKit.use("system.properties").get("SystemUserCode").equals(user.getUserCode())) {
			roleId = "0";
		} else {
			roleId = "1";
		}
		// 现在默认经销商角色ID为1
		// 1.查询出所有当前角色的所有菜单和角色关系
		List<SystemMenu> menuList = indexService.getMenuByRoleId(roleId);
		map.put("menuList", menuList);
		renderJson(map);
	}

	/**
	 * 我的活动 这里也是所有的活动
	 */
	public void activity() {
		render("/index/my-all-activity.html");
	}

	/**
	 * 我的活动 这里也是所有的活动
	 */
	public void activityTen() {
		// 查询出所有可发起活动
		List<Activity> activityList = activityService.getAllActivity();
		setAttr("activityList", activityList);
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "我的活动")
				.set("USE_TIME", uitils.newDate()).save();
		render("/index/my-all-activity-ten.html");
	}
	
	/**
	 * 活动申请
	 */
	public void activityApply() {
		render("/index/active-application.html");
	}
	
	/**
	 * 十个活动申请
	 */
	public void activityTenApply(){
		List<Activity> activityList = activityService.getAllActivity();
		setAttr("activityList", activityList);
		render("/index/active-application-ten.html");
	}

	/**
	 * 活动报表 这里也是需要传入所有的活动
	 */
	public void activityForm() {
		render("/index/activity-report.html");
	}
	
	/**
	 * 十个活动的报表链接
	 */
	public void activityFormTen() {
		// 查询出所有可发起活动
		List<Activity> activityList = activityService.getAllActivity();
		setAttr("activityList", activityList);
		render("/index/activity-report-ten.html");
	}

	/**
	 * 快速退出
	 */
	public void exit() {
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "快速退出")
				.set("USE_TIME", uitils.newDate()).save();
		getSession().setAttribute("loginUser", null);
		getSession().removeAttribute("loginUser");
		redirect("/");
	}
	
	/**
	 * 进入活动审批页面
	 * 
	 */
	public void approve() {
		render("/index/activity-accraditation-home.html");
	}
	
	/**
	 * 进入活动审批页面
	 * 
	 */
	public void approveTen() {
		// 查询出所有可发起活动
		List<Activity> activityList = activityService.getAllActivity();
		setAttr("activityList", activityList);
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		new LogInfo().set("ID", newId()).set("USE_USERCODE", user.getUserCode()).set("USE_FUNCTION", "进入活动审批页面")
				.set("USE_TIME", uitils.newDate()).save();
		// 这里是审核活动的页面地址
		render("/index/activity-accraditation-home-ten.html");
	}
	
}
