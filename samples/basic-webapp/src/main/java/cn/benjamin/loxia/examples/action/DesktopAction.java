package cn.benjamin.loxia.examples.action;

import java.io.File;
import java.util.Arrays;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.springframework.security.context.SecurityContextHolder;

import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.support.image.ImageResizer;
import cn.benjamin.loxia.utils.FileUtil;
import cn.benjamin.loxia.web.BaseProfileAction;

public class DesktopAction extends BaseProfileAction implements RequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1161602517758806580L;
	
	private File portrait;
	private String portraitContentType;
	private String portraitFileName;	

	private UserInformationManager userInformationManager;	

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
	
	@SuppressWarnings("unchecked")
	public String uploadPortrait(){
		try{
			if(portraitContentType.indexOf("image") >0){					
				byte[] portraits = ImageResizer.resizeImageAsJPG(FileUtil.getBytesFromFile(portrait), 72, 92); 
				UserInformation infor =
					userInformationManager.updatePortrait(userDetails.getUser().getId(), portraits);
				request.put("userInformation", infor);
			}else{
				request.put("errorMessage", "Invalid picture.");
			}
		}catch(Exception e){
			request.put("errorMessage", "Portrait upload failure.");
		}
		return SUCCESS;
	}
	
	public String getUserInfo(){		
		return userDetails.getUser().getUserName() + "[" + userDetails.getUsername() + "]";
	}
	
	public UserInformationManager getUserInformationManager() {
		return userInformationManager;
	}

	public void setUserInformationManager(
			UserInformationManager userInformationManager) {
		this.userInformationManager = userInformationManager;
	}
	
	public File getPortrait() {
		return portrait;
	}

	public void setPortrait(File portrait) {
		this.portrait = portrait;
	}

	public String getPortraitContentType() {
		return portraitContentType;
	}

	public void setPortraitContentType(String portraitContentType) {
		this.portraitContentType = portraitContentType;
	}

	public String getPortraitFileName() {
		return portraitFileName;
	}

	public void setPortraitFileName(String portraitFileName) {
		this.portraitFileName = portraitFileName;
	}
}
