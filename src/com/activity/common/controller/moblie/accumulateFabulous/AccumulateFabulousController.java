package com.activity.common.controller.moblie.accumulateFabulous;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.accumulate.Accumulate;
import com.activity.common.model.accumulate.AccumulateCommentWxUser;
import com.activity.common.model.accumulate.AccumulateHelpWxUser;
import com.activity.common.model.accumulate.AccumulatePrize;
import com.activity.common.model.accumulate.AccumulateWxUserWinning;
import com.activity.common.model.accumulate.RankBean;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.service.accumulateFabulous.AccumulateService;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.shareBargain.ShareBargainWxuserService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.ActivityService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.SellerRelationService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 积攒排名获奖
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/accumulateFabulous")
public class AccumulateFabulousController extends BaseController{
	WxService wxService = WxService.getService();
	// 运单Service
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	// 产品关系service
	SellerRelationService sellerRelationService = SellerRelationService.getService();
	// 可申请活动service
	ActivityService activityService = ActivityService.getService();
	// 用户发起的活动service
	ShareBargainWxuserService shareBargainWxuserService = ShareBargainWxuserService.getService();
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	// 集赞活动service
	AccumulateService accumulateService = AccumulateService.getService();
	IndexService indexService =IndexService.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IntegralService integralService = IntegralService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	/**
	 * 进入集赞活动
	 */
	public void accumulate(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				//公众号ID
				String sellerPublicNumberId = getPara("sellerPublicNumber");
				// 活动ID
				String activity = getPara("Activity");
				//所扫二维码
				String qrcode = getPara("qrcode");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				String openid = getOpenid(sellerPublicNumber);
				boolean rest = IndexService.getService().queryQrcodeState(qrcode, activity, openid);
				//第一次扫码进入
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				//使用完后释放，不释放可能存在内存溢出
				ApiConfigKit.removeThreadLocalAppId();
				//判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
				AccumulateCommentWxUser accumulateComment = accumulateService.getAccumulateByOpenidAndQrCode(openid, qrcode);
				Accumulate accumulate = Accumulate.dao.findById(activity);
				String WxUserId ;
				//1=未保存成功  2=二维码已经使用  3=成功  4进入他的评论页面
				int resule = 1;
				if(rest){
					WxUserId = "";
					if(accumulateComment!=null){
						WxUserId=accumulateComment.getId();
						//已经参加过了,再次进入
						String comments = accumulateComment.getComments();
						String commentImg = accumulateComment.getCommentImg();
						if((comments==null||comments.equals(""))&&(commentImg==null||commentImg.equals(""))){
							//该码已经扫了 但是并没有评论过
							resule=3;
						}else{
							//参加过了就直接进入他的页面
							resule=4;
						}
					}else{
						//判断是否存在和保存微信用户
						if(wxuser.getSubscribe().equals("1")){
							//保存微信用户
							wxService.saveWxUser(wxuser,openid,sellerPublicNumber,newId());
						}
						//保存用户参加记录
						WxUserId=newId();
						String nickName = "";
						String headimgurl = "";
						if (wxuser.getSubscribe().equals("1")) {
							nickName = wxuser.getNickname();
							headimgurl = wxuser.getHeadimgurl();
							// 判断名称是否包含表情符号
							Boolean emoji = EmojiUtils.containsEmoji(nickName);
							if (emoji) {
								try {
									nickName = java.net.URLEncoder.encode(nickName, "UTF-8");
								} catch (UnsupportedEncodingException e) {
									e.printStackTrace();
								}
							}
						}
						//第一次进来直接保存该用户的评论的内容和图片  其实就是明星产品 配置的产品
						int saveCommentWxUser = accumulateService.saveCommentWxUser(WxUserId, activity, openid, nickName, headimgurl, uitils.newDate(), sellerPublicNumber.getId(), qrcode, accumulate.getActivityName(), "1",accumulate.getProductIntroduction(),accumulate.getProductImg());
						String mark = PropKit.use("system.properties").get("AccumulateFabulous");
						
						// 没有活动 新建一个二维码失效记录
						Map<String, Object> map = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
						//这是开启活动的运单
						ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map.get("activitySellerInfo");
						rest = new ActivityCode().set("ID", newId()).set("CODE", qrcode).set("SELLEROUTINFO_RECORDID", activitySellerInfo.getSellerOutInfoRecordId())
								.set("ACTIVITYNAME", accumulate.getActivityName()).set("SELLERPUBLICID", sellerPublicNumber.getId()).set("SELLERPUBLICNAME", sellerPublicNumber.getPublicNumberName()).set("ACTIVITY_WXID", WxUserId).set("OPENID", openid).set("NICKNAME", nickName).set("HEADIMG", headimgurl).set("MARK", mark).set("SING_NUMBER", "1").set("ACTIVITY_ID", activity).save();
						//进来一个 就将大活动的参与人数+1
						String joinPropleNumber = accumulate.getJoinPropleNumber();
						int parseInt = Integer.parseInt(joinPropleNumber)+1;
						String updateAccumulateNumber = PropKit.use("database.properties").get("updateAccumulateNumber");
						saveCommentWxUser=Db.update(updateAccumulateNumber,parseInt+"",accumulate.getId());
						if(saveCommentWxUser>0){
							rest=true;
						}else{
							rest=false;
							}
						}
						//给该用户存中奖信息              并且推送公众号消息
						String sql2="select * from TB_ACCUMULATEFABULOUS_PRIZE where PRIZEGRADE = ? AND ACCUMULATE_ID = ? ";
						AccumulatePrize accumulateFirstPrize = AccumulatePrize.dao.findFirst(sql2,"一等奖",accumulate.getId());
						//处理阀值奖
						AccumulatePrize accumulateFZPrize = AccumulatePrize.dao.findFirst(sql2,"阀值奖",accumulate.getId());
						
						resule = 3;
						setAttr("accumulateFirstPrize", accumulateFirstPrize);
						setAttr("accumulateFZPrize", accumulateFZPrize);
						setAttr("qrcode", qrcode);
						setAttr("accumulate", accumulate);
						setAttr("openid", openid);
						setAttr("wxUserInfo", wxuser);
						setAttr("accumulateCommentWxUserId", WxUserId);
						setAttr("sellerPublicNumber", sellerPublicNumber);
				}else{
					// 二维码已经使用
					resule = 2;
				}
				if(resule == 1){
					renderError(404);
				}else if(resule == 2){
					render("/index/QRCodeInvalid.html");
				}else if(resule == 3){
					render("/accumulateFabulous/accumulateFabulous-homepage.html");
				}else if(resule == 4){
					WxUserId=(String) getRequest().getSession().getAttribute("WxUserId");
					accumulateComment=AccumulateCommentWxUser.dao.findById(WxUserId);
					/**
					 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
					 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
					 */
					String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
							+ "/accumulateFabulous/goFriendRedirect?commentWxUserId=" + accumulateComment.getId() +"&accumulateId=" + accumulate.getId()
							+ "&sellerPublicNumber=" + sellerPublicNumber.getId()+ "&qrcode=" + qrcode;
					// 判断是否属于活动时间内
					Date endDate = DateUitils.strToDateYMD(accumulate.getEndTime());
					// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
					boolean isEnd = DateUitils.isDateBefore(endDate);
					setAttr("isEnd", isEnd);
					setAttr("url", url);
					setAttr("accumulate", accumulate);
					setAttr("openid", openid);
					setAttr("qrcode", qrcode);
					setAttr("sellerPublicNumberId", sellerPublicNumberId);
					setAttr("sellerPublicNumber", sellerPublicNumber);
					setAttr("accumulateCommentWxUser", accumulateComment);
					render("/accumulateFabulous/accumulateFabulous-mine.html");
				}
				return rest;
			}
		});
	}
	
	/**
	 * 参与集赞成功
	 * commentSuccess
	 * @author 81046
	 * @date 2018年5月9日下午2:43:08
	 */
	public void commentSuccess(){
		String accumulateCommentWxUserId = getPara("accumulateCommentWxUserId");
		AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao.findById(accumulateCommentWxUserId);
		String accumulateId = accumulateCommentWxUser.getAccumulateId();
		Accumulate accumulate = Accumulate.dao.findById(accumulateId);
		//公众号ID
		String sellerPublicNumberId = getPara("sellerPublicNumber");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		//所扫二维码
		String qrcode = getPara("qrcode");
		String openid = getPara("openid");
		
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(spn.getAppId());
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
		//保存微信用户
		wxService.saveWxUser(wxuser,openid,spn,newId());
		if(accumulateCommentWxUser.getNoticed().equals("0")){
			String activityUrl="%2faccumulateFabulous%2fgoFriendRedirect%3fcommentWxUserId%3d" + accumulateCommentWxUserId + "%26accumulateId%3d" + accumulateId + "%26sellerPublicNumber%3d" + spn.getId()+ "%26qrcode%3d" + qrcode;
			//这里推送参与成功通知
			Tools.sendJoinNotice(openid, spn, activityUrl, accumulate.getActivityName(), getAccessToken(spn.getAppId(),spn.getAppSecret()));
			accumulateCommentWxUser.set("ID", accumulateCommentWxUser.getId())
								   .set("NICKNAME", wxuser.getNickname())
								   .set("HEADIMGURL", wxuser.getHeadimgurl())
								   .set("NOTICED", "1")
								   .update();
		}
		ApiConfigKit.removeThreadLocalAppId();
		/**
		 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
		 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
		 */
		String url = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
				+ "/accumulateFabulous/goFriendRedirect?commentWxUserId=" + accumulateCommentWxUserId +"&accumulateId=" + accumulateId
				+ "&sellerPublicNumber=" + spn.getId()+ "&qrcode=" + qrcode;
		setAttr("url", url);
		setAttr("openid", openid);
		setAttr("qrcode", qrcode);
		setAttr("accumulate", accumulate);
		setAttr("sellerPublicNumberId", sellerPublicNumberId);
		setAttr("sellerPublicNumber", spn);
		setAttr("accumulateCommentWxUser", accumulateCommentWxUser);
		// 判断是否属于活动时间内
		Date endDate = DateUitils.strToDateYMD(accumulate.getEndTime());
		// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
		boolean isEnd = DateUitils.isDateBefore(endDate);
		setAttr("isEnd", isEnd);
		render("/accumulateFabulous/accumulateFabulous-mine.html");
	}
	
	/**
	 * 分享砍价微信配置
	 */
	public void WxShareConfig() {
		String locationUrl = getPara("locationUrl");
		Map<String, String> wxConfigApi = WxConfigUitils.getWxConfigUitils().WxConfigApi(locationUrl);
		renderJson(wxConfigApi);
	}
	
	/**
	 * 重定向
	 */
	public void goFriendRedirect(){
		String sellerPublicNumberId = getPara("sellerPublicNumber");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
		+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
		+ JFinal.me().getContextPath() + "%2faccumulateFabulous%2ffriendRedirect%3fcommentWxUserId%3d" + getPara("commentWxUserId")
		+ "%26accumulateId%3d" + getPara("accumulateId") + "%26appid%3d" + spn.getAppId() + "%26qrcode%3d" + getPara("qrcode")
		+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect";
		redirect(url);
	}
	
	
	/**
	 * 重定向 1.下一步需要获取openid,此处从新进入页面，需要授权
	 */
	public void friendRedirect() {
		String commentWxUserId = getPara("commentWxUserId");
		String accumulateId = getPara("accumulateId");
		Accumulate accumulate = Accumulate.dao.findById(accumulateId);
		AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao.findById(commentWxUserId);
		String belongPublicNumberId = accumulateCommentWxUser.getBelongPublicNumberId();
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(belongPublicNumberId);
		ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
		ApiConfigKit.setThreadLocalAppId(spn.getAppId());
		String openid = getOpenid(spn);
		String qrcode = getPara("qrcode");
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
		ApiConfigKit.removeThreadLocalAppId();
		//这是自己进自己分享出去的页面
		if(accumulateCommentWxUser.getOpenId().equals(openid)){
			setAttr("qrcode", qrcode);
			setAttr("accumulate", accumulate);
			setAttr("openid", openid);
			setAttr("wxUserInfo", wxuser);
			setAttr("accumulateCommentWxUser", accumulateCommentWxUser);
			setAttr("accumulateCommentWxUserId", commentWxUserId);
			setAttr("sellerPublicNumber", spn);
			// 判断是否属于活动时间内
			Date endDate = DateUitils.strToDateYMD(accumulate.getEndTime());
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean isEnd = DateUitils.isDateBefore(endDate);
			setAttr("isEnd", isEnd);
			render("/accumulateFabulous/accumulateFabulous-mine.html");
		}
		//这是别人进来帮忙点赞的页面
		else{
			//在这里判断当前用户是否已经给这条评论点过赞了，点了传1  没有点传0
			String sql="select * from TB_ACCUMULATE_HELP_WXUSER where COMMENT_WXUSER_ID = ? and OPENID = ? ";
			List<AccumulateHelpWxUser> list = AccumulateHelpWxUser.dao.find(sql,commentWxUserId,openid);
			if(list.size()==0){
				setAttr("clickNum", "0");
			}else{
				setAttr("clickNum", "1");
			}
			setAttr("openid", openid);
			setAttr("accumulate", accumulate);
			setAttr("accumulateCommentWxUser", accumulateCommentWxUser);
			setAttr("sellerPublicNumber", spn);
			// 判断是否属于活动时间内
			Date endDate = DateUitils.strToDateYMD(accumulate.getEndTime());
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean isEnd = DateUitils.isDateBefore(endDate);
			setAttr("isEnd", isEnd);
			render("/accumulateFabulous/accumulateFabulous-click.html");
		}
	}
	
	/**
	 * 跳转到点赞页面    自己评论分享出去的记录ID   响应点赞事件
	 */
	public void helpAccumulate(){
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String accumulateCommentWxUserId = getPara("accumulateCommentWxUserId");
				String openid = getPara("openid");
				AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao.findById(accumulateCommentWxUserId);
				String accumulateId = accumulateCommentWxUser.getAccumulateId();
				Accumulate accumulate = Accumulate.dao.findById(accumulateId);
				String publicNumberId = accumulateCommentWxUser.getBelongPublicNumberId();
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(publicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//判断该用户是否关注  没有关注  
				if(wxuser.getSubscribe().equals("1")){
					// 判断是否属于活动时间内
					Date endDate = DateUitils.strToDateYMD(accumulate.getEndTime());
					// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
					boolean isEnd = DateUitils.isDateBefore(endDate);
					//可以点赞
					if(isEnd){
						Number helpNumber = accumulateCommentWxUser.getHelpNumber();
						int number=helpNumber.intValue()+1;
						//修改集赞总数  updateAccumulateNumber
		            	String updateAccumulateNumber = PropKit.use("database.properties").get("updateAccumulateHelpNumber");
		            	//这里先判断该用户是不是已经帮忙点过赞了
		            	String sqlq="select * from TB_ACCUMULATE_HELP_WXUSER where OPENID = ? and COMMENT_WXUSER_ID = ? ";
		            	List<AccumulateHelpWxUser> list = AccumulateHelpWxUser.dao.find(sqlq,openid,accumulateCommentWxUserId);
		            	if(list.size()==0){
		            		int updateRobRedTotal = Db.update(updateAccumulateNumber,number+"", accumulateCommentWxUserId);
		    				//添加help表里的数据 
		                	String nickName = wxuser.getNickname();
		    				//判断名称是否包含表情符号
		    				Boolean emoji =  EmojiUtils.containsEmoji(nickName);
		    				if(emoji){
		    					try {
		    						nickName=java.net.URLEncoder.encode(nickName, "UTF-8");
		    					} catch (UnsupportedEncodingException e) {
		    						e.printStackTrace();
		    					}
		    				}
		    				String saveHelpAccumulateWxUser = PropKit.use("database.properties").get("saveHelpAccumulateWxUser");
		                	updateRobRedTotal = Db.update(saveHelpAccumulateWxUser,newId(), accumulateId,accumulateCommentWxUserId,openid,nickName,wxuser.getHeadimgurl(),accumulateCommentWxUser.getBelongPublicNumberId());
		                	if(updateRobRedTotal>0){
		                		map.put("result", "true");
		    					return true;
		    				}else{
		    					map.put("result", "false");
		    					return false;
		    				}
		            	}
		            	else{
		            		map.put("result", "false");
							return false;
						}
					}
					//不能点赞
					else{
						map.put("isEnd", "true");
						return false;
					}
				}else{
					map.put("result", "nofollow");
					return false;
				}
				
			}
		});
		renderJson(map);
	}
	
	/**
	 * 集赞排行榜
	 */
	public void accumulateRank(){
		String accumulateCommentWxUserId = getPara("accumulateCommentWxUserId");
		AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao.findById(accumulateCommentWxUserId);
		String accumulateId = accumulateCommentWxUser.getAccumulateId();
		Accumulate accumulate = Accumulate.dao.findById(accumulateId);
		String sql="select * from TB_ACCUMULATE_COMMENT_WXUSER where ACCUMULATE_ID = ? order by HELP_NUMBER desc ";
		List<AccumulateCommentWxUser> rankList = AccumulateCommentWxUser.dao.find(sql,accumulateId);
		int rank=0;
		List<RankBean> list=new ArrayList<>();
		for (int i = 0; i < rankList.size(); i++) {
			//如果当前的id和传过来的id相同的话就是同一个人的那条记录
			if(accumulateCommentWxUserId.equals(rankList.get(i).getId())){
				rank=i+1;
			}
			String openId = rankList.get(i).getOpenId();
			String publicNumberId = accumulateCommentWxUser.getBelongPublicNumberId();
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(publicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openId, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
			ApiConfigKit.removeThreadLocalAppId();
			String nickName = "";
			if (wxuser.getSubscribe().equals("1")) {
				nickName = wxuser.getNickname();
				// 判断名称是否包含表情符号
				Boolean emoji = EmojiUtils.containsEmoji(nickName);
				if (emoji) {
					try {
						nickName = java.net.URLEncoder.encode(nickName, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
			}
			RankBean r=new RankBean();
			r.setNickName(nickName);
			r.setHelpNumber(rankList.get(i).getHelpNumber().intValue());
			r.setRanking(i+1);
			list.add(r);
		}
		setAttr("accumulate", accumulate);
		setAttr("rankList", list);
		setAttr("rank", rank);
		setAttr("accumulateCommentWxUser", accumulateCommentWxUser);
		String belongPublicNumberId = accumulateCommentWxUser.getBelongPublicNumberId();
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
		setAttr("sellerPublicNumber", sellerPublicNumber);
		setAttr("rankNum", accumulateCommentWxUser.getHelpNumber());
		render("/accumulateFabulous/accumulateFabulous-ranking.html");
	}
	
	/**
	 * 我也要参与集赞活动链接
	 */
	public void wantAccumulate(){
		String accumulateCommentWxUserId = getPara("accumulateCommentWxUserId");
		AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao.findById(accumulateCommentWxUserId);
		String accumulateId = accumulateCommentWxUser.getAccumulateId();
		Accumulate accumulate = Accumulate.dao.findById(accumulateId);
		String belongPublicNumberId = accumulateCommentWxUser.getBelongPublicNumberId();
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
		setAttr("sellerPublicNumber", sellerPublicNumber);
		setAttr("accumulate", accumulate);
		render("/accumulateFabulous/accumulateFabulous-want.html");
	}
	
	/**
	 * 这里是定时器里要执行的方法
	 */
	public void handleTaskMethod(){
		//首先判断该活动是否结束了
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowTime = sdf.format(date);
		//判断当前时间是不是大于集赞结束时间并且处理状态为未处理
		String sql="select * from TB_ACCUMULATEFABULOUS where HANDLE = '0' and ENDTIME < '"+nowTime+"' ";
		//这里的集合就是活动结束了，没有处理的集赞活动
		List<Accumulate> list = Accumulate.dao.find(sql);
		int saveWinning=0;
		//格式化小数   
		DecimalFormat df = new DecimalFormat("##0.00");
		if(list.size()!=0){
			for (Accumulate accumulate : list) {
				String accumulateId = accumulate.getId();
				//这里开始处理参与集赞活动的微信用户   先处理第一名
				String sql1="select * from TB_ACCUMULATE_COMMENT_WXUSER where ACCUMULATE_ID = ? order by HELP_NUMBER desc";
				//这是第一名
				AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao.findFirst(sql1,accumulateId);
				//TODO 给该用户集赞数+1
				accumulateCommentWxUser.set("ID", accumulateCommentWxUser.getId()).set("HELP_NUMBER", (accumulateCommentWxUser.getHelpNumber().intValue()+1)+"").update();
				//这是二维码 瓶码
				String scanCode = accumulateCommentWxUser.getScanCode();
				//根据扫描的二维码查找出该二维码的参与情况
				String codeSql="select * from ACTIVITY_CODE where CODE =?";
				ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
				//给该用户存中奖信息              并且推送公众号消息
				String sql2="select * from TB_ACCUMULATEFABULOUS_PRIZE where PRIZEGRADE = ? AND ACCUMULATE_ID = ? ";
				AccumulatePrize accumulateFirstPrize = AccumulatePrize.dao.findFirst(sql2,"一等奖",accumulateId);
				if(accumulateFirstPrize!=null){
					//这里将中奖的用户人数更新一下
					int number=Integer.parseInt(accumulate.getWinningPropleNumber())+1;
					accumulate.set("ID", accumulateId).set("WINNING_PROPLE_NUMBER", number+"").update();
					AccumulateWxUserWinning accumulateWxWin=new AccumulateWxUserWinning();
					//这是集赞中奖的id
					String accumulateWinningId = newId();
					//这是产品记录中奖的id    这里面的wininfoId是上面的accumulateWinningId
					String productWinningInfoId = newId();
					//积分或者红包
					String thing="";
					String redMoney = accumulateFirstPrize.getRedMoney();
					String integral = accumulateFirstPrize.getIntegral();
					if(redMoney!=null){
						thing=redMoney;
					}
					if(integral!=null){
						thing=integral;
					}
					accumulateWxWin.set("ID", accumulateWinningId)
					               .set("ACCUMULATE_WXUSER_ID", accumulateCommentWxUser.getId())
					               .set("PRIZE_TYPE", accumulateFirstPrize.getPrizeType())
					               .set("BELONG_WINNING_PRIZE_ID", accumulateFirstPrize.getId())
					               .set("WINNING_MONEY", thing)
					               .set("PRIZE_PROJECT", accumulateFirstPrize.getPrizeName())
					               .set("CREATE_TIME", sdf.format(new Date()))
					               .set("PRODUCT_WINNING_INFO_ID", productWinningInfoId)
					               .set("PRIZE_PROJECT_IMG", accumulateFirstPrize.getPrizeImg())
					               .set("OPENID", accumulateCommentWxUser.getOpenId())
					               .save();
					//这里更新了该码的中奖情况
					if(activityCode!=null){
						activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", accumulateCommentWxUser.getId()).set("WINTYPE", accumulateFirstPrize.getPrizeType()).set("WININGID", accumulateWinningId).update();
					}
					accumulateCommentWxUser.set("ID", accumulateCommentWxUser.getId()).set("WINSTATE", "1").update();
					//TODO 推送公众消息
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(accumulateCommentWxUser.getBelongPublicNumberId());
					ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
					ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
					//还需要添加中奖奖品信息
					ActivityWxUser activityWxUser = indexService.queryUserByOpenidAndPublicNumberId(accumulateCommentWxUser.getOpenId(),sellerPublicNumber.getId());
					//获奖的类型  奖品类型 1实物 2积分 3红包
					String prizeType = accumulateFirstPrize.getPrizeType();
					//1实物
					if(prizeType.equals("1")){
		    			//保存一个实物中奖信息
		    			ProductWinningInfo productWinningInfo=new ProductWinningInfo();
						productWinningInfo.setId(productWinningInfoId);
						productWinningInfo.setBelongActivityId(accumulateId);
						productWinningInfo.setActivityName(accumulate.getActivityName());
						productWinningInfo.setActivityNameType(PropKit.use("system.properties").get("AccumulateFabulous"));
						productWinningInfo.setProductId("");
						productWinningInfo.setProductName(accumulateFirstPrize.getPrizeName());
						productWinningInfo.setProductImg(accumulateFirstPrize.getPrizeImg());
						productWinningInfo.setActivityPrizeId(accumulateFirstPrize.getId());
						productWinningInfo.setCreateTime(uitils.newDate());
						productWinningInfo.setStartTime(accumulate.getStartTime());
						productWinningInfo.setEndTime(accumulate.getEndTime());
						productWinningInfo.setOpenId(accumulateCommentWxUser.getOpenId());
						productWinningInfo.setActivityWxUserId(accumulateCommentWxUser.getId());
						productWinningInfo.setBelongPublicNumberId(activityWxUser.getBelongPublicNumberId());
						productWinningInfo.setState("2");
						productWinningInfo.setWinningInfoId(accumulateWinningId);
						productWinningInfo.setPayMoney("0");
						productWinningInfo.setPrice("0");
						productWinningInfo.setLowPrice("0");
						saveWinning = productWinningInfoService.saveProductWinningInfo(productWinningInfo);
					}
					//2积分
					else if(prizeType.equals("2")){
						//查询是否存在参与的积分获奖记录
		    			IntegralWinningInfo integralWinningInfoL = IntegralService.queryIntegralWinningInfo(accumulateId,accumulateCommentWxUser.getId(),accumulateCommentWxUser.getOpenId());
		    			if(integralWinningInfoL!=null){
		    				//修改中奖积分
		    				saveWinning = integralService.updateIntegralWinningInfoByIntegralNumber(Integer.parseInt(integralWinningInfoL.getWinningIntegral())+Integer.parseInt(accumulateFirstPrize.getIntegral()),integralWinningInfoL.getId());
		    			}
		    			//没有中奖积分记录
		    			else{
		    				IntegralWinningInfo integralWinningInfo =  new IntegralWinningInfo();
		    				integralWinningInfo.setId(newId());
		    				integralWinningInfo.setBelongActivityId(accumulateId);
		    				integralWinningInfo.setActivityName(accumulate.getActivityName());
		    				integralWinningInfo.setActivityNameType(PropKit.use("system.properties").get("AccumulateFabulous"));
		    				integralWinningInfo.setWinningIntegral(accumulateFirstPrize.getIntegral());
		    				integralWinningInfo.setCreateTime(uitils.newDate());
		    				integralWinningInfo.setStartTime("0");
		    				integralWinningInfo.setEndTime("0");
		    				integralWinningInfo.setOpenid(accumulateCommentWxUser.getOpenId());
		    				integralWinningInfo.setActivityWxUserId(accumulateCommentWxUser.getId());
		    				integralWinningInfo.setBelongPublicnumberId(sellerPublicNumber.getId());
		    				integralService.saveIntegralWinningInfo(integralWinningInfo);
		    			}
		    			int totalIntegral=Integer.parseInt(activityWxUser.getTotalIntegral())+Integer.parseInt(accumulateFirstPrize.getIntegral());
		    			int surplusTotalIntegral=Integer.parseInt(activityWxUser.getSurplusTotalIntegral())+Integer.parseInt(accumulateFirstPrize.getIntegral());
		    			saveWinning=indexService.updateWxUserIntegralAndMoneyById(totalIntegral+"",surplusTotalIntegral+"",activityWxUser.getTotalMoney(),activityWxUser.getSurplusTotalMoney(),activityWxUser.getId());
					}
					//红包
					else if(prizeType.equals("3")){
						//查找是否存在参与的红包获奖记录
		    			RedWinningInfo rwi =redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(accumulateId,accumulateCommentWxUser.getOpenId(),PropKit.use("system.properties").get("AccumulateFabulous"),accumulateCommentWxUser.getId());
		    			//没有红包记录 则新增一条红包记录
		    			if(rwi == null){
		    				//保存红包中奖记录
		        			RedWinningInfo redWinningInfo = new RedWinningInfo();
		        			redWinningInfo.setId(newId());
		        			redWinningInfo.setBelongActivityId(accumulateId);
		        			redWinningInfo.setActivityName(accumulate.getActivityName());
		        			redWinningInfo.setActivityNameType(PropKit.use("system.properties").get("AccumulateFabulous"));
		        			redWinningInfo.setWinningRedTotal(accumulateFirstPrize.getRedMoney());
		        			redWinningInfo.setCreateTime(uitils.newDate());
		        			//状态 0=未完成 1=完成  
		        			redWinningInfo.setState("1");
		        			redWinningInfo.setStartTime(accumulate.getStartTime());
		        			redWinningInfo.setEndTime(accumulate.getEndTime());
		        			redWinningInfo.setWithdrawals("0");
		        			redWinningInfo.setOpenid(accumulateCommentWxUser.getOpenId());
		        			redWinningInfo.setActivityWxUserId(accumulateCommentWxUser.getId());
		        			redWinningInfo.setBelongPublicnumberId(activityWxUser.getBelongPublicNumberId());
		        			saveWinning = redWinningInfoService.saveRedInfo(redWinningInfo);
		        			if(saveWinning>0){
		        				//修改用户参与转盘中奖纪录剩余抽奖次数
		        				Float totalMoney =Float.parseFloat(activityWxUser.getTotalMoney())+Float.parseFloat(accumulateFirstPrize.getRedMoney());
		        				Float surplusTotalMoney =Float.parseFloat(activityWxUser.getSurplusTotalMoney())+Float.parseFloat(redWinningInfo.getWinningRedTotal());
		        				saveWinning=indexService.updateWxUserIntegralAndMoneyById(activityWxUser.getTotalIntegral(),activityWxUser.getSurplusTotalIntegral(),df.format(totalMoney),df.format(surplusTotalMoney),activityWxUser.getId());
		        			}
		    			}
		    			else{
							Float winningRedTotal =Float.parseFloat(rwi.getWinningRedTotal())+Float.parseFloat(accumulateFirstPrize.getRedMoney());
							saveWinning = redWinningInfoService.updateRedInfo("1",df.format(winningRedTotal),accumulate.getActivityName(),rwi.getId());
							if(saveWinning > 0 ){
								//修改用户参与转盘中奖纪录剩余抽奖次数
		        				Float totalMoney =Float.parseFloat(activityWxUser.getTotalMoney())+Float.parseFloat(accumulateFirstPrize.getRedMoney());
		        				Float surplusTotalMoney =Float.parseFloat(activityWxUser.getSurplusTotalMoney())+Float.parseFloat(rwi.getWinningRedTotal());
		        				saveWinning=indexService.updateWxUserIntegralAndMoneyById(activityWxUser.getTotalIntegral(),activityWxUser.getSurplusTotalIntegral(),df.format(totalMoney),df.format(surplusTotalMoney),activityWxUser.getId());
							}
		    			}
					}
					String activityUrl="";
					//推送消息的链接 实物
					if(prizeType.equals("1")){
						//实物的链接
						activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + accumulateCommentWxUser.getOpenId()+ "%26selectedVal%3d" + "";
					}
					//奖品类型 1实物 2积分 3红包 积分
					else if(prizeType.equals("2")){
						//积分的链接
						activityUrl="%2fpersonalCenter%2fmyIntegral%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + accumulateCommentWxUser.getOpenId()+ "%26startTime%3d" + ""+ "%26endTime%3d" + "";
					}
					//红包
					else if(prizeType.equals("3")){
						//红包的链接
						activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + accumulateCommentWxUser.getOpenId();
					}
					ApiConfigKit.removeThreadLocalAppId();
					Tools.sendWinNotice(accumulateCommentWxUser.getOpenId(), sellerPublicNumber, activityUrl, accumulate.getActivityName(), accumulateFirstPrize.getPrizeName()+"(一等奖)",getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
				}
				//处理阀值奖
				AccumulatePrize accumulateFZPrize = AccumulatePrize.dao.findFirst(sql2,"阀值奖",accumulateId);
				String threshold = accumulateFZPrize.getThreshold();
				//这里推送没有中奖的通知
				//这是配置的阀值
				String sqlNo="select * from TB_ACCUMULATE_COMMENT_WXUSER where ACCUMULATE_ID = ? and HELP_NUMBER < ? and id != ?";
				List<AccumulateCommentWxUser> noComWxUserList = AccumulateCommentWxUser.dao.find(sqlNo,accumulateId,threshold,accumulateCommentWxUser.getId());
				for (AccumulateCommentWxUser accumulateCommentWxUserNo : noComWxUserList) {
					//TODO 推送公众消息
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(accumulateCommentWxUserNo.getBelongPublicNumberId());
					ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
					ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
					//这里直接给没有中奖的用户发送通知
					String activityUrl="%2faccumulateFabulous%2fgoFriendRedirect%3fcommentWxUserId%3d" + accumulateCommentWxUserNo.getId() + "%26accumulateId%3d" + accumulateId + "%26sellerPublicNumber%3d" + sellerPublicNumber.getId()+ "%26qrcode%3d" + accumulateCommentWxUserNo.getScanCode();
					Tools.sendWinNotice(accumulateCommentWxUserNo.getOpenId(), sellerPublicNumber, activityUrl, accumulate.getActivityName(), "未中奖", getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
					ApiConfigKit.removeThreadLocalAppId();
				}
				
				if(accumulateFZPrize!=null){
					//这里将中奖的用户人数更新一下
					int number=Integer.parseInt(accumulate.getWinningPropleNumber())+1;
					accumulate.set("ID", accumulateId).set("WINNING_PROPLE_NUMBER", number+"").update();
					//这是配置的阀值
					String sql3="select * from TB_ACCUMULATE_COMMENT_WXUSER where ACCUMULATE_ID = ? and HELP_NUMBER >= ? and id != ?";
					List<AccumulateCommentWxUser> comWxUserList = AccumulateCommentWxUser.dao.find(sql3,accumulateId,threshold,accumulateCommentWxUser.getId());
					//这里中了阀值奖的用户
					for (AccumulateCommentWxUser accumulateCommentWxUser2 : comWxUserList) {
						//TODO 推送公众消息
						SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(accumulateCommentWxUser2.getBelongPublicNumberId());
						ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
						ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
						AccumulateWxUserWinning accumulateWxWin1=new AccumulateWxUserWinning();
						//积分或者红包
						String thing="";
						//这里是集赞中奖的id
						String accumulateWinningId = newId();
	        			String productWinningInfoId = newId();
						String redMoney = accumulateFZPrize.getRedMoney();
						String integral = accumulateFZPrize.getIntegral();
						if(redMoney!=null&&!"".equals(redMoney)){
							thing=redMoney;
						}
						if(integral!=null&&!"".equals(integral)){
							thing=integral;
						}
						accumulateWxWin1.set("ID", accumulateWinningId)
			               .set("ACCUMULATE_WXUSER_ID", accumulateCommentWxUser2.getId())
			               .set("PRIZE_TYPE", accumulateFZPrize.getPrizeType())
			               .set("BELONG_WINNING_PRIZE_ID", accumulateFZPrize.getId())
			               .set("WINNING_MONEY", thing)
			               .set("PRODUCT_WINNING_INFO_ID", productWinningInfoId)
			               .set("PRIZE_PROJECT", accumulateFZPrize.getPrizeName())
			               .set("CREATE_TIME", sdf.format(new Date()))
			               .set("PRIZE_PROJECT_IMG", accumulateFZPrize.getPrizeImg())
			               .set("OPENID", accumulateCommentWxUser2.getOpenId())
			               .save();
						//这里更新了该码的中奖情况
						if(activityCode!=null){
							activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", accumulateCommentWxUser.getId()).set("WINTYPE", accumulateFZPrize.getPrizeType()).set("WININGID", accumulateWinningId).update();
						}
						accumulateCommentWxUser2.set("ID", accumulateCommentWxUser2.getId()).set("WINSTATE", "2").update();
						ActivityWxUser activityWxUser1 = indexService.queryUserByOpenidAndPublicNumberId(accumulateCommentWxUser2.getOpenId(),sellerPublicNumber.getId());
						//TODO 推送消息  阀值奖用户
						SellerPublicNumber sellerPublicNumber1 = SellerPublicNumber.dao.findById(accumulateCommentWxUser2.getBelongPublicNumberId());
						ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber1.getToKen(), sellerPublicNumber1.getAppId(), sellerPublicNumber1.getAppSecret()));
						//获奖的类型  奖品类型 1实物 2积分 3红包
						String prizeType1 = accumulateFZPrize.getPrizeType();
						//1实物
						if(prizeType1.equals("1")){
		        			//保存一个实物中奖信息
		        			ProductWinningInfo productWinningInfo=new ProductWinningInfo();
							productWinningInfo.setId(productWinningInfoId);
							productWinningInfo.setBelongActivityId(accumulateId);
							productWinningInfo.setActivityName(accumulate.getActivityName());
							productWinningInfo.setActivityNameType(PropKit.use("system.properties").get("AccumulateFabulous"));
							productWinningInfo.setProductId("");
							productWinningInfo.setProductName(accumulateFZPrize.getPrizeName());
							productWinningInfo.setProductImg(accumulateFZPrize.getPrizeImg());
							productWinningInfo.setActivityPrizeId(accumulateFZPrize.getId());
							productWinningInfo.setCreateTime(uitils.newDate());
							productWinningInfo.setStartTime(accumulate.getStartTime());
							productWinningInfo.setEndTime(accumulate.getEndTime());
							productWinningInfo.setOpenId(accumulateCommentWxUser2.getOpenId());
							productWinningInfo.setActivityWxUserId(accumulateCommentWxUser2.getId());
							productWinningInfo.setBelongPublicNumberId(activityWxUser1.getBelongPublicNumberId());
							productWinningInfo.setState("2");
							productWinningInfo.setWinningInfoId(accumulateWinningId);
							saveWinning = productWinningInfoService.saveProductWinningInfo(productWinningInfo);
						}
						//2积分
						else if(prizeType1.equals("2")){
							//查询是否存在参与的积分获奖记录
		        			IntegralWinningInfo integralWinningInfoL = IntegralService.queryIntegralWinningInfo(accumulateId,accumulateCommentWxUser2.getId(),accumulateCommentWxUser2.getOpenId());
		        			if(integralWinningInfoL!=null){
		        				//修改中奖积分
		        				saveWinning = integralService.updateIntegralWinningInfoByIntegralNumber(Integer.parseInt(integralWinningInfoL.getWinningIntegral())+Integer.parseInt(accumulateFZPrize.getIntegral()),integralWinningInfoL.getId());
		        			}
		        			//没有中奖积分记录
		        			else{
		        				IntegralWinningInfo integralWinningInfo =  new IntegralWinningInfo();
		        				integralWinningInfo.setId(newId());
		        				integralWinningInfo.setBelongActivityId(accumulateId);
		        				integralWinningInfo.setActivityName(accumulate.getActivityName());
		        				integralWinningInfo.setActivityNameType(PropKit.use("system.properties").get("AccumulateFabulous"));
		        				integralWinningInfo.setWinningIntegral(accumulateFZPrize.getIntegral());
		        				integralWinningInfo.setCreateTime(uitils.newDate());
		        				integralWinningInfo.setStartTime("0");
		        				integralWinningInfo.setEndTime("0");
		        				integralWinningInfo.setOpenid(accumulateCommentWxUser2.getOpenId());
		        				integralWinningInfo.setActivityWxUserId(accumulateCommentWxUser2.getId());
		        				integralWinningInfo.setBelongPublicnumberId(sellerPublicNumber.getId());
		        				integralService.saveIntegralWinningInfo(integralWinningInfo);
		        			}
		        			int totalIntegral=Integer.parseInt(activityWxUser1.getTotalIntegral())+Integer.parseInt(accumulateFZPrize.getIntegral());
		        			int surplusTotalIntegral=Integer.parseInt(activityWxUser1.getSurplusTotalIntegral())+Integer.parseInt(accumulateFZPrize.getIntegral());
		        			saveWinning=indexService.updateWxUserIntegralAndMoneyById(totalIntegral+"",surplusTotalIntegral+"",activityWxUser1.getTotalMoney(),activityWxUser1.getSurplusTotalMoney(),activityWxUser1.getId());
						}
						//红包
						else if(prizeType1.equals("3")){
							//查找是否存在参与的红包获奖记录
		        			RedWinningInfo rwi =redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(accumulateId,accumulateCommentWxUser2.getOpenId(),PropKit.use("system.properties").get("AccumulateFabulous"),accumulateCommentWxUser2.getId());
		        			//没有红包记录 则新增一条红包记录
		        			if(rwi == null){
		        				//保存红包中奖记录
		            			RedWinningInfo redWinningInfo = new RedWinningInfo();
		            			redWinningInfo.setId(newId());
		            			redWinningInfo.setBelongActivityId(accumulateId);
		            			redWinningInfo.setActivityName(accumulate.getActivityName());
		            			redWinningInfo.setActivityNameType(PropKit.use("system.properties").get("AccumulateFabulous"));
		            			redWinningInfo.setWinningRedTotal(accumulateFZPrize.getRedMoney());
		            			redWinningInfo.setCreateTime(uitils.newDate());
		            			//状态 0=未完成 1=完成  
		            			redWinningInfo.setState("1");
		            			redWinningInfo.setStartTime(accumulate.getStartTime());
		            			redWinningInfo.setEndTime(accumulate.getEndTime());
		            			redWinningInfo.setWithdrawals("0");
		            			redWinningInfo.setOpenid(accumulateCommentWxUser2.getOpenId());
		            			redWinningInfo.setActivityWxUserId(accumulateCommentWxUser2.getId());
		            			redWinningInfo.setBelongPublicnumberId(activityWxUser1.getBelongPublicNumberId());
		            			saveWinning = redWinningInfoService.saveRedInfo(redWinningInfo);
		            			if(saveWinning>0){
		            				//修改用户参与转盘中奖纪录剩余抽奖次数
		            				Float totalMoney =Float.parseFloat(activityWxUser1.getTotalMoney())+Float.parseFloat(accumulateFZPrize.getRedMoney());
		            				Float surplusTotalMoney =Float.parseFloat(activityWxUser1.getSurplusTotalMoney())+Float.parseFloat(redWinningInfo.getWinningRedTotal());
		            				saveWinning=indexService.updateWxUserIntegralAndMoneyById(activityWxUser1.getTotalIntegral(),activityWxUser1.getSurplusTotalIntegral(),df.format(totalMoney),df.format(surplusTotalMoney),activityWxUser1.getId());
		            			}
		        			}
		        			else{
		    					Float winningRedTotal =Float.parseFloat(rwi.getWinningRedTotal())+Float.parseFloat(accumulateFZPrize.getRedMoney());
		    					saveWinning = redWinningInfoService.updateRedInfo("1",df.format(winningRedTotal),accumulate.getActivityName(),rwi.getId());
		    					if(saveWinning > 0 ){
		    						//修改用户参与转盘中奖纪录剩余抽奖次数
		            				Float totalMoney =Float.parseFloat(activityWxUser1.getTotalMoney())+Float.parseFloat(accumulateFZPrize.getRedMoney());
		            				Float surplusTotalMoney =Float.parseFloat(activityWxUser1.getSurplusTotalMoney())+Float.parseFloat(rwi.getWinningRedTotal());
		            				saveWinning=indexService.updateWxUserIntegralAndMoneyById(activityWxUser1.getTotalIntegral(),activityWxUser1.getSurplusTotalIntegral(),df.format(totalMoney),df.format(surplusTotalMoney),activityWxUser1.getId());
		    					}
		        			}
						}
						String activityUrl="";
						//推送消息的链接 实物
						if(prizeType1.equals("1")){
							//实物的链接
							activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber1.getId() + "%26oid%3d" + accumulateCommentWxUser2.getOpenId()+ "%26selectedVal%3d" + "";
						}
						//奖品类型 1实物 2积分 3红包 积分
						else if(prizeType1.equals("2")){
							activityUrl="%2fpersonalCenter%2fmyIntegral%3fBPN%3d" + sellerPublicNumber1.getId() + "%26oid%3d" + accumulateCommentWxUser2.getOpenId()+ "%26startTime%3d" + ""+ "%26endTime%3d" + "";
						}
						//红包
						else if(prizeType1.equals("3")){
							activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber1.getId() + "%26oid%3d" + accumulateCommentWxUser2.getOpenId();
						}
						Tools.sendWinNotice(accumulateCommentWxUser2.getOpenId(), sellerPublicNumber1, activityUrl, accumulate.getActivityName(), accumulateFZPrize.getPrizeName()+"(阀值奖)", getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
						ApiConfigKit.removeThreadLocalAppId();
					}
				}
				//这里阀值奖处理完
				//这里将该集赞活动的状态修改为已经处理的了
				accumulate.set("ID", accumulate.getId()).set("HANDLE", "1").update();
			 }
		}
	}
}
