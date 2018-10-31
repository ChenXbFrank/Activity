package com.activity.common.service.system;

import java.util.ArrayList;
import java.util.List;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.system.SystemMenu;
import com.activity.common.model.system.SystemUser;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

/**
 * 基础服务 包含对数据层操作
 */
public class IndexService {
	private static IndexService indexService = new IndexService();

	private IndexService() {
	}

	public static IndexService getService() {
		return indexService;
	}
	
	/**
	 * 分页查询
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Page<SystemUser> paginate(int pageNumber, int pageSize) {
		SystemUser user = new SystemUser();
		return user.dao().paginate(pageNumber, pageSize, "select *", "from SystemUser order by id asc");
	}

	/**
	 * 生成反馈链接
	 * @param appid
	 * @param activityid
	 * @param qrcode
	 * @param sellerPublicNumberId
	 * @param isEnd
	 * @return
	 */
	public String feedbackVerification(String appid,String activityid,String qrcode,String sellerPublicNumberId,String isEnd){
		String feedbackStr= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appid
		+ "&redirect_uri=http%3a%2f%2f"+ PropKit.use("system.properties").get("http")
		+ JFinal.me().getContextPath() + "%2findex%2fisJoin%3fActivity%3d"
		+ activityid + "%26qrcode%3d" + qrcode + "%26spn%3d" +sellerPublicNumberId + "%26flag%3d" + isEnd 
		+ "&response_type=code&scope=snsapi_base&state=wx"
		+ "&connect_redirect=1#wechat_redirect";
		
		return feedbackStr;
	}
	
	
	/**
	 * 根据UserCode查询视图，返回单个用户信息
	 * 
	 * @param userCode
	 * @return
	 */
	public List<SystemUser> getUserByCode(String userCode) {
		// 查询一个集合，防止code相同
		String sql = PropKit.use("database.properties").get("getUserByCode");
		List<Record> userView = Db.find(sql, userCode);
		List<SystemUser> userList = new ArrayList<SystemUser>();
		for (Record cord : userView) {
			SystemUser user = new SystemUser();
			user.mapping(cord, user);
			userList.add(user);
		}
		return userList;
	}

	/**
	 * 根据UserCode和USERID查询视图，返回单个用户信息
	 * @param UserId
	 * @param userCode
	 * @return
	 */
	public SystemUser getUserByCodeAndUserId(String userCode,String UserId) {
		// 查询一个集合，防止code相同
		String sql = PropKit.use("database.properties").get("getUserByCodeAndUserId");
		List<Record> userView = Db.find(sql, userCode,UserId);
		List<SystemUser> userList = new ArrayList<SystemUser>();
		for (Record cord : userView) {
			SystemUser user = new SystemUser();
			user.mapping(cord, user);
			userList.add(user);
		}
		SystemUser backUser = new SystemUser();
		if(userList.size() == 1 ){
			for(SystemUser suBL:userList){
				backUser = suBL;
			}
		}
		return backUser;
	}
	
	/**
	 * 根据扫描二维码查询四位验证码
	 * 
	 * @param qrcode
	 * @return
	 */
	public String QueryVerificationCodeByQrcode(String qrcode) {
		String sql = PropKit.use("database.properties").get("QueryVerificationCodeByQrcode");
		List<Record> verificationCodeView = Db.find(sql, qrcode);
		String verificationCode = "";
		for (Record cord : verificationCodeView) {
			verificationCode = cord.getStr("VERIFICATIONCODE");
		}
		return verificationCode;
	}

	/**
	 * 根据二维码查询箱码
	 * 
	 * @param qrcode
	 * @return
	 */
	public String QueryBoxCodeByQrcode(String qrcode) {
		String sql = PropKit.use("database.properties").get("QueryBoxCodeByQrcode");
		List<Record> verificationCodeView = Db.find(sql, qrcode);
		String boxCode = "";
		for (Record cord : verificationCodeView) {
			boxCode = cord.getNumber("BOXCODE").toString();
		}
		return boxCode;
	}

	/**
	 * 获取所有菜单信息
	 * 
	 * @return
	 */
	public List<SystemMenu> getMenu() {
		List<SystemMenu> menuList = CacheKit.get("menu", "menuList");
		if (menuList == null) {
			String sql = PropKit.use("database.properties").get("getMenu");
			menuList = SystemMenu.dao.find(sql);
			CacheKit.put("menu", "menuList", menuList);
		}
		return menuList;
	}

	/**
	 * 根据code和ActivityId查询出已有的code 主要判断当前code是否已经参加过该活动
	 * 
	 * @param code
	 * @param activityId
	 * @return
	 */
	public ActivityCode getCodeByCodeAndActivity(String code, String activityId) {
		String sql = PropKit.use("database.properties").get("getCodeByCodeAndActivity");
		ActivityCode ac = ActivityCode.dao.findFirst(sql, code, activityId);
		return ac;
	}

