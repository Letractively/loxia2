package cn.benjamin.loxia.examples.action;

import java.util.HashMap;
import java.util.Map;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.model.User;
import cn.benjamin.loxia.support.json.JSONObject;
import cn.benjamin.loxia.web.BaseProfileAction;
import cn.benjamin.loxia.web.annotation.DataResponse;

public class UserMaintainAction extends BaseProfileAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2519287147927865666L;
	
	private User user;
	
	private UserDao userDao;
		

	public String addUserEntry() throws Exception{
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
}
