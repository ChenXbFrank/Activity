package com.activity.common.service.system;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;

import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.utils.emoji.EmojiUtils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

public class WxService {
	private static WxService wxService = new WxService();
	private WxService() {}
	public static WxService getService() {
		return wxService;
	}
	private int i=0;
	public int saveWxUser(WxUserInfo wxuser,String openid,SellerPublicNumber spn,String newId){
		i=0;
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				//判断名称是否包含表情符号
				Boolean emoji =  EmojiUtils.containsEmoji(wxuser.getNickname());
				if(emoji){
					try {
						String name=java.net.URLEncoder.encode(wxuser.getNickname(), "UTF-8");
						wxuser.setNickname(name);
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
				// 保存微信用户信息
				if (openid != null) {
					// 首先根据OPENID查询是否已经存在
					List<ActivityWxUser> awList = IndexService.getService().getuserByopenid(openid);
					if (awList.size() > 0) {
						ActivityWxUser aw = new ActivityWxUser();
						for (ActivityWxUser awErgodic : awList) {
							aw = awErgodic;
						}
						String sql = PropKit.use("database.properties").get("updateWxUser");
						i = Db.update(sql,wxuser.getOpenid(),spn.getId(),wxuser.getNickname(),wxuser.getSex(),wxuser.getCountry()
								,wxuser.getProvince(),wxuser.getCity(),wxuser.getHeadimgurl(),aw.getId());
					} else {
						String sql = PropKit.use("database.properties").get("saveWxUser");
						i = Db.update(sql,newId,wxuser.getOpenid(),spn.getId(),wxuser.getNickname(),wxuser.getSex(),wxuser.getCountry()
								,wxuser.getProvince(),wxuser.getCity(),wxuser.getHeadimgurl());
					}
				}
				if(i>0){
					return true;
				}else{
					return false;
				}
			}});
		return i;
	}
	
	/**
	 * 保存未关注用户
	 * @param wxuser
	 * @param openid
	 * @param spn
	 * @param newId
	 * @return
	 */
	public int noSaveWxUser(WxUserInfo wxuser,String openid,SellerPublicNumber spn,String newId){
		i=0;
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				// 保存微信用户信息
				if (openid != null) {
					// 首先根据OPENID查询是否已经存在
					List<ActivityWxUser> awList = IndexService.getService().getuserByopenid(openid);
					if (awList.size() > 0) {
						ActivityWxUser aw = new ActivityWxUser();
						for (ActivityWxUser awErgodic : awList) {
							aw = awErgodic;
						}
						String sql = PropKit.use("database.properties").get("updateWxUser");
						i = Db.update(sql,wxuser.getOpenid(),spn.getId(),"","",""
								,"","","",aw.getId());
					} else {
						String sql = PropKit.use("database.properties").get("saveWxUser");
						i = Db.update(sql,newId,wxuser.getOpenid(),spn.getId(),"","",""
								,"","","");
					}
				}
				if(i>0){
					return true;
				}else{
					return false;
				}
			}});
		return i;
	}
	
	public String emoji(String emojiStr){
		//判断名称是否包含表情符号
		Boolean emoji =  EmojiUtils.containsEmoji(emojiStr);
		String str = "";
		if(emoji){
			try {
				String name=java.net.URLEncoder.encode(emojiStr, "UTF-8");
				str=name;
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}else{
			str = emojiStr;
		}
		return str;
	}
}
