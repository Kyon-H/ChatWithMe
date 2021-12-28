package com.main.dao;

import java.util.List;

import com.main.entity.UserImage;

public interface UserImageDao {
	public UserImage getUserImage(int userId);
	
	public boolean deleteUserImage(int userId);
	
	public void addUserImage(UserImage userImage);
	
	public boolean updateUserImage(UserImage userImage);
	
	public boolean updateUserImage(int userId,String userImg);
	
	public List<UserImage> getAllUserImage();
}
