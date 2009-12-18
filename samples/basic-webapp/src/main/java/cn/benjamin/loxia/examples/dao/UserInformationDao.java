package cn.benjamin.loxia.examples.dao;

import cn.benjamin.loxia.annotation.NamedQuery;
import cn.benjamin.loxia.annotation.QueryParam;
import cn.benjamin.loxia.dao.GenericEntityDao;
import cn.benjamin.loxia.examples.model.UserInformation;

public interface UserInformationDao extends GenericEntityDao<UserInformation, Long> {

	@NamedQuery
	UserInformation findUserInformationByUser(@QueryParam("userId") Long userId);
}
