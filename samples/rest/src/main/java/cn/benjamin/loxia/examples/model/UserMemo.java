package cn.benjamin.loxia.examples.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Index;

import cn.benjamin.loxia.model.BaseModel;
import cn.benjamin.loxia.model.User;

@Entity
@Table(name="T_BI_USER_MEMO")
@org.hibernate.annotations.Proxy(lazy=false)
public class UserMemo extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 780395223153599107L;

	@Id @GeneratedValue(generator="pk_gen", strategy=GenerationType.SEQUENCE)
	@SequenceGenerator(name="pk_gen", sequenceName="T_BI_USER_MEMO", allocationSize=1, initialValue=1)
	@Column(name="ID")
	private Long id;
	
	@Column(name="MEMO_DATE")
	private Date memoDate;
	
	@Column(name="MEMO", length=2000)
	private String memo;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="USER_ID")
	@Index(name="IDX_USRM_USR")
	private User user;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getMemoDate() {
		return memoDate;
	}
	public void setMemoDate(Date memoDate) {
		this.memoDate = memoDate;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	
}
