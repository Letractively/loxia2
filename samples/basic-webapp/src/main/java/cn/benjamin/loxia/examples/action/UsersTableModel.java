package cn.benjamin.loxia.examples.action;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import cn.benjamin.loxia.dao.Pagination;
import cn.benjamin.loxia.examples.dao.UserInformationDao;
import cn.benjamin.loxia.examples.dto.UserInformationDto;
import cn.benjamin.loxia.web.table.AbstractTableModelSupport;
import cn.benjamin.loxia.web.table.TableModel;

public class UsersTableModel extends AbstractTableModelSupport<UserInformationDto> {
	private UserInformationDao userInformationDao;
	
	private Pagination<Object[]> p;
	
	@Override
	public TableModel query(){
		int startPage = getCurrentPage() <1 ? 1: getCurrentPage();		
		p = userInformationDao.findUserInfosSql((startPage-1)*getItemPerPage(), getItemPerPage(), getSorts());
		return this;
	}
	
	@Override
	public long getCount() {
		return p.getCount();
	}

	@Override
	public List<UserInformationDto> getItems() {
		List<UserInformationDto> result = new ArrayList<UserInformationDto>();
		for(Object[] objs: p.getItems())
			result.add(translate(objs));
		return result;
	}
	
	private UserInformationDto translate(Object[] objs){
		if(objs == null) return null;
		UserInformationDto dto = new UserInformationDto();
		
		dto.setId(objs[0] == null ? null : ((BigInteger)objs[0]).longValue());
		dto.setLoginName((String)objs[1]);
		dto.setUserName((String)objs[2]);
		dto.setUid(objs[3] == null ? null : ((BigInteger)objs[3]).longValue());
		dto.setHabbit((String)objs[4]);
		dto.setDescription((String)objs[5]);
		Integer i = (Integer)objs[6];
		dto.setWithProtrait((i>0));
		return dto;
	}
	
	public UserInformationDao getUserInformationDao() {
		return userInformationDao;
	}

	public void setUserInformationDao(UserInformationDao userInformationDao) {
		this.userInformationDao = userInformationDao;
	}

}
