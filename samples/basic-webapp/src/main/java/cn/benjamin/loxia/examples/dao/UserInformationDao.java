package cn.benjamin.loxia.examples.dao;

import cn.benjamin.loxia.annotation.NamedQuery;
import cn.benjamin.loxia.annotation.NativeQuery;
import cn.benjamin.loxia.annotation.QueryParam;
import cn.benjamin.loxia.dao.GenericEntityDao;
import cn.benjamin.loxia.dao.Pagination;
import cn.benjamin.loxia.dao.Sort;
import cn.benjamin.loxia.examples.model.UserInformation;

public interface UserInformationDao extends GenericEntityDao<UserInformation, Long> {

	@NamedQuery
	UserInformation findUserInformationByUser(@QueryParam("userId") Long userId);
	
	@NativeQuery(sqlResultMapping="userInfo", pagable=true)
	Pagination<Object[]> findUserInfosSql(int start, int pageSize, Sort[] sorts);
}
