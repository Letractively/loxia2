package cn.benjamin.loxia.examples.manager.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.examples.manager.UserManager;
import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.model.User;
import cn.benjamin.loxia.utils.PropertyUtil;

@Transactional
public class UserManagerImpl implements UserManager{
	
	private UserDao userDao;
	private UserInformationManager userInformationManager;
	public void deleteUser(Long userId){
		if(userId == null) throw new IllegalArgumentException();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		userDao.updateByNamedQuery("User.deleteUserbyUserId", params);
	}
	
	@Transactional
	public void EditUser(User user,UserInformation userInformation) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException
	{
		User u=userDao.getByPrimaryKey(user.getId());
    	String password=user.getPassword();
    	String userName=user.getUserName();
    	PropertyUtil.copyProperties(u, user);
    	if(password!=null&&!password.equals(""))
    		user.setPassword(password);
    	if(userName!=null&&!userName.equals(""))
    		user.setUserName(userName);
    	
    	userInformation.setPortrait(userInformationManager.getPortraitByUserId(user.getId()));
    	userInformation.setUser(user);
		userDao.save(user);
		if(userInformation != null)
			userInformationManager.saveOrUpdate(userInformation);
	}
	
	public UserInformationManager getUserInformationManager() {
		return userInformationManager;
	}
	public void setUserInformationManager(
			UserInformationManager userInformationManager) {
		this.userInformationManager = userInformationManager;
	}
	public UserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
}
