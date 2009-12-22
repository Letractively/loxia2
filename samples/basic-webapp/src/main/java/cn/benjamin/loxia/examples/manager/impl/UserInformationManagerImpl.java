package cn.benjamin.loxia.examples.manager.impl;

import org.springframework.transaction.annotation.Transactional;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.dao.UserInformationDao;
import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.examples.model.UserInformation;

@Transactional
public class UserInformationManagerImpl implements UserInformationManager {

	private UserInformationDao userInformationDao;
	private UserDao userDao;
	
	public UserInformation updatePortrait(Long userId, byte[] portrait){
		if(userId == null) throw new IllegalArgumentException();
		UserInformation ui = userInformationDao.findUserInformationByUser(userId);
		if(ui == null){
			ui = new UserInformation();
			ui.setUser(userDao.getByPrimaryKey(userId));
			if(ui.getUser() == null) throw new RuntimeException("User should be existed.");
		}
		ui.setPortrait(portrait);
		return userInformationDao.save(ui);		
	}
	
	public UserInformation saveOrUpdate(UserInformation userInfor){
		if(userInfor == null || userInfor.getUser() == null || userInfor.getUser().getId() == null)
			throw new IllegalArgumentException();
		UserInformation ui = userInformationDao.findUserInformationByUser(userInfor.getUser().getId());
		if(ui == null){
			ui = new UserInformation();
			ui.setUser(userDao.getByPrimaryKey(userInfor.getUser().getId()));
			if(ui.getUser() == null) throw new RuntimeException("User should be existed.");
		}
		ui.setHabbit(userInfor.getHabbit());
		ui.setPortrait(userInfor.getPortrait());
		return userInformationDao.save(ui);		
	}
	
	@Transactional(readOnly=true)
	public byte[] getPortraitByUserId(Long userId) {
		UserInformation ui = userInformationDao.findUserInformationByUser(userId);
		if(ui == null)
			return null;
		return ui.getPortrait();
	}

	@Transactional(readOnly=true)
	public byte[] getPortraitByUserInfoId(Long userInfoId) {
		UserInformation ui = userInformationDao.getByPrimaryKey(userInfoId);
		if(ui == null)
			return null;
		return ui.getPortrait();
	}

	public UserInformationDao getUserInformationDao() {
		return userInformationDao;
	}
	public void setUserInformationDao(UserInformationDao userInformationDao) {
		this.userInformationDao = userInformationDao;
	}
	public UserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}	
}
