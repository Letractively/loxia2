package cn.benjamin.loxia.examples.action;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.web.BaseAction;

public class GetAttachmentAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -759469373258405633L;

	private Long userInfoIdForPortrait;
	
	private String filename;
	private String contentType;
	private InputStream inputStream;	
	
	private UserInformationManager userInformationManager;	

	@Override
	public String execute() throws Exception {
		if(userInfoIdForPortrait != null){
			byte[] portrait = userInformationManager.getPortraitByUserInfoId(userInfoIdForPortrait);
			if(portrait == null){
				throw new RuntimeException("Portrait fetching error.");
			}
			inputStream = new ByteArrayInputStream(portrait);
			contentType = "image/jpeg";
			filename = "portrait.jpg";
		}else{
			
		}
		return SUCCESS;
	}
	
	public Long getUserInfoIdForPortrait() {
		return userInfoIdForPortrait;
	}
	public void setUserInfoIdForPortrait(Long userInfoIdForPortrait) {
		this.userInfoIdForPortrait = userInfoIdForPortrait;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	
	public UserInformationManager getUserInformationManager() {
		return userInformationManager;
	}
	public void setUserInformationManager(
			UserInformationManager userInformationManager) {
		this.userInformationManager = userInformationManager;
	}
}
