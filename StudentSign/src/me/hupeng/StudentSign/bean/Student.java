package me.hupeng.StudentSign.bean;

import java.sql.Timestamp;
import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * 学生类
 * */
@Table("student")
public class Student {
	
	@Id
	private int id;
	
	@Name
	@Column("username")
	private String username;
	
	@Column("name")
	private String name;
	
	@Column("password")
	private String password;
	
	@Column("gender")
	private Integer gender;
	
	@Column
	private String college;
	
	@Column
	private String phone;
	
	@Column
	private String weixin;
	
	@Column
	private String qq;
	
	@Column("work_location")
	private String workLocation;
	
	@Column("work_character")
	private String workCharacter;
	
	@Column("register_time")
	private Timestamp registerTime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getCollege() {
		return college;
	}

	public void setCollege(String college) {
		this.college = college;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getWeixin() {
		return weixin;
	}

	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getWorkLocation() {
		return workLocation;
	}

	public void setWorkLocation(String workLocation) {
		this.workLocation = workLocation;
	}

	public String getWorkCharacter() {
		return workCharacter;
	}

	public void setWorkCharacter(String workCharacter) {
		this.workCharacter = workCharacter;
	}

	public Timestamp getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Timestamp registerTime) {
		this.registerTime = registerTime;
	}	
}
