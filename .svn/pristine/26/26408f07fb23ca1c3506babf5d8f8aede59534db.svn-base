package com.activity.common.controller.pc.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.accumulate.Accumulate;
import com.activity.common.model.accumulate.AccumulateCommentWxUser;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.black.BlackList;
import com.activity.common.model.black.BlackPrize;
import com.activity.common.model.breakEgg.BreakEgg;
import com.activity.common.model.breakEgg.BreakEggWxUser;
import com.activity.common.model.centerObjcet.BlackCenterObj;
import com.activity.common.model.centerObjcet.BlackListBean;
import com.activity.common.model.groupPurchase.GroupPurchase;
import com.activity.common.model.groupPurchase.GroupPurchaseWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyShop;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUser;
import com.activity.common.model.puzzle.Puzzle;
import com.activity.common.model.puzzle.PuzzleWxUser;
import com.activity.common.model.robRed.RobRed;
import com.activity.common.model.robRed.RobRedWxUser;
import com.activity.common.model.scratchCard.ScratchCard;
import com.activity.common.model.scratchCard.ScratchCardWxUser;
import com.activity.common.model.shareBargain.ShareBargain;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.activity.common.model.system.SystemUser;
import com.activity.common.model.turntable.TurnTable;
import com.activity.common.model.turntable.TurnTableWxUser;
import com.activity.common.service.system.BlackListService;
import com.activity.common.utils.system.Tools;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.kit.PropKit;
import com.web.controller.ControllerPath;

import net.sf.json.JSONArray;

/**
 * 黑名单控制器
 * 
 * @author ChenXb
 *
 *         2018年5月30日
 */
@ControllerPath(controllerKey = "/black")
public class BlackController extends BaseController {
	
	BlackListService blackListService = BlackListService.getService();
	/**
	 * 黑名单模块 查询出所有的超过阀值的扫码报表
	 */
	public void index() {
		SystemUser user = CacheLoginUser();
		//先根据经销商USERCODE查询他是否已经配置过了
		BlackPrize blackPrize = blackListService.getBlackPrizeByUserCode(user.getUserCode());
		String threshold = blackPrize.getThreshold();
		setAttr("threshold", threshold);
		render("/system/black.html");
	}

