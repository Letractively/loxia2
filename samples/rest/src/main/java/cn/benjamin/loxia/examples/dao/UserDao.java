package cn.benjamin.loxia.examples.dao;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.benjamin.loxia.annotation.NamedQuery;
import cn.benjamin.loxia.annotation.QueryParam;
import cn.benjamin.loxia.dao.GenericEntityDao;
import cn.benjamin.loxia.model.User;

@Transactional(readOnly=true, propagation=Propagation.SUPPORTS)
public interface UserDao extends GenericEntityDao<User, Long> {
	
	@NamedQuery
	User findByLoginName(@QueryParam("loginName") String loginName);
}
