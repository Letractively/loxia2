package cn.benjamin.loxia.examples.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.dao.UserMemoDao;
import cn.benjamin.loxia.examples.manager.UserMemoManager;
import cn.benjamin.loxia.examples.model.UserMemo;
import cn.benjamin.loxia.model.User;
import cn.benjamin.loxia.support.json.JSONObject;
import cn.benjamin.loxia.utils.DateUtil;
import cn.benjamin.loxia.web.BaseProfileAction;
import cn.benjamin.loxia.web.annotation.DataResponse;

public class UserMaintainAction extends BaseProfileAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2519287147927865666L;
	
	private User user;
	//TODO add date selection
	private Date date;		

	private List<UserMemo> userMemos = new ArrayList<UserMemo>();	

	private UserDao userDao;	
	private UserMemoDao userMemoDao;	
	private UserMemoManager userMemoManager;	

	@SuppressWarnings("unchecked")
	private void prepareForTodoListMaintain(){
		request.put("umList", 
				userMemoDao.findUserMemosByUserIdAndDate(userDetails.getUser().getId(), 
						date == null ? DateUtil.today() : DateUtil.roundDate(date)));
	}

	public String maintainTodoListEntry() throws Exception{
		prepareForTodoListMaintain();
		return SUCCESS;
	}
	
	public String maintainTodoList() throws Exception{		
		userMemoManager.maintainUserMemos(userDetails.getUser().getId(), 
						date == null ? DateUtil.today() : DateUtil.roundDate(date), userMemos);
		prepareForTodoListMaintain();
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	@DataResponse
	public String addUser() throws Exception{		
		user.setId(null);
		user = userDao.save(user);
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("result", true);
		request.put("json", new JSONObject(result));
		return JSON;
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
}