	/**
	 * 进入页面加载该方法 给页面传递数据 getBlackListPage
	 * 
	 * @author 81046
	 * @date 2018年6月4日下午3:21:11
	 */
	public void getBlackListPage() {
		SystemUser user = CacheLoginUser();
		String pageNumber = getPara("pageNumber");
		String activityNamePra = getPara("activityName");
		List<BlackListBean> results = new ArrayList<>();
		// 这是所有的扫码记录
		List<ActivityCode> list = blackListService.getCodeByName(activityNamePra);
		// 这里根据微信活动id和大活动的mark去查询用户的扫码记录
		for (ActivityCode activityCode : list) {
			// 先取出活动的mark
			String mark = activityCode.getMark();
			// 这里再取出微信活动的ID 然后再查询对应的数据
			String activityWxId = activityCode.getActivityWxId();
			// 大活动id
			String activityId = activityCode.getActivityId();
			// 运单的记录ID
			String sellerOutInfoRecordId = activityCode.getSellerOutInfoRecordId();
			// 酒品名称
			String prizeName = "";
			// 活动名称
			String activityName = "";
			// 微信昵称
			String nickName = "";
			// 头像
			String headImg = "";
			// 扫码次数
			String scanNum = "";
			// openId
			String openId = "";
			if (!StringUtils.isEmpty(sellerOutInfoRecordId)) {
				prizeName=blackListService.getProductNameByRecordId(sellerOutInfoRecordId);
			}

			// 分享砍价活动
			if (mark.equals(PropKit.use("system.properties").get("ShareBargain"))) {
				if (!StringUtils.isEmpty(activityId)) {
					ShareBargain shareBargain = ShareBargain.dao.findById(activityId);
					if (shareBargain != null)
						activityName = shareBargain.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					ShareBargainWxuser shareBargainWxuser = ShareBargainWxuser.dao.findById(activityWxId);
					if (shareBargainWxuser != null) {
						nickName = shareBargainWxuser.getNickName();
						headImg = shareBargainWxuser.getHeadImgUrl();
						openId = shareBargainWxuser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 红包活动
			if (mark.equals(PropKit.use("system.properties").get("RobRed"))) {
				if (!StringUtils.isEmpty(activityId)) {
					RobRed robRed = RobRed.dao.findById(activityId);
					if (robRed != null)
						activityName = robRed.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					RobRedWxUser robRedWxUser = RobRedWxUser.dao.findById(activityWxId);
					if (robRedWxUser != null) {
						nickName = robRedWxUser.getNickName();
						headImg = robRedWxUser.getHeadImgUrl();
						openId = robRedWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 积分活动
			if (mark.equals(PropKit.use("system.properties").get("Integral")))
				System.out.println("积分活动没有扫码");
			// 拼图活动
			if (mark.equals(PropKit.use("system.properties").get("Puzzle"))) {
				if (!StringUtils.isEmpty(activityId)) {
					Puzzle puzzle = Puzzle.dao.findById(activityId);
					if (puzzle != null)
						activityName = puzzle.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					PuzzleWxUser puzzleWxUser = PuzzleWxUser.dao.findById(activityWxId);
					if (puzzleWxUser != null) {
						nickName = puzzleWxUser.getNickName();
						headImg = puzzleWxUser.getHeadImgUrl();
						openId = puzzleWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 呱呱卡活动
			if (mark.equals(PropKit.use("system.properties").get("ScratchCard"))) {
				if (!StringUtils.isEmpty(activityId)) {
					ScratchCard scratchCard = ScratchCard.dao.findById(activityId);
					if (scratchCard != null)
						activityName = scratchCard.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					ScratchCardWxUser scratchCardWxUser = ScratchCardWxUser.dao.findById(activityWxId);
					if (scratchCardWxUser != null) {
						nickName = scratchCardWxUser.getNickName();
						headImg = scratchCardWxUser.getHeadImgUrl();
						openId = scratchCardWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 转盘活动
			if (mark.equals(PropKit.use("system.properties").get("Turntable"))) {
				if (!StringUtils.isEmpty(activityId)) {
					TurnTable turnTable = TurnTable.dao.findById(activityId);
					if (turnTable != null)
						activityName = turnTable.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					TurnTableWxUser turnTableWxUser = TurnTableWxUser.dao.findById(activityWxId);
					if (turnTableWxUser != null) {
						nickName = turnTableWxUser.getNickName();
						headImg = turnTableWxUser.getHeadImgUrl();
						openId = turnTableWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 拼团活动
			if (mark.equals(PropKit.use("system.properties").get("GroupPurchase"))) {
				if (!StringUtils.isEmpty(activityId)) {
					GroupPurchase groupPurchase = GroupPurchase.dao.findById(activityId);
					if (groupPurchase != null)
						activityName = groupPurchase.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(activityWxId);
					if (groupPurchaseWxUser != null) {
						nickName = groupPurchaseWxUser.getNickName();
						headImg = groupPurchaseWxUser.getHeadImgUrl();
						openId = groupPurchaseWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 砸蛋活动
			if (mark.equals(PropKit.use("system.properties").get("BreakEgg"))) {
				if (!StringUtils.isEmpty(activityId)) {
					BreakEgg breakEgg = BreakEgg.dao.findById(activityId);
					if (breakEgg != null)
						activityName = breakEgg.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					BreakEggWxUser breakEggWxUser = BreakEggWxUser.dao.findById(activityWxId);
					if (breakEggWxUser != null) {
						nickName = breakEggWxUser.getNickName();
						headImg = breakEggWxUser.getHeadImgUrl();
						openId = breakEggWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 集赞活动
			if (mark.equals(PropKit.use("system.properties").get("AccumulateFabulous"))) {
				if (!StringUtils.isEmpty(activityId)) {
					Accumulate accumulate = Accumulate.dao.findById(activityId);
					if (accumulate != null)
						activityName = accumulate.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					AccumulateCommentWxUser accumulateCommentWxUser = AccumulateCommentWxUser.dao
							.findById(activityWxId);
					if (accumulateCommentWxUser != null) {
						nickName = accumulateCommentWxUser.getNickName();
						headImg = accumulateCommentWxUser.getHeadImgUrl();
						openId = accumulateCommentWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			// 一元购活动
			if (mark.equals(PropKit.use("system.properties").get("OneMoneyShop"))) {
				if (!StringUtils.isEmpty(activityId)) {
					OneMoneyShop oneMoneyShop = OneMoneyShop.dao.findById(activityId);
					if (oneMoneyShop != null)
						activityName = oneMoneyShop.getActivityName();
				}
				if (!StringUtils.isEmpty(activityWxId)) {
					OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findById(activityWxId);
					if (oneMoneyWxUser != null) {
						nickName = oneMoneyWxUser.getNickName();
						headImg = oneMoneyWxUser.getHeadImgUrl();
						openId = oneMoneyWxUser.getOpenId();
						if (!StringUtils.isEmpty(openId))
							scanNum = blackListService.getScanNumByOpenIdActivityMarkAndId(openId, mark, activityId);
					}
				}
			}
			
			//添加集合之前，判断该集合里面是否已经有了该对象了
			BlackListBean bb = new BlackListBean();
			bb.setActivityName(activityName);
			bb.setActivityType(mark);
			bb.setHeadImgUrl(headImg);
			bb.setNickName(nickName);
			bb.setPrizeName(prizeName);
			bb.setScanNum(scanNum);
			bb.setOpenId(openId);
			bb.setActivityId(activityId);
			//这里判断该用户的该次活动的扫码次数是否大于了阀值  
			BlackPrize blackPrize = blackListService.getBlackPrizeByUserCode(user.getUserCode());
			String threshold = blackPrize.getThreshold();
			if(Integer.parseInt(scanNum)>=Integer.parseInt(threshold)){
				results.add(bb);
			}
		}
		//去重复
        for (int i = 0; i < results.size(); i++){  //外循环是循环的次数
            for (int j = results.size() - 1 ; j > i; j--){	//内循环是 外循环一次比较的次数
                if (results.get(i).getActivityId().equals(results.get(j).getActivityId())){
                	if(results.get(i).getOpenId().equals(results.get(j).getOpenId())){
                		results.remove(j);
                	}
                }
            }
        }
        //这里查询出来之后，还要查看该用户记录是否已经在黑名单里面的了，如果在则移除
        for (int i = 0; i < results.size(); i++) {
        	//判断该用户是不是黑名单
        	if(blackListService.existBlackList(results.get(i).getOpenId(), results.get(i).getActivityId(), user.getUserCode())){
        		results.remove(i);
        		i--;
        	}
		}
        
		// *****
		int startLen = 0;
		int endLen = 0;
		int totalPages = 0;
		// 每页显示的条数
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		int pageNum = Integer.parseInt(pageNumber);
		int size = results.size();
		if (pageNum == 1) {
			startLen = 0;
			if (size < page)
				endLen = results.size();
			else
				endLen = page;
		}
		// 其他页数
		else {
			// 比如是第3页 20-30
			startLen = page * pageNum - page;
			endLen = page * pageNum;
		}
		totalPages = Tools.getSize(size);
		// ******
		List<BlackListBean> resultList = new ArrayList<>();
		// 前包含 后不包含
        resultList = results.subList(startLen, endLen); // 获取子列表
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("currentPage", pageNumber);
		model.put("totalPages", totalPages);
		model.put("allAdmins", resultList);
		renderJson(model);
	}
	
	
	
	/**
	 * 保存黑名单配置
	 */
	public void saveBlackThreshold(){
		String threshold = getPara("threshold");
		SystemUser user = CacheLoginUser();
		//先根据经销商USERCODE查询他是否已经配置过了
		BlackPrize blackPrize = blackListService.getBlackPrizeByUserCode(user.getUserCode());
		boolean result=false;
		if(blackPrize==null){
			BlackPrize bp=new BlackPrize();
			result=bp.set("ID", newId()).set("THRESHOLD", threshold).set("USERCODE", user.getUserCode()).save();
		}else{
			result=blackPrize.set("ID", blackPrize.getId()).set("THRESHOLD", threshold).update();
		}
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	
	/**
	 * 加入黑名单 操作
	 */
	public void addBlackList(){
		SystemUser user = CacheLoginUser();
		String userCode = user.getUserCode();
		String addAwardsAjax = getPara("addAwardsAjax");
		JSONArray blackJson = JSONArray.fromObject(addAwardsAjax);
		boolean flag=false;
		@SuppressWarnings("unchecked")
		List<BlackCenterObj> blackList = (List<BlackCenterObj>) JSONArray.toCollection(blackJson,BlackCenterObj.class);
		for (BlackCenterObj bo : blackList) {
			BlackList bl=new BlackList();
			//根据openid和活动id 查询该用户是否已经在黑名单里面了 如果在就不添加
			String opid = bo.getOpid();
			String acid = bo.getAcid();
			boolean existBlackList = blackListService.existBlackList(opid, acid, userCode);
			if(!existBlackList){
				flag=bl.set("ID", newId())
						  .set("NICKNAME", bo.getWx_name())
						  .set("HEADIMG", blackListService.getHeadImgByOpenId(opid))
						  .set("ACTIVITYNAME", bo.getActivity_name())
						  .set("PRODUCTNAME", bo.getWine_name())
						  .set("SCANNUMBER", bo.getSinNum())
						  .set("ACTIVITYID", acid)
						  .set("USERCODE", userCode)
						  .set("OPENID", bo.getOpid()).save();
			}
		}
		if(flag){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	
	/**
	 * 查看黑名单
	 */
	public void lookBlackList(){
		render("/system/blackList.html");
	}
	
	/**
	 * 分页显示黑名单
	 */
	public void blackListPage(){
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		String activityName = getPara("nickName");
		String currentPage = getPara("currentPage");
		Map<String, Object> model = new HashMap<String, Object>();
		Map<String, Object> map = BlackList.dao.paginate(Integer.parseInt(currentPage), page,activityName);
		model.put("currentPage", map.get("currentPage"));
		model.put("totalPages", map.get("totalPages"));
		model.put("allAdmins", map.get("list"));
		renderJson(model);
	}
	
	/**
	 * 移除黑名单
	 */
	public void removeBlackList(){
		boolean result=false;
		String ids= getPara("ids");
		String contents_pic = ids.substring(1, ids.length() -1);
		String[] a = contents_pic.split(",");
		for(int i=0; i<a.length; i++){
		    String b = a[i].trim();
		    String id = b.replace("\"","").replace("\"","");
		    result = BlackList.dao.deleteById(id);
		}
		if(result){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
}
