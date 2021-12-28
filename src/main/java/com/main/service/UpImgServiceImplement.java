package com.main.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.main.controller.OSSClientUtil;

@Service
public class UpImgServiceImplement implements UpImgService {
	public static final Logger logger = LoggerFactory.getLogger(UpImgServiceImplement.class);
	@Override
	public String updateHead(MultipartFile file) {
		System.out.println("UpImgServiceImplement.updateHead()");
		OSSClientUtil ossClient = new OSSClientUtil();
		String name = ossClient.uploadImg2Oss(file);
		if(name.equals("imgbt")) {
			return "imgbt";
		}
		if(name.equals("error")) {
			return "error";
		}
		String imgUrl = ossClient.getImgUrl(name);
		String[] split = imgUrl.split("\\?");
		return split[0];
	}
	
	@Override
	public String updateHead(int userId, MultipartFile file) {
		// TODO Auto-generated method stub
		System.out.println("UpImgServiceImplement.updateHead()");
		OSSClientUtil ossClient = new OSSClientUtil();
		String name = ossClient.uploadImg2Oss(userId,file);
		if(name.equals("imgbt")) {
			return "imgbt";
		}
		if(name.equals("error")) {
			return "error";
		}
		String imgUrl = ossClient.getImgUrl(name);
		String[] split = imgUrl.split("\\?");
		return split[0];
	}
}

 



	
	