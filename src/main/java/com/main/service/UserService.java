package com.main.service;


import java.util.List;

import com.main.entity.User;

public interface UserService {

    public User getUser(int id);

    public User getUser(String name);

    public void addUser(User user);

    public boolean deleteUser(int id);

    public boolean updateUser(User user);

    public List<User> getAllUser();
}
