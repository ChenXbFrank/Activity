package com.activity.common.utils.system;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.activity.common.model.integral.IntegralPrize;
import com.activity.common.model.integral.IntegralWinObj;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.weixin.sdk.utils.HttpUtils;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

/**
 * @author ChenXb
 *
 *         2017年9月5日
 */
public class Tools {
	/**
	 * 
	 * map转换json. <br>
	 * 详细说明
	 * 
	 * @param map
	 *            集合
	 * @return
	 * @return String json字符串
	 * @throws @author
	 *             slj
	 */
	public static String mapToJson(Map<String, Object> map) {
		Set<String> keys = map.keySet();
		String key = "";
		Object value;
		StringBuffer jsonBuffer = new StringBuffer();
		jsonBuffer.append("{");
		for (Iterator<String> it = keys.iterator(); it.hasNext();) {
			key = (String) it.next();
			value = map.get(key);
			if (value instanceof java.util.List) {
				jsonBuffer.append("\"" + key + "\":" + value);
			} else {
				jsonBuffer.append("\"" + key + "\":" + "\"" + value + "\"");
			}

			if (it.hasNext()) {
				jsonBuffer.append(",");
			}
		}
		jsonBuffer.append("}");
		return jsonBuffer.toString();
	}

	/**
	 * 计算总页数
	 */
	public static int getSize(int size) {
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		if (size % page == 0) {
			return size / page;
		} else {
			return size / page + 1;
		}
	}
	
