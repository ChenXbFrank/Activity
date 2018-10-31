package com.activity.common.model.publicNumber;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.activity.common.model.publicNumber.base.BaseSellerPublicNumber;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 经销商公众号表
 * 
 * @author 小石潭记丶
 *
 *         2017年8月9日
 */
@SuppressWarnings("serial")
public class SellerPublicNumber extends BaseSellerPublicNumber<SellerPublicNumber> {
	public static final SellerPublicNumber dao = new SellerPublicNumber();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public SellerPublicNumber mapping(Record cord, SellerPublicNumber info) {
		info.setId(cord.getStr("ID"));
		info.setPublicNumberName(cord.getStr("PUBLICNUMBER_NAME"));
		info.setAppId(cord.getStr("APPID"));
		info.setAppSecret(cord.getStr("APPSECRET"));
		info.setPublicNumberQrcodeImg(cord.getStr("PUBLICNUMBER_QRCODE_IMG"));
		info.setShopNumber(cord.getStr("SHOP_NUMBER"));
		info.setPayKey(cord.getStr("PAY_KEY"));
		info.setSellerUserId(cord.getStr("SELLER_USERID"));
		info.setSellerUserCode(cord.getStr("SELLER_USERCODE"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setSpareTwo(cord.getStr("SPARE_TWO"));
		info.setSpareTwo(cord.getStr("TOKEN"));
		info.setSendId(cord.getStr("SENDID"));
		info.setSuccessId(cord.getStr("SUCCESSID"));
		info.setCompany(cord.getStr("COMPANY"));
		info.setScanImg(cord.getStr("SCAN_IMG"));
		info.setLogo(cord.getStr("LOGO"));
		info.setPhone(cord.getStr("PHONE"));
		info.setCertPath(cord.getStr("CERTPATH"));
		return info;
	}
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate1(int pageNumber, int pageSize,String name) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_SELLER_PUBLICNUMBER where 1=1 ";
		// 这里是模糊查询名字
		if (!StringUtils.isEmpty(name)) {
			sql += " and PUBLICNUMBER_NAME like '%" + name + "%'";
		}
		Page<SellerPublicNumber> page = paginate(pageNumber, pageSize, "select *", sql);
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			SellerPublicNumber sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("name", sb.getPublicNumberName());
			model.put("company", sb.getCompany());
			model.put("appid", sb.getAppId());
			model.put("appsecret", sb.getAppSecret());
			model.put("macid", sb.getShopNumber());
			model.put("paykey", sb.getPayKey());
			model.put("usercode", sb.getSellerUserCode());
			model.put("token", sb.getToKen());
			model.put("img", sb.getPublicNumberQrcodeImg());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
