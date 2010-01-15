package cn.benjamin.loxia.examples.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.easymock.EasyMock;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import cn.benjamin.loxia.examples.dao.UserDao;
import cn.benjamin.loxia.examples.dao.UserInformationDao;
import cn.benjamin.loxia.examples.dao.UserMemoDao;
import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.examples.manager.UserManager;
import cn.benjamin.loxia.examples.manager.UserMemoManager;
import cn.benjamin.loxia.examples.manager.impl.UserInformationManagerImpl;
import cn.benjamin.loxia.examples.manager.impl.UserManagerImpl;
import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.examples.model.UserMemo;
import cn.benjamin.loxia.model.OperatingUnit;
import cn.benjamin.loxia.model.User;
import cn.benjamin.loxia.security.LoxiaUserDetails;
import cn.benjamin.loxia.utils.DateUtil;


public class UserMaintainActionTest {
	private UserDao userDao;	
	private UserMemoDao userMemoDao;	
	private UserMemoManager userMemoManager;	
	private UserInformationManager userInformationManager;
	private UserManager userManager;
	private UserInformationDao userInformationDao;
	
	private User user=new User();
	private UserInformation ui=new UserInformation();
	private final OperatingUnit ou=new OperatingUnit();
	private List<UserMemo> userMemos = new ArrayList<UserMemo>();
	private UserMaintainAction action;
	
	@BeforeTest
	public void init()
	{
		userMemoManager=EasyMock.createMock(UserMemoManager.class);
		userDao=EasyMock.createMock(UserDao.class);
		userMemoDao=EasyMock.createMock(UserMemoDao.class);
		userInformationManager=EasyMock.createMock(UserInformationManager.class);
		userManager=EasyMock.createMock(UserManager.class);
		userInformationDao=EasyMock.createMock(UserInformationDao.class);
//		user=EasyMock.createMock(User.class);
		
		Map<String,Object> request=new HashMap<String,Object>();
		
		action=new UserMaintainAction();
		action.setUserMemoDao(userMemoDao);
		action.setUserMemoManager(userMemoManager);
		action.setUserManager(userManager);
		action.setUserDao(userDao);
		action.setUser(user);
		
		action.setUserInformation(ui);
		action.setRequest(request);
		
		
		
		ou.setId(1l);
		user.setOu(ou);
		user.setId(null);
		user.setPassword("password");
		
		ui.setUser(user);
		
		
		
		
	}
	
//	@Test
//	public void testExecute() throws Exception
//	{
//		User user1=new User();
//		EasyMock.expect(userDao.save(user)).andReturn(user1);
////		EasyMock.replay(userDao);
////		
////		EasyMock.expect(userDao.save(user)).andStubReturn(user1);
//		EasyMock.replay(userDao);
//		String result=action.addUser();
//		assert "json".equals(result):"Wrong Result";
//		
//		
//	}
	
	@Test
	public void testEditUser() throws Exception
	{
		EasyMock.expect(userDao.getByPrimaryKey(1l)).andReturn(user);
		EasyMock.expect(userInformationDao.findUserInformationByUser(1l)).andReturn(ui);
		EasyMock.expect(userInformationManager.getPortraitByUserId(1l)).andReturn(new byte[]{});
		
		EasyMock.replay(userDao);
		EasyMock.replay(userInformationDao);
		EasyMock.replay(userInformationManager);
		
		String result=action.modifyUser();
		assert "json".equals(result):"Wrong Result";
		
		
	}
}
