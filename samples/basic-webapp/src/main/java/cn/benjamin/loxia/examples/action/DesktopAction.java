package cn.benjamin.loxia.examples.action;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.security.context.SecurityContextHolder;

import cn.benjamin.loxia.dao.Sort;
import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.dao.UserInformationDao;
import cn.benjamin.loxia.examples.dao.UserMemoDao;
import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.support.image.ImageResizer;
import cn.benjamin.loxia.utils.FileUtil;
import cn.benjamin.loxia.utils.PropListCopyable;
import cn.benjamin.loxia.utils.PropertyUtil;
import cn.benjamin.loxia.web.BaseProfileAction;
import cn.benjamin.loxia.web.annotation.DataResponse;

public class DesktopAction extends BaseProfileAction implements SessionAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1161602517758806580L;
	
	private File portrait;
	private String portraitContentType;
	private String portraitFileName;	

	private UserInformationManager userInformationManager;	
	private UserInformationDao userInformationDao;	
	private UserMemoDao userMemoDao;
	private UserDao userDao;

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@SuppressWarnings("unchecked")
	Map session;
	
	@SuppressWarnings("unchecked")
	public void setSession(Map session) {
		this.session = session;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public String execute() throws Exception{
		
		
		UsersTableModel userTableModel = new UsersTableModel();
		userTableModel.setUserInformationDao(userInformationDao);
		userTableModel.setItemPerPage(10);
		userTableModel.setSorts(new Sort[]{new Sort("u.USER_NAME")});
		session.put("userTableModel", userTableModel.query());
		UserMemosTableModel umTableModel = new UserMemosTableModel(userDetails.getUser().getId(), new Date());
		umTableModel.setUserMemoDao(userMemoDao);
		session.put("umTableModel", umTableModel.query());
		UserInformation ui = userInformationDao.findUserInformationByUser(userDetails.getUser().getId());
		if(ui != null){
			UserInformation retUi = new UserInformation();
			PropertyUtil.copyProperties(ui, retUi, new PropListCopyable("id","habbit","description"));
			request.put("userInformation", retUi);
		}
		request.put("user", userDao.getByPrimaryKey(userDetails.getUser().getId()));
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
	@DataResponse
	public String getTodaysWork(){
		UserMemosTableModel tableModel = (UserMemosTableModel)session.get("umTableModel");
		request.put("json", tableModel.query().getModel());
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
				request.put("userInformation", ui);
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
	public boolean checkAcl(String [] acls)
	{
		
		return userDetails.checkAuthority(acls);
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
	public UserMemoDao getUserMemoDao() {
		return userMemoDao;
	}

	public void setUserMemoDao(UserMemoDao userMemoDao) {
		this.userMemoDao = userMemoDao;
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
