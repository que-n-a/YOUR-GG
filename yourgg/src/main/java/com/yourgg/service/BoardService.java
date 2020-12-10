package com.yourgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.yourgg.domain.BoardVO;
import com.yourgg.persistence.BoardDAO;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO board;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	public String getPassword(int boardNumber) {
		return board.getPassword(boardNumber);
	}
	
	public int getTotalPost() {
		return board.getTotalPost();
	}
	
	public List<BoardVO> getPosts(int nowPage) {
		return board.getPosts(nowPage);
	}
	
	public void registPost(BoardVO boardVO) {
		boardVO.setBoardPassword(passwordEncoder.encode(boardVO.getBoardPassword()));
		board.registPost(boardVO);
	}
	
	public BoardVO getPost(int boardNumber) {
		return board.getPost(boardNumber);
	}
	
	public boolean deletePost(BoardVO boardVO) {
		if(passwordEncoder.matches(boardVO.getBoardPassword(), board.getPassword(boardVO.getBoardNumber()))) {
			board.deletePost(boardVO.getBoardNumber());
			return true;
		}
		else return false;
	}
	
	public boolean updateJudge(BoardVO boardVO) {
		if(passwordEncoder.matches(boardVO.getBoardPassword(), board.getPassword(boardVO.getBoardNumber()))) return true;
		else return false;
	}
	
	public void updatePost(BoardVO boardVO) {
		board.updatePost(boardVO);
	}
}
