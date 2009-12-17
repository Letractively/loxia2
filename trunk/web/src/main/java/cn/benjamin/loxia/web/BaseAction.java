package cn.benjamin.loxia.web;

import java.util.Locale;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.LocalizedTextUtil;

public class BaseAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4113598733962053745L;
	
	public static final String FOLLOWING_URL_AFTER_OPERATING_UNIT_PICKUP = "BaseAction.followingUrl";

	private String acl;
	private Long selectedOuId;	

	protected String getMessage(String key, Object[] args){
		Locale locale = ActionContext.getContext().getLocale();
		return LocalizedTextUtil.findText(this.getClass(), key, locale, key, args);
	}
	
	public void addActionError(String errKey, Object[] args){
		addActionError(getMessage(errKey, args));
	}

	public void addFieldError(String fieldName, String errKey, Object[] args){
		addFieldError(fieldName, getMessage(errKey, args));
	}

	public void addActionMessage(String msgKey, Object[] args){
		addActionMessage(getMessage(msgKey, args));
	}
	
	public String getAcl() {
		return acl;
	}
	public void setAcl(String acl) {
		this.acl = acl;
	}
	public Long getSelectedOuId() {
		return selectedOuId;
	}
	public void setSelectedOuId(Long selectedOuId) {
		this.selectedOuId = selectedOuId;
	}
}
