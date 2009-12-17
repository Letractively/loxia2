package cn.benjamin.loxia.examples.action;

import java.util.Arrays;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.springframework.security.context.SecurityContextHolder;

import cn.benjamin.loxia.web.BaseProfileAction;

public class DesktopAction extends BaseProfileAction implements RequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1161602517758806580L;
	
	@SuppressWarnings("unchecked")
	Map request;
	
	@SuppressWarnings("unchecked")
	public void setRequest(Map request) {
		this.request = request;
	}

	@SuppressWarnings("unchecked")
	public String logout() throws Exception{
		SecurityContextHolder.getContext().setAuthentication(null);
		request.put("messages", Arrays.asList("System logout successfully."));
		return SUCCESS;
	}
	
	public String getUserInfo(){		
		return userDetails.getUser().getUserName() + "[" + userDetails.getUsername() + "]";
	}
}
