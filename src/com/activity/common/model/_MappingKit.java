package com.activity.common.model;

import com.activity.common.model.accessToken.TbAccessToken;
import com.activity.common.model.accumulate.Accumulate;
import com.activity.common.model.accumulate.AccumulateCommentWxUser;
import com.activity.common.model.accumulate.AccumulateHelpWxUser;
import com.activity.common.model.accumulate.AccumulatePrize;
import com.activity.common.model.accumulate.AccumulateWxUserWinning;
import com.activity.common.model.activity.Activity;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.activity.TbCustomActivity;
import com.activity.common.model.black.BlackList;
import com.activity.common.model.black.BlackPrize;
import com.activity.common.model.breakEgg.BreakEgg;
import com.activity.common.model.breakEgg.BreakEggPrize;
import com.activity.common.model.breakEgg.BreakEggWxUser;
import com.activity.common.model.breakEgg.BreakEggWxUserWinning;
import com.activity.common.model.fireStorm.FireStormRed;
import com.activity.common.model.fireStorm.FireStormRedPrize;
import com.activity.common.model.fireStorm.FireStormRedWxUser;
import com.activity.common.model.fireStorm.FireStormRedWxUserWining;
import com.activity.common.model.groupPurchase.GroupPurchase;
import com.activity.common.model.groupPurchase.GroupPurchaseGroupWxUser;
import com.activity.common.model.groupPurchase.GroupPurchasePrize;
import com.activity.common.model.groupPurchase.GroupPurchaseWxUser;
import com.activity.common.model.groupPurchase.PurchaseWxUserWinning;
import com.activity.common.model.integral.IntegalExchange;
import com.activity.common.model.integral.Integral;
import com.activity.common.model.integral.IntegralActivity;
import com.activity.common.model.integral.IntegralPrize;
import com.activity.common.model.integral.IntegralProduct;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.integral.JoinActivity;
import com.activity.common.model.jzRed.JzRed;
import com.activity.common.model.jzRed.JzRedPrize;
import com.activity.common.model.jzRed.JzRedWxUser;
import com.activity.common.model.jzRed.JzRedWxUserWining;
import com.activity.common.model.loginfo.LogInfo;
import com.activity.common.model.oneMoneyShop.OneMoneyGroupWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyPrize;
import com.activity.common.model.oneMoneyShop.OneMoneyShop;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUserWinning;
import com.activity.common.model.openWine.OpenWine;
import com.activity.common.model.openWine.OpenWinePrize;
import com.activity.common.model.openWine.OpenWineSharePrize;
import com.activity.common.model.openWine.OpenWineWxUser;
import com.activity.common.model.openWine.OpenWineWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.puzzle.Puzzle;
import com.activity.common.model.puzzle.PuzzlePrize;
import com.activity.common.model.puzzle.PuzzleWxUser;
import com.activity.common.model.puzzle.PuzzleWxUserWinning;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.model.robRed.RobRed;
import com.activity.common.model.robRed.RobRedPrize;
import com.activity.common.model.robRed.RobRedWxUser;
import com.activity.common.model.robRed.RobRedWxUserWining;
import com.activity.common.model.scratchCard.ScratchCard;
import com.activity.common.model.scratchCard.ScratchCardPrize;
import com.activity.common.model.scratchCard.ScratchCardWxUser;
import com.activity.common.model.scratchCard.ScratchCardWxUserWinning;
import com.activity.common.model.sellerOutInfo.OurSellerOutInfo;
import com.activity.common.model.shareBargain.ShareBargain;
import com.activity.common.model.shareBargain.ShareBargainHelp;
import com.activity.common.model.shareBargain.ShareBargainPrize;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.activity.common.model.system.Advert;
import com.activity.common.model.system.Express;
import com.activity.common.model.system.SystemConfig;
import com.activity.common.model.system.SystemMenu;
import com.activity.common.model.system.UploadImg;
import com.activity.common.model.turntable.TurnTable;
import com.activity.common.model.turntable.TurnTablePrize;
import com.activity.common.model.turntable.TurnTableWxUser;
import com.activity.common.model.turntable.TurnTableWxUserWinning;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;

/**
 * 配置实体对象与数据库表映射，参数格式(表名，主键，实体对象)
 */
public class _MappingKit {

