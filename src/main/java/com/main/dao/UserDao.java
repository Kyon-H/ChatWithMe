package com.main.dao;

import java.util.List;


import com.main.entity.*;

public interface UserDao {

    public User getUser(int id);

    public User getUser(String name);

    public void addUser(User user);

    public boolean deleteUser(int id);

    public boolean updateUser(User user);

    public List<User> getAllUser();
}