	/**
	 * 根据Openid查询当前用户
	 */
	public List<ActivityWxUser> getuserByopenid(String openid) {
		String sql = PropKit.use("database.properties").get("getuserByopenid");
		List<ActivityWxUser> awList = ActivityWxUser.dao.find(sql, openid);
		return awList;
	}

	/**
	 * 根据Openid和公众号APPID查询当前用户 只有ID
	 */
	public ActivityWxUser getUserByopenidAndappId(String openid,String appId) {
		String sql = PropKit.use("database.properties").get("getUserByopenidAndappId");
		ActivityWxUser aw = ActivityWxUser.dao.findFirst(sql, openid,appId);
		return aw;
	}
	/**
	 * 根据Openid和公众号APPID修改
	 */
	public int updateUserByOpenidAndAppId(String openid,String appId) {
		String sql = PropKit.use("database.properties").get("updateUserByOpenidAndAppId");
		return Db.update(sql, "0",openid, appId);
	}
	
	/**
	 * 根据Openid和公众号APPID修改 surMoney
	 */
	public int updateUserMoneyByOpenidAndAppId(String surMoney,String openid,String appId) {
		String sql = PropKit.use("database.properties").get("updateUserByOpenidAndAppId");
		return Db.update(sql, surMoney,openid, appId);
	}
	
	/**
	 * 根据Openid和公众号ID查询当前用户所有信息
	 */
	public ActivityWxUser queryUserByOpenidAndPublicNumberId(String openid,String appId) {
		String sql = PropKit.use("database.properties").get("queryUserByOpenidAndPublicNumberId");
		return ActivityWxUser.dao.findFirst(sql, openid,appId);
	}
	
	/**
	 * 根据角色ID查询出当前角色拥有的菜单
	 * 
	 * @param roleId
	 * @return List<SystemMenuRole>
	 */
	public List<SystemMenu> getMenuByRoleId(String roleId) {
		String sql = PropKit.use("database.properties").get("getMenuByRoleId");
		List<SystemMenu> list = SystemMenu.dao.find(sql, roleId);
		return list;
	}
	
	/**
	 * 根据微信用户修改积分或金额值
	 */
	public int updateWxUserIntegralAndMoneyById(String totalIntegral,String surplusTotalIntegral,String totalMoney,String surplusTotalMoney,String id){
		String sql = PropKit.use("database.properties").get("updateWxUserIntegralAndMoneyById");
		return Db.update(sql, totalIntegral, surplusTotalIntegral,totalMoney,surplusTotalMoney,id);
	}
	
	/**
	 * 新增扫码进入活动记录
	 */
	public int insertAtcitityCode(String id,String qrcode,String recordId,String sellerPublicNumberId,String sellerPublicNumberName,String turntableWxuserId,String openid,String nickname,String headimgurl,String mark,String singNumber,String activityId,String activityName){
		String sql = PropKit.use("database.properties").get("insertAtcitityCode");
		int i = Db.update(sql,id,qrcode,recordId,sellerPublicNumberId,sellerPublicNumberName,turntableWxuserId,openid,nickname,headimgurl,mark,singNumber,activityId,activityName);
		return i;
	}
	
	
	/**
	 * 根据ScanCode修改码数据
	 */
	public int updateWinningByScanCode(String activityUserId,String winningType,String winningId,String code){
		String sql = PropKit.use("database.properties").get("updateWinningByScanCode");
		return Db.update(sql, activityUserId, winningType,winningId,code);
	}
	
	/**
	 * 查询当前二维码是否已经参与活动
	 */
	public boolean queryQrcodeState(String qrcode,String activity,String openid){
		// 查询当前二维码是否已参加活动
		ActivityCode ac = this.getCodeByCodeAndActivity(qrcode, activity);
		boolean rest = false;
		if (ac != null) {// 说明有活动
			if (ac.getOpenId().equals(openid)) {
				// 自己进来查看，可以查看，但不用新建一个二维码失效记录
				rest = true;
			}else{
				rest = false;
			}
		}else{
			rest = true;
		}
		return rest;
	}
	
	
	/**
	 * 根据openid和活动id查询该用户是否在黑名单里面
	 */
	public boolean isExistBlack(String openId,String activityId){
		String sql="select count(*) from TB_BLACK_LIST  where OPENID = ? and ACTIVITYID = ? ";
		Long queryLong = Db.queryNumber(sql, openId, activityId).longValue();
		int intValue = queryLong.intValue();
		if(intValue!=0){
			return true;
		}else{
			return false;
		}
	}
	
}
