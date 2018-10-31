package com.activity.common.service.robRed;

import java.util.List;
import com.activity.common.model.robRed.RobRedWxUser;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 抢红包微信用户参加记录
 * @author 唐
 *
 */
public class RobRedWxUserService {
	private static RobRedWxUserService robRedWxUserService = new RobRedWxUserService();
	private RobRedWxUserService() {
	}
	public static RobRedWxUserService getService() {
		return robRedWxUserService;
	}
	
	/**
	 * 根据openid和所扫码scanCode查询是否已经参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public RobRedWxUser getRobRedWxUserByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getRobRedWxUserByOpenidAndQrCode");
		return RobRedWxUser.dao.findFirst(sql,openid,scanCode);
	}
	
	/**
	 * 根据微信参与用户记录ID，查询出抢红包参与用户
	 * @param Id
	 * @return
	 */
	public RobRedWxUser getRobRedWxUserById(String Id){
		Record soiView =  Db.findById("TB_ROB_RED_WXUSER",Id);
		RobRedWxUser rrwu =new RobRedWxUser();
		rrwu.mapping(soiView, rrwu);
		return rrwu;
	}
	
	/**
	 * 根据openid和公众号Id查询参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public List<RobRedWxUser> getRobRedWxUserByOpenidAndAppid(String openid,String sellerPublicNumberId){
		String sql = PropKit.use("database.properties").get("getRobRedWxUserByOpenidAndAppid");
		return RobRedWxUser.dao.find(sql,openid,sellerPublicNumberId);
	}
	
	/**
	 * 根据openid和公众号Id查询参加活动未提现
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public List<RobRedWxUser> getRobRedWxUserByOpenidAndSPNId(String openid,String sellerPublicNumberId){
		String sql = PropKit.use("database.properties").get("getRobRedWxUserByOpenidAndSPNId");
		return RobRedWxUser.dao.find(sql,openid,sellerPublicNumberId);
	}
	
	/**
	 * 根据openid和公众号ID修改参加活动未提现的记录
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public int updateRobredWxUserState(String openid,String sellerPublicNumberId){
		String sql = PropKit.use("database.properties").get("updateRobredWxUserState");
		return Db.update(sql,openid, sellerPublicNumberId);
	}
	
	/**
	 * 根据红包活动ID查询参与活动微信用户
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public List<RobRedWxUser> getRobRedWxUserByRedId(String redId,String nickName){
		String sqlstr = "";
		if (nickName != null && !"".equals(nickName) ) {
			sqlstr += " and a.NICKNAME like '%" + nickName + "%'";
		}
		String sql = PropKit.use("database.properties").get("getRobRedWxUserByRedId");
		return RobRedWxUser.dao.find(sql+sqlstr,redId);
	}
}
