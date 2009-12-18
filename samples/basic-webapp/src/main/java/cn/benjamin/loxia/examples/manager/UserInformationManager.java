package cn.benjamin.loxia.examples.manager;

import cn.benjamin.loxia.examples.model.UserInformation;

public interface UserInformationManager {
	UserInformation updatePortrait(Long userId, byte[] portrait);
	UserInformation saveOrUpdate(UserInformation userInfor);
	byte[] getPortraitByUserInfoId(Long userInfoId);
	byte[] getPortraitByUserId(Long userId);
}
