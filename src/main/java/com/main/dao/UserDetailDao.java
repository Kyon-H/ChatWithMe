package com.main.dao;

import java.util.List;

import com.main.entity.UserDetail;

public interface UserDetailDao {

    public UserDetail getUserDetail(int id);

    public UserDetail getUserDetail(String name);

    public void addUserDetail(UserDetail userDetail);

    public boolean deleteUserDetail(int id);

    public boolean updateUserDetail(UserDetail userDetail);

    public List<UserDetail> getAllUserDetail();
}
