package com.main.service;

import java.util.List;

import com.main.entity.UserRelation;

public interface UserRelationService {

    public UserRelation getUserRelation(int idA, int idB);

    public void addUserRelation(UserRelation userRelation);

    public boolean deleteUserRelation(int idA, int idB);

    public boolean updateUser(UserRelation userRelation);

    @SuppressWarnings("rawtypes")
    public List getAllFriends(int id);
}
