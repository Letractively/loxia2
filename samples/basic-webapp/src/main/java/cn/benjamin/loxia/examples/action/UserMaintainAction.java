package cn.benjamin.loxia.examples.action;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.dao.UserInformationDao;
import cn.benjamin.loxia.examples.dao.UserMemoDao;
import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.examples.manager.UserManager;
import cn.benjamin.loxia.examples.manager.UserMemoManager;
import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.examples.model.UserMemo;
import cn.benjamin.loxia.model.OperatingUnit;
import cn.benjamin.loxia.model.User;
import cn.benjamin.loxia.support.image.ImageResizer;
import cn.benjamin.loxia.support.json.JSONObject;
import cn.benjamin.loxia.utils.DateUtil;
import cn.benjamin.loxia.utils.FileUtil;
import cn.benjamin.loxia.utils.PropListCopyable;
import cn.benjamin.loxia.utils.PropertyUtil;
import cn.benjamin.loxia.web.BaseProfileAction;
import cn.benjamin.loxia.web.annotation.Acl;
import cn.benjamin.loxia.web.annotation.DataResponse;

public class UserMaintainAction extends BaseProfileAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2519287147927865666L;
	
	private User user;
	private UserInformation userInformation;
	private String portraitContentType;
	private String portraitFileName;
	private File portrait;
	//TODO add date selection
	private Date date;		

	private List<UserMemo> userMemos = new ArrayList<UserMemo>();	
	
	private final OperatingUnit ou=new OperatingUnit();
	
	private UserDao userDao;
	private UserManager userManager;
	private UserMemoDao userMemoDao;	
	private UserMemoManager userMemoManager;
	private UserInformationDao userInformationDao;
	private UserInformationManager userInformationManager;
	
	@SuppressWarnings("unchecked")
	private void prepareForTodoListMaintain(){
		
		request.put("umList", 
				userMemoDao.findUserMemosByUserIdAndDate(userDetails.getUser().getId(), 
						date == null ? DateUtil.today() : DateUtil.roundDate(date)));
	}

	@Acl("ACL_USERMEMO_MAINTAIN")
	public String maintainTodoListEntry() throws Exception{
		prepareForTodoListMaintain();
		return SUCCESS;
	}
	
	@Acl("ACL_USERMEMO_MAINTAIN")
	public String maintainTodoList() throws Exception{		
		logger.debug("collected date from page: {}", date);
		userMemoManager.maintainUserMemos(userDetails.getUser().getId(), 
						date == null ? DateUtil.today() : DateUtil.roundDate(date), userMemos);
		prepareForTodoListMaintain();
		return SUCCESS;
	}
	
	@Acl("ACL_USER_MAINTAIN")
	@SuppressWarnings("unchecked")
	@DataResponse
	public String addUser() throws Exception{		
		user.setId(null);
		userInformation.setId(null);
		ou.setId(1l);
		user.setOu(ou);
		userInformation.setUser(user);
		user = userDao.save(user);
		userInformationManager.saveOrUpdate(userInformation);
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("result", true);
		request.put("json", new JSONObject(result));
		return JSON;
	}
	
	//just load user and userInformation and redirect
	@Acl("ACL_USER_MAINTAIN")
	@SuppressWarnings("unchecked")
	public String editUser()
	{
		user=userDao.getByPrimaryKey(user.getId());
		userInformation=userInformationDao.findUserInformationByUser(user.getId());
		
		return JSON;
	}
	//save the modified user and ui
	public String modifyUser()
	{
		    try {
		    	userManager.EditUser(user, userInformation);
		    	Map<String,Object> result = new HashMap<String, Object>();
				result.put("result", true);
				request.put("json", new JSONObject(result));
				
			} catch (Exception e) {
				if(logger.isDebugEnabled())
					e.printStackTrace();
				request.put("errorMessage", "System error.");
			}
		return JSON;
	}
	
	@SuppressWarnings("unchecked")
	public String uploadPortrait(){
		try{
			logger.debug("upload portrait's content type: {}", portraitContentType);
			if(portraitContentType.indexOf("image") ==0){					
				byte[] portraits = ImageResizer.resizeImageAsJPG(FileUtil.getBytesFromFile(portrait), 72, 92); 
				UserInformation infor =
					userInformationManager.updatePortrait(user.getId(), portraits);
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
	
	@SuppressWarnings("unchecked")
	@DataResponse
	public String checkUserUnique() throws Exception{
		User u = userDao.findByLoginName(user.getLoginName());
		Map<String,Object> result = new HashMap<String, Object>();
		if(u != null){
			result.put("unique", false);
		}else{
			result.put("unique", true);
		}
		request.put("json", new JSONObject(result));
		return JSON;
	}

	@Acl(value="ACL_USERMEMO_MAINTAIN")
	@SuppressWarnings("unchecked")
	@DataResponse
	public String deleteUser() throws Exception{
		userManager.deleteUser(user.getId());
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", true);
		request.put("json", new JSONObject(result));
		return JSON;
	}
	
	@SuppressWarnings("unchecked")
	@DataResponse
	public String viewUser() throws Exception{
		User u = userDao.getByPrimaryKey(user.getId());
		UserInformation ui = userInformationDao.findUserInformationByUser(user.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userName", u.getUserName());
		map.put("createTime", u.getCreateTime());
		map.put("latestUpdateTime", u.getLatestUpdateTime());
		if(ui != null){
			map.put("habbit", ui.getHabbit());
			map.put("description", ui.getDescription());
			map.put("portrait", ui.getPortrait());
		}
			request.put("json", new JSONObject(map));
		return JSON;
	}
	
	public String updateHabbit() {
		userInformationManager.updateHabbit(user.getId(), userInformation.getHabbit());
		return JSON;
	}
	
	public String updateDescription() {
		userInformationManager.updateDescription(user.getId(), userInformation.getDescription());
		return JSON;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	public UserMemoDao getUserMemoDao() {
		return userMemoDao;
	}

	public void setUserMemoDao(UserMemoDao userMemoDao) {
		this.userMemoDao = userMemoDao;
	}
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	public List<UserMemo> getUserMemos() {
		return userMemos;
	}

	public void setUserMemos(List<UserMemo> userMemos) {
		this.userMemos = userMemos;
	}
	public UserMemoManager getUserMemoManager() {
		return userMemoManager;
	}

	public void setUserMemoManager(UserMemoManager userMemoManager) {
		this.userMemoManager = userMemoManager;
	}

	
	public UserInformation getUserInformation() {
		return userInformation;
	}

	public void setUserInformation(UserInformation userInformation) {
		this.userInformation = userInformation;
	}

	public UserInformationDao getUserInformationDao() {
		return userInformationDao;
	}

	public void setUserInformationDao(UserInformationDao userInformationDao) {
		this.userInformationDao = userInformationDao;
	}
	
	
	public UserManager getUserManager() {
		return userManager;
	}

	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
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

	public File getPortrait() {
		return portrait;
	}

	public void setPortrait(File portrait) {
		this.portrait = portrait;
	}

	public UserInformationManager getUserInformationManager() {
		return userInformationManager;
	}

	public void setUserInformationManager(
			UserInformationManager userInformationManager) {
		this.userInformationManager = userInformationManager;
	}
}
