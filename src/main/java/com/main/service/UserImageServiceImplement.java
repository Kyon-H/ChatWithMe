package com.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.dao.UserImageDao;
import com.main.entity.UserImage;

@Service
public class UserImageServiceImplement implements UserImageService {
	
	@Autowired private UserImageDao userImageDao;
	
	@Override
	public UserImage getUserImage(int id) {
		// TODO Auto-generated method stub
		return userImageDao.getUserImage(id);
	}

	@Override
	public void addUserImage(UserImage userImage) {
		// TODO Auto-generated method stub
		userImageDao.addUserImage(userImage);
	}

	@Override
	public boolean updateUserImage(UserImage userImage) {
		// TODO Auto-generated method stub
		return userImageDao.updateUserImage(userImage);
	}
	
	@Override
	public boolean updateUserImage(int userId, String userImg) {
		// TODO Auto-generated method stub
		return userImageDao.updateUserImage(userId, userImg);
	}
}
