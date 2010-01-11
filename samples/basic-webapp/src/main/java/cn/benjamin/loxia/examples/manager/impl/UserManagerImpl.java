package cn.benjamin.loxia.examples.manager.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.manager.UserManager;

@Transactional
public class UserManagerImpl implements UserManager{
	
	private UserDao userDao;

	public void deleteUser(Long userId){
		if(userId == null) throw new IllegalArgumentException();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		userDao.updateByNamedQuery("User.deleteUserbyUserId", params);
	}
	
	public UserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
}
