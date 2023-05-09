package com.main.service;

import com.main.entity.UserImage;

public interface UserImageService {
    public UserImage getUserImage(int id);

    public void addUserImage(UserImage userImage);

    public boolean updateUserImage(UserImage userImage);

    public boolean updateUserImage(int userId, String userImg);
}
