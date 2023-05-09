package com.main.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.main.entity.User;
import com.main.entity.UserImage;
import com.main.entity.UserRelation;
import com.main.service.UserImageService;
import com.main.service.UserRelationService;
import com.main.service.UserService;

@Controller
public class UserRealtionController {

    @Resource
    private UserService userService;
    @Resource
    private UserRelationService userRelationService;
    @Resource
    private UserImageService userImageService;

    @RequestMapping(value = "/getRelationByName", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getRelationByName(String userName, HttpSession session) {
        User usera = userService.getUser(userName);
        int idA = usera.getUserId();
        User userb = (User) session.getAttribute("currentUser");
        int idB = userb.getUserId();
        String result = "Fail";
        if (idA > idB) {
            int tmp = idA;
            idA = idB;
            idB = tmp;
        }
        UserRelation userRelation = userRelationService.getUserRelation(idA, idB);
        if (userRelation == null) {
            result = "unexist";
        } else {
            result = "exist";
        }
        Map<String, Object> resoult = new HashMap<String, Object>();
        resoult.put("result", result);
        return resoult;
    }

    @RequestMapping(value = "/getRelationById", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getRelationById(int userId, HttpSession session) {
        int idA = userId;
        User userb = (User) session.getAttribute("currentUser");
        int idB = userb.getUserId();
        String result = "Fail";
        if (idA > idB) {
            int tmp = idA;
            idA = idB;
            idB = tmp;
        }
        UserRelation userRelation = userRelationService.getUserRelation(idA, idB);
        if (userRelation == null) {
            result = "unexist";
        } else {
            result = "exist";
        }
        Map<String, Object> resoult = new HashMap<String, Object>();
        resoult.put("result", result);
        return resoult;
    }

    @RequestMapping(value = "/buildRelation", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> buildRelation(int userIdA, int userIdB) {
        UserRelation userRelation = new UserRelation();
        if (userIdA < userIdB) {
            userRelation.setUserIdA(userIdA);
            userRelation.setUserIdB(userIdB);
        } else if (userIdA > userIdB) {
            userRelation.setUserIdA(userIdB);
            userRelation.setUserIdB(userIdA);
        } else {
            //userIdA==userIdB
            Map<String, Object> resoult = new HashMap<String, Object>();
            resoult.put("resoult", "error");
            return resoult;
        }
        userRelation.setRelationStatus(1);
        Date date = new Date();
        Timestamp timestamp = new Timestamp(date.getTime());
        userRelation.setRelationStart(timestamp);
        userRelationService.addUserRelation(userRelation);
        Map<String, Object> resoult = new HashMap<String, Object>();
        resoult.put("resoult", "success");
        return resoult;
    }

    @RequestMapping(value = "/removeRelation", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> removeRelation(int userId, HttpSession httpSession) {
        String result = "Fail";
        User user = (User) httpSession.getAttribute("currentUser");
        int idA = user.getUserId();
        int idB = userId;
        if (idA > idB) {
            int tmp = idA;
            idA = idB;
            idB = tmp;
        }
        if (userRelationService.deleteUserRelation(idA, idB)) {
            result = "success";
        } else {
            result = "error";
        }
        //httpSession.setAttribute("friends", userRelationService.getAllFriends(user.getUserId()));
        Map<String, Object> resoult = new HashMap<String, Object>();
        resoult.put("result", result);
        return resoult;
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/getRelations", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getRelations(int userId) {
        System.out.println("UserRealtionController.getRelations()userid: " + userId);
        List<User> list = new ArrayList<User>();
        list = userRelationService.getAllFriends(userId);
        String relations = JSONArray.toJSONString(list);
        Map<String, Object> resoult = new HashMap<String, Object>();
        resoult.put("relations", relations);
        System.out.println("共" + list.size() + "条记录");
        return resoult;
    }
}