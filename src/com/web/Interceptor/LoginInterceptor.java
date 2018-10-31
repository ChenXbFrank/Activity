package com.web.Interceptor;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.web.utils.UserAgentUtils;

public class LoginInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		// TODO Auto-generated method stub
		HttpServletRequest request = inv.getController().getRequest();
		String requestDeviceType = UserAgentUtils.isMobileOrTablet(request) ? "mobile" : "pc";
		if (requestDeviceType.equals("pc")) {
			if (request.getSession().getAttribute("loginUser") == null) {
				inv.getController().renderError(404, "/index/active-login.html");
			}
		}
		inv.invoke();
	}

}
