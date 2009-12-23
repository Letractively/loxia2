package cn.benjamin.loxia.examples.manager;

import java.util.Date;
import java.util.List;

import cn.benjamin.loxia.examples.model.UserMemo;

public interface UserMemoManager {
	void maintainUserMemos(Long userId, Date date, List<UserMemo> userMemos);
}
