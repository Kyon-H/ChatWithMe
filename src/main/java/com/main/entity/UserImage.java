package com.main.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="user_image")
public class UserImage {
	private int userId;
	private String userImg;
	
	@Id
	@GenericGenerator(name = "generator", strategy = "assigned")
	@GeneratedValue(generator = "generator")
	
	@Column(name="user_id")
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	@Column(name="user_img")
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	public UserImage() {
	}
	public UserImage(int userId, String userImg) {
		this.userId = userId;
		this.userImg = userImg;
	}
	public UserImage(UserDetail userDetail) {
		this.userId=userDetail.getUserDetailId();
		this.userImg="";
	}
}
