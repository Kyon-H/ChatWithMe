package com.main.service;
import org.springframework.web.multipart.MultipartFile;

public interface UpImgService {
 
	String updateHead(MultipartFile file);
	
	String updateHead(int userId,MultipartFile file);
}
