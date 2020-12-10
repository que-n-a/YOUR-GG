package com.yourgg.tester;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yourgg.service.BoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class Tester {

	@Autowired
	private BoardService service;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

//	@Test
//	public void test() {
//		
//		int nowPage = 51;
//		int totalPost = service.getTotalPost();
//		int totalPage = (int)Math.ceil(service.getTotalPost()/20);
//		int endPage = (int)(Math.ceil(nowPage/10.0))*10; 
//		int startPage = endPage - 9;
//		
//		log.info("현재 페이지 = " + nowPage);
//		log.info("총 게시글 = " + totalPost);
//		log.info("총 페이지 = " + totalPage);
//		log.info("시작 페이지 = " + startPage);
//		log.info("끝 페이지 = " + endPage); 
//		
//		service.getPosts(new PageVO(nowPage, 20));
//
//	}
	
	@Test
	public void test() {
		
		String str = "1234";
		String pass = passwordEncoder.encode(str);
		boolean judge = passwordEncoder.matches(str, pass);
		
		log.info("입력 = " + str);
		log.info("password = " + pass);
		log.info("판단 = " + judge);
		
	}

}
