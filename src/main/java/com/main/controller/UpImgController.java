package com.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jboss.logging.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.main.entity.UserImage;
import com.main.service.UpImgService;
import com.main.service.UserImageService;

//未用到
//@Controller
public class UpImgController {
    public static final Logger logger = LoggerFactory.getLogger(UpImgController.class);
    @Autowired
    private UpImgService upImgService;

    //@RequestMapping(value = "/headImgUpload", produces = "text/html;charset=UTF-8")
    //@ResponseBody
    public Map<String, Object> headImgUpload(Integer userId, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
        System.out.println("UpImgController.headImgUpload()");
        String result = "Fail";
        Map<String, Object> value = new HashMap<String, Object>();
        if (file == null || file.getSize() <= 0) {
            System.out.println("file is empty");
            result = "empty";
            value.put("result", result);
        } else {
            try {
                String url = upImgService.updateHead(file);
                System.out.println("UpImgController.headImgUpload()url " + url);
                logger.debug("图片路径{}", url);
                value.put("data", url);
                value.put("code", 0);
                value.put("msg", "图片上传成功");
                result = "success";
                value.put("result", result);
            } catch (Exception e) {
                e.printStackTrace();
                value.put("code", 2000);
                result = "error";
                value.put("result", result);
            }
        }
        return value;
    }
}
