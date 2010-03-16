package cn.benjamin.loxia.examples.dao;

import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.benjamin.loxia.annotation.NamedQuery;
import cn.benjamin.loxia.annotation.QueryParam;
import cn.benjamin.loxia.dao.GenericEntityDao;
import cn.benjamin.loxia.examples.model.UserMemo;

@Transactional(readOnly=true, propagation=Propagation.SUPPORTS)
public interface UserMemoDao extends GenericEntityDao<UserMemo, Long> {

	@NamedQuery
	List<UserMemo> findUserMemosByUserIdAndDate(@QueryParam("userId") Long userId, @QueryParam("date") Date date);
}