	public static void mapping(ActiveRecordPlugin arp) {
		// 系统菜单
		arp.addMapping("SYS_MENU", "ID", SystemMenu.class);
		// 系统配置
		arp.addMapping("SYS_CONFIG", "ID", SystemConfig.class);
		// 日志管理
		arp.addMapping("LOG_INFO", "ID", LogInfo.class);
		//图片上传
		arp.addMapping("UPLOAD_IMG", "ID", UploadImg.class);
		// 活动用户
		arp.addMapping("ACTIVITY_WXUSER", "ID", ActivityWxUser.class);
		// 活动与二维码数据关系
		arp.addMapping("ACTIVITY_CODE", "ID", ActivityCode.class);
		// 日志
		arp.addMapping("LOG_INFO", "ID", LogInfo.class);
		// 可申请活动
		arp.addMapping("TB_ACTIVITY", "ID", Activity.class);
		// 实物产品中奖记录
		arp.addMapping("TB_PRODUCT_WINNING_INFO", "ID", ProductWinningInfo.class);
		// 分享砍价奖品配置表
		arp.addMapping("TB_SHARE_BARGAIN_PRIZE", "ID", ShareBargainPrize.class);
		// 分享砍价活动表
		arp.addMapping("TB_SHARE_BARGAIN", "ID", ShareBargain.class);
		// 经销商公众号表
		arp.addMapping("TB_SELLER_PUBLICNUMBER ", "ID", SellerPublicNumber.class);
		// 活动与运单表
		arp.addMapping("TB_ACTIVITY_SELLEROUTINFO ", "ID", ActivitySellerOutInfo.class);
		// 微信分享活动参与用户
		arp.addMapping("TB_SHARE_BARGAIN_WXUSER", "ID", ShareBargainWxuser.class);
		// 微信分享活动帮助砍价用户
		arp.addMapping("TB_SHARE_BARGAIN_HELP", "ID", ShareBargainHelp.class);
		// 红包中奖记录
		arp.addMapping("TB_RED_WINNING_INFO", "ID", RedWinningInfo.class);
		// 红包
		arp.addMapping("TB_ROB_RED", "RED_ID", RobRed.class);
		// 红包配置
		arp.addMapping("TB_ROB_RED_PRIZE", "RED_PRIZE_ID", RobRedPrize.class);
		// 红包微信参与用户
		arp.addMapping("TB_ROB_RED_WXUSER", "RED_WXUSER_ID", RobRedWxUser.class);
		// 红包微信用户中奖记录
		arp.addMapping("TB_ROB_RED_WXUSER_WINNING", "RED_WXUSER_WINNING_ID", RobRedWxUserWining.class);
		//积分中奖记录
		arp.addMapping("TB_INTEGRAL_WINNING_INFO", "ID", IntegralWinningInfo.class);
		//积分活动表
		arp.addMapping("TB_INTEGRAL", "INTEGRAL_ID", Integral.class);
		//积分兑换活动
		arp.addMapping("TB_INTEGRAL_ACTIVITY", "ID", IntegralActivity.class);
		//积分兑换产品
		arp.addMapping("TB_INTEGRAL_PRODUCT", "ID", IntegralProduct.class);
		//积分兑换记录
		arp.addMapping("TB_INTEGRAL_EXCHANGE", "INTEGRAL_EXCHANGE_ID", IntegalExchange.class);
		//转盘活动配置
		arp.addMapping("TB_TURNTABLE", "TURNTABLE_ID", TurnTable.class);
		//转盘活动奖品
		arp.addMapping("TB_TURNTABLE_PRIZE", "TURNTABLE_PRIZE_ID", TurnTablePrize.class);
		//转盘活动微信用户参与记录
		arp.addMapping("TB_TURNTABLE_WXUSER", "TURNTABLE_WXUSER_ID", TurnTableWxUser.class);
		//转盘活动微信用户参与中奖记录
		arp.addMapping("TB_TURNTABLE_WXUSER_WINNING", "TURNTABLE_WXUSER_WINNING_ID", TurnTableWxUserWinning.class);
		//刮刮乐活动
		arp.addMapping("TB_SCRATCHCARD", "SCRATCHCARD_ID",ScratchCard.class);
		//刮刮乐奖品配置
		arp.addMapping("TB_SCRATCHCARD_PRIZE", "SCRATCHCARD_PRIZE_ID",ScratchCardPrize.class);
		//刮刮乐微信中奖用户记录
		arp.addMapping("TB_SCRATCHCARD_WXUSER", "SCRATCHCARD_WXUSER_ID",ScratchCardWxUser.class);
		//刮刮乐参与中奖记录
		arp.addMapping("TB_SCRATCHCARD_WXUSER_WINNING", "SCRATCHCARD_WXUSER_WINNING_ID",ScratchCardWxUserWinning.class);
		//集赞活动
		arp.addMapping("TB_ACCUMULATEFABULOUS", "ID",Accumulate.class);
		//集赞活动配置
		arp.addMapping("TB_ACCUMULATEFABULOUS_PRIZE", "ID",AccumulatePrize.class);
		//集赞活动评论用户
		arp.addMapping("TB_ACCUMULATE_COMMENT_WXUSER", "ID",AccumulateCommentWxUser.class);
		//集赞活动点赞用户
		arp.addMapping("TB_ACCUMULATE_HELP_WXUSER", "ID",AccumulateHelpWxUser.class);
		//集赞活动中奖情况
		arp.addMapping("TB_ACCUMULATE_WXUSER_WINNING", "ID",AccumulateWxUserWinning.class);
		//砸蛋活动
		arp.addMapping("TB_BREAK_EGG", "ID",BreakEgg.class);
		//砸蛋活动配置
		arp.addMapping("TB_BREAK_EGG_PRIZE", "ID",BreakEggPrize.class);
		//砸蛋活动用户
		arp.addMapping("TB_BREAKEGG_WXUSER", "ID",BreakEggWxUser.class);
		//砸蛋参与中奖记录
		arp.addMapping("TB_BREAKEGG_WXUSER_WINNING", "ID",BreakEggWxUserWinning.class);
		//一元购活动
		arp.addMapping("TB_ONE_MONEY_SHOP", "ID",OneMoneyShop.class);
		//一元购活动配置
		arp.addMapping("TB_ONE_MONEY_PRIZE", "ID",OneMoneyPrize.class);
		//一元购活动微信用户
		arp.addMapping("TB_ONE_MONEY_WXUSER", "ID",OneMoneyWxUser.class);
		arp.addMapping("TB_ONE_MONEY_GROUP_WXUSER", "ID",OneMoneyGroupWxUser.class);
		arp.addMapping("TB_ONEMONEY_WXUSER_WINNING", "ID",OneMoneyWxUserWinning.class);
		//拼图活动
		arp.addMapping("TB_PUZZLE", "ID",Puzzle.class);
		//拼图活动配置
		arp.addMapping("TB_PUZZLE_PRIZE", "ID",PuzzlePrize.class);
		//拼图活动 微信user
		arp.addMapping("TB_PUZZLE_WXUSER", "ID",PuzzleWxUser.class);
		//拼图活动微信中奖用户
		arp.addMapping("TB_PUZZLE_WXUSER_WINNING", "ID",PuzzleWxUserWinning.class);
		//拼团活动
		arp.addMapping("TB_GROUP_PURCHASE", "ID",GroupPurchase.class);
		//拼团活动配置
		arp.addMapping("TB_GROUP_PURCHASE_PRIZE", "ID",GroupPurchasePrize.class);
		//拼团微信参与用户记录
		arp.addMapping("TB_GROUP_PURCHASE_WXUSER", "ID",GroupPurchaseWxUser.class);
		//拼团微信参与用户记录 组队
		arp.addMapping("TB_GROUP_PURCHASE_GROUP_WXUSER", "ID",GroupPurchaseGroupWxUser.class);
		//拼团参与中奖记录
		arp.addMapping("TB_PURCHASE_WXUSER_WINNING", "ID",PurchaseWxUserWinning.class);
		//快递公司
		arp.addMapping("TB_EXPRESS", "ID",Express.class);
		//积分活动参与活动
		arp.addMapping("JOINACTIVITY", "ID",JoinActivity.class);
		//积分活动配置
		arp.addMapping("TB_INTEGRAL_PRIZE", "ID",IntegralPrize.class);
		//黑名单列表
		arp.addMapping("TB_BLACK_LIST", "ID",BlackList.class);
		//黑名单配置
		arp.addMapping("TB_BLACK_PRIZE", "ID",BlackPrize.class);
		//广告配置
		arp.addMapping("TB_ADVERT", "ID",Advert.class);
		//定制活动
		arp.addMapping("TB_CUSTOM_ACTIVITY", "ID",TbCustomActivity.class);
		//定制活动--开酒
		arp.addMapping("TB_OPENWINE_WXUSER", "ID",OpenWineWxUser.class);
		//开酒中奖纪录
		arp.addMapping("TB_OPENWINE_WXUSER_WIN", "ID",OpenWineWxUserWinning.class);
		//开酒活动
		arp.addMapping("TB_OPENWINE", "ID",OpenWine.class);
		//开酒活动扫码配置
		arp.addMapping("TB_OPENWINE_PRIZE", "ID",OpenWinePrize.class);
		//开酒分享奖品配置
		arp.addMapping("TB_OPENWINE_SHARE_PRIZE", "ID",OpenWineSharePrize.class);
		
		
		//火爆小酒活动
		arp.addMapping("FIRE_STORM_RED", "ID",FireStormRed.class);
		//火爆小酒活动扫码配置
		arp.addMapping("FIRE_STORM_RED_PRIZE", "ID",FireStormRedPrize.class);
		//火爆小酒微信参与用户
		arp.addMapping("FIRE_STORM_RED_WXUSER", "ID",FireStormRedWxUser.class);
		//火爆小酒中奖纪录
		arp.addMapping("FIRE_STORM_RED_WXUSER_WINNING", "ID",FireStormRedWxUserWining.class);
		
		
		//我们数据库的运单信息
		arp.addMapping("TB_SELLEROUTINFO", "RECORDID",OurSellerOutInfo.class);
		//ACCESS_TOKEN
		arp.addMapping("TB_ACCESS_TOKEN", "APPID", TbAccessToken.class);
		
		//尖庄红包活动
		arp.addMapping("TB_JZ_RED", "ID",JzRed.class);
		//尖庄红包活动扫码配置
		arp.addMapping("TB_JZ_RED_PRIZE", "ID",JzRedPrize.class);
		//尖庄红包活动微信参与用户
		arp.addMapping("TB_JZ_RED_WXUSER", "ID",JzRedWxUser.class);
		//尖庄红包活动中奖纪录
		arp.addMapping("TB_JZ_RED_WXUSER_WININFO", "ID",JzRedWxUserWining.class);
				
	}
}
