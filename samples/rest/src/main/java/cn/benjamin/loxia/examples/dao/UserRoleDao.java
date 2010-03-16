package cn.benjamin.loxia.examples.dao;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.benjamin.loxia.dao.GenericEntityDao;
import cn.benjamin.loxia.model.UserRole;

@Transactional(readOnly=true, propagation=Propagation.SUPPORTS)
public interface UserRoleDao extends GenericEntityDao<UserRole, Long> {
	
}
