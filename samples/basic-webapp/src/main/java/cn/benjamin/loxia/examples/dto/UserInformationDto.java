package cn.benjamin.loxia.examples.dto;

public class UserInformationDto {
	private Long id;
	private String loginName;
	private String userName;
	private Long uid;
	private String habbit;
	private String description;
	private boolean withProtrait;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getUid() {
		return uid;
	}
	public void setUid(Long uid) {
		this.uid = uid;
	}
	public String getHabbit() {
		return habbit;
	}
	public void setHabbit(String habbit) {
		this.habbit = habbit;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}	
	public boolean isWithProtrait() {
		return withProtrait;
	}
	public void setWithProtrait(boolean withProtrait) {
		this.withProtrait = withProtrait;
	}
	public boolean isWithInformation(){
		return (uid != null);
	}
}
