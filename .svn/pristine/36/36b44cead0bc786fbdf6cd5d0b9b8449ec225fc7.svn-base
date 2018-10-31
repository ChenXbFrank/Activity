package com.activity.common.controller.moblie.base;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.breakEgg.BreakEggWxUser;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.openWine.OpenWineWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.service.openWine.OpenWineService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.activity.common.utils.wxInterface.WxRedPackageUitils;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.ICallback;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;


@ControllerPath(controllerKey = "/sendRobRed")
public class SendRedController extends BaseController{
	IndexService indexService = IndexService.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	OpenWineService openWineService = OpenWineService.getService();
	WxService wxService = WxService.getService();
	Boolean sendRed = false;
	String newMoney = "0.00";
	SellerPublicNumber spn = null;
	
	/**
	 * 发送红包
	 */
	public void sendRedPackage(){
		//第一步 获取openid 公众号id
		String userCode = getPara("userCode");
		List<SellerPublicNumber> sellerPublicNumberList = SellerPublicNumberService.getService().getPublicNumberByUsercode(userCode);
		spn = new SellerPublicNumber();
		for (SellerPublicNumber spnErgodic : sellerPublicNumberList) {
			spn = spnErgodic;
		}
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(),spn.getAppId(), spn.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(spn.getAppId());
		String openid = getOpenid(spn);
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,spn.getId());
		//补全用户信息
		
