package cn.benjamin.loxia.examples.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.security.AuthenticationException;

import cn.benjamin.loxia.web.BaseProfileAction;

public class DesktopAction extends BaseProfileAction implements ServletRequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1161602517758806580L;
	
	private HttpServletRequest httpRequest;

	public String accessDenied() throws Exception{
		System.out.println(httpRequest.getParameterMap());
		System.out.println(httpRequest.getSession().getAttributeNames());
		return SUCCESS;
	}

	public void setServletRequest(HttpServletRequest req) {
		this.httpRequest = req; 
	}
}
