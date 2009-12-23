package cn.benjamin.loxia.examples.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.benjamin.loxia.examples.dao.UserMemoDao;
import cn.benjamin.loxia.examples.model.UserMemo;
import cn.benjamin.loxia.utils.DateUtil;
import cn.benjamin.loxia.web.table.AbstractTableModelSupport;
import cn.benjamin.loxia.web.table.TableModel;

public class UserMemosTableModel extends AbstractTableModelSupport<UserMemo> {

	private Long userId;
	private Date date;
	private UserMemoDao userMemoDao;		

	public UserMemosTableModel(Long userId, Date date) {
		if(userId == null || date == null)
			throw new IllegalArgumentException();
		this.userId = userId;
		this.date = date;
	}

	private List<UserMemo> userMemos = new ArrayList<UserMemo>();
	@Override
	public long getCount() {
		return userMemos.size();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List getItems() {
		return userMemos;
	}

	@Override
	public TableModel query() {
		userMemos = userMemoDao.findUserMemosByUserIdAndDate(userId,DateUtil.roundDate(date));
		return this;
	}

	public UserMemoDao getUserMemoDao() {
		return userMemoDao;
	}

	public void setUserMemoDao(UserMemoDao userMemoDao) {
		this.userMemoDao = userMemoDao;
	}
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
}
