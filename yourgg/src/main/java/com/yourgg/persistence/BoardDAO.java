package com.yourgg.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.yourgg.domain.BoardVO;

public interface BoardDAO {
	
	@Select ("select count(*) from board")
	public int getTotalPost();
	
	@Select ("select * from board")
	public BoardVO getInfo(int boardNumber);
	
	public List<BoardVO> getPosts(int nowPage);
	
	public void registPost(BoardVO boardVO);
	
	@Select ("select board_number, board_regdate, board_title, board_content, board_writer from board where board_number = #{param}")
	public BoardVO getPost(int boardNumber);
	
	@Select ("select board_password from board where board_number = #{param}")
	public String getPassword(int boardNumber);
	
	@Delete ("delete from board where board_number = #{param}")
	public void deletePost(int boardNumber);
	
	@Update ("update board set board_title = #{boardTitle}, board_content = #{boardContent} where board_number = #{boardNumber}")
	public void updatePost(BoardVO boardVO);

}
