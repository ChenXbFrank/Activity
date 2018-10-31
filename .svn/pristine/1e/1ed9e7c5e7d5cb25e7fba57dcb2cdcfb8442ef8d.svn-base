package com.web.Interceptor;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.web.utils.UserAgentUtils;

public class BaseInterceptor implements Interceptor {

	String staticPath = "";

	@Override
	public void intercept(Invocation inv) {
		// TODO Auto-generated method stub
		Route(inv);
		inv.invoke();
	}

	private void Route(Invocation inv) {
		HttpServletRequest request = inv.getController().getRequest();
		String requestDeviceType = UserAgentUtils.isMobileOrTablet(request) ? "mobile" : "pc";
		System.out.println("访问终端" + requestDeviceType);
		System.out.println("访问IP地址" + getIPAddr(request));
		if (requestDeviceType != null) {
			staticPath = JFinal.me().getContextPath() + "/static/" + requestDeviceType;
			// 返回页面路径时，web-inf路径后会加入deviceType值
			request.getSession().setAttribute("deviceType", requestDeviceType);
			request.setAttribute("staticPath", staticPath);
			request.setAttribute("systemHttp", PropKit.use("system.properties").get("http"));
			request.setAttribute("basePath", JFinal.me().getContextPath());
		}
	}
	
	 /** 
     * 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址; 
     *  
     * @param request 
     * @return 
     * @throws IOException 
     */  
	public static String getIPAddr(HttpServletRequest request){  
        if (request == null)  
            return null;  
        String ip = request.getHeader("X-Forwarded-For");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))  
            ip = request.getHeader("Proxy-Client-IP"); 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))  
            ip = request.getRemoteAddr(); 
        if ("127.0.0.1".equals(ip) || "0:0:0:0:0:0:0:1".equals(ip))  
            try {  
                ip = InetAddress.getLocalHost().getHostAddress();  
            }  
            catch (UnknownHostException unknownhostexception) {  
            }  
        
        return ip;  
    } 
}