	/**
	 * 输出文件流
	 * @param filename
	 * @param wb
	 * @param response
	 */
	public static void writeStream(String filename, Workbook wb, HttpServletResponse response) {
		try {
			filename += ".xlsx";

			filename.replaceAll("/", "-");
			filename = URLEncoder.encode(filename, "UTF-8");
			
			response.reset();
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=" + filename);
			response.setContentType("application/octet-stream;charset=UTF-8");
			
			OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
			
			wb.write(outputStream);
			
			outputStream.flush();
			outputStream.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 导出公用的方法
	 */
	public static void comExportExcel(@SuppressWarnings("rawtypes") List list,String title,HttpServletResponse response,String templateFilePath){
		Map<String, Object> datamap = new HashMap<String, Object>();
		datamap.put("list", list);	// 导出excel的数据
		datamap.put("title", title);	// 导出excel的标题
		InputStream in = null;
		try {
			in = new FileInputStream(templateFilePath);	// 将模板文件转换为文件流
			XLSTransformer transformer = new XLSTransformer();	// jxls生成excel
			//HSSFWorkbook  XSSFWorkbook
			//HSSF是POI工程对Excel 97(-2007)文件操作的纯Java实现 
			//XSSF是POI工程对Excel 2007 OOXML (.xlsx)文件操作的纯Java实现 
			XSSFWorkbook wb = (XSSFWorkbook) transformer.transformXLS(in, datamap);	// 将excel流转换为Workbook 
			//Sheet sheet = wb.getSheetAt(0);	// 取第一个sheet
			//sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));	// 四个参数分别是：起始行，结束行，起始列，结束列
			writeStream(title, wb, response);	// 返回excel
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (ParsePropertyException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} finally{
			try {
				if(in != null) in.close();
			} catch (IOException e) {
			}
		}
	}
	
	/**
	 * sendNotice  这里是发货通知
	 * @author 81046
	 * @date 2018年3月30日上午9:26:53
	 * @param openId oepndid
	 * @param sellerPublicNumber  公众号
	 * @param activityName  活动名称
	 * @param prizeName  奖品名称
	 * @param token  微信的token
	 */
	public static void sendNotice(String openId,SellerPublicNumber sellerPublicNumber,String prizeName,String sendCompany,String orderId,String address,String token){
		//发送中奖通知
		String json = " {\"touser\":\""+openId+"\","+"\"template_id\":\""+sellerPublicNumber.getSendId()+"\","
				+ "\"url\":\"http://open.weixin.qq.com/connect/oauth2/authorize?appid=" + sellerPublicNumber.getAppId()
				+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
				+ "%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + openId+ "%26selectedVal%3d" + ""
				+ "&response_type=code&scope=snsapi_userinfo&state=wx#wechat_redirect\"," + "\"topcolor\":\"#FF0000\","
				+ "\"data\":{" + "\"first\": {" + "\"value\":\"发货成功通知\"," + "\"color\":\"#000000" + "\"},"
				+ "\"keyword1\":{" + "\"value\":\"" + prizeName + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"keyword2\":{" + "\"value\":\"" + sendCompany + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"keyword3\":{" + "\"value\":\"" + orderId + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"keyword4\":{" + "\"value\":\"" + address + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"remark\":{" + "\"value\":\"前往个人中心查看信息\"," + "\"color\":\"#CD4F39\"}}}";
		HttpUtils.post("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + token,json);
	}
	
	/**
	 * 参与活动通知
	 
	public static void sendJoinNotice(String openId,SellerPublicNumber sellerPublicNumber,String activityUrl,String activityName,String token){
		//这里推送参与成功通知
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//发送参与通知
		String json = " {\"touser\":\""+openId+"\","+"\"template_id\":\""+sellerPublicNumber.getSuccessId()+"\","
				+ "\"url\":\"http://open.weixin.qq.com/connect/oauth2/authorize?appid=" + sellerPublicNumber.getAppId()
				+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
				+ activityUrl
				+ "&response_type=code&scope=snsapi_userinfo&state=wx#wechat_redirect\"," + "\"topcolor\":\"#FF0000\","
				+ "\"data\":{" + "\"first\": {" + "\"value\":\"活动参与成功通知\"," + "\"color\":\"#000000" + "\"},"
				+ "\"keyword1\":{" + "\"value\":\"" + activityName + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"keyword2\":{" + "\"value\":\"" + sdf.format(new Date()) + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"remark\":{" + "\"value\":\"感谢您的参与，点击可以查看活动详情\"," + "\"color\":\"#CD4F39\"}}}";
		HttpUtils.post("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + token,json);
	}*/
	
	/**
	 * 参与活动通知
	 */
	public static void sendJoinNotice(String openId,SellerPublicNumber sellerPublicNumber,String activityUrl,String activityName,String token){
		System.out.println("测试================");
		//这里推送参与成功通知
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//发送参与通知
		String json = " {\"touser\":\""+openId+"\","+"\"template_id\":\""+sellerPublicNumber.getSuccessId()+"\","
				+ "\"url\":\"http://open.weixin.qq.com/connect/oauth2/authorize?appid=" + sellerPublicNumber.getAppId()
				+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
				+ activityUrl
				+ "&response_type=code&scope=snsapi_userinfo&state=wx#wechat_redirect\"," + "\"topcolor\":\"#FF0000\","
				+ "\"data\":{" + "\"first\": {" + "\"value\":\"您已成功参与["+activityName +"]活动\"," + "\"color\":\"#000000" + "\"},"
				+ "\"keyword1\":{" + "\"value\":\"活动参与成功通知\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"keyword2\":{" + "\"value\":\"" + sdf.format(new Date()) + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"remark\":{" + "\"value\":\"感谢您的参与，点击可以查看活动详情\"," + "\"color\":\"#CD4F39\"}}}";
		HttpUtils.post("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + token,json);
	}
	
	/**
	 * 中奖通知
	 */
	public static void sendWinNotice(String openId,SellerPublicNumber sellerPublicNumber,String activityUrl,String activityName,String prizeName,String token){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String json = " {\"touser\":\""+openId+"\","+"\"template_id\":\""+sellerPublicNumber.getWinningNewId()+"\","
				+ "\"url\":\"http://open.weixin.qq.com/connect/oauth2/authorize?appid=" + sellerPublicNumber.getAppId()
				+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
				+ activityUrl
				+ "&response_type=code&scope=snsapi_userinfo&state=wx#wechat_redirect\"," + "\"topcolor\":\"#FF0000\","
				+ "\"data\":{" + "\"first\": {" + "\"value\":\"活动中奖结果消息\"," + "\"color\":\"#000000" + "\"},"
				+ "\"keyword1\":{" + "\"value\":\"" + activityName + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"keyword2\":{" + "\"value\":\"" + prizeName + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"keyword3\":{" + "\"value\":\"" + sdf.format(new Date()) + "\"," + "\"color\":\"#1d326b" + "\"},"
				+ "\"remark\":{" + "\"value\":\"点击查看中奖详情\"," + "\"color\":\"#CD4F39\"}}}";
		HttpUtils.post("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + token,json);
	}
	
	/**
     * 根据Math.random()产生一个double型的随机数，判断每个奖品出现的概率
     * @param prizes
     * @return random：奖品列表prizes中的序列（prizes中的第random个就是抽中的奖品）
     * 
     *  如上图，为了便于计算和理解，设置每种奖品的权重分别为1，2，3，4，所以被抽到的概率分别为0.1，0.2，0.3，0.4（本次活动中奖概率为100%）。
	 *
	 *　先生成一个随机数randomNumber，然后根据随机数所处区域判断奖品：
	 *
	 *	0<randomNumber<=0.1   表示抽中一等奖
	 *	0.1<randomNumber<=0.3 表示抽中二等奖
	 *	0.3<randomNumber<=0.6 表示抽中三等奖
	 *	0.6<randomNumber<=1.0 表示抽中四等奖
     */
    public static int getPrizeIndex(List<IntegralPrize> prizes) {
        int random = -1;
        try{
            //计算总权重
            double sumWeight = 0;
            for(IntegralPrize p : prizes){
                sumWeight += Double.parseDouble(p.getWeight());
            }
            //产生随机数
            double randomNumber;
            randomNumber = Math.random();

            //根据随机数在所有奖品分布的区域并确定所抽奖品
            double d1 = 0;
            double d2 = 0;          
            for(int i=0;i<prizes.size();i++){
                d2 += Double.parseDouble(String.valueOf(prizes.get(i).getWeight()))/sumWeight;
                if(i==0){
                    d1 = 0;
                }else{
                    d1 +=Double.parseDouble(String.valueOf(prizes.get(i-1).getWeight()))/sumWeight;
                }
                if(randomNumber >= d1 && randomNumber <= d2){
                    random = i;
                    break;
                }
            }
        }catch(Exception e){
            System.out.println("生成抽奖随机数出错，出错原因：" +e.getMessage());
        }
        return random;
    }
    
    
    /**
     * 根据集合list里面的时间字段进行时间降序排列
     * ListSort
     * @author 81046
     * @date 2018年5月14日上午9:25:01
     * @param list
     * /*  
     * int compare(Student o1, Student o2) 返回一个基本类型的整型，  
     * 返回负数表示：o1 小于o2，  
     * 返回0 表示：o1和o2相等，  
     * 返回正数表示：o1大于o2。  
     */  
	public static void ListSort(List<IntegralWinObj> list) {
		Collections.sort(list, new Comparator<IntegralWinObj>() {
			@Override
			public int compare(IntegralWinObj o1, IntegralWinObj o2) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				try {
					Date dt1 = format.parse(o1.getWinTime());
					Date dt2 = format.parse(o2.getWinTime());
					if (dt1.getTime() < dt2.getTime()) {
						return 1;
					} else if (dt1.getTime() > dt2.getTime()) {
						return -1;
					} else {
						return 0;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return 0;
			}
		});
	}
}
