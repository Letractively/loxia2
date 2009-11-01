package cn.benjamin.loxia.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.testng.annotations.Test;

import cn.benjamin.loxia.model.User;

@ContextConfiguration(locations={"classpath*:loxia-*.xml"})
public class GenericEntityDaoTests extends AbstractTestNGSpringContextTests {
	
	@Autowired
	private UserDao userDao;
	
	@Test
	public void testUserDaoAdd(){
		User user = new User();
		user.setId(1l);
		user.setLoginName("user");
		user.setPassword("loxia");
		user.setUserName("Loxia User");
		userDao.save(user);
		System.out.println("==============================");
		User u = userDao.getByPrimaryKey(1l);
		assert u != null : "user is null";
		assert u.getLoginName().equals("user") : "wrong user";
		System.out.println("==============================");
		u.setUserName("Dragon");
		userDao.save(u);
		System.out.println("==============================");
		u = userDao.getByPrimaryKey(1l);
		assert u.getUserName().equals("Dragon") : "wrong user name";
		System.out.println("==============================");
		user = new User();
		user.setId(1l);
		user.setLoginName("user");
		user.setPassword("loxia");
		user.setUserName("Loxia User");
		userDao.save(user);
	}
}