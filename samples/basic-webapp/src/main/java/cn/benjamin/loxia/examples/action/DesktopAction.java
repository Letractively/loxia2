package cn.benjamin.loxia.examples.action;

import java.io.File;
import java.util.Arrays;
import java.util.Map;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.security.context.SecurityContextHolder;

import cn.benjamin.loxia.dao.Sort;
import cn.benjamin.loxia.examples.dao.UserInformationDao;
import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.support.image.ImageResizer;
import cn.benjamin.loxia.utils.FileUtil;
import cn.benjamin.loxia.utils.PropListCopyable;
import cn.benjamin.loxia.utils.PropertyUtil;
import cn.benjamin.loxia.web.BaseProfileAction;
import cn.benjamin.loxia.web.annotation.DataResponse;

public class DesktopAction extends BaseProfileAction implements RequestAware, SessionAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1161602517758806580L;
	
	private File portrait;
	private String portraitContentType;
	private String portraitFileName;	

	private UserInformationManager userInformationManager;	
	private UserInformationDao userInformationDao;	

	@SuppressWarnings("unchecked")
	Map request;
	
	@SuppressWarnings("unchecked")
	Map session;
	
	@SuppressWarnings("unchecked")
	public void setSession(Map session) {
		this.session = session;
	}

	@SuppressWarnings("unchecked")
	public void setRequest(Map request) {
		this.request = request;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public String execute() throws Exception{
		UsersTableModel tableModel = new UsersTableModel();
		tableModel.setUserInformationDao(userInformationDao);
		tableModel.setPagable(true);
		tableModel.setItemPerPage(20);
		tableModel.setSorts(new Sort[]{new Sort("u.USER_NAME")});
		session.put("userTableModel", tableModel.query());
		UserInformation ui = userInformationDao.findUserInformationByUser(userDetails.getUser().getId());
		if(ui != null){
			UserInformation retUi = new UserInformation();
			PropertyUtil.copyProperties(ui, retUi, new PropListCopyable("id","habbit","description"));
			request.put("userInformation", retUi);
		}
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String logout() throws Exception{
		SecurityContextHolder.getContext().setAuthentication(null);
		request.put("messages", Arrays.asList("System logout successfully."));
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	@DataResponse
	public String getUsers(){
		UsersTableModel tableModel = (UsersTableModel)session.get("userTableModel");
		tableModel.setCurrentPage(currentPage);
		tableModel.setItemPerPage(pageSize);
		tableModel.setSortString(sortString);
		session.put("userTableModel", tableModel.query());
		request.put("json", tableModel.getModel());
		return JSON;
	}
	
	@SuppressWarnings("unchecked")
	public String uploadPortrait(){
		try{
			logger.debug("upload portrait's content type: {}", portraitContentType);
			if(portraitContentType.indexOf("image") ==0){					
				byte[] portraits = ImageResizer.resizeImageAsJPG(FileUtil.getBytesFromFile(portrait), 72, 92); 
				UserInformation infor =
					userInformationManager.updatePortrait(userDetails.getUser().getId(), portraits);
				UserInformation ui = new UserInformation();
				PropertyUtil.copyProperties(infor, ui, new PropListCopyable("id","habbit","description"));
				request.put("userInformation", infor);
			}else{
				request.put("errorMessage", "Invalid picture.");
			}
		}catch(Exception e){
			if(logger.isDebugEnabled())
				e.printStackTrace();
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
	
	public UserInformationDao getUserInformationDao() {
		return userInformationDao;
	}

	public void setUserInformationDao(UserInformationDao userInformationDao) {
		this.userInformationDao = userInformationDao;
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
