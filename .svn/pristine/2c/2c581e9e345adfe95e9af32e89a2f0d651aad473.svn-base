package com.activity.common.utils.system;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * 将XML解析成MAP
 * 
 * @author Joe
 * @version $Id: XMLInToMap.java, v 0.1 2014年12月18日 下午8:25:21 Joe Exp $
 */
public class XMLToMap {

	@SuppressWarnings("static-access")
	public static Map<String, String> getXML(String requestXml) {
		Map<String, String> map = new HashMap<String, String>();
		// 将字符串转为XML
		Document doc;
		try {
			doc = DocumentHelper.parseText(requestXml);
			// 获取根节点
			Element rootElm = doc.getRootElement();// 从root根节点获取请求报文
			XMLToMap xmlIntoMap = new XMLToMap();
			map = xmlIntoMap.parseXML(rootElm, new HashMap<String, String>());
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		return map;
	}

	/**
	 * 将xml解析成map键值对 <功能详细描述>
	 * 
	 * @param ele
	 *            需要解析的xml对象
	 * @param map
	 *            入参为空，用于内部迭代循环使用
	 * @return
	 * @see [类、类#方法、类#成员]
	 */
	public static Map<String, String> parseXML(Element ele, Map<String, String> map) {

		for (Iterator<?> i = ele.elementIterator(); i.hasNext();) {
			Element node = (Element) i.next();
			// System.out.println("parseXML node name:" + node.getName());
			if (node.attributes() != null && node.attributes().size() > 0) {
				for (Iterator<?> j = node.attributeIterator(); j.hasNext();) {
					Attribute item = (Attribute) j.next();

					map.put(item.getName(), item.getValue());
				}
			}
			if (node.getText().length() > 0) {
				map.put(node.getName(), node.getText());
			}
			if (node.elementIterator().hasNext()) {
				parseXML(node, map);
			}
		}
		return map;
	}
	
	public static void main(String[] args) {
		String xml="<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg><appid><![CDATA[wx3db6ea684d097397]]></appid><mch_id><![CDATA[1445165502]]></mch_id><nonce_str><![CDATA[kbvzeJEWIg7ONXda]]></nonce_str><sign><![CDATA[786F48F8594B5E81249FF2422D867F8E]]></sign><result_code><![CDATA[SUCCESS]]></result_code><transaction_id><![CDATA[4200000058201804191553934742]]></transaction_id><out_trade_no><![CDATA[money7941948420180419164313]]></out_trade_no><out_refund_no><![CDATA[2b9c597f-92a7-4102-b4e0-298f68eb]]></out_refund_no><refund_id><![CDATA[50000606422018041904240202020]]></refund_id><refund_channel><![CDATA[]]></refund_channel><refund_fee>100</refund_fee><coupon_refund_fee>0</coupon_refund_fee><total_fee>100</total_fee><cash_fee>100</cash_fee><coupon_refund_count>0</coupon_refund_count><cash_refund_fee>100</cash_refund_fee></xml>";
		Map<String, String> map = getXML(xml);
		String return_code = map.get("return_code");
		System.out.println(return_code);
		String return_msg = map.get("return_msg");
		System.out.println(return_msg);
	}
}