package com.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.main.entity.UserImage;
import com.main.service.UpImgService;
import com.main.service.UserImageService;

@Controller
public class UserImageController {

    public static final Logger logger = LoggerFactory.getLogger(UpImgController.class);
    @Autowired
    private UpImgService upImgService;
    @Autowired
    private UserImageService userImageService;

    /**
     * 图片上传
     *
     * @param userId 用户id
     * @param file   图片文件
     * @return empty|imgbt|error|success
     */
    @RequestMapping(value = "/userImgUpload", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> userImgUpload(int userId, @RequestParam(value = "file", required = false) MultipartFile file) {
        String result = "Fail";
        Map<String, Object> value = new HashMap<String, Object>();
        if (file == null || file.getSize() <= 0) {
            result = "empty";
            value.put("result", result);
            return value;
        }
        String url = upImgService.updateHead(userId, file);
        if (url.equals("imgbt") || url.equals("error"))
            result = url;
        else {
            System.out.println("UpImgController.userImgUpload()url " + url);
            UserImage userImage = userImageService.getUserImage(userId);
            userImage.setUserImg(url);
            userImageService.updateUserImage(userId, url);
            result = "success";
        }
        value.put("result", result);
        return value;
    }

    @PostMapping("/doFindUserImgById")
    @ResponseBody
    public Map<String, Object> FindUserImgById(int userId) {
        //System.out.println("UserImgController.GetUserImgById()");
        UserImage userImg = userImageService.getUserImage(userId);
        Map<String, Object> result = new HashMap<String, Object>();
        if (userImg != null) {
            result.put("userId", userImg.getUserId());
            result.put("userImg", userImg.getUserImg());
        } else {
            result = null;
        }
        return result;
    }
}
