package com.activity.common.utils.date;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期格式转换工具类 tanghaobo
 */
public class DateUitils {
	private static DateUitils dateUitils = new DateUitils();

	private DateUitils() {
	}

	public static DateUitils getUitils() {
		return dateUitils;
	}

	/**
	 * 新建时间并格式转换 年月日 时分秒
	 */
	public String newDate() {
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return time.format(date);
	}

	/**
	 * 新建时间并格式转换 年月日
	 */
	public static String newDateByYMD() {
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");
		return time.format(date);
	}

	/**
	 * 新建时间并格式转换 年月
	 */
	public static String newDateByYM() {
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM");
		return time.format(date);
	}

	/**
	 * 判断当前时间是否大于传来时间
	 */
	public static boolean newDateBefore(Date date) {
		Date newDate = new Date();// 当前时间
		return newDate.before(date);// newDate比date时间提前
	}

	/**
	 * 判断时间一是否大于时间二
	 */
	public static boolean isDateBefore(Date date1, Date date2) {
		return date1.before(date2);// newDate比date时间提前
	}

	/**
	 * 时间戳时间转为yyyy-MM-dd HH:mm:ss
	 * 
	 * @return
	 */
	public static String timeStamp(String time) {
		long msgCreateTime = Long.parseLong(time) * 1000L;
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = format.format(new Date(msgCreateTime));
		return date;
	}

	/**
	 * String转Date
	 * 
	 * @return
	 */
	public static Date strToDateYMD(String time) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * String转Date
	 * 
	 * @return
	 */
	public static Date strToDate(String time) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Date转String
	 * 
	 * @return
	 */
	public static String DateTostr(Date time) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		java.util.Date date=new java.util.Date();  
		String str=sdf.format(date);
		return str;  
	}
	
	/**
	 * Date转String
	 * 
	 * @return
	 */
	public static String DateToString() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		java.util.Date date=new java.util.Date();  
		String str=sdf.format(date);
		return str;  
	}
	

	/**
	 * 判断时间当前时间是否大于读取的时间
	 * 
	 * @param date
	 * @return
	 */
	public static boolean isDateBefore(Date date) {
		Date date1 = new Date();// 当前时间
		return date1.before(date);// date1比date2时间提前
	}
	
	/**
	 * 随机生成10位数
	 * @return
	 */
	public String RandomNumber(){
		int a[] = new int[10];
		String number ="";
	      for(int i=0;i<a.length;i++ ) {
	          a[i] = (int)(10*(Math.random()));
	          number += a[i]+"";
	      }
	     return number+"";
	}
}
