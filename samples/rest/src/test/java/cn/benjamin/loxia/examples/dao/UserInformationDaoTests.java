package cn.benjamin.loxia.examples.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.testng.annotations.Test;

import cn.benjamin.loxia.examples.model.UserInformation;

@ContextConfiguration(locations={"classpath*:loxia-service-*.xml","classpath*:loxia-security-*.xml",
		"classpath*:loxia-hibernate-*.xml",
		"classpath*:spring.xml"})
public class UserInformationDaoTests extends AbstractTestNGSpringContextTests {
	
	@Autowired
	private UserInformationDao userInformationDao;
	
	@Test
	public void test(){
		UserInformation ui = userInformationDao.findUserInformationByUser(1L);
		assert ui != null : "User information is null";
	}
}
