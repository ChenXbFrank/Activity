package com.activity.common.controller.moblie.puzzleConfig;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.puzzle.Puzzle;
import com.activity.common.model.puzzle.PuzzlePrize;
import com.activity.common.model.puzzle.PuzzleWxUser;
import com.activity.common.model.puzzle.PuzzleWxUserWinning;
import com.activity.common.service.puzzle.PuzzleService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 拼图游戏
 * @author ChenXb
 *
 * 2017年12月18日
 */
@ControllerPath(controllerKey = "/puzzle")
public class PuzzleController extends BaseController{
	PuzzleService puzzleService = PuzzleService.getService();
	IndexService indexService =IndexService.getService();
	WxService wxService = WxService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	
	public void puzzle(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				//公众号ID
				String sellerPublicNumberId = getPara("sellerPublicNumber");
				// 活动ID
				String activity = getPara("Activity");
				//所扫二维码
				String qrcode = getPara("qrcode");
				String sql="select * from TB_PUZZLE_PRIZE where PUZZLE_ID = ? ";
				PuzzlePrize puzzlePrize = PuzzlePrize.dao.findFirst(sql,activity);
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getOpenid(sellerPublicNumber);
				boolean rest = IndexService.getService().queryQrcodeState(qrcode, activity, openid);
				//第一次扫码进入
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				// 默认该用户未关注
				String follow = "0";
				if (wxuser.getSubscribe().equals("1")) {
					// 不为空的时候则是获取该用户的关注情况
					follow = wxuser.getSubscribe();
				}
				setAttr("follow", follow);
				//判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
				PuzzleWxUser puzzleWxUser = puzzleService.getPuzzleByOpenidAndQrCode(openid, qrcode);
				Puzzle puzzle = Puzzle.dao.findById(activity);
				String joinPropleNumber = puzzle.getJoinPropleNumber();
				//当前参与人数
				int parseInt = Integer.parseInt(joinPropleNumber);
				String WxUserId ;
				//1=未保存成功  2=二维码已经使用  3=成功
				int resule = 1;
				if(rest){
					WxUserId = "";
					if(puzzleWxUser!=null){
						//已经参加过了,再次进入
						WxUserId=puzzleWxUser.getId();
					}else{
						WxUserId=newId();
						// 保存微信用户 现在的流程是不需要关注就可以参与抽奖，所以保存的信息就只有openid
						wxService.noSaveWxUser(wxuser, openid, sellerPublicNumber, newId());
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
						int savePuzzleWxUser = puzzleService.savePuzzleWxUser(WxUserId, activity, openid, nickName, headimgurl, uitils.newDate(), sellerPublicNumber.getId(), qrcode, puzzle.getActivityName(), "3");
						// 查询出所属运单   没有活动 新建一个二维码失效记录   保存当前所扫二维码已被使用的记录
						Map<String, Object> map = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
						//这是开启活动的运单
						ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map.get("activitySellerInfo");
						String mark = PropKit.use("system.properties").get("Puzzle");
						rest = new ActivityCode().set("ID", newId()).set("CODE", qrcode).set("SELLEROUTINFO_RECORDID", activitySellerInfo.getSellerOutInfoRecordId())
								.set("ACTIVITYNAME", puzzle.getActivityName()).set("SELLERPUBLICID", sellerPublicNumber.getId()).set("SELLERPUBLICNAME", sellerPublicNumber.getPublicNumberName()).set("ACTIVITY_WXID", WxUserId).set("OPENID", openid).set("NICKNAME", nickName).set("HEADIMG", headimgurl).set("MARK", mark).set("SING_NUMBER", "1").set("ACTIVITY_ID", activity).save();
						//updatePuzzleNumber 更新参与人数
						String updatePuzzleNumber = PropKit.use("database.properties").get("updatePuzzleNumber");
						savePuzzleWxUser=Db.update(updatePuzzleNumber,parseInt+1+"",activity);
						if(savePuzzleWxUser>0){
							rest=true;
						}
						else{
							rest=false;
						    }
					}
					resule = 3;
					setAttr("qrcode", qrcode);
					setAttr("puzzle", puzzle);
					setAttr("puzzlePrize", puzzlePrize);
					setAttr("openid", openid);
					setAttr("wxUserInfo", wxuser);
					setAttr("puzzleWxUserId", WxUserId);
					setAttr("sellerPublicNumber", sellerPublicNumber);
					//根据openID和二维码查询该用户是否能拼图了     状态0开始拼图 1成功 2未成功 3未开始拼图
					String sql1="select * from TB_PUZZLE_WXUSER where OPENID = ? and SCAN_CODE = ? and STATE = ? ";
					List<PuzzleWxUser> list = PuzzleWxUser.dao.find(sql1,openid,qrcode,"3");
					//如果有记录  则表示该码还可以拼图
					if(list.size()>0){
						setAttr("canPuzzle", "1");
					}else{
						setAttr("canPuzzle", "0");
					}
				}else{
					// 二维码已经使用
					resule = 2;
				}
				if(resule == 1){
					renderError(404);
				}else if(resule == 2){
					render("/index/QRCodeInvalid.html");
				}else if(resule == 3){
					render("/puzzle/index.html");
				}
				return rest;
			}
		});
	}
	
	/**
	 * 点击开始拼图
	 */
	public void puzzleStart(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String puzzleWxUserId = getPara("puzzleWxUserId");
				PuzzleWxUser puzzleWxUser = PuzzleWxUser.dao.findById(puzzleWxUserId);
				//将该状态改为开始拼图         状态0开始拼图 1成功 2未成功 3未开始拼图 
				Boolean update = puzzleWxUser.set("ID", puzzleWxUserId).set("STATE", "0").update();
				renderJson(update);
				return update;
			}
		});
	}
	
	/**
	 * 拼图失败
	 */
	public void puzzleFailure(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String puzzleWxUserId = getPara("puzzleWxUserId");
				PuzzleWxUser puzzleWxUser = PuzzleWxUser.dao.findById(puzzleWxUserId);
				//将该状态改为开始拼图         状态0开始拼图 1成功 2未成功 3未开始拼图 
				Boolean update = puzzleWxUser.set("ID", puzzleWxUserId).set("STATE", "2").update();
				renderJson(update);
				return update;
			}
		});
		
	}
	
	/**
	 * 拼图成功  生成一个实物奖品
	 */
	public void savePrize(){
		Map<String,String> map=new HashMap<>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String puzzleWxUserId = getPara("puzzleWxUserId");
				String openId = getPara("openId");
				PuzzleWxUser puzzleWxUser = PuzzleWxUser.dao.findById(puzzleWxUserId);
				String belongPublicNumberId = puzzleWxUser.getBelongPublicNumberId();
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String scanCode = puzzleWxUser.getScanCode();
				//根据扫描的二维码查找出该二维码的参与情况
				String codeSql="select * from ACTIVITY_CODE where CODE =?";
				ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
				//将该状态改为拼图成功
				boolean update = puzzleWxUser.set("ID", puzzleWxUserId).set("STATE", "1").update();
				//这里查询该码是否已经有中奖记录了
				String sql1="select * from TB_PUZZLE_WXUSER_WINNING where PUZZLE_WXUSER_ID = ? and OPENID = ? ";
				PuzzleWxUserWinning puzzleWxUserWinning = PuzzleWxUserWinning.dao.findFirst(sql1,puzzleWxUserId,openId);
				if(puzzleWxUserWinning==null){
					String puzzleId = puzzleWxUser.getPuzzleId();
					Puzzle puzzle = Puzzle.dao.findById(puzzleId);
					//将中奖人数更新一下
					String winningPropleNumber = puzzle.getWinningPropleNumber();
					int parseInt = Integer.parseInt(winningPropleNumber);
					update=puzzle.set("ID", puzzleId).set("WINNING_PROPLE_NUMBER", parseInt+1+"").update();
					String sql="select * from TB_PUZZLE_PRIZE where PUZZLE_ID = ? ";
					PuzzlePrize puzzlePrize = PuzzlePrize.dao.findFirst(sql,puzzleId);
					//保存中奖实物的记录
					String newId = newId();//product产品id
					String winNewId = newId(); //中奖记录的id
					ProductWinningInfo pwi=new ProductWinningInfo();
					update = pwi.set("ID", newId)
					   .set("BELONG_ACTIVITY_ID", puzzleWxUserId)
					   .set("ACTIVITY_NAME_TYPE", PropKit.use("system.properties").get("Puzzle"))
					   .set("ACTIVITY_NAME", puzzle.getActivityName())
					   .set("ACTIVITY_PRIZE_ID", puzzlePrize.getId())
					   .set("PRODUCT_NAME", puzzlePrize.getPrizeName())
					   .set("PRODUCT_ID", puzzlePrize.getId())
					   .set("PRODUCT_IMG", puzzlePrize.getProductImg())
					   .set("CREATE_TIME", uitils.newDate())
					   .set("OPENID", openId)
					   .set("ACTIVITY_WXUSER_ID", puzzleWxUser.getId())
					   .set("BELONG_PUBLICNUMBER_ID", puzzleWxUser.getBelongPublicNumberId())
					   .set("STATE", "2")
					   .set("WINNING_INFO_ID", winNewId)
					   .set("PAY_MONEY","0")
					   .set("PRICE", "0")
					   .set("LOW_PRICE","0")
					   .save();
					PuzzleWxUserWinning pw=new PuzzleWxUserWinning();
					update = pw.set("ID", winNewId)
					   .set("PUZZLE_WXUSER_ID", puzzleWxUserId)
					   .set("BELONG_WINNING_PRIZE_ID", puzzlePrize.getId())
					   .set("PRIZE_PROJECT", puzzlePrize.getPrizeName())
					   .set("PRIZE_TYPE", "1")
					   .set("PRIZE_PROJECT_IMG", puzzlePrize.getProductImg())
					   .set("CREATE_TIME", uitils.newDate())
					   .set("OPENID", openId)
					   .set("STATE", "2")
					   .set("PRODUCT_WINNING_INFO_ID", newId)
					   .save();
					if(activityCode!=null){
					//这里更新了该码的中奖情况
					activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", puzzleWxUser.getId()).set("WINTYPE", "1").set("WININGID", winNewId).update();
					}
					String activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + puzzleWxUser.getOpenId()+ "%26selectedVal%3d" + "";
					//这里推送中奖通知  实物
					Tools.sendWinNotice(puzzleWxUser.getOpenId(), sellerPublicNumber, activityUrl, puzzle.getActivityName(), puzzlePrize.getPrizeName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));;
					ApiConfigKit.removeThreadLocalAppId();
					if(update){
						map.put("result","true");
					}else{
						map.put("result","false");
					}
					map.put("puzzleWinningId", winNewId);
				}else{
					map.put("result","false");
					map.put("puzzleWinningId", newId());
				}
				return update;
			}
		});
		renderJson(map);
	}
	
	/**
	 * 填写地址
	 */
	public void address(){
		String puzzleWinningId = getPara("puzzleWinningId");
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		Boolean result=false;
		if(puzzleWinningId!=null){
			PuzzleWxUserWinning puzzleWxUserWinning = PuzzleWxUserWinning.dao.findById(puzzleWinningId);
			result =  new PuzzleWxUserWinning().set("ID", puzzleWinningId).set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
				.set("ADDRESSEE_PHONE", tel).set("STATE", "3").update();
			if(result){
				result = new ProductWinningInfo().set("ID", puzzleWxUserWinning.getProductWinningInfoId()).set("STATE", "3").set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
						.set("ADDRESSEE_PHONE", tel).update();
			}
			String openid = puzzleWxUserWinning.getOpenId();
			if (openid != null) {
				String puzzleWxuserId = puzzleWxUserWinning.getPuzzleWxuserId();
				PuzzleWxUser puzzleWxUser = PuzzleWxUser.dao.findById(puzzleWxuserId);
				String belongPublicNumberId = puzzleWxUser.getBelongPublicNumberId();
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				//补全用户信息
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//保存或修改微信用户
				wxService.saveWxUser(wxuser,openid,sellerPublicNumber,newId());
				//修改记录中的微信名称和头像地址  这是修改拼图的
				String sqlPuzzle = PropKit.use("database.properties").get("updatePuzzleNameByOpenid");
				Db.update(sqlPuzzle,wxuser.getNickname(),wxuser.getHeadimgurl(),openid);
			}
		}
		renderJson(result);
	}
	
	/**
	 * 点击我的奖品
	 */
	public void myPrize(){
		String puzzleWxUserId = getPara("puzzleWxUserId");
		String sql="select * from TB_PUZZLE_WXUSER_WINNING where PUZZLE_WXUSER_ID = ? ";
		PuzzleWxUserWinning puzzleWxUserWinning = PuzzleWxUserWinning.dao.findFirst(sql,puzzleWxUserId);
		renderJson(puzzleWxUserWinning);
	}
	
}
