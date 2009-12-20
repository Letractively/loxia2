package cn.benjamin.loxia.examples.model;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Version;

import org.hibernate.annotations.Index;
import org.hibernate.annotations.OptimisticLockType;

import cn.benjamin.loxia.model.BaseModel;
import cn.benjamin.loxia.model.User;

@Entity
@Table(name="T_BI_USER_INFO")
@org.hibernate.annotations.Proxy(lazy=false)
@org.hibernate.annotations.Entity(optimisticLock=OptimisticLockType.VERSION)
public class UserInformation extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3483792601831124980L;

	@Id @GeneratedValue(generator="pk_gen", strategy=GenerationType.SEQUENCE)
	@SequenceGenerator(name="pk_gen", sequenceName="SEQ_T_BI_USER_INFO", allocationSize=1, initialValue=1)
	@Column(name="ID")
	private Long id;
	
	@Column(name="HABBIT", length=500)
	private String habbit;
	
	@Column(name="DESCRIPTION", length=2000)
	private String description;
		
	@Lob
	@Basic(fetch=FetchType.LAZY)
    @Column(name="PORTRAIT", columnDefinition="VARBINARY(500000)", nullable=true)
	private byte[] portrait;
	
	@Version
	@Column(name="VERSION")
	private int version;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="USER_ID")
	@Index(name="IDX_USRI_USR")
	private User user;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	public byte[] getPortrait() {
		return portrait;
	}
	public void setPortrait(byte[] portrait) {
		this.portrait = portrait;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
