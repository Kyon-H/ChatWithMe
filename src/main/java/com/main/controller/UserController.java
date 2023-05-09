package com.main.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.main.entity.User;
import com.main.entity.UserDetail;
import com.main.entity.UserImage;
import com.main.service.UserDetailService;
import com.main.service.UserImageService;
import com.main.service.UserService;


@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserDetailService userDetailService;
    @Autowired
    private UserImageService userImgService;

    @RequestMapping(value = "/info")
    public String info() {
        return "info";
    }

    @RequestMapping(value = "/doFindUserByName", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> findUserByName(String userName) {
        System.out.println("UserController.findUserByName()" + userName);

        User user = userService.getUser(userName);
        UserDetail userDetail = userDetailService.getUserDetail(userName);
        UserImage userImg = userImgService.getUserImage(user.getUserId());
        //通过HashMap来构建Json数据，其实和Server里面通过JSONObject来构建效果是一样的
        Map<String, Object> resoult = new HashMap<String, Object>();
        if (user != null) {
            resoult.put("userId", user.getUserId());
            resoult.put("userName", user.getUserName());
            resoult.put("userNickName", user.getUserNickName());
            resoult.put("userPassword", userDetail.getUserDetailPassword());
            resoult.put("userEmail", userDetail.getUserMailNumber());
            resoult.put("userPhone", userDetail.getUserPhoneNumber());
            resoult.put("userIsOnline", user.getUserIsOnline());
            resoult.put("userRole", user.getUserRole());
            resoult.put("userImg", userImg.getUserImg());
        }
        return resoult;
    }

    ;

    @RequestMapping(value = "/doFindUserById", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> findUserById(int userId) {
        System.out.println("UserController.findUserById()" + userId);
        User user = userService.getUser(userId);
        UserDetail userDetail = userDetailService.getUserDetail(userId);
        UserImage userImg = userImgService.getUserImage(userId);
        Map<String, Object> resoult = new HashMap<String, Object>();
        if (user != null) {
            resoult.put("userId", user.getUserId());
            resoult.put("userName", user.getUserName());
            resoult.put("userNickName", user.getUserNickName());
            resoult.put("userPassword", userDetail.getUserDetailPassword());
            resoult.put("userEmail", userDetail.getUserMailNumber());
            resoult.put("userPhone", userDetail.getUserPhoneNumber());
            resoult.put("userIsOnline", user.getUserIsOnline());
            resoult.put("userRole", user.getUserRole());
            resoult.put("userImg", userImg.getUserImg());
        } else
            resoult = null;
        return resoult;
    }

    ;

    @RequestMapping(value = "/doDeleteUserById", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> DeleteUserById(int userId) {
        System.out.println("UserController.DeleteUserById()");
        String result = "Fail";
        if (userService.deleteUser(userId)) {
            result = "success";
        } else {
            result = "error";
        }
        Map<String, Object> resoult = new HashMap<String, Object>();
        resoult.put("result", result);
        return resoult;
    }

    @RequestMapping(value = "/doUpdateUserInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> UpdateUserInfo(int userId, String userName, String userNickName,
                                              String userEmail, String userPhone, HttpSession httpSession) {
        System.out.println("UserController.UpdateUserInfo()");
        String result = "fail";
        User user = userService.getUser(userId);
        UserDetail userDetail = userDetailService.getUserDetail(userId);
        user.setUserName(userName);
        user.setUserNickName(userNickName);
        userDetail.setUserDetailName(userName);
        userDetail.setUserDetailNickName(userNickName);
        userDetail.setUserMailNumber(userEmail);
        userDetail.setUserPhoneNumber(userPhone);
        if (userDetailService.updateUserDetail(userDetail)) {
            userService.updateUser(user);
            httpSession.setAttribute("currentUser", user);
            result = "success";
        }
        Map<String, Object> results = new HashMap<String, Object>();
        results.put("result", result);
        if (result.equals("success"))
            results.put("user", JSON.toJSON(user));
        return results;
    }

    @RequestMapping(value = "/doUpdateUserPassword", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> UpdateUserPassword(int userId, String userOldPassword, String userNewPassword) {
        System.out.println("UserController.UpdateUserPassword()");
        String result = "fail";
        UserDetail userDetail = userDetailService.getUserDetail(userId);
        if (userDetail.getUserDetailPassword().equals(userOldPassword)) {
            userDetail.setUserDetailPassword(userNewPassword);
            userDetailService.updateUserDetail(userDetail);
            result = "success";
        } else {
            result = "unexist";
        }
        Map<String, Object> results = new HashMap<String, Object>();
        results.put("result", result);
        return results;
    }
}