package com.yourgg.domain;

import lombok.Data;

@Data
public class PageDTO {

	private int nowPage;
	private int totalPost;
	private int totalPage;
	private int endPage;
	private int trueEndPage;
	private int startPage;
	private boolean prev;
	private boolean next;

	public PageDTO(int nowPage, int totalPost) {
		this.nowPage = nowPage;
		this.totalPost = totalPost;
		
		totalPage = (int) Math.ceil(totalPost / 20);
		endPage = (int) (Math.ceil(nowPage / 10.0)) * 10;
		trueEndPage = (int) Math.ceil((totalPost * 1.0) / 20);
		startPage = endPage - 9;

		if (trueEndPage < endPage) endPage = trueEndPage;

		prev = startPage > 1;
		next = endPage < trueEndPage;
	}

}
