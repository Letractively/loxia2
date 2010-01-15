package cn.benjamin.loxia.examples.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.easymock.EasyMock;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import cn.benjamin.loxia.dao.Pagination;
import cn.benjamin.loxia.dao.Sort;
import cn.benjamin.loxia.examples.dao.UserInformationDao;
import cn.benjamin.loxia.examples.dao.UserMemoDao;
import cn.benjamin.loxia.examples.manager.UserInformationManager;
import cn.benjamin.loxia.model.User;
import cn.benjamin.loxia.security.LoxiaUserDetails;
import cn.benjamin.loxia.utils.DateUtil;
import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.examples.model.UserMemo;
public class DesktopActionTest {
	private UserInformationManager userInformationManager;
	private UserInformationDao userInformationDao;
	private UserMemoDao userMemoDao;
	
	private DesktopAction action;
	
	@BeforeTest
	public void init()
	{
		userInformationDao=EasyMock.createMock(UserInformationDao.class);
		userInformationDao=EasyMock.createMock(UserInformationDao.class);
		userMemoDao=EasyMock.createMock(UserMemoDao.class);
		
		Map<String,Object> session=new HashMap<String,Object>();
		Map<String,Object> request=new HashMap<String,Object>();
		
		LoxiaUserDetails userDetails=new LoxiaUserDetails();
		User user=new User();
		user.setId(2l);
		userDetails.setUser(user);
		
		action=new DesktopAction();
		action.setUserInformationDao(userInformationDao);
		action.setUserInformationManager(userInformationManager);
		action.setUserMemoDao(userMemoDao);
		action.setRequest(request);
		action.setSession(session);
		action.setLoxiaUserDetails(userDetails);
	}
	
	@Test
	public void testExecute() throws Exception
	{
		Pagination<Object[]> upag =new Pagination<Object[]>();
		List<UserMemo> umList=new  ArrayList<UserMemo>();
		UserInformation um=new UserInformation();

		
		//		EasyMock.expect(userInformationDao.findUserInfosSql(0, 10,new Sort[]{new Sort("u.USER_NAME")})).andReturn(upag);
		EasyMock.expect(userInformationDao.findUserInfosSql(EasyMock.eq(0), EasyMock.eq(10),EasyMock.aryEq(new Sort[]{new Sort("u.USER_NAME")}))).andReturn(upag);

		//		userInformationDao.findUserInfosSql(0, 10,new Sort[]{new Sort("u.USER_NAME")});
		
//		EasyMock.expectLastCall().andReturn(upag);
		
		EasyMock.expect(userMemoDao.findUserMemosByUserIdAndDate(2l,DateUtil.roundDate(new Date()))).andReturn(umList);
		EasyMock.expect(userInformationDao.findUserInformationByUser(2l)).andReturn(um);
		
		EasyMock.replay(userInformationDao);
		EasyMock.replay(userMemoDao);
		
		String result=action.execute();
		assert "success".equals(result):"Wrong Result";
		
		/*
		 List<Object[]> list = new ArrayList<Object[]>();
		  list.add(new Object[]{1l,"admin","Administrator", true,1l,null,null,false});  
		  Pagination<Object[]> upag1 = new Pagination<Object[]>(list,1);

		  Map<String,Object> session=new HashMap<String,Object>();
		  Map<String,Object> request=new HashMap<String,Object>();
		  String result1 = action.execute();
		  assert "success".equals(result) : "Wrong Result";
		  assert session.get("userTableModel") != null : "Wrong Model";
		  UsersTableModel model = (UsersTableModel) session.get("userTableModel");
		  assert model.getCount() == 1l : "Wrong count for User Information";
	 */
	}
	
}
