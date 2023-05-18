package com.tworaveler.tlog;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.tworaveler.tlog.member.MemberVO;

@SpringBootApplication
public class TlogApplication {

	public static void main(String[] args) {
		SpringApplication.run(TlogApplication.class, args);
	}
	private static String uploadPath;

	public TlogApplication(@Value("${spring.servlet.multipart.location}") String uploadPath){
		this.uploadPath = uploadPath;
	}

	public static void profileImgUpload(MemberVO vo, HttpServletRequest request) {
		String profilePath = uploadPath+"user/";
		System.out.println("프로필사진 업로드 위치"+profilePath);
		String path = profilePath;
		MultipartFile file = ((MultipartRequest) request).getFile("profileImgs");
		if(!file.getOriginalFilename().equals("")) {
			String orgFileName = file.getOriginalFilename();
			int point = orgFileName.lastIndexOf(".");
			String ext = orgFileName.substring(point+1);
			
			orgFileName = System.currentTimeMillis()+"."+ext;
			File f = new File(path+orgFileName);
			
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			vo.setProfileImg("/upload/user/"+orgFileName);
		}
	}
	
	public static void removeImg(String imgRealPath) {
		File f = new File(imgRealPath);
		if(f.exists()) {
			f.delete();
		}
	}
}