		if(awu!=null){
			//判断当前人员可用金额是否大于微信限制金额
			float a =  (float)Float.parseFloat(awu.getSurplusTotalMoney())*100;
			int sup = (int)a;
			if(sup >= Integer.parseInt(PropKit.use("system.properties").get("weixintixian"))){
				setAttr("openid",openid);
				setAttr("sellerPublicNumber", spn);
				setAttr("mch_billno", "wly"+RandomNumber());
				//TODO  这里将开酒瓶的活动的中奖纪录信息的状态修改为已经提现
				List<OpenWineWxUserWinning> openWinByOpenIdList = openWineService.getOpenWinByOpenId(openid);
				for (OpenWineWxUserWinning openWineWxUserWinning : openWinByOpenIdList) {
					/**
					 * 提现成功 将提现状态修改为已提现
					 */
					int updateOpenWinState = openWineService.updateOpenWinState(openWineWxUserWinning.getId());
					System.out.println("***updateOpenWinState***"+updateOpenWinState);
					int updateOpenWineState = openWineService.updateOpenWineState(openWineWxUserWinning.getOpenWineWxuserId());
					System.out.println("***updateOpenWineState***"+updateOpenWineState);
					//将该用户的头像昵称更新
					openWineService.updateOpenWxInfoByOpenWxUserId(wxuser.getNickname(), wxuser.getHeadimgurl(),openid);
				}
				sendRed = true;
			}else{
				sendRed = false;
			}
			//判断是否存在和保存微信用户
			if(wxuser.getSubscribe().equals("1")){
				//保存或修改微信用户
				wxService.saveWxUser(wxuser,openid,spn,newId());
				Db.execute(new ICallback() {
					@Override
					public Object call(Connection conn) throws SQLException {
						// TODO Auto-generated method stub
						CallableStatement proc = conn.prepareCall("{call updateNameOrHeadimgByOpenid(?,?,?)}");
						proc.setString(1, wxuser.getNickname());
						proc.setString(2, wxuser.getHeadimgurl());
						proc.setString(3, openid);
		                proc.execute();
						return proc;
					}
				});
			}
			setAttr("newMoney", awu.getSurplusTotalMoney());
			if(sendRed){
				render("/nowTiXian/tixianSuccess.html");
			}else{
				render("/nowTiXian/tixianFail.html");
			}
		}else{
			setAttr("newMoney",newMoney);
			render("/nowTiXian/tixianFail.html");
		}
		
	}
	
	int isOK = 0; 
	
	/**
	 * 活动内立即提现 发送红包
	 */
	public void nowSendRedPackage(){
		isOK= 0 ;
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				Boolean rest = false;
				//第一步 获取openid 公众号id
				String sellerPublicNumberId = getPara("sellerPublicNumberId");
				String openid = getPara("openid");
				//商户订单号
				String mch_billno = getPara("mch_billno"); 
				SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(),spn.getAppId(), spn.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(spn.getAppId());
				//补全用户信息
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//当前人员剩余金额
				ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,spn.getId());
				//保存或修改微信用户
				wxService.saveWxUser(wxuser,openid,spn,newId());
				//查询该表里的该用户的参与记录
				String sql1="select * from TB_BREAKEGG_WXUSER where openid= ? ";
				List<BreakEggWxUser> list = BreakEggWxUser.dao.find(sql1,openid);
				for (BreakEggWxUser breakEggWxUser : list) {
					String id = breakEggWxUser.getId();
					if(StringUtils.isEmpty(breakEggWxUser.getNickName())||StringUtils.isEmpty(breakEggWxUser.getHeadImgUrl())){
						breakEggWxUser.set("ID", id).set("NICKNAME", wxuser.getNickname()).set("HEADIMGURL", wxuser.getHeadimgurl()).update();
					}
				}
				//修改记录中的微信名称和头像地址
				String sql = PropKit.use("database.properties").get("updateNameByOpenid");
				Db.update(sql,wxuser.getNickname(),wxuser.getHeadimgurl(),openid);
				//判断当前人员可用金额是否大于微信限制金额
				float a =  (float)Float.parseFloat(awu.getSurplusTotalMoney())*100;
				int sup = (int)a;
				System.out.println("当前人员金额"+sup);
				System.out.println("提下金额"+Integer.parseInt(PropKit.use("system.properties").get("weixintixian")));
				if(sup >= Integer.parseInt(PropKit.use("system.properties").get("weixintixian"))){
					//修改当前用户剩余余额
					int suprlus = indexService.updateUserByOpenidAndAppId(openid,spn.getId());
					if(suprlus > 0){
						//修改当前人参与的当前公众号活动未提现记录全部为已经提现
						//int state = robRedWxUserService.updateRobredWxUserState(openid,spn.getId());
						//修改所有红包中奖记录未提现的提现   修改提现状态为0的记录，更改为1已经提现，条件是完成状态是1=已完成的
						int state = redWinningInfoService.updateRedInfoByWithdrawals("1","1",openid,spn.getId());
						if(state > 0){
							/**
							 * 发送普通红包
							 * @param mchId  微信支付分配的商户号
							 * @param appid  微信分配的公众账号ID（企业号corpid即为此appId）
							 * @param sendName  红包发送者名称
							 * @param openid   接受红包的用户,用户在wxappid下的openid
							 * @param totalAmount  付款金额，单位分
							 * @param totalNum  红包发放总人数total_num=1
							 * @param redWishing  红包祝福语
							 * @param activityName  活动名称
							 * @param redRemark  备注信息   猜越多得越多，快来抢！
							 * @param payKey  支付密钥
							 */
							Map<String, String> paymap = WxRedPackageUitils.getWxRedPackageUitils().enterprisePayment(mch_billno,spn.getShopNumber(), spn.getAppId(), spn.getSenderName(), openid, awu.getSurplusTotalMoney(), "1", 
									spn.getWish(), spn.getSenderName()+"的活动", spn.getRemarks(), spn.getPayKey(),spn.getCertPath());
							if(paymap.get("state").equals("OK")){
								isOK=1;
								//查询开酒瓶的中奖记录状态
//								List<RedWinningInfo> redWinList = openWineService.getRedWinList();
//								for (RedWinningInfo redWinningInfo : redWinList) {
//									openWineService.updateRedWinInfoState(redWinningInfo.getId());
//								}
							}else{
								isOK=0;
							}
						}else{
							isOK=0;
						}
					}else{
						isOK=0;
					}
					rest = true;
				  }
				return rest;
			}
		});
		renderJson(isOK);
	}
	
	//10位随机数
	public static String RandomNumber(){
		int a[] = new int[10];
		String number ="";
	      for(int i=0;i<a.length;i++ ) {
	          a[i] = (int)(10*(Math.random()));
	          number += a[i]+"";
	      }
	     return number+"";
	}
}
