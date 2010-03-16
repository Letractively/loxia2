package cn.benjamin.loxia.examples.manager.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.dao.UserMemoDao;
import cn.benjamin.loxia.examples.manager.UserMemoManager;
import cn.benjamin.loxia.examples.model.UserMemo;
import cn.benjamin.loxia.model.User;
import cn.benjamin.loxia.utils.DateUtil;

@Transactional
public class UserMemoManagerImpl implements UserMemoManager {	

	private UserDao userDao;
	private UserMemoDao userMemoDao;
	
	public void maintainUserMemos(Long userId, Date date,
			List<UserMemo> userMemos) {
		User user = userDao.getByPrimaryKey(userId);
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("userId", userId);
		params.put("date", DateUtil.roundDate(date));
		userDao.updateByNamedQuery("UserMemo.deleteUserMemoByUserIdAndDate", params);
		for(UserMemo um: userMemos){
			um.setId(null);
			um.setMemoDate(DateUtil.roundDate(date));
			um.setUser(user);
			userMemoDao.save(um);
		}
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
}
