package com.yourgg.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yourgg.domain.BoardVO;
import com.yourgg.domain.PageDTO;
import com.yourgg.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
public class MainController {
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/")
	public String getIndex(Model model) {		
		model.addAttribute("board", boardService.getPosts(1));
		model.addAttribute("pageInfo", new PageDTO(1, boardService.getTotalPost()));
		return "index";
	}
	
	@GetMapping("/boardList")
	public String getBoard(Model model, @RequestParam("page") int nowPage) {
		model.addAttribute("board", boardService.getPosts(nowPage));
		model.addAttribute("pageInfo", new PageDTO(nowPage, boardService.getTotalPost()));
		return "index";
	}
	
	@GetMapping("/post")
	public String doPost(Model model, @RequestParam("page") int nowPage) {
		model.addAttribute("pageInfo", new PageDTO(nowPage, boardService.getTotalPost()));
		return "post";
	}
	
	@PostMapping("/post/regist")
	public String doRegist(BoardVO boardVO) {
		boardService.registPost(boardVO);
		return "redirect:/";
	}
	
	@GetMapping("/get/view-post")
	public String seePost(Model model, @RequestParam("page") int nowPage, @RequestParam("boardNumber") int boardNumber) {
		model.addAttribute("pageInfo", new PageDTO(nowPage, boardService.getTotalPost()));
		model.addAttribute("board", boardService.getPost(boardNumber));
		return "view-post";
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public boolean deletePost(BoardVO boardVO) {
		return boardService.deletePost(boardVO);
	}
	
	@PostMapping("/update-judge")
	@ResponseBody
	public boolean updatePost(BoardVO boardVO) {
		return boardService.updateJudge(boardVO);
	}
	
	@PostMapping("/post/update")
	public String doUpdatePost(BoardVO boardVO) {
		boardService.updatePost(boardVO);
		return "redirect:/";
	}
	
}
