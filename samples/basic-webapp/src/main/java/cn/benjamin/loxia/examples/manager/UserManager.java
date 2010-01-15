package cn.benjamin.loxia.examples.manager;

import java.lang.reflect.InvocationTargetException;

import cn.benjamin.loxia.examples.model.UserInformation;
import cn.benjamin.loxia.model.User;

public interface UserManager {
	void deleteUser(Long userId);
	void EditUser(User user,UserInformation userInformation) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException;
}
